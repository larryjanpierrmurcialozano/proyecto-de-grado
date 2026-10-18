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
                   g.codigo_grupo
            FROM asistencia a
            JOIN estudiantes e ON a.id_estudiante = e.id_estudiante
            JOIN grupos g ON a.id_grupo = g.id_grupo
            WHERE 1=1
        """
        params = []
        if grupo_id:
            query += " AND a.id_grupo = %s"
            params.append(grupo_id)
        if fecha:
            query += " AND a.fecha_asistencia = %s"
            params.append(fecha)

        cursor.execute(query + " ORDER BY a.fecha_asistencia DESC, e.apellido", params)
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
            id_periodo = registro.get('id_periodo')
            if not id_periodo:
                cursor.execute(
                    "SELECT id_periodo FROM periodos WHERE estado = 'Abierto' ORDER BY numero_periodo LIMIT 1"
                )
                periodo = cursor.fetchone()
                id_periodo = periodo[0] if periodo else None
            if not id_periodo:
                return jsonify({'error': 'No hay un período abierto'}), 400
            cursor.execute("""
                INSERT INTO asistencia
                    (id_estudiante, id_grupo, id_periodo, fecha_asistencia, estado, observaciones)
                VALUES (%s, %s, %s, %s, %s, %s)
                ON CONFLICT (id_estudiante, fecha_asistencia) DO UPDATE SET
                    estado = EXCLUDED.estado, observaciones = EXCLUDED.observaciones
            """, (registro['id_estudiante'], registro['id_grupo'], id_periodo,
                  registro['fecha'], registro['estado'],
                  registro.get('observaciones')))

        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({'status': 'ok'}), 201
    except Exception as e:
        return _error_interno(e)
