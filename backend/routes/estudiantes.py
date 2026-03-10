# ════════════════════════════════════════════════════════════════════════════════
# BLUEPRINT: ESTUDIANTES — CRUD de estudiantes
# ════════════════════════════════════════════════════════════════════════════════

from flask import Blueprint, jsonify, request
from utils.database import get_db
from utils.helpers import _error_interno

estudiantes_bp = Blueprint('estudiantes', __name__)


@estudiantes_bp.route('/api/estudiantes', methods=['GET'])
def api_estudiantes():
    """Listar estudiantes"""
    try:
        conn = get_db()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT e.*, g.codigo_grupo, gr.nombre_grado
            FROM estudiantes e
            JOIN grupos g ON e.id_grupo = g.id_grupo
            JOIN grados gr ON g.id_grado = gr.id_grado
            ORDER BY gr.id_grado, g.codigo_grupo, e.apellido
        """)
        estudiantes = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify({'status': 'ok', 'estudiantes': estudiantes}), 200
    except Exception as e:
        return _error_interno(e)


@estudiantes_bp.route('/api/estudiantes/<int:id>', methods=['GET'])
def api_estudiante_detalle(id):
    """Detalle de estudiante"""
    try:
        conn = get_db()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT e.*, g.codigo_grupo, gr.nombre_grado
            FROM estudiantes e
            JOIN grupos g ON e.id_grupo = g.id_grupo
            JOIN grados gr ON g.id_grado = gr.id_grado
            WHERE e.id_estudiante = %s
        """, (id,))
        estudiante = cursor.fetchone()
        cursor.close()
        conn.close()
        return jsonify({'status': 'ok', 'estudiante': estudiante}), 200
    except Exception as e:
        return _error_interno(e)


@estudiantes_bp.route('/api/estudiantes', methods=['POST'])
def api_estudiante_crear():
    """Crear estudiante"""
    try:
        data = request.get_json()
        conn = get_db()
        cursor = conn.cursor()
        cursor.execute("""
            INSERT INTO estudiantes (documento, nombre, apellido, fecha_nacimiento, genero,
                id_grupo, acudiente_nombre, acudiente_telefono, correo, direccion, estado)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, 'Activo')
        """, (
            data['documento'],
            data['nombre'],
            data['apellido'],
            data.get('fecha_nacimiento'),
            data.get('genero', 'M'),
            data['id_grupo'],
            data.get('acudiente_nombre'),
            data.get('acudiente_telefono'),
            data.get('correo'),
            data.get('direccion')
        ))
        conn.commit()
        nuevo_id = cursor.lastrowid
        cursor.close()
        conn.close()
        return jsonify({'status': 'ok', 'id': nuevo_id}), 201
    except Exception as e:
        return _error_interno(e)


@estudiantes_bp.route('/api/estudiantes/<int:id>', methods=['PUT'])
def api_estudiante_actualizar(id):
    """Actualizar estudiante"""
    try:
        data = request.get_json()
        conn = get_db()
        cursor = conn.cursor()
        cursor.execute("""
            UPDATE estudiantes SET documento=%s, nombre=%s, apellido=%s, fecha_nacimiento=%s, genero=%s,
                id_grupo=%s, acudiente_nombre=%s, acudiente_telefono=%s, correo=%s, direccion=%s, estado=%s
            WHERE id_estudiante=%s
        """, (
            data['documento'],
            data['nombre'],
            data['apellido'],
            data.get('fecha_nacimiento') or None,
            data.get('genero', 'M'),
            data['id_grupo'],
            data.get('acudiente_nombre'),
            data.get('acudiente_telefono'),
            data.get('correo'),
            data.get('direccion'),
            data.get('estado', 'Activo'),
            id
        ))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({'status': 'ok'}), 200
    except Exception as e:
        return _error_interno(e)


@estudiantes_bp.route('/api/estudiantes/<int:id>', methods=['DELETE'])
def api_estudiante_eliminar(id):
    """Eliminar estudiante físicamente y limpiar dependencias relacionadas"""
    try:
        conn = get_db()
        cursor = conn.cursor()

        dependencias = [
            "DELETE FROM detalle_asistencia WHERE id_estudiante = %s",
            "DELETE FROM asistencia WHERE id_estudiante = %s",
            "DELETE FROM asistencias_por_periodo WHERE id_estudiante = %s",
            "DELETE FROM justificantes_ausencia WHERE id_estudiante = %s",
            "DELETE FROM reportes_inasistencias WHERE id_estudiante = %s",
            "DELETE FROM datos_sensibles_estudiante WHERE id_estudiante = %s",
            "DELETE FROM observador WHERE id_estudiante = %s",
            "DELETE FROM notas WHERE id_estudiante = %s"
        ]

        for q in dependencias:
            cursor.execute(q, (id,))

        cursor.execute("DELETE FROM estudiantes WHERE id_estudiante = %s", (id,))
        if cursor.rowcount == 0:
            conn.rollback()
            cursor.close()
            conn.close()
            return jsonify({'error': 'Estudiante no encontrado'}), 404

        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({'status': 'ok'}), 200
    except Exception as e:
        try:
            conn.rollback()
        except Exception:
            pass
        return _error_interno(e)
