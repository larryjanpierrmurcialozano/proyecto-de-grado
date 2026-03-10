# ════════════════════════════════════════════════════════════════════════════════
# BLUEPRINT: REGISTROS — Asistencia + Observador
# ════════════════════════════════════════════════════════════════════════════════

from flask import Blueprint, jsonify, request, session
from datetime import datetime
from utils.database import get_db
from utils.helpers import _error_interno

registros_bp = Blueprint('registros', __name__)

# ── Asistencia ───────────────────────────────────────────────────────────────

@registros_bp.route('/api/asistencia', methods=['GET'])
def api_asistencia():
    """Listar asistencia"""
    try:
        grupo_id = request.args.get('grupo_id')
        fecha = request.args.get('fecha')

        conn = get_db()
        cursor = conn.cursor(dictionary=True)

        query = """
            SELECT a.*, e.nombre as estudiante_nombre, e.apellido as estudiante_apellido,
                   g.codigo_grupo, m.nombre_materia
            FROM asistencia a
            JOIN estudiantes e ON a.id_estudiante = e.id_estudiante
            JOIN grupos g ON a.id_grupo = g.id_grupo
            LEFT JOIN materias m ON a.id_materia = m.id_materia
            WHERE 1=1
        """
        params = []
        if grupo_id:
            query += " AND a.id_grupo = %s"
            params.append(grupo_id)
        if fecha:
            query += " AND a.fecha = %s"
            params.append(fecha)

        cursor.execute(query + " ORDER BY a.fecha DESC, e.apellido", params)
        asistencia = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify({'status': 'ok', 'asistencia': asistencia}), 200
    except Exception as e:
        return _error_interno(e)


@registros_bp.route('/api/asistencia', methods=['POST'])
def api_asistencia_registrar():
    """Registrar asistencia"""
    try:
        data = request.get_json()
        conn = get_db()
        cursor = conn.cursor()

        for registro in data['registros']:
            cursor.execute("""
                INSERT INTO asistencia (id_estudiante, id_grupo, id_materia, id_docente, fecha, estado, observaciones)
                VALUES (%s, %s, %s, %s, %s, %s, %s)
                ON DUPLICATE KEY UPDATE estado = VALUES(estado), observaciones = VALUES(observaciones)
            """, (registro['id_estudiante'], registro['id_grupo'], registro.get('id_materia'),
                  session.get('user_id'), registro['fecha'], registro['estado'],
                  registro.get('observaciones')))

        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({'status': 'ok'}), 201
    except Exception as e:
        return _error_interno(e)

# ── Observador ───────────────────────────────────────────────────────────────

@registros_bp.route('/api/observador', methods=['GET'])
def api_observador():
    """Listar observaciones"""
    try:
        estudiante_id = request.args.get('estudiante_id')

        conn = get_db()
        cursor = conn.cursor(dictionary=True)

        query = """
            SELECT o.*, e.nombre as estudiante_nombre, e.apellido as estudiante_apellido,
                   u.nombre as registrado_nombre, u.apellido as registrado_apellido,
                   g.codigo_grupo
            FROM observador o
            JOIN estudiantes e ON o.id_estudiante = e.id_estudiante
            JOIN usuarios u ON o.id_registrado_por = u.id_usuario
            JOIN grupos g ON e.id_grupo = g.id_grupo
            WHERE 1=1
        """
        params = []
        if estudiante_id:
            query += " AND o.id_estudiante = %s"
            params.append(estudiante_id)

        cursor.execute(query + " ORDER BY o.fecha DESC", params)
        observaciones = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify({'status': 'ok', 'observaciones': observaciones}), 200
    except Exception as e:
        return _error_interno(e)


@registros_bp.route('/api/observador', methods=['POST'])
def api_observador_crear():
    """Crear observación"""
    try:
        data = request.get_json()
        conn = get_db()
        cursor = conn.cursor()
        cursor.execute("""
            INSERT INTO observador (id_estudiante, id_registrado_por, fecha, tipo, categoria, descripcion, compromiso)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """, (data['id_estudiante'], session.get('user_id'),
              data.get('fecha', datetime.now().date()),
              data['tipo'], data.get('categoria'), data['descripcion'],
              data.get('compromiso')))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({'status': 'ok'}), 201
    except Exception as e:
        return _error_interno(e)
