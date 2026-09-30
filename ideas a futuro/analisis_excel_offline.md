# Analisis de uso de Excel y consumo de BD (DocstrY)

## Resumen corto
- Excel se usa principalmente en el modulo de calificaciones como planillas offline.
- La BD sigue siendo la fuente principal de datos para generar planillas y para la mayor parte de las consultas.
- Existe lectura de Excel para mostrar una grilla web en calificaciones, pero es parcial.
- No hay un cache general basado en Excel para los otros modulos (usuarios, estudiantes, horarios, observador, etc.).

## Evidencia rapida (archivos revisados)
- backend/routes/calificaciones.py: crea, lee y sincroniza Excel, versiona archivos, exporta desde BD.
- backend/iniciador.py: registra el blueprint de calificaciones.
- backend/routes/temp.py: pruebas de Drive + Excel con pandas (no esta activo en el servidor).
- backend/routes/periodos.py: limpia uploads/planillas, no consume Excel.

## Respuesta a la pregunta
**No, el sistema no usa Excel como fuente primaria para evitar consumo de la BD.**
- Lo que si hace: genera Excel desde la BD y luego importa Excel hacia la BD.
- La generacion de planillas consulta la BD para estudiantes, actividades y notas.
- Hay un endpoint que lee el Excel para la pantalla web, pero la mayor parte de operaciones sigue leyendo BD.

## Se puede hacer? (Si, con cambios)
### Opcion A: Excel como cache de lectura (minimo viable)
1. Mantener la exportacion masiva (ya existe) para crear planillas locales y en el servidor web.
2. Crear una capa de acceso a datos (repositorio) que primero intente leer Excel y, si no existe o esta viejo, use la BD.
3. Guardar un manifest (JSON) por planilla con: ultima_sync, hash, total_registros.
4. Cuando haya conexion, sincronizar solo los cambios hacia la BD y actualizar el manifest.

### Opcion B: Offline-first real (recomendado para calificaciones)
1. Definir modo offline (flag o deteccion de conectividad).
2. Para lecturas: usar Excel como fuente de verdad local.
3. Para escrituras: guardar cambios en un log local (JSON o CSV) y luego aplicar el log a la BD cuando vuelva la conexion.
4. Resolver conflictos con reglas simples (ultimo cambio gana) o por rol (admin prioriza).

### Opcion C: Mejor alternativa tecnica
- Para reducir carga de BD y mejorar consistencia, usar SQLite local como cache y dejar Excel solo para exportar/importar.
- Excel es debil para concurrencia y relaciones complejas, pero sirve para planillas y reportes.

## Limites actuales
- El modulo de calificaciones ya soporta flujo Excel <-> BD, pero no reemplaza la BD para todas las consultas.
- Otros modulos no usan Excel y dependen 100% de la BD.

## Recomendacion corta
- Mantener Excel para calificaciones (offline y exportes).
- Implementar cache local (Excel o SQLite) solo donde haya necesidad real de trabajo offline.
- Agregar una capa de repositorio para decidir si leer desde Excel o BD segun conectividad.
