if __name__ == '__main__':
    import traceback
    import sys, os

    # Asegurar que el paquete `utils` y `routes` sean importables cuando se ejecuta
    # este script desde la raíz del repositorio o desde cualquier otra ruta.
    THIS_DIR = os.path.dirname(os.path.abspath(__file__))
    BACKEND_DIR = os.path.dirname(THIS_DIR)
    if BACKEND_DIR not in sys.path:
        sys.path.insert(0, BACKEND_DIR)

    from utils.database import get_db
    from routes import calificaciones
    
    try:
        conn = get_db()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT id_grado, id_grupo, id_materia FROM asignaciones_docente WHERE estado = 'Activa' LIMIT 10")
        asigns = cursor.fetchall()
        print(f"Found {len(asigns)} asignaciones (limite 10)")
        for a in asigns:
            try:
                print(f"Generando excel para: grado={a['id_grado']}, grupo={a['id_grupo']}, materia={a['id_materia']}")
                path = calificaciones._crear_excel_fisico(a['id_grado'], a['id_grupo'], a['id_materia'], force_recreate=True)
                print('-> OK, ruta:', path)
            except Exception as e:
                print('-> Error al crear excel para', a)
                traceback.print_exc()
    except Exception as e:
        print('Error general:')
        traceback.print_exc()