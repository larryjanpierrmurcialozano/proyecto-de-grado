"""Script de prueba: crea una planilla usando la función interna del módulo calificaciones.
Busca la primera combinación grupo × materia en la DB y llama a `_crear_excel_fisico`.
Imprime la ruta creada o errores.
"""
import sys
import os

# Asegurar que el paquete backend esté en sys.path
_here = os.path.dirname(os.path.dirname(__file__))
if _here not in sys.path:
    sys.path.insert(0, _here)

from routes import calificaciones
from utils.database import get_db

def main():
    try:
        conn = get_db()
        cur = conn.cursor(dictionary=True)
        cur.execute("SELECT id_grupo, id_grado FROM grupos LIMIT 1")
        grupo = cur.fetchone()
        cur.execute("SELECT id_materia FROM materias LIMIT 1")
        materia = cur.fetchone()
        cur.close(); conn.close()

        if not grupo or not materia:
            print('[test] No hay datos de grupos o materias en la BD para crear la planilla')
            return

        ruta = calificaciones._crear_excel_fisico(grupo['id_grado'], grupo['id_grupo'], materia['id_materia'], periodo_id=1, force_recreate=True)
        if ruta:
            print('[OK] Archivo creado en:', ruta)
        else:
            print('[ERR] La función devolvió None')
    except Exception as e:
        import traceback
        traceback.print_exc()

if __name__ == '__main__':
    main()
