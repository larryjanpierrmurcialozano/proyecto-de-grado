import os
from flask import Blueprint, jsonify, request, session
from utils.database import get_db
from utils.helpers import _error_interno

periodos_bp = Blueprint('periodos', __name__)


def _es_admin_periodos():
	rol = str(session.get('user_role') or '').strip().lower()
	return rol in ('server_admin', 'admin_server', 'admin', 'rector')


def _serializar_periodo(periodo):
	if not periodo:
		return periodo
	if periodo.get('fecha_inicio'):
		periodo['fecha_inicio'] = periodo['fecha_inicio'].isoformat()
	if periodo.get('fecha_fin'):
		periodo['fecha_fin'] = periodo['fecha_fin'].isoformat()
	return periodo


def _vaciar_archivos_directorio(ruta_base):
	"""Elimina solo archivos (no carpetas) de forma recursiva."""
	if not ruta_base or not os.path.exists(ruta_base):
		return 0

	total = 0
	for root, _, files in os.walk(ruta_base):
		for nombre in files:
			ruta = os.path.join(root, nombre)
			try:
				os.remove(ruta)
				total += 1
			except Exception:
				pass
	return total


@periodos_bp.route('/api/periodos/reset-ciclo', methods=['POST'])
def api_periodos_reset_ciclo():
	"""Resetea datos trabajados por docentes al cerrar ciclo académico."""
	conn = None
	cursor = None
	try:
		if not _es_admin_periodos():
			return jsonify({'error': 'Solo el administrador puede ejecutar este reseteo'}), 403

		conn = get_db()
		cursor = conn.cursor(dictionary=True)

		# Tablas objetivo (se limpian solo si existen en el esquema actual).
		tablas_objetivo = [
			# Calificaciones
			'notas', 'actividades_periodo', 'actividades',
			# Asistencias
			'detalle_asistencia', 'asistencias_diarias', 'asistencias_por_periodo',
			'asistencia', 'justificantes_ausencia',
			# Observador
			'observador', 'observador_anotaciones', 'observador_descargos', 'observador_compromisos',
			# Comunicados
			'comunicado_destinatarios', 'comunicado_adjuntos', 'lecturas_comunicado', 'comunicados',
			# Reportes
			'reportes', 'reportes_generados'
		]

		# No dependemos de information_schema para evitar fallos por permisos.
		# Se intenta borrar tabla por tabla de forma tolerante.
		tablas_existentes = []

		registros_db = 0
		errores_tablas = []
		cursor.execute("SET SQL_SAFE_UPDATES = 0")
		cursor.execute("SET FOREIGN_KEY_CHECKS = 0")
		for tabla in tablas_objetivo:
			try:
				cursor.execute(f"SELECT COUNT(*) AS total FROM `{tabla}`")
				row = cursor.fetchone() or {}
				registros_db += int(row.get('total') or 0)
				# WHERE 1 evita problemas en algunos motores/configuraciones con DELETE masivo.
				cursor.execute(f"DELETE FROM `{tabla}` WHERE 1")
				tablas_existentes.append(tabla)
				try:
					cursor.execute(f"ALTER TABLE `{tabla}` AUTO_INCREMENT = 1")
				except Exception:
					pass
			except Exception as tabla_err:
				# Tabla inexistente/no accesible: continuar con las demás.
				errores_tablas.append({'tabla': tabla, 'error': str(tabla_err)})
		cursor.execute("SET FOREIGN_KEY_CHECKS = 1")
		cursor.execute("SET SQL_SAFE_UPDATES = 1")

		# Limpieza de archivos trabajados por docentes.
		_here = os.path.dirname(os.path.abspath(__file__))
		_parent = os.path.dirname(_here)
		rutas_archivos = [
			os.path.join(_parent, 'backend', 'uploads', 'acuerdos_pedagogicos'),
			os.path.join(_parent, 'backend', 'uploads', 'justificantes'),
			os.path.join(_parent, 'backend', 'uploads', 'planillas'),
			os.path.join(_parent, 'backend', 'uploads', 'reportes')
		]

		archivos_eliminados = 0
		for ruta in rutas_archivos:
			archivos_eliminados += _vaciar_archivos_directorio(ruta)

		conn.commit()

		return jsonify({
			'status': 'ok' if not errores_tablas else 'partial',
			'message': 'Reseteo de ciclo ejecutado correctamente' if not errores_tablas else 'Reseteo ejecutado con advertencias',
			'tablas_limpiadas': len(tablas_existentes),
			'registros_eliminados': registros_db,
			'archivos_eliminados': archivos_eliminados,
			'errores_tablas': errores_tablas
		}), 200
	except Exception as e:
		return _error_interno(e)
	finally:
		if cursor:
			try:
				cursor.execute("SET FOREIGN_KEY_CHECKS = 1")
				cursor.execute("SET SQL_SAFE_UPDATES = 1")
			except Exception:
				pass
			try:
				cursor.close()
			except Exception:
				pass
		if conn:
			try:
				conn.close()
			except Exception:
				pass


@periodos_bp.route('/api/periodos', methods=['GET'])
def api_periodos_listar():
	"""Lista períodos académicos ordenados por número."""
	try:
		conn = get_db()
		cursor = conn.cursor(dictionary=True)
		cursor.execute("SELECT * FROM periodos ORDER BY numero_periodo")
		periodos = [_serializar_periodo(p) for p in cursor.fetchall()]
		cursor.close()
		conn.close()
		return jsonify({'status': 'ok', 'periodos': periodos}), 200
	except Exception as e:
		return _error_interno(e)


@periodos_bp.route('/api/periodos', methods=['POST'])
def api_periodo_crear():
	"""Crea un nuevo período académico."""
	try:
		if not _es_admin_periodos():
			return jsonify({'error': 'Solo el administrador puede modificar períodos'}), 403

		data = request.get_json() or {}
		nombre_periodo = (data.get('nombre_periodo') or '').strip()
		numero_periodo = data.get('numero_periodo')
		fecha_inicio = data.get('fecha_inicio')
		fecha_fin = data.get('fecha_fin')

		if not nombre_periodo or not numero_periodo or not fecha_inicio or not fecha_fin:
			return jsonify({'error': 'Faltan datos obligatorios del período'}), 400

		conn = get_db()
		cursor = conn.cursor(dictionary=True)

		cursor.execute("SELECT id_periodo FROM periodos WHERE numero_periodo = %s LIMIT 1", (numero_periodo,))
		if cursor.fetchone():
			cursor.close()
			conn.close()
			return jsonify({'error': 'Ya existe un período con ese número'}), 400

		estado = data.get('estado', 'Cerrado')
		if estado not in ('Abierto', 'Cerrado'):
			estado = 'Cerrado'

		if estado == 'Abierto':
			cursor.execute("UPDATE periodos SET estado = 'Cerrado' WHERE estado = 'Abierto'")

		cursor.execute(
			"""
			INSERT INTO periodos (numero_periodo, nombre_periodo, fecha_inicio, fecha_fin, estado)
			VALUES (%s, %s, %s, %s, %s)
			""",
			(numero_periodo, nombre_periodo, fecha_inicio, fecha_fin, estado)
		)
		conn.commit()

		nuevo_id = cursor.lastrowid
		cursor.execute("SELECT * FROM periodos WHERE id_periodo = %s", (nuevo_id,))
		periodo = _serializar_periodo(cursor.fetchone())

		cursor.close()
		conn.close()
		return jsonify({'status': 'ok', 'periodo': periodo}), 201
	except Exception as e:
		return _error_interno(e)


@periodos_bp.route('/api/periodos/<int:id_periodo>', methods=['PUT'])
def api_periodo_actualizar(id_periodo):
	"""Actualiza un período existente."""
	try:
		if not _es_admin_periodos():
			return jsonify({'error': 'Solo el administrador puede modificar períodos'}), 403

		data = request.get_json() or {}
		nombre_periodo = (data.get('nombre_periodo') or '').strip()
		numero_periodo = data.get('numero_periodo')
		fecha_inicio = data.get('fecha_inicio')
		fecha_fin = data.get('fecha_fin')

		if not nombre_periodo or not numero_periodo or not fecha_inicio or not fecha_fin:
			return jsonify({'error': 'Faltan datos obligatorios del período'}), 400

		conn = get_db()
		cursor = conn.cursor(dictionary=True)

		cursor.execute("SELECT id_periodo FROM periodos WHERE id_periodo = %s LIMIT 1", (id_periodo,))
		if not cursor.fetchone():
			cursor.close()
			conn.close()
			return jsonify({'error': 'Período no encontrado'}), 404

		cursor.execute(
			"""
			SELECT id_periodo FROM periodos
			WHERE numero_periodo = %s AND id_periodo <> %s
			LIMIT 1
			""",
			(numero_periodo, id_periodo)
		)
		if cursor.fetchone():
			cursor.close()
			conn.close()
			return jsonify({'error': 'Ya existe otro período con ese número'}), 400

		cursor.execute(
			"""
			UPDATE periodos
			SET numero_periodo = %s,
				nombre_periodo = %s,
				fecha_inicio = %s,
				fecha_fin = %s
			WHERE id_periodo = %s
			""",
			(numero_periodo, nombre_periodo, fecha_inicio, fecha_fin, id_periodo)
		)
		conn.commit()

		cursor.execute("SELECT * FROM periodos WHERE id_periodo = %s", (id_periodo,))
		periodo = _serializar_periodo(cursor.fetchone())

		cursor.close()
		conn.close()
		return jsonify({'status': 'ok', 'periodo': periodo}), 200
	except Exception as e:
		return _error_interno(e)


@periodos_bp.route('/api/periodos/<int:id_periodo>/estado', methods=['PUT'])
def api_periodo_cambiar_estado(id_periodo):
	"""Abre o cierra un período. Solo se permite uno abierto a la vez."""
	try:
		if not _es_admin_periodos():
			return jsonify({'error': 'Solo el administrador puede modificar períodos'}), 403

		data = request.get_json() or {}
		nuevo_estado = data.get('estado')
		if nuevo_estado not in ('Abierto', 'Cerrado'):
			return jsonify({'error': 'Estado inválido'}), 400

		conn = get_db()
		cursor = conn.cursor(dictionary=True)

		cursor.execute("SELECT id_periodo FROM periodos WHERE id_periodo = %s LIMIT 1", (id_periodo,))
		if not cursor.fetchone():
			cursor.close()
			conn.close()
			return jsonify({'error': 'Período no encontrado'}), 404

		if nuevo_estado == 'Abierto':
			cursor.execute("UPDATE periodos SET estado = 'Cerrado' WHERE estado = 'Abierto'")

		cursor.execute("UPDATE periodos SET estado = %s WHERE id_periodo = %s", (nuevo_estado, id_periodo))
		conn.commit()

		cursor.execute("SELECT * FROM periodos WHERE id_periodo = %s", (id_periodo,))
		periodo = _serializar_periodo(cursor.fetchone())
		cursor.close()
		conn.close()
		return jsonify({'status': 'ok', 'periodo': periodo}), 200
	except Exception as e:
		return _error_interno(e)


@periodos_bp.route('/api/periodos/resumen', methods=['GET'])
def api_periodos_resumen():
	"""Resumen por grado y grupo del avance de notas en un período."""
	try:
		periodo_id = request.args.get('periodo_id', type=int)
		if not periodo_id:
			return jsonify({'error': 'Debe enviar periodo_id'}), 400

		conn = get_db()
		cursor = conn.cursor(dictionary=True)

		cursor.execute("SELECT id_periodo FROM periodos WHERE id_periodo = %s LIMIT 1", (periodo_id,))
		if not cursor.fetchone():
			cursor.close()
			conn.close()
			return jsonify({'error': 'Período no encontrado'}), 404

		cursor.execute(
			"""
			SELECT
				g.id_grado,
				g.numero_grado,
				g.nombre_grado,
				gr.id_grupo,
				gr.codigo_grupo,
				COUNT(DISTINCT e.id_estudiante) AS total_estudiantes,
				COUNT(DISTINCT a.id_materia) AS total_materias,
				COUNT(DISTINCT CASE WHEN n.id_periodo = %s THEN CONCAT(n.id_estudiante, '-', n.id_materia) END) AS registros_cargados
			FROM grados g
			JOIN grupos gr ON gr.id_grado = g.id_grado
			LEFT JOIN estudiantes e ON e.id_grupo = gr.id_grupo AND e.estado = 'Activo'
			LEFT JOIN asignaciones_docente a ON a.id_grupo = gr.id_grupo AND a.estado = 'Activa'
			LEFT JOIN notas n ON n.id_estudiante = e.id_estudiante
			GROUP BY g.id_grado, g.numero_grado, g.nombre_grado, gr.id_grupo, gr.codigo_grupo
			ORDER BY g.numero_grado, gr.codigo_grupo
			""",
			(periodo_id,)
		)
		rows = cursor.fetchall()

		grados_map = {}
		for row in rows:
			id_grado = row['id_grado']
			if id_grado not in grados_map:
				grados_map[id_grado] = {
					'id_grado': id_grado,
					'numero_grado': row['numero_grado'],
					'nombre_grado': row['nombre_grado'],
					'grupos': [],
					'grupos_count': 0,
					'completos': 0,
					'pendientes': 0
				}

			total_estudiantes = int(row['total_estudiantes'] or 0)
			total_materias = int(row['total_materias'] or 0)
			registros_cargados = int(row['registros_cargados'] or 0)

			esperado = total_estudiantes * total_materias if total_materias > 0 else total_estudiantes
			progreso = 100 if esperado == 0 else round((registros_cargados / esperado) * 100, 1)

			grados_map[id_grado]['grupos'].append({
				'id_grupo': row['id_grupo'],
				'codigo_grupo': row['codigo_grupo'],
				'total_estudiantes': total_estudiantes,
				'total_materias': total_materias,
				'registros_cargados': registros_cargados,
				'registros_esperados': esperado,
				'progreso': progreso
			})
			grados_map[id_grado]['grupos_count'] += 1
			grados_map[id_grado]['completos'] += registros_cargados
			grados_map[id_grado]['pendientes'] += max(esperado - registros_cargados, 0)

		cursor.close()
		conn.close()

		grados = list(grados_map.values())
		return jsonify({'status': 'ok', 'grados': grados}), 200
	except Exception as e:
		return _error_interno(e)
