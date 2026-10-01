# Arquitectura del proyecto

## Estado actual

El proyecto es un monolito Flask modular. `backend/iniciador.py` registra los
blueprints y sirve el frontend estatico desde `frontend/`. La base de datos se
conecta mediante `backend/utils/database.py`.

La primera reorganizacion separa los recursos por responsabilidad:

- `backend/routes/`: endpoints Flask existentes.
- `backend/utils/`: conexion, helpers y constantes compartidas.
- `frontend/`: templates, JavaScript, CSS e imagenes.
- `storage/uploads/`: archivos subidos por usuarios.
- `storage/backups/`: respaldos de MySQL, no versionados.
- `scripts/database/`: herramientas de exportacion e importacion.
- `scripts/legacy/`: scripts antiguos que no deben ejecutarse por defecto.
- `docs/`: instalacion, correo, periodos y arquitectura.

## Objetivo

La estructura objetivo es un monolito modular por bloques. Cada bloque de
negocio podra separar posteriormente sus rutas, servicios, repositorios y
esquemas sin cambiar las URLs publicas.

```text
backend/app/
  core/             # configuracion y errores comunes
  infrastructure/   # base de datos, archivos, correo e integraciones
  modules/          # auth, academico, asistencia, calificaciones, etc.
frontend/
storage/
scripts/
tests/
docs/
```

## Reglas de migracion

1. Mantener las URLs actuales mientras se mueve cada modulo.
2. Centralizar rutas fisicas antes de mover codigo Python.
3. Migrar un bloque por vez y probar sus endpoints.
4. No mezclar backups, uploads ni secretos con codigo versionable.
5. Retirar `routes/temp.py`, copias `.bak` y codigo legacy solo despues de
   confirmar que no tienen consumidores activos.