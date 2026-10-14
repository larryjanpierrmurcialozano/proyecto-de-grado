# ProyectoGrado.Api

Primera base ASP.NET Core para migrar progresivamente las rutas Flask a C#.
Este proyecto funciona en paralelo: no reemplaza todavía `backend/`.

## Slice implementado

- `GET /api/health`: comprueba la conexión al PostgreSQL de Docker.
- `GET /api/usuarios`: lista usuarios con su rol.
- `GET /api/usuarios/{id}`: obtiene el detalle de un usuario.
- `GET /api/roles`: lista roles.
- `GET /api/auth/profile`: obtiene el perfil autenticado.
- `POST /api/auth/login`: inicia sesión con cookie HttpOnly.
- `POST /api/auth/register`: registra un usuario con rol Profesor.
- `GET /api/auth/check`: comprueba la cookie de sesión.
- `POST /api/auth/change-password`: cambia la contraseña verificando la actual.
- `POST /api/auth/logout`: elimina la cookie de sesión.
- `POST /api/usuarios`: crea un usuario.
- `PUT /api/usuarios/{id}`: actualiza un usuario.
- `DELETE /api/usuarios/{id}`: elimina un usuario.

Las consultas usan parámetros PostgreSQL (`$1`) y no interpolan valores
provenientes de la solicitud. Las contraseñas usan BCrypt compatible con los
hashes existentes en la base migrada.

## Ejecutar

Desde la raíz del repositorio:

```powershell
dotnet run --project backend-csharp\ProyectoGrado.Api.csproj
```

La cadena de conexión está en `appsettings.json` solo como configuración local
de desarrollo. Para otros entornos se debe usar
`ConnectionStrings__Postgres` como variable de entorno.

## Estado de migración

Este slice ya puede probarse en paralelo con Flask. La cookie de C# es
independiente de la sesión Flask, por lo que todavía no se debe cambiar el
frontend global ni apagar Flask. Antes del corte se deben validar permisos de
administrador para eliminaciones, comparar respuestas con Flask y configurar
CORS/clave de protección de cookies por entorno.
