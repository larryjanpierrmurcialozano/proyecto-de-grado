# ════════════════════════════════════════════════════════════════════════════════
# BLUEPRINT: REPORTES — Reportes, correos por grupo, envío de correo, logs
# ════════════════════════════════════════════════════════════════════════════════

from flask import Blueprint, jsonify, request, session
import mysql.connector
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from datetime import datetime
import os
from utils.database import get_db
from utils.helpers import _error_interno, log_action

reportes_bp = Blueprint('reportes', __name__)

# ── Logs ─────────────────────────────────────────────────────────────────────

@reportes_bp.route('/api/logs', methods=['GET'])
def api_logs():
    """Listar logs del sistema"""
    try:
        conn = get_db()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT l.*, u.nombre as usuario_nombre, u.apellido as usuario_apellido
            FROM log_registro l
            LEFT JOIN usuarios u ON l.id_usuario = u.id_usuario
            ORDER BY l.fecha DESC
            LIMIT 100
        """)
        logs = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify({'status': 'ok', 'logs': logs}), 200
    except Exception as e:
        return _error_interno(e)

# ── Obtener grupos para reportes ─────────────────────────────────────────────

@reportes_bp.route('/api/reportes/grupos', methods=['GET'])
def api_obtener_grupos():
    """Obtiene todos los grupos con su información de grado asociado"""
    try:
        if 'user_id' not in session:
            return jsonify({'error': 'No autenticado'}), 401

        conn = get_db()
        cursor = conn.cursor(dictionary=True)

        cursor.execute("""
            SELECT
                g.id_grupo,
                g.codigo_grupo AS codigo_grupo,
                gd.nombre_grado AS nombre_grado,
                gd.id_grado
            FROM grupos g
            INNER JOIN grados gd ON g.id_grado = gd.id_grado
            ORDER BY gd.id_grado ASC, g.codigo_grupo ASC
        """)

        grupos = cursor.fetchall()
        cursor.close()
        conn.close()

        grupos_lista = []
        for g in grupos:
            item = {
                'id_grupo': int(g['id_grupo']),
                'codigo_grupo': str(g['codigo_grupo']),
                'nombre_grado': str(g['nombre_grado']),
                'id_grado': int(g['id_grado'])
            }
            grupos_lista.append(item)

        return jsonify({'status': 'ok', 'grupos': grupos_lista}), 200

    except mysql.connector.Error:
        return _error_interno(Exception('Error de base de datos al obtener grupos'))
    except Exception as e:
        return _error_interno(e)

# ── Correos por grupo ────────────────────────────────────────────────────────

@reportes_bp.route('/api/reportes/correos-grupo/<int:id_grupo>', methods=['GET'])
def api_correos_por_grupo(id_grupo):
    """Obtiene todos los correos de estudiantes de un grupo específico"""
    try:
        if 'user_id' not in session:
            return jsonify({'error': 'No autenticado'}), 401

        conn = get_db()
        cursor = conn.cursor(dictionary=True)

        cursor.execute("""
            SELECT DISTINCT e.correo
            FROM estudiantes e
            WHERE e.id_grupo = %s
            AND e.correo IS NOT NULL
            AND e.correo != ''
            AND e.estado = 'Activo'
        """, (id_grupo,))

        resultados = cursor.fetchall()
        correos = [row['correo'] for row in resultados]
        cursor.close()
        conn.close()

        return jsonify({
            'status': 'ok',
            'id_grupo': id_grupo,
            'cantidad': len(correos),
            'correos': correos
        }), 200

    except mysql.connector.Error:
        return _error_interno(Exception('Error de base de datos al obtener correos'))
    except Exception as e:
        return _error_interno(e)

# ── Envío de correo SMTP ─────────────────────────────────────────────────────

def enviar_correo_smtp(remitente, destinatarios, asunto, mensaje_html):
    """Envía correo usando SMTP (Gmail)"""
    try:
        smtp_server = os.getenv('SMTP_SERVER', 'smtp.gmail.com')
        smtp_port = int(os.getenv('SMTP_PORT', 587))
        email_cuenta = os.getenv('EMAIL_CUENTA', 'tu_email@gmail.com')
        email_password = os.getenv('EMAIL_PASSWORD', 'tu_app_password')

        mensaje = MIMEMultipart('alternative')
        mensaje['Subject'] = asunto
        mensaje['From'] = email_cuenta
        mensaje['To'] = ', '.join(destinatarios)

        html = f"""
        <html>
            <body style="font-family: Arial, sans-serif; background-color: #f5f5f5; padding: 20px;">
                <div style="max-width: 600px; margin: 0 auto; background-color: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
                    <h2 style="color: #8B6F47; border-bottom: 2px solid #8B6F47; padding-bottom: 10px;">
                        📄 Reporte de la Institución
                    </h2>
                    <div style="margin: 20px 0;">
                        <p><strong>De:</strong> {remitente}</p>
                        <p><strong>Fecha:</strong> {datetime.now().strftime('%d/%m/%Y %H:%M')}</p>
                    </div>
                    <div style="background-color: #f9f9f9; padding: 15px; border-radius: 5px; margin: 20px 0; border-left: 4px solid #8B6F47;">
                        {mensaje_html.replace(chr(10), '<br>')}
                    </div>
                    <hr style="border: none; border-top: 1px solid #ddd; margin: 20px 0;">
                    <p style="color: #999; font-size: 12px; text-align: center;">
                        Este es un correo automático del Sistema de Gestión Académica DOCSTRY
                    </p>
                </div>
            </body>
        </html>
        """

        parte_html = MIMEText(html, 'html')
        mensaje.attach(parte_html)

        with smtplib.SMTP(smtp_server, smtp_port) as servidor:
            servidor.starttls()
            servidor.login(email_cuenta, email_password)
            servidor.sendmail(email_cuenta, destinatarios, mensaje.as_string())

        return True
    except Exception as e:
        print(f"❌ Error enviando correo: {e}")
        return False


@reportes_bp.route('/api/reportes/enviar-correo', methods=['POST'])
def api_enviar_reporte_correo():
    """Envía un reporte por correo a uno o varios destinatarios"""
    try:
        if 'user_id' not in session:
            return jsonify({'error': 'No autenticado'}), 401

        data = request.get_json()
        remitente = data.get('remitente', '')
        tipo_reporte = data.get('tipoReporte', '')
        correos = data.get('correos', [])
        mensaje_usuario = data.get('mensaje', '')

        if not remitente or not tipo_reporte or not correos or not mensaje_usuario:
            return jsonify({'error': 'Faltan datos requeridos'}), 400

        if not isinstance(correos, list) or len(correos) == 0:
            return jsonify({'error': 'Correos inválidos'}), 400

        asuntos = {
            'boletin': 'Boletín de Calificaciones',
            'consolidado': 'Consolidado de Notas',
            'asistencia_diaria': 'Reporte de Asistencia Diaria',
            'estudiantes': 'Lista de Estudiantes'
        }
        asunto = asuntos.get(tipo_reporte, 'Reporte de la Institución')

        success = enviar_correo_smtp(remitente, correos, asunto, mensaje_usuario)

        if success:
            log_action(session['user_id'], 'Export',
                       f'Envió {tipo_reporte} a {len(correos)} destinatario(s)')
            return jsonify({
                'status': 'ok',
                'message': f'Reporte enviado a {len(correos)} destinatario(s)',
                'destinatarios': len(correos)
            }), 200
        else:
            return jsonify({'error': 'Error al enviar el correo'}), 502

    except Exception as e:
        print(f"Error en api_enviar_reporte_correo: {e}")
        return _error_interno(e)
