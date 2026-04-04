# ══════════════════════════════════════════════════════════════════════════════
# DOCSTRY - BACKEND FLASK
# ══════════════════════════════════════════════════════════════════════════════
# Sistema de Gestión Académica
# Versión: 3.0 (Blueprints)
# ══════════════════════════════════════════════════════════════════════════════

from flask import Flask, jsonify, request, session, send_from_directory
from flask_cors import CORS
from werkzeug.exceptions import HTTPException
import os, logging, sys
from dotenv import load_dotenv
import openpyxl
from openpyxl import *
# Utilidades compartidas
from utils.database import db_config, cleanup_db_connections
from utils.constants import RUTAS_PUBLICAS

# Blueprints
from routes.auth import auth_bp
from routes.usuarios import usuarios_bp
from routes.estudiantes import estudiantes_bp
from routes.docentes import docentes_bp
from routes.academico import academico_bp
from routes.registros import registros_bp
from routes.comunicados import comunicados_bp
from routes.reportes import reportes_bp
from routes.horarios import horarios_bp
from routes.calificaciones import calificaciones_bp
from routes.asistencia import asistencia_bp
from routes.periodos import periodos_bp
from routes.observador import observador_bp
from routes.mis_clases import mis_clases_bp
# [DESHABILITADO PARA TECNÓLOGO] from routes.servicio_drive import drive_bp


# ══════════════════════════════════════════════════════════════════════════════
# CONFIGURACIÓN
# ══════════════════════════════════════════════════════════════════════════════

load_dotenv()

BASE_DIR = os.path.abspath(os.path.dirname(__file__))
TEMPLATE_DIR = os.path.join(BASE_DIR, 'backend', 'templates')
STATIC_DIR = os.path.join(BASE_DIR, 'backend', 'static')
UPLOAD_DIR = os.path.join(BASE_DIR, 'backend', 'uploads')

app = Flask(
    __name__,
    template_folder=TEMPLATE_DIR,
    static_folder=STATIC_DIR,
    static_url_path='/static'
)

CORS(app, origins=os.getenv('CORS_ORIGINS', 'http://127.0.0.1:5000,http://localhost:5000').split(','),
     supports_credentials=True)
app.secret_key = os.getenv('SECRET_KEY', 'dev_key_cambiar_en_produccion')
app.config['UPLOAD_FOLDER'] = UPLOAD_DIR

# Limpieza automatica: cierra conexiones DB que las rutas no cerraron
app.teardown_appcontext(cleanup_db_connections)

# ══════════════════════════════════════════════════════════════════════════════
# REGISTRO DE BLUEPRINTS
# ══════════════════════════════════════════════════════════════════════════════

app.register_blueprint(auth_bp)          # Páginas + Auth + Health + Dashboard
app.register_blueprint(usuarios_bp)      # CRUD Usuarios + Roles
app.register_blueprint(estudiantes_bp)   # CRUD Estudiantes
app.register_blueprint(docentes_bp)      # Docentes admin + Panel docente
app.register_blueprint(academico_bp)     # Grados, Grupos, Materias, Asignaciones, Períodos
app.register_blueprint(horarios_bp)      # CRUD Horarios + Niveles + Asignaciones-grupo
app.register_blueprint(calificaciones_bp)# Módulo Offline First de Calificaciones por Excel
app.register_blueprint(registros_bp)     # Asistencia legacy
app.register_blueprint(comunicados_bp)   # CRUD Comunicados
app.register_blueprint(reportes_bp)      # Reportes + Logs + Envío de correo
app.register_blueprint(asistencia_bp)    # Módulo de Asistencia
app.register_blueprint(periodos_bp)      # Módulo de Períodos
app.register_blueprint(observador_bp)    # Módulo Observador
app.register_blueprint(mis_clases_bp)    # Portal personal de docentes - sus clases
# [DESHABILITADO PARA TECNÓLOGO] app.register_blueprint(drive_bp)        # Módulo de integración con Google Drive

# ══════════════════════════════════════════════════════════════════════════════
# MIDDLEWARE — AUTENTICACIÓN GLOBAL
# ══════════════════════
@app.before_request
def verificar_autenticacion():
    """Verifica que toda petición a /api/ esté autenticada (excepto rutas públicas)."""
    if request.path in RUTAS_PUBLICAS:
        return None
    if request.path.startswith('/static'):
        return None
    if request.path.startswith('/api/') and 'user_id' not in session:
        return jsonify({'error': 'No autenticado'}), 401
    return None

@app.errorhandler(404)
def handle_404(e):
    """Archivos o rutas no encontrados — no contaminar logs."""
    return jsonify({'error': 'No encontrado'}), 404

@app.errorhandler(Exception)
def handle_exception(e):
    """Captura excepciones no manejadas — devuelve error genérico al cliente."""
    # No loguear errores HTTP normales (404, 405, etc.)
    if isinstance(e, HTTPException):
        return jsonify({'error': e.description}), e.code
    print(f"[ERROR] Excepcion no manejada: {e}")
    return jsonify({'error': 'Error interno del servidor'}), 500

@app.route('/favicon.ico')
def favicon():
    return send_from_directory(
        os.path.join(app.root_path, 'backend', 'static', 'img'),
        'logo.png', mimetype='image/png'
    )

# ── RUTA PARA SERVIR FRAGMENTOS HTML DE MÓDULOS DEL FRONTEND ──
@app.route('/templates/modules html/<filename>')
def serve_module_html(filename):
    """Devuelve los fragmentos HTML puros sin renderizar todo el layout."""
    import flask
    return flask.render_template(f'modules html/{filename}')

# ══════════════════════════════════════════════════════════════════════════════
# INICIO DEL SERVIDOR
# ══════════════════════════════════════════════════════════════════════════════

if __name__ == '__main__':
    # Forzar logs de peticiones visibles en consola
    logging.basicConfig(stream=sys.stderr, level=logging.DEBUG)
    werkzeug_log = logging.getLogger('werkzeug')
    werkzeug_log.setLevel(logging.INFO)
    werkzeug_log.addHandler(logging.StreamHandler(sys.stderr))

    print("\n" + "="*60)
    print("  DOCSTRY - Sistema de Gestión Académica v3.0")
    print("  Arquitectura: Flask Blueprints")
    print("="*60)
    print(f"  URL: http://127.0.0.1:5000/bienvenida")
    print(f"  Base de datos: {db_config['database']}")
    print("="*60 + "\n")
    sys.stdout.flush()

    app.run(debug=True, host='127.0.0.1', port=5000)
