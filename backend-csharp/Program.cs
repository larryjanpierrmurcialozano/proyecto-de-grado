using Npgsql;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using ProyectoGrado.Api.Data;
using ProyectoGrado.Api.Modules.Auth;
using ProyectoGrado.Api.Modules.Usuarios;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSingleton<PostgresConnectionFactory>();
builder.Services.AddScoped<AuthQueries>();
builder.Services.AddScoped<UsuarioQueries>();
builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(options =>
    {
        options.Cookie.Name = "proyecto_grado_auth";
        options.Cookie.HttpOnly = true;
        options.Cookie.SameSite = SameSiteMode.Lax;
        options.ExpireTimeSpan = TimeSpan.FromHours(8);
        options.SlidingExpiration = true;
        options.Events.OnRedirectToLogin = context =>
        {
            context.Response.StatusCode = StatusCodes.Status401Unauthorized;
            return Task.CompletedTask;
        };
    });
builder.Services.AddAuthorization();
builder.Services.AddValidation();

var app = builder.Build();
app.UseAuthentication();
app.UseAuthorization();

app.MapGet("/", () => Results.Ok(new
{
    service = "ProyectoGrado.Api",
    status = "ready",
    migratedFrom = "backend/routes"
}));

app.MapGet("/api/health", async (PostgresConnectionFactory factory, CancellationToken cancellationToken) =>
{
    try
    {
        await using var connection = await factory.OpenConnectionAsync(cancellationToken);
        await using var command = new NpgsqlCommand("SELECT current_database()", connection);
        var database = (string?)await command.ExecuteScalarAsync(cancellationToken);
        return Results.Ok(new { status = "ok", database });
    }
    catch (NpgsqlException)
    {
        return Results.Problem(
            title: "PostgreSQL no disponible",
            detail: "Verifica el contenedor y la cadena de conexión.",
            statusCode: StatusCodes.Status503ServiceUnavailable);
    }
});

app.MapGet("/api/usuarios", async (UsuarioQueries queries, CancellationToken cancellationToken) =>
    Results.Ok(await queries.ListAsync(cancellationToken)));

app.MapGet("/api/usuarios/{id:int}", async (
    int id,
    UsuarioQueries queries,
    CancellationToken cancellationToken) =>
{
    var usuario = await queries.GetAsync(id, cancellationToken);
    return usuario is null ? Results.NotFound(new { error = "Usuario no encontrado" }) : Results.Ok(usuario);
});

app.MapGet("/api/roles", async (UsuarioQueries queries, CancellationToken cancellationToken) =>
    Results.Ok(await queries.ListRolesAsync(cancellationToken)));

app.MapPost("/api/usuarios", async (
    CreateUsuarioRequest request,
    UsuarioQueries queries,
    CancellationToken cancellationToken) =>
{
    try
    {
        var id = await queries.CreateAsync(request, cancellationToken);
        return Results.Created($"/api/usuarios/{id}", new { status = "ok", id });
    }
    catch (PostgresException exception) when (exception.SqlState == "23505")
    {
        return Results.BadRequest(new { error = "El email o documento ya está registrado." });
    }
});

app.MapPut("/api/usuarios/{id:int}", async (
    int id,
    UpdateUsuarioRequest request,
    UsuarioQueries queries,
    CancellationToken cancellationToken) =>
{
    try
    {
        return await queries.UpdateAsync(id, request, cancellationToken)
            ? Results.Ok(new { status = "ok" })
            : Results.NotFound(new { error = "Usuario no encontrado" });
    }
    catch (PostgresException exception) when (exception.SqlState == "23505")
    {
        return Results.BadRequest(new { error = "El email o documento ya está registrado." });
    }
});

app.MapDelete("/api/usuarios/{id:int}", async (
    int id,
    UsuarioQueries queries,
    CancellationToken cancellationToken) =>
{
    return await queries.DeleteAsync(id, cancellationToken)
        ? Results.NoContent()
        : Results.NotFound(new { error = "Usuario no encontrado" });
}).RequireAuthorization(policy => policy.RequireRole("server_admin"));

app.MapGet("/api/auth/profile", async (
    HttpContext httpContext,
    AuthQueries queries,
    CancellationToken cancellationToken) =>
{
    if (!int.TryParse(httpContext.User.FindFirst("user_id")?.Value, out var id))
    {
        return Results.Json(new { error = "No autenticado" }, statusCode: StatusCodes.Status401Unauthorized);
    }

    var profile = await queries.GetProfileAsync(id, cancellationToken);
    return profile is null
        ? Results.NotFound(new { error = "Usuario no encontrado" })
        : Results.Ok(new { status = "ok", usuario = profile });
});

app.MapPost("/api/auth/login", async (
    LoginRequest request,
    AuthQueries queries,
    HttpContext httpContext,
    CancellationToken cancellationToken) =>
{
    var user = await queries.AuthenticateAsync(request.Email, request.Password, cancellationToken);
    if (user is null)
    {
        return Results.Json(new { error = "Email o contraseña incorrectos" }, statusCode: StatusCodes.Status401Unauthorized);
    }

    await httpContext.SignInAsync(
        CookieAuthenticationDefaults.AuthenticationScheme,
        user.Principal,
        user.Properties);

    return Results.Ok(new
    {
        status = "ok",
        user_id = user.User.IdUsuario,
        user_name = $"{user.User.Nombre} {user.User.Apellido}",
        user_role = user.User.NombreRol
    });
});

app.MapGet("/api/auth/check", (HttpContext httpContext) =>
{
    if (httpContext.User.Identity?.IsAuthenticated != true)
    {
        return Results.Json(new { authenticated = false }, statusCode: StatusCodes.Status401Unauthorized);
    }

    return Results.Ok(new
    {
        authenticated = true,
        user_id = httpContext.User.FindFirst("user_id")?.Value,
        user_name = httpContext.User.FindFirst("user_name")?.Value,
        user_email = httpContext.User.FindFirst("user_email")?.Value,
        user_role = httpContext.User.FindFirst("user_role")?.Value
    });
});

app.MapPost("/api/auth/logout", async (HttpContext httpContext) =>
{
    await httpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
    return Results.Ok(new { status = "ok" });
});

app.MapPost("/api/auth/change-password", async (
    ChangePasswordRequest request,
    HttpContext httpContext,
    AuthQueries queries,
    CancellationToken cancellationToken) =>
{
    if (!int.TryParse(httpContext.User.FindFirst("user_id")?.Value, out var id))
    {
        return Results.Json(new { error = "No autenticado" }, statusCode: StatusCodes.Status401Unauthorized);
    }

    var result = await queries.ChangePasswordAsync(id, request, cancellationToken);
    return result switch
    {
        PasswordChangeResult.Unauthenticated => Results.Json(
            new { error = "No autenticado" }, statusCode: StatusCodes.Status401Unauthorized),
        PasswordChangeResult.InvalidCurrentPassword => Results.BadRequest(
            new { error = "Contraseña actual incorrecta" }),
        PasswordChangeResult.InvalidNewPassword => Results.BadRequest(
            new { error = "Nueva contraseña mínimo 6 caracteres" }),
        _ => Results.Ok(new { status = "ok", message = "Contraseña actualizada" })
    };
});

app.MapPost("/api/auth/register", async (
    RegisterRequest request,
    AuthQueries queries,
    CancellationToken cancellationToken) =>
{
    var result = await queries.RegisterAsync(request, cancellationToken);
    return result.IsSuccess
        ? Results.Created($"/api/usuarios/{result.UserId}", new
        {
            status = "ok",
            message = "Usuario registrado",
            user_id = result.UserId
        })
        : Results.BadRequest(new { error = result.Error });
});

app.Run();

public partial class Program;
