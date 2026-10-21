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

## Módulo académico en paralelo

Se agregó `Modules/Academico/` para grados, grupos, materias y asignaciones de
docentes. Conserva los contratos de las rutas Flask correspondientes y requiere
autenticación mediante la cookie de C# cuando se ejecuta directamente en el
puerto de ASP.NET Core. Flask continúa atendiendo las URLs del frontend; sus
blueprints no se han cambiado ni eliminado.

- Grados: `GET/POST /api/grados`, `GET/PUT/DELETE /api/grados/{id}` y
  `GET /api/grados/{gradoId}/grupos`.
- Grupos: `GET/POST /api/grupos`, `GET/PUT/DELETE /api/grupos/{id}` y
  `GET /api/grupos/{id}/estudiantes`.
- Materias: `GET/POST /api/materias`, `GET/PUT/DELETE /api/materias/{id}` y
  `GET /api/materias/{materiaId}/docentes-disponibles`.
- Asignaciones: `POST /api/asignaciones-docente` y
  `DELETE /api/asignaciones-docente/{id}`.

Este es un despliegue paralelo, no un cambio de destino desde Flask. La
integración Flask -> C# queda pendiente hasta acordar el paso seguro de sesión
y roles entre servicios.

## Módulo Estudiantes en paralelo

Se agregó `Modules/Estudiantes/` para el CRUD que existe en Flask. Mantiene las
cinco rutas `/api/estudiantes` y exige cookie de autenticación C# al llamarlas
directamente. La eliminación ejecuta la limpieza de relaciones dentro de una
transacción y pasa usuario, IP, agente y conteos al trigger de auditoría
PostgreSQL.

## Consultas de Docentes

`Modules/Docentes/` implementa las consultas de administración y del panel del
docente. Lee docente disponibles, asignaciones, grados/grupos, materias propias
y horario, reutilizando el identificador de usuario validado por Flask al
reenviar las solicitudes.

## Horarios

`Modules/Horarios/` contiene consulta con filtros, detalle, altas, edición,
eliminación, asignaciones por grupo/grado y catálogo de niveles. El alta valida
cruces de horario del grupo y del docente; las operaciones de escritura intentan
registrar la acción en `log_registro` sin revertir el cambio si ese registro
auxiliar no está disponible. `POST /api/horarios/exportar-pdf` permanece en
Flask para preservar el formato institucional.

Al ejecutar C# con `dotnet run`, cada solicitud se registra en consola con
método, ruta, código HTTP y duración. No se registran cuerpos de solicitud ni
contraseñas.

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

## Integración opcional detrás de Flask

Los módulos Estudiantes, Académico y las consultas GET de Docentes pueden
recibir solicitudes reenviadas por Flask sin cambiar las URLs del frontend. La
opción está apagada por defecto y Flask conserva los blueprints como
implementación local cuando no se habilita.

Configura en Flask y ASP.NET Core el mismo secreto privado en
`CSHARP_PROXY_SECRET` y permite `estudiantes` y/o `academico` en
`CSHARP_PROXY_MODULES` de ambos procesos (separados por coma). En Flask,
configura además `CSHARP_API_URL` con la dirección del
servidor C# (por defecto `http://127.0.0.1:5124`). Reinicia ambos procesos para
que lean las variables. C# valida el secreto y solo acepta módulos incluidos
en su lista de permitidos. Si C# no está disponible durante el proxy, Flask
responde 502; vaciar `CSHARP_PROXY_MODULES` en Flask restaura el servicio
directo desde Python.

`estudiantes` enruta el CRUD de estudiantes. `academico` enruta grados, grupos,
materias y asignaciones de docente. `docentes` enruta sus consultas GET y
`horarios` enruta CRUD y consultas de datos. `/api/periodos` permanece en Flask
porque no pertenece al conjunto de endpoints académicos implementado en C#.

`docentes` enruta por ahora solo consultas GET: lista, disponibles, asignaciones,
grados/grupos y el panel `mis-materias`/`mi-horario`. La escritura
`POST /api/docentes/{id}/asignaciones` se mantiene en Python: reemplaza de forma
masiva las asignaciones y usa un contrato anterior que no incluye grupo.

Antes de habilitarlo para usuarios reales, compara en desarrollo las rutas CRUD,
permisos por rol, efectos de eliminación y auditoría PostgreSQL.
