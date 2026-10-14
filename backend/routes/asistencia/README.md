# Asistencia

- Python: `routes.py`
- Responsabilidad: asistencia diaria, detalle, justificantes y consolidados.
- Tablas principales: `asistencias_diarias`, `detalle_asistencia`, `asistencia`, `asistencias_por_periodo`.
- Archivos: `storage/uploads/justificantes/`.
- Estado PostgreSQL: tres upserts convertidos a `ON CONFLICT`.
- Pendientes: validar escrituras y retirar la dependencia legacy.
