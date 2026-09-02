GUIA VISUAL - MODULO DE HORARIOS (ADMINISTRACION)

Objetivo
- Definir en detalle como se vera y se usara el modulo de horarios en el apartado de administracion.
- Priorizar claridad, cero confusion y acciones guiadas para usuarios sin experiencia.
- Usar un estilo limpio: fondo blanco y bordes negros en toda la interfaz.

Enfoque visual general
- Fondo blanco en toda la vista.
- Bordes negros en tarjetas, inputs, botones y grilla.
- Tipografia clara y grande, con jerarquia marcada por peso (negrita) y espaciado.
- Evitar colores fuertes. El color se usa solo para alertas criticas.

Por que este estilo es comodo
- Blanco + bordes negros facilita la lectura y reduce distracciones.
- Los limites visuales son claros, ideal para personas sin experiencia.
- El usuario entiende rapido donde empieza y termina cada seccion.

1) Estructura general de la pantalla (administracion)
- Encabezado superior con:
	- Titulo grande: "Administracion de Horarios".
	- Subtitulo breve: "Planifica, valida y exporta horarios".
	- Boton de ayuda "Como usar" con guia rapida.
- Barra de filtros arriba, siempre visible.
- Grilla semanal al centro, ocupando el mayor espacio.
- Columna lateral derecha con acciones, conflictos y resumen.

2) Barra de filtros (zona superior fija)
- Filtro 1: Grado (obligatorio).
	- Texto guia: "Paso 1: selecciona un grado".
- Filtro 2: Grupo (se activa al elegir grado).
	- Texto guia: "Paso 2: selecciona un grupo".
- Filtro 3: Docente (opcional).
	- Texto guia: "Opcional: ver horario del docente".
- Boton "Cargar horario" para evitar recargas automaticas confusas.

Razonamiento critico
- La carga manual con un boton evita que el usuario crea que "no funciona" por filtros parciales.
- El texto paso a paso reduce errores de personas no tecnicas.

3) Grilla semanal (zona central)
- Cuadricula con borde negro en cada celda.
- Columnas: dias de la semana.
- Filas: horas del dia.
- Bloques de horario:
	- Fondo blanco, borde negro mas grueso.
	- Titulo en negrita: materia.
	- Subtexto: docente, hora y aula.
	- Botones pequenos "Editar" y "Eliminar" dentro del bloque.

Razonamiento critico
- Los bloques en blanco con borde negro se sienten como fichas fisicas.
- Evita el uso de colores por materia, que puede confundir o distraer.
- Si se necesita destacar, usar etiquetas con borde negro y texto en mayusculas.

4) Panel de acciones (columna derecha)
- Tarjeta "Acciones" con borde negro.
- Botones principales, con texto explicativo debajo:
	- "Agregar bloque" - "Crea una clase en el horario seleccionado".
	- "Aplicar preset" - "Usa configuraciones rapidas".
	- "Auto-completar" - "Llena espacios libres con asignaciones".
	- "Reordenar" - "Optimiza sin romper choques".

Razonamiento critico
- En administracion, los botones deben estar siempre visibles.
- El texto debajo evita que el usuario tenga que adivinar.

5) Panel de conflictos (debajo de acciones)
- Tarjeta "Conflictos" con borde negro.
- Lista con errores en rojo tenue (solo texto, no fondos).
- Cada conflicto tiene:
	- Descripcion clara.
	- Boton "Resolver".
	- Boton "Ver alternativas".

Razonamiento critico
- La lista evita que el usuario busque el problema dentro de la grilla.
- Las acciones directas dan seguridad y reducen frustracion.

6) Panel de resumen rapido
- Tarjeta "Resumen" con:
	- Total de bloques.
	- Total de horas por docente.
	- Indicador de conflictos activos.

Razonamiento critico
- Resumen visible ayuda a saber si el horario esta "completo".
- Evita que el usuario entre a reportes solo para verificar.

7) Modales guiados (crear, editar, eliminar)
- Modal "Crear bloque":
	- Campos con borde negro y ejemplos visibles.
	- Texto de apoyo: "Ejemplo: Lunes 07:00 - 08:00".
	- Validacion en tiempo real.
- Modal "Editar bloque":
	- Resalta que se revalidan choques.
	- Boton "Guardar cambios" y "Cancelar".
- Modal "Eliminar bloque":
	- Confirmacion obligatoria.
	- Texto claro: "Esta accion no se puede deshacer".

8) Ayuda contextual para administracion
- Icono "i" en cada seccion.
- Al abrir, mostrar:
	- Que se puede hacer.
	- Que no se debe hacer.
	- Ejemplos rapidos.

Razonamiento critico
- La ayuda integrada reduce dependencia de manuales externos.
- El administrador aprende sin salir del sistema.

9) Flujo de uso recomendado (paso a paso)
1) Seleccionar grado.
2) Seleccionar grupo.
3) Cargar horario.
4) Revisar conflictos en panel lateral.
5) Agregar o editar bloques.
6) Verificar resumen.
7) Exportar o guardar.

10) Exportaciones en administracion
- Boton "Exportar PDF" y "Exportar Excel" en el encabezado.
- Boton "Exportar todos" en panel de acciones.
- Confirmacion antes de exportar masivo.

Razonamiento critico
- Exportacion masiva debe estar separada para evitar clic accidental.
- El mensaje preventivo evita que el usuario crea que el sistema se "quedo".

11) Reglas visuales especificas (blanco + bordes negros)
- Todos los contenedores con borde negro 1px.
- Los bloques de horario con borde negro 2px.
- Botones con fondo blanco y borde negro.
- Hover: fondo gris muy claro (no usar colores).
- Error: texto en rojo oscuro, borde negro igual.

12) Comodidad y accesibilidad
- Espacios amplios entre secciones.
- Fuente minima 14-16px.
- Botones grandes con texto completo.
- Estados visibles: cargando, vacio, sin conflictos.

Resumen final (vision)
- Un modulo de administracion limpio, ordenado y guiado.
- El usuario entiende el flujo paso a paso sin experiencia previa.
- El estilo blanco con bordes negros crea una interfaz seria y confiable.
