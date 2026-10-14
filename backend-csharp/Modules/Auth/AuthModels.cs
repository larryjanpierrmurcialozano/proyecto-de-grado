using System.ComponentModel.DataAnnotations;
using System.Security.Claims;
using Microsoft.AspNetCore.Authentication;

namespace ProyectoGrado.Api.Modules.Auth;

/// <summary>Credenciales para iniciar sesión.</summary>
public sealed record LoginRequest
{
    [Required, EmailAddress]
    public required string Email { get; init; }

    [Required]
    public required string Password { get; init; }
}

/// <summary>Datos públicos para registrar un usuario profesor.</summary>
public sealed record RegisterRequest
{
    [Required, MaxLength(100)]
    public required string Nombre { get; init; }

    [Required, MaxLength(100)]
    public required string Apellido { get; init; }

    [Required, EmailAddress, MaxLength(255)]
    public required string Email { get; init; }

    [Required, MinLength(6)]
    public required string Password { get; init; }

    [Required, MaxLength(100)]
    public required string Documento { get; init; }
}

/// <summary>Contraseña actual y nueva para cambiar las credenciales.</summary>
public sealed record ChangePasswordRequest
{
    [Required]
    public required string CurrentPassword { get; init; }

    [Required, MinLength(6)]
    public required string NewPassword { get; init; }
}

public enum PasswordChangeResult
{
    Updated,
    Unauthenticated,
    InvalidCurrentPassword,
    InvalidNewPassword
}

public sealed record AuthenticatedUser(
    ProyectoGrado.Api.Modules.Usuarios.UsuarioDetail User,
    ClaimsPrincipal Principal,
    AuthenticationProperties Properties);

public sealed record RegistrationResult(bool IsSuccess, int? UserId, string? Error);
