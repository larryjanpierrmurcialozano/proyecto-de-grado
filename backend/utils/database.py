# ════════════════════════════════════════════════════════════════════════════════
# CONEXION A BASE DE DATOS — SINGLETON POOL + AUTO-CLEANUP
# ════════════════════════════════════════════════════════════════════════════════

from mysql.connector import Error
from mysql.connector.pooling import MySQLConnectionPool
from contextlib import contextmanager
import os
from dotenv import load_dotenv

load_dotenv()

db_config = {
    'host': os.getenv('DB_HOST', 'localhost'),
    'port': int(os.getenv('DB_PORT', 3306)),
    'user': os.getenv('DB_USER', 'root'),
    'password': os.getenv('DB_PASSWORD', '3202964025larry.'),
    'database': os.getenv('DB_NAME', 'anexo_de_datos')
}

# Pool unico (singleton) que se crea UNA sola vez al arrancar el servidor.
# Todas las llamadas a get_db() obtienen una conexion reutilizable del pool.
try:
    db_pool = MySQLConnectionPool(
        pool_name="docstry_pool",
        pool_size=20,
        pool_reset_session=True,
        **db_config
    )
    print("[OK] Pool Singleton inicializado (20 conexiones reutilizables)")
except Error as e:
    db_pool = None
    print(f"[ERROR] Error creando pool de BD: {e}")


# ════════════════════════════════════════════════════════════════════════════════
# SafeConnection — Wrapper que previene double-close y permite limpieza
# automatica al final de cada request Flask (teardown_appcontext).
# ════════════════════════════════════════════════════════════════════════════════

class SafeConnection:
    """Envuelve una PooledMySQLConnection para evitar fugas de conexiones.

    - Si la ruta llama conn.close(), la conexion se devuelve al pool
      y el flag _closed impide que el teardown la cierre de nuevo.
    - Si la ruta NO llama conn.close() (ej. por excepcion), el teardown
      la cierra automaticamente al final del request.
    """

    def __init__(self, conn):
        self._conn = conn
        self._closed = False

    def close(self):
        if not self._closed:
            self._closed = True
            self._conn.close()

    def __getattr__(self, name):
        return getattr(self._conn, name)

    def __setattr__(self, name, value):
        if name in ('_conn', '_closed'):
            super().__setattr__(name, value)
        else:
            setattr(self._conn, name, value)


def get_db():
    """Obtiene una conexion REUTILIZABLE del pool singleton.
    La conexion queda registrada para limpieza automatica al final del request."""
    try:
        if not db_pool:
            print("[ERROR] Pool no disponible")
            return None
        raw = db_pool.get_connection()
        conn = SafeConnection(raw)
        # Registrar para cierre automatico al final del request
        try:
            from flask import g, has_request_context
            if has_request_context():
                if not hasattr(g, '_db_conns'):
                    g._db_conns = []
                g._db_conns.append(conn)
        except Exception:
            pass
        return conn
    except Error as e:
        print(f"[ERROR] Error obteniendo conexion del pool: {e}")
        return None


def cleanup_db_connections(exception=None):
    """Cierra conexiones que quedaron abiertas al final del request.
    Se registra con app.teardown_appcontext en iniciador.py."""
    try:
        from flask import g
        conns = g.pop('_db_conns', [])
        for c in conns:
            try:
                c.close()
            except Exception:
                pass
    except Exception:
        pass


@contextmanager
def get_db_cursor(dictionary=True):
    """Context manager: abre conexion + cursor y garantiza cierre con try/finally.
    Uso: with get_db_cursor() as (conn, cursor): ..."""
    conn = get_db()
    if not conn:
        raise ConnectionError('Sin conexion a base de datos')
    cursor = conn.cursor(dictionary=dictionary)
    try:
        yield conn, cursor
    finally:
        cursor.close()
        conn.close()
