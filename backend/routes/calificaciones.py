# 
# 
# indicaciones by larry.ai.chan.uwu.rmppnochas3000 :D 
# el id de periodo es el que permite modificar el archivo excel, si el id de periodo esta desactivado desde el futuro modulo de periodos, el cual la idea es que cierre el permiso de modificaciones, el cual en algun futuro se añadira
# en calificaciones se requiere que los excel se rellenen con los nombre de los estudiantes y los partes de las notas las cuales deben ser modificables dentro de la app
# Calificaciones sistema de gestion de calificaciones, CRUD de calificaciones, listado de calificaciones por curso, etc. 
# ═══════════════════════════════════════════════════════════════════════════════
# BLUEPRINT: CALIFICACIONES — CRUD de calificaciones, listado de calificaciones por curso
# todo el modulo de calificaciones funciona como un sistema local, el cual usara los archivos, tanto a nivel locar como a nivel de servidor, 
# para almacenar las calificaciones, esto con el fin de evitar problemas de concurrencia y bloqueo de base de datos, 
# ademas de que se podra usar en modo offline, y luego sincronizar con el servidor cuando se tenga conexion a internet.
# todo se tratara de guardar en formato excel, usando libreria openpyxl, y se guardara en una carpeta especifica para cada curso, 
# dentro de una carpeta general de calificaciones, esto con el fin de mantener un orden y facilitar la busqueda de las calificaciones. 
#   todo se tendra una estructura de carpetas asi:
#   calificaciones/
#       grado #/ 
#                grupo #/ 
#                          materias #/
#           materia_#_#_(en este espacio de numeral para materias se decidira poner 2 valores tipo el grado y grupo perteneciente, siendo tal que se vea "materia_g6_A_calificaciones.xlsx")calificaciones.xlsx
#           calificaciones.xlsx / todo para cada curso por grupos
#  el chiste de todo es usar archivos excel como referencia, que sean editable dentro de la aplicacion 
# y que se puedan descargar o subir al sistema para asi mantener cierta flexibilidad y facilidad de uso.
# este sistema tambien podra incluir funcionalidades como el calculo de promedios, la generacion de reportes, la exportacion a pdf, etc.
# todo se tendra una ruta para cada funcionalidad, por ejemplo:
#   /calificaciones/grado_#_calificaciones/grupo_#_calificaciones.xlsx
#       GET: devuelve el archivo excel con las calificaciones del grado # y del grupo #
#       POST: recibe un archivo excel con las calificaciones del grado # y del grupo #, y lo guarda en el archivo correspondiente
#       PUT: actualiza las calificaciones del grado # y del grupo #, basadas en el archivo excel recibido
#       DELETE: elimina el archivo excel con las calificaciones del grado #
# grado (#) es literal como señalo el grado tipo 1 2 3 4 5 6 7 8 9 10 11, y se usara como parte del nombre del archivo y de la carpeta.
# sin embargo la idea es que se autogeneren estas funcionalidad de manera dinamica, es decir, 
# que se tenga una ruta general para cada curso, y que se maneje el archivo excel de manera dinamica, 
# sin necesidad de tener una ruta especifica para cada curso, esto con el fin de evitar la redundancia y facilitar el mantenimiento del codigo.
# tambien hay que tener claro que lo que se busca es que al generar el excel de cada grado se autogenere con el valor seleccionado 
# salido de la lista, tipo en caso de seleccionar el grado 7, que se genere la carpeta con el nombre,
# /grado_7_calificaciones(calificaciones/grado_7_calificaciones/grupo_A_calificaciones.xlsx(la idea en la que pongo grupo es para,
# tener la identificacion de que esa planilla es para ese grupo en especifico, con la idea de que al crear la carpeta para los archivos .xlsx ,
# seria que el propio coso genere segun los grupos existentes, osea seria tipo si hay un grupo, que se autogenere el xlsx para el grupo, 
# si se elimina el grupo, se prioriza que quede un precedente del archivo, para esto es la idea de que al crear estas carpetas, 
# dentro del propio dispositivo se tenga un archivo de respaldo donde se guarden todos los excel que esten hechos con sus modificaciones 
# hasta el ultimo momento en el que existieron o hubo un ultimo cambio)), y que al descargarlo se descargue con ese nombre, y al subirlo se suba 
# con ese nombre
# que se guarde en la carpeta correspondiente, y que al descargarlo se descargue con ese nombre, y al subirlo se suba con ese nombre, 
# claro, se creara es una carpeta del grado con el nombre del grado, y dentro de esa carpeta se creara un archivo excel con el nombre del grupo, 
# esto con el fin de mantener un orden y facilitar la busqueda de las calificaciones.
# se puede mantener un control de archivos dentro del modulo grafico de calificaciones, no se muy bien como se deberia ver, pero tengo una idea,
# podria recrear una especia de explorador de archivos dentro del modulo de calificaciones, donde se pueda ver la estructura de carpetas y archivos,
# y se pueda navegar por ella y se pueda selecionar todos las carpetas y rutas, sin importar si es profesor o admin, cada uno tendra un sistema de
# gestion de carpetas propio, claro la idea es que el profesor solo vea las carpetas y archivos que le corresponden a sus grados y grupos de
# materias asignadas, y el admin/director/cordinador, tendra una vista de todas las carpetas y archivos dentro del sistema, todo organizado
# en escala de grados y grupos como esta ya diseñado, la idea es que cada grupo con una materia asiganada tenga un archivo de calificaciones,
# claro, seria una estructura mucho mas compleja, puesto que cada grado deberia tener su planilla de cada materia que tiene asignada, 
# entonces seria algo asi: 
# /calificaciones/grado_#(# = numero de grado sea sexto septimo y asi)/grupo_# (siendo el # el grupo que sea tipo a, b, o c)/materias_#/materia_#_#_calificaciones.xlsx
# regulacion, lee la base de datos para entender estructura completa, te especifico las tablas que usaras para construir estas indicaciones

# ═══════════════════════════════════════════════════════════════════════════════
# BLUEPRINT: CALIFICACIONES — Sistema Híbrido (Archivos Locales + Sincronización DB)
# ═══════════════════════════════════════════════════════════════════════════════
#
# CONCEPTO ARQUITECTÓNICO DEL MÓDULO: "Tolerancia a fallos y Trabajo Offline"
# --------------------------------------------------------------------------------
# Este módulo se basa en un enfoque híbrido, combinando la flexibilidad de uso de 
# archivos Excel (carpetas locales) con la rapidez y seguridad de una Base de Datos (MySQL).
#
# 1. ALMACENAMIENTO FÍSICO JERÁRQUICO (El corazón local/offline):
#    - El sistema será el encargado ÚNICO de CREAR los archivos Excel.
#    - Mantiene una estructura de carpetas física y persistente: EJEMPLO:
#      /planillas_locales/Grado_7/Grupo_A/materia_Matematicas_G7_A.xlsx
#    - Esto asegura que la App/Web pueda funcionar incluso si no hay conexión 
#      momentánea a la base de datos principal, manteniendo los Excel en su directorio.
#
# 2. SISTEMA DE RESPALDO Y VERSIONADO ("El Archivador Histórico"):
#    - NUNCA se sobreescribe destructivamente un Excel modificado. 
#    - Al subir un Excel con nuevas calificaciones, la versión anterior se mueve a 
#      una subcarpeta /historial_respaldos/ con marca de tiempo (ej. ..._v20260313.xlsx).
#    - Estos archivos se guardan permanentemente y SOLO se borran por mantenimiento 
#      directo de sistema o DB (nunca desde la interfaz normal del usuario).
#
# 3. SINCRONIZACIÓN AUTOMÁTICA HACIA LA BASE DE DATOS:
#    - Cuando hay internet/conexión a la base de datos, el sistema lee el archivo 
#      Excel ingresado/modificado y "sincroniza" esos datos, rellenando las tablas:
#      `notas`, `estudiantes`, `actividades`, etc.
#    - La base de datos mantiene lectura constante de estos envíos. Generar los Excel
#      siempre se hace en base a la info maestra.
#
# 4. EXCEL CONTROLADOS:
#    - Los archivos generados por el sistema bloquearán las zonas de nombres/id, 
#      permitiendo al docente llenar solo las notas.
#    - Los IDs de estudiantes / notas, en lugar de estar ocultos en el Excel, serán
#      manejables o visibles de forma opcional DENTRO de la interfaz web/app del 
#      sistema, no estorbando en el propio archivo físico .xlsx esto con el fin de 
#      que al desear imprimir o descargar el archivo, se tenga un formato limpio y 
#      profesional, pero a su vez, al subirlo, el sistema pueda reconocer los datos y 
#      sincronizarlos con la base de datos sin problemas.
#
# RUTAS CORE A IMPLEMENTAR:
# - GET/POST `/api/calificaciones/estructura_carpetas`: Explora y crea la jerarquía.
# - GET `/api/calificaciones/generar_planilla`: Crea el Excel bloqueado físicamente.
# - POST `/api/calificaciones/subir_planilla`: Recibe Excel, versiona el anterior, guarda y sincroniza DB.
#
# LIBRERÍAS CLAVE: os (rutas), shutil (movimiento de historiales), openpyxl (creación/lectura de Excel).ahora quiero que ya funcionando la creacion de excel, sirva la sincronizacion del escritorio con el "server", osea que si se crean archivos o excel en el escritorio principal, se carguen en el server ahi te mostre donde tengo los archivos dentro del "server" para que se sincronice los archivos del escritorio y se suban a donde corresponden automaticamente, evitando lo de tener que crear el get de cada excel, tipo la idea es que los que crean la planilla son la coordinadora y roles superiores, el rol de profesores no lo vera pero no nos preocupemos por eso de momento, por ahora concentremonos en hacer funcionar lo que hay
# ═══════════════════════════════════════════════════════════════════════════════


import sys
import os

# Si el archivo se ejecuta directamente (p. ej. `python backend/routes/calificaciones.py`),
# asegurar que la carpeta `backend` esté en sys.path para poder importar `utils`.
_here = os.path.dirname(os.path.abspath(__file__))  # .../backend/routes
_backend_root = os.path.dirname(_here)               # .../backend
if _backend_root not in sys.path:
    sys.path.insert(0, _backend_root)

from flask import Blueprint, jsonify, request, send_file
import mysql.connector
import shutil
import openpyxl
from openpyxl.styles import Font, PatternFill, Alignment, Protection
from openpyxl.worksheet.protection import SheetProtection
from datetime import datetime
from utils.database import get_db
from utils.helpers import _error_interno

calificaciones_bp = Blueprint('calificaciones', __name__)

# ── CONFIGURACIÓN DE CARPETAS LOCALES (EN EL ESCRITORIO DEL USUARIO) ────────

def obtener_ruta_escritorio():
    usuario_dir = os.path.expanduser("~")
    # Intentar varias rutas comunes (Windows en español, OneDrive, etc.)
    rutas_posibles = [
        os.path.join(usuario_dir, "OneDrive", "Escritorio"),
        os.path.join(usuario_dir, "Desktop"),
        os.path.join(usuario_dir, "Escritorio")
    ]
    for ruta in rutas_posibles:
        if os.path.exists(ruta):
            return ruta
    return usuario_dir # Fallback

ESCRITORIO = obtener_ruta_escritorio()
PLANILLAS_DIR = os.path.join(ESCRITORIO, 'Planillas_DocstrY')
HISTORIAL_DIR = os.path.join(ESCRITORIO, 'Planillas_DocstrY_Historial')

# Garantizar que el Archivador Histórico y la Carpeta Local existan al iniciar
os.makedirs(PLANILLAS_DIR, exist_ok=True)
os.makedirs(HISTORIAL_DIR, exist_ok=True)

# ======= INVENTARIO RÁPIDO (generado por el agente) =======
# Contenido relevante en el workspace `backend`:
# - Archivos/dirs raíz dentro de `backend`: .env, iniciador.py, instalador_imports.py,
#   CONFIG_CORREOS.md, requirements.txt, requirements_limpio.txt, planillas_locales/, historial_respaldos/, scripts/, utils/, routes/, backend/ (estáticos y templates).
# - `backend/backend/static/` contiene activos JS/CSS y `backend/backend/static/js/modules/calificaciones.js`.
# - `backend/routes/` contiene endpoints incluyendo `calificaciones.py` (este archivo), `estudiantes.py`, `docentes.py`, `grados.py` (si aplica), etc.
# - `backend/utils/` contiene `database.py` (pool), `helpers.py` (decoradores y utilidades), `constants.py`.
# Propósito: este inventario documenta qué hay en el proyecto y ayuda a reproducir opciones (UI/API)
# ======================================================



def _crear_excel_fisico(grado_id, grupo_id, materia_id, periodo_id=1, force_recreate=False):
    """Función interna para crear un archivo Excel si no existe o se requiere forzar"""
    conn = get_db()
    cursor = conn.cursor(dictionary=True)
    # 1. Obtener la info del Grado, Grupo y Materia para el nombre del archivo
    info = {}
    try:
        cursor.execute("SELECT id_grado, numero_grado FROM grados WHERE id_grado = %s", (grado_id,))
        g = cursor.fetchone()
        if g:
            info['id_grado'] = g.get('id_grado')
            info['numero_grado'] = g.get('numero_grado')
        else:
            print(f"[calificaciones] Aviso: grado id={grado_id} no encontrado en DB")

        cursor.execute("SELECT id_grupo, codigo_grupo, id_grado FROM grupos WHERE id_grupo = %s", (grupo_id,))
        gr = cursor.fetchone()
        if gr:
            info['id_grupo'] = gr.get('id_grupo')
            info['codigo_grupo'] = gr.get('codigo_grupo')
            if 'numero_grado' not in info and gr.get('id_grado'):
                cursor.execute("SELECT numero_grado FROM grados WHERE id_grado=%s", (gr.get('id_grado'),))
                gg = cursor.fetchone()
                if gg:
                    info['numero_grado'] = gg.get('numero_grado')
        else:
            print(f"[calificaciones] Aviso: grupo id={grupo_id} no encontrado en DB")

        cursor.execute("SELECT id_materia, nombre_materia, codigo_materia FROM materias WHERE id_materia = %s", (materia_id,))
        m = cursor.fetchone()
        if m:
            info['id_materia'] = m.get('id_materia')
            info['nombre_materia'] = m.get('nombre_materia')
            info['codigo_materia'] = m.get('codigo_materia')
        else:
            print(f"[calificaciones] Aviso: materia id={materia_id} no encontrada en DB")
    except Exception as e:
        print('[calificaciones] Error consultando metadata:', e)

    # 2. Estudiantes: intentar varias estrategias para obtener el listado
    estudiantes = []
    try:
        # Intento 1: por grupo (lo habitual)
        cursor.execute("""
            SELECT id_estudiante, nombre, apellido, documento_identidad
            FROM estudiantes
            WHERE id_grupo = %s AND estado = 'Activo'
            ORDER BY apellido, nombre
        """, (grupo_id,))
        estudiantes = cursor.fetchall() or []

        # Intento 2: si no hay estudiantes por grupo, intentar por grado (algunos datos usan id_grado en vez de id_grupo)
        if not estudiantes and grado_id:
            try:
                cursor.execute("""
                    SELECT id_estudiante, nombre, apellido, documento_identidad
                    FROM estudiantes
                    WHERE id_grado = %s AND estado = 'Activo'
                    ORDER BY apellido, nombre
                """, (grado_id,))
                estudiantes = cursor.fetchall() or []
                if estudiantes:
                    print(f"[calificaciones] Fallback: se encontraron {len(estudiantes)} estudiantes por grado id={grado_id}")
            except Exception as e2:
                print('[calificaciones] Error fallback por grado:', e2)

        # Intento 3: si sigue vacío, traer todos los estudiantes activos (último recurso)
        if not estudiantes:
            try:
                cursor.execute("""
                    SELECT id_estudiante, nombre, apellido, documento_identidad
                    FROM estudiantes
                    WHERE estado = 'Activo'
                    ORDER BY apellido, nombre
                    LIMIT 500
                """)
                estudiantes = cursor.fetchall() or []
                if estudiantes:
                    print(f"[calificaciones] Fallback amplio: se encontraron {len(estudiantes)} estudiantes (limite 500).")
            except Exception as e3:
                print('[calificaciones] Error fallback amplio estudiantes:', e3)

    except Exception as e:
        print('[calificaciones] Error consultando estudiantes:', e)

    cursor.close(); conn.close()

    # 3. Preparar la ruta
    nombre_carpeta_grado = f"Grado_{info['numero_grado']}"
    nombre_carpeta_grupo = f"Grupo_{info['codigo_grupo']}"
    ruta_directorio = os.path.join(PLANILLAS_DIR, nombre_carpeta_grado, nombre_carpeta_grupo)
    os.makedirs(ruta_directorio, exist_ok=True) 
    
    # Preparar nombres usando placeholders cuando falten datos
    numero_grado = str(info.get('numero_grado') or f"Gr{grado_id}")
    codigo_grupo = str(info.get('codigo_grupo') or f"G{grupo_id}")
    nombre_materia = str(info.get('nombre_materia') or f"Materia_{materia_id}")

    materia_limpia = nombre_materia.replace(" ", "_").replace("/", "-")
    nombre_archivo = f"{materia_limpia}_G{numero_grado}_{codigo_grupo}_P{periodo_id}.xlsx"
    ruta_archivo = os.path.join(ruta_directorio, nombre_archivo)

    # 4. Creación del Excel si NO existe (o si se fuerza reescritura)
    if os.path.exists(ruta_archivo) and not force_recreate:
        return ruta_archivo # Ya existe, no lo vamos a destruir

    wb = openpyxl.Workbook()
    ws = wb.active
    ws.title = f"Notas - P{periodo_id}"
    
    header_fill = PatternFill(start_color="3B82F6", end_color="3B82F6", fill_type="solid")
    header_font = Font(color="FFFFFF", bold=True)
    bloqueado = Protection(locked=True)
    desbloqueado = Protection(locked=False)
    
    headers = ['ID_Estudiante', 'Apellidos y Nombres', 'Actividad 1', 'Actividad 2', 'Actividad 3', 'Actividad 4', 'Nota_Final']
    ws.append(headers)
    
    for col, title in enumerate(headers, start=1):
        celda = ws.cell(row=1, column=col)
        celda.fill = header_fill
        celda.font = header_font
        celda.protection = bloqueado
    
    # Log: cantidad de estudiantes que se volcarán
    try:
        print(f"[calificaciones] Volcando {len(estudiantes)} estudiantes en el Excel (grado={grado_id} grupo={grupo_id} materia={materia_id})")
        if estudiantes:
            sample = estudiantes[:5]
            print('[calificaciones] Primeros registros:', sample)
    except Exception:
        pass

    for row_num, est in enumerate(estudiantes, start=2):
        # detectar id de forma robusta
        est_id = None
        if isinstance(est, dict):
            for key in ('id_estudiante', 'id', 'id_alumno', 'estudiante_id'):
                if key in est and est.get(key) is not None:
                    est_id = est.get(key); break
        try:
            ws.cell(row=row_num, column=1, value=est_id)
        except Exception:
            ws.cell(row=row_num, column=1, value=None)

        # componer nombre de forma robusta
        nombre_val = None
        if isinstance(est, dict):
            if est.get('apellido') and est.get('nombre'):
                nombre_val = f"{est.get('apellido')} {est.get('nombre')}"
            elif est.get('nombre_completo'):
                nombre_val = est.get('nombre_completo')
            elif est.get('nombre'):
                nombre_val = est.get('nombre')
            else:
                for key in ('full_name','nombre_estudiante'):
                    if key in est:
                        nombre_val = est.get(key); break
        ws.cell(row=row_num, column=2, value=nombre_val)

        # Celdas Notas: dejar vacías (editable)
        for c_idx in range(3, 8):  # Columnas 3 a 7 (Act 1,2,3,4 y Nota Final)
            ws.cell(row=row_num, column=c_idx, value=None)
            
    ws.column_dimensions['A'].hidden = True
    ws.column_dimensions['B'].width = 35


    wb.save(ruta_archivo)
    return ruta_archivo


# Ruta de utilidad: devolver estructura de carpetas y archivos bajo PLANILLAS_DIR
@calificaciones_bp.route('/api/calificaciones/estructura_carpetas', methods=['GET'])
def api_estructura_carpetas():
    try:
        def build_tree(root_path, max_depth=3):
            tree = []
            root_path = os.path.abspath(root_path)
            for dirpath, dirnames, filenames in os.walk(root_path):
                rel = os.path.relpath(dirpath, root_path)
                depth = 0 if rel == '.' else rel.count(os.sep) + 1
                if depth > max_depth:
                    # evitar profundizar demasiado: eliminar subdirs
                    dirnames[:] = []
                    continue
                entry = {
                    'path': rel if rel != '.' else '',
                    'dirs': dirnames.copy(),
                    'files': filenames.copy()
                }
                tree.append(entry)
            return tree

        if not os.path.exists(PLANILLAS_DIR):
            return jsonify({'status': 'ok', 'tree': [], 'message': 'No existe la carpeta de planillas en este equipo.'}), 200

        tree = build_tree(PLANILLAS_DIR, max_depth=4)
        return jsonify({'status': 'ok', 'tree': tree, 'base': PLANILLAS_DIR}), 200
    except Exception as e:
        return _error_interno(e)


# ── 1. SINCRONIZADOR MASIVO (Desde la DB hacia el sistema local) ────────

@calificaciones_bp.route('/api/calificaciones/sincronizar_carpetas', methods=['POST'])
def api_sincronizar_carpetas():
    """
    Crea la estructura de carpetas para todos los grados y grupos que existan en el sistema.
    Luego genera los Excel únicamente para las materias asignadas.
    """
    try:
        conn = get_db()
        cursor = conn.cursor(dictionary=True)
        
        # 1. Crear carpetas para absolutamente todos los Grados y Grupos existentes
        cursor.execute("""
            SELECT g.numero_grado, gr.codigo_grupo 
            FROM grupos gr
            JOIN grados g ON gr.id_grado = g.id_grado
        """)
        todos_los_grupos = cursor.fetchall()
        
        carpetas_creadas = 0
        for grupo in todos_los_grupos:
            ruta = os.path.join(PLANILLAS_DIR, f"Grado_{grupo['numero_grado']}", f"Grupo_{grupo['codigo_grupo']}")
            if not os.path.exists(ruta):
                os.makedirs(ruta, exist_ok=True)
                carpetas_creadas += 1

        # 2. Obtener todas las asignaciones (Materias designadas)
        cursor.execute("""
            SELECT id_grado, id_grupo, id_materia 
            FROM asignaciones_docente WHERE estado = 'Activa'
        """)
        asignaciones = cursor.fetchall()

        archivos_creados = 0
        created_files = []
        errors = []

        if not asignaciones:
            # Si no hay asignaciones activas, crear exceles para todas las combinaciones
            # de grupos y materias (modo "crear todo" para instalaciones nuevas).
            cursor.execute("""
                SELECT g.id_grado, gr.id_grupo, g.numero_grado, gr.codigo_grupo
                FROM grupos gr
                JOIN grados g ON gr.id_grado = g.id_grado
            """)
            grupos = cursor.fetchall()

            cursor.execute("SELECT id_materia FROM materias")
            materias_rows = cursor.fetchall()
            materias = [m['id_materia'] for m in materias_rows]

            for grupo in grupos:
                for m_id in materias:
                    try:
                        res = _crear_excel_fisico(grupo['id_grado'], grupo['id_grupo'], m_id, force_recreate=True)
                        if res:
                            archivos_creados += 1
                            created_files.append(res)
                    except Exception as ex:
                        errors.append({
                            'grado': grupo.get('id_grado'),
                            'grupo': grupo.get('id_grupo'),
                            'materia': m_id,
                            'error': str(ex)
                        })
        else:
            for asig in asignaciones:
                try:
                    res = _crear_excel_fisico(asig['id_grado'], asig['id_grupo'], asig['id_materia'], force_recreate=True)
                    if res:
                        archivos_creados += 1
                        created_files.append(res)
                except Exception as ex:
                    errors.append({
                        'grado': asig.get('id_grado'),
                        'grupo': asig.get('id_grupo'),
                        'materia': asig.get('id_materia'),
                        'error': str(ex)
                    })

        cursor.close(); conn.close()
                
        return jsonify({
            'status': 'ok',
            'message': f'Sincronización completa. Carpetas de grados/grupos verificadas. {carpetas_creadas} nuevas carpetas creadas.',
            'archivos_en_sistema': archivos_creados,
            'created_files': created_files,
            'errors': errors
        }), 200

    except Exception as e:
        return _error_interno(e)


# ── 2. GENERADOR DE PLANILLAS EXCEL CONGELADA (Offline First) ────────────────

@calificaciones_bp.route('/api/calificaciones/generar_planilla', methods=['GET'])
def api_generar_planilla():
    """
    Endpoint maestro.
    Recibe por parámetros el ID de grado, grupo, materia y periodo.
    Consulta la DB, crea la carpeta si falta, y genera un Excel bloqueado donde
    el profesor solo puede editar las notas.
    """
    grado_id = request.args.get('grado_id')
    grupo_id = request.args.get('grupo_id')
    materia_id = request.args.get('materia_id')
    periodo_id = request.args.get('periodo_id', 1)  # Ejemplo, por defecto 1

    if not all([grado_id, grupo_id, materia_id]):
        return jsonify({'error': 'Faltan parámetros (grado_id, grupo_id, materia_id)'}), 400

    try:
        conn = get_db()
        cursor = conn.cursor(dictionary=True)
        
        # 1. Obtener la info del Grado, Grupo y Materia para el nombre del archivo
        cursor.execute("""
            SELECT g.numero_grado, gr.codigo_grupo, m.nombre_materia, m.codigo_materia
            FROM grados g, grupos gr, materias m
            WHERE g.id_grado = %s AND gr.id_grupo = %s AND m.id_materia = %s
        """, (grado_id, grupo_id, materia_id))
        info = cursor.fetchone()
        
        if not info:
            cursor.close()
            conn.close()
            return jsonify({'error': 'Datos de grado, grupo o materia no existen.'}), 404

        # 2. Consultar todos los estudiantes activos en este grupo
        ruta_archivo = _crear_excel_fisico(grado_id, grupo_id, materia_id, periodo_id)
        
        if not ruta_archivo:
             return jsonify({'error': 'Error interno al generar archivo físico'}), 500
             
        nombre_archivo = os.path.basename(ruta_archivo)

        # Enviar archivo al profesor para descargar
        return send_file(
            ruta_archivo,
            as_attachment=True,
            download_name=nombre_archivo,
            mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        )

    except Exception as e:
        return _error_interno(e)

# ── NUEVA RUTA: LEER EXCEL PARA PANTALLA (Grilla Web) ────────────────────────
@calificaciones_bp.route('/api/calificaciones/leer_planilla', methods=['GET'])
def api_leer_planilla():
    grado_id = request.args.get('grado_id')
    grupo_id = request.args.get('grupo_id')
    materia_id = request.args.get('materia_id')
    periodo_id = request.args.get('periodo_id', 1)

    try:
        ruta_archivo = _crear_excel_fisico(grado_id, grupo_id, materia_id, periodo_id)
        if not ruta_archivo or not os.path.exists(ruta_archivo):
            return jsonify({'error': 'No se encontro ni se pudo generar el Excel físico'}), 404
            
        wb = openpyxl.load_workbook(ruta_archivo, data_only=True)
        ws = wb.active
        
        data = []
        for row in ws.iter_rows(min_row=2, max_col=7, values_only=True):
            if row[0]: # Si hay ID de estudiante
                data.append({
                    'id_estudiante': row[0],
                    'nombre': row[1],
                    'act1': row[2] if row[2] is not None else '',
                    'act2': row[3] if row[3] is not None else '',
                    'act3': row[4] if row[4] is not None else '',
                    'act4': row[5] if row[5] is not None else '',
                    'nota': row[6] if row[6] is not None else '' # Nota_Final
                })
                
        return jsonify({'status': 'ok', 'alumnos': data}), 200
        
    except Exception as e:
         return _error_interno(e)

# ── NUEVA RUTA: GUARDAR DESDE PANTALLA WEB DIRECTO ─────────────────────────────
@calificaciones_bp.route('/api/calificaciones/guardar_planilla_web', methods=['POST'])
def api_guardar_planilla_web():
    data_json = request.get_json()
    grado_id = data_json.get('grado_id')
    grupo_id = data_json.get('grupo_id')
    materia_id = data_json.get('materia_id')
    periodo_id = data_json.get('periodo_id', 1)
    alumnos = data_json.get('alumnos', [])
    
    try:
        # Encontramos el archivo físico
        conn = get_db()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT g.numero_grado, gr.codigo_grupo, m.nombre_materia FROM grados g, grupos gr, materias m WHERE g.id_grado=%s AND gr.id_grupo=%s AND m.id_materia=%s", (grado_id, grupo_id, materia_id))
        info = cursor.fetchone()
        
        materia_limpia = str(info['nombre_materia']).replace(" ", "_").replace("/", "-")
        nombre_carpeta_grado = f"Grado_{info['numero_grado']}"
        nombre_carpeta_grupo = f"Grupo_{info['codigo_grupo']}"
        nombre_archivo = f"{materia_limpia}_G{info['numero_grado']}_{info['codigo_grupo']}_P{periodo_id}.xlsx"
        
        ruta_archivo_actual = os.path.join(PLANILLAS_DIR, nombre_carpeta_grado, nombre_carpeta_grupo, nombre_archivo)
        
        if not os.path.exists(ruta_archivo_actual):
             return jsonify({'error': 'El Excel fisico no existe para ser actualizado'}), 404

        # Versionado (Archivador) - igual que al subir archivo manual
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        nombre_historico = f"{nombre_archivo.replace('.xlsx', '')}_v{timestamp}.xlsx"
        ruta_historial_dir = os.path.join(HISTORIAL_DIR, nombre_carpeta_grado, nombre_carpeta_grupo)
        os.makedirs(ruta_historial_dir, exist_ok=True)
        shutil.copy2(ruta_archivo_actual, os.path.join(ruta_historial_dir, nombre_historico))

        # Modificamos el Excel Físico
        wb = openpyxl.load_workbook(ruta_archivo_actual)
        ws = wb.active
        
        # Mapeamos los alumos llegados desde la web a un diccionario
        alumnos_map = {int(a['id_estudiante']): a for a in alumnos}
        
        for fila_idx in range(2, ws.max_row + 1):
            id_est = ws.cell(row=fila_idx, column=1).value
            if id_est and int(id_est) in alumnos_map:
                alumno_data = alumnos_map[int(id_est)]
                
                # Helper para convertir a float seguro
                def set_float_val(col, key):
                    val = str(alumno_data.get(key, '')).strip()
                    if val == "": ws.cell(row=fila_idx, column=col).value = None
                    else:
                        try: ws.cell(row=fila_idx, column=col).value = float(val)
                        except: pass
                
                set_float_val(3, 'act1')
                set_float_val(4, 'act2')
                set_float_val(5, 'act3')
                set_float_val(6, 'act4')
                set_float_val(7, 'nota')
                
        wb.save(ruta_archivo_actual)
        
        # Sincronizamos la DB
        cursor.execute("SELECT id_actividad FROM actividades WHERE id_materia=%s AND id_periodo=%s AND id_grupo=%s LIMIT 1", (materia_id, periodo_id, grupo_id))
        act_row = cursor.fetchone()
        if not act_row:
             cursor.execute("INSERT INTO actividades (nombre_actividad, id_materia, id_periodo, id_grupo) VALUES ('Carga desde Web', %s, %s, %s)", (materia_id, periodo_id, grupo_id))
             conn.commit()
             id_actividad = cursor.lastrowid
        else:
             id_actividad = act_row['id_actividad']
             
        for est_id, nota in alumnos_map.items():
             if str(nota).strip() != "":
                 cursor.execute("SELECT id_nota FROM notas WHERE id_estudiante=%s AND id_actividad=%s", (est_id, id_actividad))
                 existing = cursor.fetchone()
                 try:
                     n_float = float(nota)
                     if existing:
                         cursor.execute("UPDATE notas SET puntaje_obtenido=%s WHERE id_nota=%s", (n_float, existing['id_nota']))
                     else:
                         cursor.execute("INSERT INTO notas (id_estudiante, id_actividad, puntaje_obtenido) VALUES (%s, %s, %s)", (est_id, id_actividad, n_float))
                 except ValueError: pass
                 
        conn.commit()
        cursor.close(); conn.close()
        
        return jsonify({'status': 'ok', 'message': 'Guardado en Excel físico y BD exitosamente'})

    except Exception as e:
        import traceback
        traceback.print_exc()
        return _error_interno(e)


# ── 3. SUBIDA Y PROCESAMIENTO CON HISTORIAL (El Archivador Inmortal) ─────────

@calificaciones_bp.route('/api/calificaciones/subir_planilla', methods=['POST'])
def api_subir_planilla():
    """
    Ruta que recibe el archivo Excel que el profesor editó.
    1. Si ya existía uno viejo, lo mueve a /historial_respaldos/ de forma permanente.
    2. Guarda el nuevo en la ruta local correspondiente.
    3. Lee el Excel, extrae las notas, y hace INSERT/UPDATE en la base de datos `notas`
       validando con el ID oculto del estudiante en la Columna 1.
    """
    try:
        # Validación de parámetros y archivo
        grado_id = request.form.get('grado_id')
        grupo_id = request.form.get('grupo_id')
        materia_id = request.form.get('materia_id')
        periodo_id = request.form.get('periodo_id', 1)
        
        if 'archivo_excel' not in request.files:
            return jsonify({'error': 'No se envió el archivo de Excel'}), 400
            
        archivo = request.files['archivo_excel']
        if archivo.filename == '':
            return jsonify({'error': 'Archivo sin nombre o inválido'}), 400
            
        if not all([grado_id, grupo_id, materia_id]):
            return jsonify({'error': 'Faltan parámetros (grado_id, grupo_id, materia_id)'}), 400

        # Conectar a la DB para sacar los nombres de carpetas
        conn = get_db()
        cursor = conn.cursor(dictionary=True)
        
        cursor.execute("""
            SELECT g.numero_grado, gr.codigo_grupo, m.nombre_materia
            FROM grados g, grupos gr, materias m
            WHERE g.id_grado = %s AND gr.id_grupo = %s AND m.id_materia = %s
        """, (grado_id, grupo_id, materia_id))
        info = cursor.fetchone()
        
        if not info:
            cursor.close()
            conn.close()
            return jsonify({'error': 'Datos de grado, grupo o materia no válidos'}), 404

        # Construir rutas físicas exactas
        materia_limpia = str(info['nombre_materia']).replace(" ", "_")
        nombre_carpeta_grado = f"Grado_{info['numero_grado']}"
        nombre_carpeta_grupo = f"Grupo_{info['codigo_grupo']}"
        nombre_archivo = f"{materia_limpia}_G{info['numero_grado']}_{info['codigo_grupo']}_P{periodo_id}.xlsx"
        
        ruta_directorio = os.path.join(PLANILLAS_DIR, nombre_carpeta_grado, nombre_carpeta_grupo)
        ruta_archivo_actual = os.path.join(ruta_directorio, nombre_archivo)
        
        os.makedirs(ruta_directorio, exist_ok=True)

        # ---------------------------------------------------------
        # FASE 1: El Archivador Inmortal (Backup del archivo viejo)
        # ---------------------------------------------------------
        if os.path.exists(ruta_archivo_actual):
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            nombre_historico = f"{nombre_archivo.replace('.xlsx', '')}_v{timestamp}.xlsx"
            
            ruta_historial_dir = os.path.join(HISTORIAL_DIR, nombre_carpeta_grado, nombre_carpeta_grupo)
            os.makedirs(ruta_historial_dir, exist_ok=True)
            
            ruta_historial_final = os.path.join(ruta_historial_dir, nombre_historico)
            
            # Copiar en lugar de mover para asegurar que la descarga/sobrescritura no falle
            shutil.copy2(ruta_archivo_actual, ruta_historial_final)

        # ---------------------------------------------------------
        # FASE 2: Guardar el nuevo Excel maestro localmente
        # ---------------------------------------------------------
        archivo.save(ruta_archivo_actual)

        # ---------------------------------------------------------
        # FASE 3: Sincronización Inversa (Excel -> Base de Datos)
        # ---------------------------------------------------------
        # Abrimos el Excel en modo lectura para sacar solo los datos (data_only=True mejora el rendimiento)
        wb = openpyxl.load_workbook(ruta_archivo_actual, data_only=True)
        ws = wb.active
        
        # Debemos asegurar que el entorno preparó la Actividad central general 
        # (Si quisieras múltiples actividades como nota 1, nota 2, se haría un bucle dinámico, 
        # pero asumiremos una actividad base para registrar de prueba).
        # Buscar o crear "Plantilla General" rápida para enganchar las notas.
        cursor.execute("""
            SELECT id_actividad FROM actividades 
            WHERE id_materia = %s AND id_periodo = %s AND id_grupo = %s LIMIT 1
        """, (materia_id, periodo_id, grupo_id))
        actividad_row = cursor.fetchone()
        
        if not actividad_row:
            # Si no hay actividad creada para subir la nota, la creamos "On the Fly"
            cursor.execute("""
                INSERT INTO actividades (nombre_actividad, descripcion, id_materia, id_periodo, id_grupo, id_plantilla)
                VALUES ('Carga desde Planilla', 'Importado desde Excel', %s, %s, %s, NULL)
            """, (materia_id, periodo_id, grupo_id))
            conn.commit()
            id_actividad = cursor.lastrowid
        else:
            id_actividad = actividad_row['id_actividad']

        notas_procesadas = 0
        
        # Iterar desde la fila 2 (evitando encabezados)
        for fila in ws.iter_rows(min_row=2, max_col=5, values_only=True):
            # Formato de array fila: (ID_Estudiante, Nombre, Nota1, Nota2, Nota3)
            # fila[0] es ID, fila[2] es la Nota 1 (Columna C)
            id_est_excel = fila[0]
            nota_1 = fila[2] 
            
            if id_est_excel and isinstance(id_est_excel, int) and nota_1 is not None:
                # Comprobar si ya tiene nota
                cursor.execute("""
                    SELECT id_nota FROM notas 
                    WHERE id_estudiante = %s AND id_actividad = %s
                """, (id_est_excel, id_actividad))
                
                nota_existente = cursor.fetchone()
                
                try:
                    valor_nota = float(nota_1)
                    if nota_existente:
                        # UPDATE
                        cursor.execute("""
                            UPDATE notas SET puntaje_obtenido = %s 
                            WHERE id_nota = %s
                        """, (valor_nota, nota_existente['id_nota']))
                    else:
                        # INSERT
                        cursor.execute("""
                            INSERT INTO notas (id_estudiante, id_actividad, puntaje_obtenido)
                            VALUES (%s, %s, %s)
                        """, (id_est_excel, id_actividad, valor_nota))
                    notas_procesadas += 1
                except ValueError:
                    # Si el profe escribió "Hola" en vez de un número, lo ignoramos de la DB
                    pass 

        conn.commit()
        cursor.close()
        conn.close()

        return jsonify({
            'status': 'ok',
            'message': 'Planilla subida exitosamente.',
            'notas_procesadas': notas_procesadas,
            'archivo_viejo_respaldado': os.path.exists(ruta_archivo_actual) # Confirmación de que se hizo backup si existía
        }), 200

    except Exception as e:
        return _error_interno(e)

