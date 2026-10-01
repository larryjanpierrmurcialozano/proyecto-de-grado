# Docstry

Sistema de gestion academica desarrollado con Flask, MySQL y un frontend
estatico servido por el backend.

## Ejecutar en desarrollo

Desde la raiz del proyecto:

```powershell
python backend/iniciador.py
```

Abrir `http://127.0.0.1:5000/bienvenida`.

## Estructura principal

- `backend/`: codigo Python de la aplicacion.
- `frontend/`: templates, JavaScript, CSS e imagenes.
- `storage/`: uploads, archivos generados y respaldos locales.
- `scripts/`: herramientas de base de datos y mantenimiento.
- `docs/`: instalacion, arquitectura y documentacion operativa.
- `tests/`: pruebas automatizadas, en crecimiento.

Consulta [docs/architecture.md](docs/architecture.md) para la estrategia de
migracion por bloques.