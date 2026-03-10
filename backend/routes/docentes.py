# ════════════════════════════════════════════════════════════════════════════════
# BLUEPRINT: DOCENTES — Admin + Panel del docente
# ════════════════════════════════════════════════════════════════════════════════

from flask import Blueprint, jsonify, request, session
from datetime import datetime
from utils.database import get_db
from utils.helpers import _error_interno

docentes_bp = Blueprint('docentes', __name__)

# ── Admin de docentes ────────────────────────────────────────────────────────

@docentes_bp.route('/api/docentes', methods=['GET'])
def api_docentes():
    """Listar docentes con sus asignaciones"""
    try:
        conn = get_db()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
             SELECT u.id_usuario, u.documento, u.nombre, u.apellido, u.correo, u.is_activo,
                 COUNT(DISTINCT a.id_asignacion) as total_asignaciones,
                 COUNT(DISTINCT a.id_grado) as total_grados,
                 GROUP_CONCAT(DISTINCT m.nombre_materia ORDER BY m.nombre_materia SEPARATOR ', ') AS materias,
                 GROUP_CONCAT(DISTINCT g.nombre_grado ORDER BY g.numero_grado SEPARATOR ', ') AS grados
             FROM usuarios u
             LEFT JOIN asignaciones_docente a ON u.id_usuario = a.id_usuario AND a.estado = 'Activa'
             LEFT JOIN materias m ON a.id_materia = m.id_materia
             LEFT JOIN grados g ON a.id_grado = g.id_grado
             WHERE u.id_rol = 4
             GROUP BY u.id_usuario
             ORDER BY u.apellido, u.nombre
        """)
        docentes = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify({'status': 'ok', 'docentes': docentes}), 200
    except Exception as e:
        return _error_interno(e)


@docentes_bp.route('/api/docentes/disponibles', methods=['GET'])
def api_docentes_disponibles():
    """Lista simple de usuarios con rol Profesor activos para selección"""
    try:
        conn = get_db()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT u.id_usuario, u.documento, u.nombre, u.apellido, u.correo, u.is_activo
            FROM usuarios u
            WHERE u.id_rol = 4 AND u.is_activo = 1
            ORDER BY u.apellido, u.nombre
        """)
        docentes = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify({'status': 'ok', 'docentes': docentes}), 200
    except Exception as e:
        return _error_interno(e)


@docentes_bp.route('/api/docentes/<int:id>/asignaciones', methods=['GET'])
def api_docente_asignaciones(id):
    """Asignaciones de un docente"""
    try:
        conn = get_db()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT a.*, m.nombre_materia, g.nombre_grado
            FROM asignaciones_docente a
            JOIN materias m ON a.id_materia = m.id_materia
            JOIN grados g ON a.id_grado = g.id_grado
            WHERE a.id_usuario = %s
        """, (id,))
        asignaciones = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify({'status': 'ok', 'asignaciones': asignaciones}), 200
    except Exception as e:
        return _error_interno(e)


@docentes_bp.route('/api/docentes/<int:id>/asignaciones', methods=['POST'])
def api_docente_guardar_asignaciones(id):
    """Reemplaza las asignaciones de un docente con la lista enviada"""
    try:
        data = request.get_json()
        asignaciones = data.get('asignaciones', [])

        conn = get_db()
        cursor = conn.cursor()

        cursor.execute("DELETE FROM asignaciones_docente WHERE id_usuario = %s", (id,))

        for a in asignaciones:
            cursor.execute("""
                INSERT INTO asignaciones_docente (id_usuario, id_materia, id_grado, año_lectivo, estado)
                VALUES (%s, %s, %s, %s, %s)
            """, (
                id,
                a['id_materia'],
                a['id_grado'],
                a.get('año_lectivo', datetime.now().year),
                a.get('estado', 'Activa')
            ))

        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({'status': 'ok'}), 200
    except Exception as e:
        return _error_interno(e)


@docentes_bp.route('/api/docentes/<int:id>/grados-grupos', methods=['GET'])
def api_docente_grados_grupos(id):
    """Obtener grados y grupos donde el docente tiene asignaciones activas"""
    try:
        conn = get_db()
        cursor = conn.cursor(dictionary=True)

        # Grados distintos del docente
        cursor.execute("""
            SELECT g.id_grado, g.nombre_grado, g.numero_grado
            FROM grados g
            WHERE g.id_grado IN (
                SELECT DISTINCT a.id_grado
                FROM asignaciones_docente a
                WHERE a.id_usuario = %s AND a.estado = 'Activa'
            )
            ORDER BY g.numero_grado
        """, (id,))
        grados = cursor.fetchall()

        # Grupos distintos del docente (con su grado)
        cursor.execute("""
            SELECT gr.id_grupo, gr.codigo_grupo, gr.id_grado,
                   g.nombre_grado, g.numero_grado
            FROM grupos gr
            JOIN grados g ON gr.id_grado = g.id_grado
            WHERE gr.id_grupo IN (
                SELECT DISTINCT a.id_grupo
                FROM asignaciones_docente a
                WHERE a.id_usuario = %s AND a.estado = 'Activa'
            )
            ORDER BY g.numero_grado, gr.codigo_grupo
        """, (id,))
        grupos = cursor.fetchall()

        cursor.close()
        conn.close()
        return jsonify({'status': 'ok', 'grados': grados, 'grupos': grupos}), 200
    except Exception as e:
        return _error_interno(e)


# ── Panel del docente (mis-clases, mis-materias, mi-horario) ─────────────────

@docentes_bp.route('/api/docente/mis-clases', methods=['GET'])
def api_docente_mis_clases():
    """Clases del docente actual"""
    if 'user_id' not in session:
        return jsonify({'error': 'No autenticado'}), 401

    try:
        conn = get_db()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT DISTINCT g.id_grupo, g.codigo_grupo, gr.nombre_grado, gr.id_grado,
                   COUNT(DISTINCT e.id_estudiante) as total_estudiantes,
                   COUNT(DISTINCT a.id_materia) as total_materias
            FROM asignaciones_docente a
            JOIN grados gr ON a.id_grado = gr.id_grado
            JOIN grupos g ON g.id_grado = gr.id_grado
            LEFT JOIN estudiantes e ON g.id_grupo = e.id_grupo AND e.estado = 'Activo'
            WHERE a.id_usuario = %s AND a.estado = 'Activa'
            GROUP BY g.id_grupo
            ORDER BY gr.numero_grado, g.codigo_grupo
        """, (session['user_id'],))
        clases = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify({'status': 'ok', 'clases': clases}), 200
    except Exception as e:
        return _error_interno(e)


@docentes_bp.route('/api/docente/mis-materias', methods=['GET'])
def api_docente_mis_materias():
    """Materias del docente actual"""
    if 'user_id' not in session:
        return jsonify({'error': 'No autenticado'}), 401

    try:
        conn = get_db()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT DISTINCT m.id_materia, m.nombre_materia, m.codigo_materia, m.intensidad_horaria,
                   GROUP_CONCAT(DISTINCT gr.nombre_grado ORDER BY gr.numero_grado SEPARATOR ', ') as grados
            FROM asignaciones_docente a
            JOIN materias m ON a.id_materia = m.id_materia
            JOIN grados gr ON a.id_grado = gr.id_grado
            WHERE a.id_usuario = %s AND a.estado = 'Activa'
            GROUP BY m.id_materia
            ORDER BY m.nombre_materia
        """, (session['user_id'],))
        materias = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify({'status': 'ok', 'materias': materias}), 200
    except Exception as e:
        return _error_interno(e)


@docentes_bp.route('/api/docente/mi-horario', methods=['GET'])
def api_docente_mi_horario():
    """Horario del docente actual"""
    if 'user_id' not in session:
        return jsonify({'error': 'No autenticado'}), 401

    try:
        conn = get_db()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT h.*, g.codigo_grupo, m.id_materia, m.nombre_materia, gr.nombre_grado
            FROM horarios h
            JOIN grupos g ON h.id_grupo = g.id_grupo
            JOIN grados gr ON g.id_grado = gr.id_grado
            JOIN asignaciones_docente a ON h.id_asignacion = a.id_asignacion
            JOIN materias m ON a.id_materia = m.id_materia
            WHERE a.id_usuario = %s
            ORDER BY FIELD(h.dia_semana, 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes'), h.hora_inicio
        """, (session['user_id'],))
        horario = cursor.fetchall()

        # Convertir timedelta a string "HH:MM"
        for h in horario:
            for campo in ('hora_inicio', 'hora_fin'):
                val = h.get(campo)
                if val is not None and not isinstance(val, str):
                    total = int(val.total_seconds())
                    h[campo] = f"{total // 3600:02d}:{(total % 3600) // 60:02d}"

        cursor.close()
        conn.close()
        return jsonify({'status': 'ok', 'horario': horario}), 200
    except Exception as e:
        return _error_interno(e)
