# ════════════════════════════════════════════════════════════════════════════════
# FUNCIONES AUXILIARES
# ════════════════════════════════════════════════════════════════════════════════

from flask import jsonify, session
from functools import wraps
import bcrypt
from utils.database import get_db


def _error_interno(e):
    """Log error internamente y devolver respuesta genérica (sin exponer detalles al cliente)"""
    print(f"[ERROR] Error interno: {e}")
    return jsonify({'error': 'Error interno del servidor'}), 500


def hash_password(password):
    """Hashear contraseña con bcrypt (salt automático incluido)"""
    return bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')


def verify_password(password, hashed):
    """Verificar contraseña con bcrypt"""
    try:
        return bcrypt.checkpw(password.encode('utf-8'), hashed.encode('utf-8'))
    except Exception:
        return False


def log_action(id_usuario, accion, descripcion):
    """Registro de acciones (con fallback silencioso si la tabla no existe)"""
    try:
        conn = get_db()
        if not conn:
            return
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO log_registro (id_usuario, tipo_accion, descripcion) VALUES (%s, %s, %s)",
            (id_usuario, accion, descripcion)
        )
        conn.commit()
    except Exception as e:
        print(f"Log error: {e}")
    finally:
        try:
            cursor.close()
            conn.close()
        except Exception:
            pass


def role_required(required_role):
    """Decorador para validar rol en sesión y pasar current_user al handler"""
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            user_role = session.get('user_role')
            if not user_role:
                return jsonify({'error': 'No autorizado'}), 401
            normalized_required = 'server_admin' if required_role == 'admin_server' else required_role
            normalized_user = 'server_admin' if user_role == 'admin_server' else user_role
            if normalized_user != normalized_required:
                return jsonify({'error': 'Permiso denegado'}), 403

            current_user = {
                'id_usuario': session.get('user_id'),
                'nombre': session.get('user_name'),
                'rol': user_role
            }
            return func(current_user, *args, **kwargs)
        return wrapper
    return decorator
