README FUNCIONALIDAD - SISTEMA DE HORARIOS

meterle funcionalidad de carga en el sistema, tipo que el programa se ejecute solo cuando se entre en el apartado de esta, tipo que aunque este en la misma pagina, no cargue este sistema sino hasta que alguien entre en el, y que quede abierto en el sistema del que lo abrio hasta que cerre sesion, o apague el computador

Objetivo
- Definir la logica funcional del modulo de horarios (sin codigo) para planificar su implementacion web.
- Cubrir flujo, reglas de negocio, entradas, salidas, validaciones y exportacion.

Alcance del modulo
- Crear, editar y eliminar bloques de horario.
- Consultar horarios por grupo, grado y docente.
- Evitar choques de docentes y grupos.
- Generar reportes descargables (PDF y Excel) por grupo y por docente.
- Exportar en lote todos los horarios a carpetas organizadas.

Entidades funcionales
- Grado: nivel academico (ej. 6, 7, 8).
- Grupo: subdivision del grado (ej. 6-A).
- Materia: asignatura academica.
- Docente: persona encargada de dictar una materia.
- Asignacion docente: relacion entre docente, materia y grupo.
- Bloque de horario: unidad minima del horario (dia, hora inicio, hora fin, aula, observaciones).

Entradas principales
- Catalogos: grados, grupos, docentes, materias.
- Asignaciones activas: docente + materia + grupo.
- Rango de horas institucional (ej. 07:00 a 14:00).
- Dias de la semana (lunes a viernes).

Salidas principales
- Grilla semanal para un grupo (visual y editable).
- Grilla semanal para un docente (solo lectura o administrable segun rol).
- Reporte PDF por grupo/docente.
- Reporte Excel por grupo/docente.
- Exportacion masiva de todos los horarios por carpetas.

Flujo principal (gestion por grupos)
1) Seleccionar grado.
2) Listar grupos del grado.
3) Seleccionar grupo.
4) Cargar bloques existentes del grupo.
5) Mostrar grilla semanal con bloques.
6) Crear/editar/eliminar bloques.
7) Guardar cambios con validaciones.

Flujo alterno (consulta por docente)
1) Seleccionar docente.
2) Cargar bloques del docente.
3) Mostrar grilla semanal.
4) Permitir exportar reporte (PDF/Excel).

Reglas de negocio (validaciones)
- Dia valido: lunes, martes, miercoles, jueves, viernes.
- Hora inicio y fin en formato HH:MM.
- Hora fin > hora inicio.
- Bloque debe estar dentro del rango institucional.
- No se permiten solapes en el mismo grupo (dia y rango horario).
- No se permiten solapes para el mismo docente en otro grupo.
- La asignacion docente debe existir y estar activa.
- Cada bloque pertenece a una asignacion y un grupo.

Prioridad de conflicto
- Conflicto de grupo: siempre bloquea la creacion/edicion.
- Conflicto de docente: bloquea la creacion/edicion y muestra el grupo en conflicto.

Logica de renderizado de grilla
- La grilla se arma por dias (columnas) y horas (filas).
- Cada bloque puede cubrir una o mas horas.
- Bloques contiguos del mismo dia se agrupan para evitar duplicar celdas.
- La celda muestra: materia, docente, rango horario y aula (si aplica).

Edicion de bloques
- Crear: seleccionar asignacion, dia, hora inicio, hora fin, aula, observaciones.
- Editar: mismas reglas que crear, con validacion de conflictos ignorando el bloque actual.
- Eliminar: confirmar y remover del horario.

Persistencia de datos (conceptual)
- Tabla de horarios con: id_horario, id_asignacion, id_grupo, dia_semana, hora_inicio, hora_fin, aula, observaciones.
- Relacion con grupos, grados, docentes y materias via asignaciones.

Control de roles (funcional)
- Admin/coordinador: CRUD completo.
- Docente: consulta y descarga de su propio horario.
- Estudiante/consulta: visualizacion de horarios por grupo (opcional).

Exportacion individual
- PDF: tabla semanal con horas y dias, cada celda con materia y docente/grupo.
- Excel: grilla con formato, similar a PDF.
- Nombre de archivo: Horario_<tipo>_<nombre>_<fecha>.pdf/xlsx.

Exportacion masiva (requerimiento clave)
- Objetivo: descargar todos los horarios de grupos y docentes, cada uno en su carpeta.
- Estructura sugerida:
	- Escritorio/Horarios/Grados/<Grado>/<Grupo>/Horario_Grupo_<Grupo>.pdf
	- Escritorio/Horarios/Docentes/<Docente>/Horario_Docente_<Docente>.pdf
- Alternativa para servidor:
	- <ruta_base>/Horarios/Grados/<Grado>/<Grupo>/...
	- <ruta_base>/Horarios/Docentes/<Docente>/...
- Generar un ZIP general con toda la carpeta para descarga unica (opcional).

Mensajes de error esperados
- "Asignacion no encontrada o inactiva"
- "Grupo no encontrado"
- "Choque de horario en el grupo"
- "El docente ya tiene clase en otro grupo"
- "Dia invalido" / "Hora invalida"

Indicadores utiles en UI
- Cantidad de bloques por grupo/docente.
- Total de horas programadas por docente.
- Alertas visuales para solapes o huecos largos.

Requerimientos futuros (opcional)
- Integracion con motor FET (import/export de restricciones).
- Generacion automatica de horarios segun restricciones.
- Versionado de horarios por periodos y historicos.
- Aprobacion de horarios (borrador -> aprobado).

FET - Funcionamiento y funcionalidades (explicado)

Que es FET
- FET (Free Timetabling Software) es un motor que construye horarios automaticamente.
- No es solo una plantilla: resuelve restricciones reales y optimiza el horario.
- El resultado es un horario base que luego puedes ajustar manualmente.

Como funciona en palabras simples
1) Tu defines los datos: docentes, grupos, materias, aulas, horas y dias.
2) Defines restricciones duras (obligatorias) y blandas (preferencias).
3) FET intenta crear un horario que cumpla todas las duras.
4) Si existen muchas opciones, busca la que tenga el menor "costo" en blandas.
5) Entrega un horario completo, listo para exportar o editar.

Restricciones duras (ejemplos)
- Un docente no puede estar en dos grupos a la misma hora.
- Un grupo no puede tener dos materias al mismo tiempo.
- Una actividad debe tener la duracion exacta definida.
- Un aula no puede ocuparse por dos actividades simultaneas.
- Actividades solo pueden ubicarse en dias/horas validas.

Restricciones blandas (ejemplos)
- Evitar huecos (tiempos muertos) en el horario de docentes o grupos.
- Preferir materias en ciertas horas (ej. matematicas temprano).
- Limitar la cantidad de horas seguidas de una materia.
- Distribuir actividades de un docente en dias equilibrados.

Que necesita FET como entrada minima
- Lista de grupos y docentes.
- Lista de materias.
- Asignaciones (docente + materia + grupo).
- Rango de horas por dia (ej. 07:00-14:00 en bloques).
- Dias activos (lunes a viernes).
- Disponibilidad de docentes (si aplica).

Que produce FET como salida
- Un horario por grupo con todas las materias asignadas.
- Un horario por docente con sus bloques.
- Reportes en formatos exportables (depende de la configuracion).

Integracion funcional con tu sistema
- FET puede usarse como generador inicial de horarios.
- El sistema importa el horario y lo guarda en la base.
- Luego se permite edicion manual en la grilla web.
- Se respetan las mismas validaciones (choques de grupo/docente).

Beneficios funcionales de usar FET
- Reduce el tiempo de planeacion de horarios.
- Minimiza conflictos y errores humanos.
- Permite simular escenarios cambiando restricciones.
- Genera un horario base consistente para ajustes finos.

Limitaciones a considerar
- Si las restricciones son demasiado estrictas, puede no encontrar solucion.
- Requiere datos limpios (asignaciones y disponibilidades correctas).
- No reemplaza la revision humana: siempre requiere verificacion.

Resumen practico
- FET toma datos + reglas y devuelve un horario completo.
- El horario generado se usa como base en el sistema web.
- Luego se exporta, ajusta y distribuye por grupos y docentes.

Guia de uso en interfaz (botones y explicaciones)
Objetivo
- Antes de que el usuario haga clic, mostrar una explicacion corta y clara de cada accion.
- Reducir errores y mejorar la comprension para usuarios sin experiencia.

Componentes sugeridos
- Tooltips: texto corto al pasar el mouse.
- Ayuda contextual: un icono (i) que abre un panel lateral.
- Texto previo: una linea explicativa bajo cada boton principal.

Seccion: Gestion por grupos
- Boton: "Seleccionar grado"
	- Explicacion: "Elige el grado para ver sus grupos y horarios disponibles."
- Boton: "Seleccionar grupo"
	- Explicacion: "Escoge el grupo para cargar su horario semanal."
- Boton: "Agregar bloque"
	- Explicacion: "Crea una clase en un dia y hora especificos."
- Boton: "Editar bloque"
	- Explicacion: "Ajusta materia, docente, hora o aula del bloque existente."
- Boton: "Eliminar bloque"
	- Explicacion: "Quita la clase del horario. Esta accion no se puede deshacer."

Seccion: Gestion por docentes
- Boton: "Seleccionar docente"
	- Explicacion: "Muestra el horario del docente elegido."
- Boton: "Exportar PDF"
	- Explicacion: "Descarga el horario listo para imprimir."
- Boton: "Exportar Excel"
	- Explicacion: "Descarga el horario para editarlo o compartirlo."

Seccion: Exportaciones
- Boton: "Exportar este horario"
	- Explicacion: "Genera el horario actual en PDF o Excel."
- Boton: "Exportar todos"
	- Explicacion: "Crea todos los horarios por grupos y docentes en carpetas organizadas."

Mensajes preventivos (antes de acciones sensibles)
- Al eliminar: "Estas seguro? Esta accion elimina el bloque definitivamente."
- Al exportar todos: "Puede tardar algunos minutos. Se generaran carpetas por grado y docente."

Mejoras para usuarios sin experiencia
- Mostrar ejemplos con formato: "Ejemplo: Lunes 07:00 - 08:00"
- Marcar campos obligatorios con asterisco.
- Resaltar conflictos en rojo y explicar el motivo.
- Mostrar un resumen antes de guardar cambios.
- Boton de "Ayuda rapida" con preguntas frecuentes.

Mejoras avanzadas de funcionalidad (presets y ajustes rapidos)

1) Presets de configuracion
- Objetivo: aplicar un conjunto de parametros en un clic.
- Preset "Estandar": 07:00-14:00, bloques de 60 min, lunes a viernes.
- Preset "Bloques 50 min": ajusta horas y grilla automaticamente.
- Preset "Sin ultimas horas": bloquea la ultima hora para X grado.
- Preset "Prioridad materias clave": intenta ubicar materias fuertes temprano.

2) Ajustes rapidos por reglas (encender/apagar)
- Evitar huecos en docentes.
- Evitar huecos en grupos.
- Maximo 2 horas seguidas por materia.
- Maximo 6 horas por docente al dia.
- Distribuir materias pesadas a lo largo de la semana.

3) Plantillas por rol (para simplificar la interfaz)
- Plantilla "Coordinador": acceso total y reglas avanzadas.
- Plantilla "Docente": solo consulta, exportar y comentarios.
- Plantilla "Auxiliar": crear/editar basico sin reglas complejas.

4) Botones de accion inteligente
- "Reordenar por prioridad": reorganiza sin romper choques.
- "Auto-completar semana": llena huecos con asignaciones pendientes.
- "Limpiar y rehacer": borra y genera de nuevo segun reglas activas.
- "Aplicar preset": reconfigura horas, dias y reglas en un paso.

5) Vista de conflictos con soluciones
- Lista de conflictos detectados en tiempo real.
- Cada conflicto muestra: causa, bloque implicado, sugerencias.
- Boton "Resolver automaticamente" con opciones sugeridas.
- Boton "Ver alternativas" para proponer horarios libres.

6) Explicaciones simples junto a cada ajuste
- "Evitar huecos": "Reduce tiempos muertos en los horarios."
- "Maximo horas seguidas": "Evita que una materia se repita sin descanso."
- "Distribuir materias": "Reparte materias fuertes entre los dias."

7) Modo seguro para usuarios nuevos
- Un switch "Modo basico" que oculta ajustes avanzados.
- Mensajes mas guiados y confirmaciones obligatorias.
- Boton "Deshacer ultimo cambio" para reducir miedo a equivocarse.