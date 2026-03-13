# indicaciones by larry.ai.chan.uwu.rmppnochas3000 :D 
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
# LIBRERÍAS CLAVE: os (rutas), shutil (movimiento de historiales), openpyxl (creación/lectura de Excel).
# ═══════════════════════════════════════════════════════════════════════════════


from flask import Blueprint, jsonify, request, send_file
import mysql.connector
import os
import shutil
import openpyxl
from openpyxl.styles import Font, PatternFill, Alignment, Protection
from openpyxl.worksheet.protection import SheetProtection
from datetime import datetime

from utils.database import get_db
from utils.helpers import _error_interno

calificaciones_bp = Blueprint('calificaciones', __name__)

# ── CONFIGURACIÓN DE CARPETAS LOCALES ────────────────────────────────────────

# Directorios base en el backend (se crearán en 'backend/planillas_locales')
BACKEND_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), '..'))
PLANILLAS_DIR = os.path.join(BACKEND_DIR, 'planillas_locales')
HISTORIAL_DIR = os.path.join(BACKEND_DIR, 'historial_respaldos')

# Garantizar que el Archivador Histórico y la Carpeta Local existan al iniciar
os.makedirs(PLANILLAS_DIR, exist_ok=True)
os.makedirs(HISTORIAL_DIR, exist_ok=True)


# ── 1. SINCRONIZADOR DE CARPETAS (Desde la DB hacia el sistema local) ────────

@calificaciones_bp.route('/api/calificaciones/sincronizar_carpetas', methods=['POST'])
def api_sincronizar_carpetas():
    """
    Ruta para que el sistema lea la base de datos y cree automáticamente
    toda la estructura de carpetas físicas (Grados y Grupos) en el servidor,
    preparando el terreno para los archivos Excel.
    """
    try:
        conn = get_db()
        cursor = conn.cursor(dictionary=True)
        
        # Obtenemos todos los grupos activos con su información de grado
        cursor.execute("""
            SELECT g.numero_grado, g.nombre_grado, gr.codigo_grupo, gr.id_grupo, g.id_grado
            FROM grupos gr
            JOIN grados g ON gr.id_grado = g.id_grado
        """)
        grupos = cursor.fetchall()
        
        rutas_creadas = []
        
        for grupo in grupos:
            # Formateamos los nombres de forma segura para carpetas (ej. Grado_7/Grupo_A)
            grado_nombre_carpeta = f"Grado_{grupo['numero_grado']}"
            grupo_nombre_carpeta = f"Grupo_{grupo['codigo_grupo']}"
            
            # Construimos la ruta: /planillas_locales/Grado_7/Grupo_A/
            ruta_fisica = os.path.join(PLANILLAS_DIR, grado_nombre_carpeta, grupo_nombre_carpeta)
            
            if not os.path.exists(ruta_fisica):
                os.makedirs(ruta_fisica, exist_ok=True)
                rutas_creadas.append(ruta_fisica)
                
        cursor.close()
        conn.close()
        
        return jsonify({
            'status': 'ok',
            'message': 'Árbol de carpetas sincronizado con la Base de Datos.',
            'carpetas_nuevas': len(rutas_creadas)
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
        cursor.execute("""
            SELECT id_estudiante, nombre, apellido, documento_identidad
            FROM estudiantes
            WHERE id_grupo = %s AND estado = 'Activo'
            ORDER BY apellido, nombre
        """, (grupo_id,))
        estudiantes = cursor.fetchall()
        
        cursor.close()
        conn.close()

        # 3. Preparar la ruta y el nombre del archivo (Estructura física)
        nombre_carpeta_grado = f"Grado_{info['numero_grado']}"
        nombre_carpeta_grupo = f"Grupo_{info['codigo_grupo']}"
        ruta_directorio = os.path.join(PLANILLAS_DIR, nombre_carpeta_grado, nombre_carpeta_grupo)
        os.makedirs(ruta_directorio, exist_ok=True) # Creamos si de casualidad no existe
        
        # Formato: materia_G7_A_Periodo1.xlsx
        materia_limpia = str(info['nombre_materia']).replace(" ", "_")
        nombre_archivo = f"{materia_limpia}_G{info['numero_grado']}_{info['codigo_grupo']}_P{periodo_id}.xlsx"
        ruta_archivo = os.path.join(ruta_directorio, nombre_archivo)

        # ---------------------------------------------------------------------
        # 4. Magia de creación del Excel (Doble Capa de Seguridad)
        # ---------------------------------------------------------------------
        wb = openpyxl.Workbook()
        ws = wb.active
        ws.title = f"Notas - P{periodo_id}"
        
        # Estilos visuales listos para diseño
        header_fill = PatternFill(start_color="3B82F6", end_color="3B82F6", fill_type="solid")
        header_font = Font(color="FFFFFF", bold=True)
        bloqueado = Protection(locked=True)
        desbloqueado = Protection(locked=False)
        
        # Construimos el encabezado. ¡Columnas 1 y 2 tienen la clave! 
        # (El documento oculto para tu control, y los nombres para el profesor)
        headers = ['ID_Estudiante (NO TOCAR)', 'Apellidos y Nombres', 'Nota 1', 'Nota 2', 'Nota 3']
        ws.append(headers)
        
        for col, title in enumerate(headers, start=1):
            celda = ws.cell(row=1, column=col)
            celda.fill = header_fill
            celda.font = header_font
            celda.protection = bloqueado
        
        # Rellenar con estudiantes y preparar celdas de escritura
        for row_num, est in enumerate(estudiantes, start=2):
            # Col 1: ID - lo ponemos en la celda y lo protegemos
            celda_id = ws.cell(row=row_num, column=1, value=est['id_estudiante'])
            celda_id.protection = bloqueado
            
            # Col 2: Nombres
            nombre_completo = f"{est['apellido']} {est['nombre']}"
            celda_noms = ws.cell(row=row_num, column=2, value=nombre_completo)
            celda_noms.protection = bloqueado

            # Celdas Notas: ¡DESBLOQUEADAS! Aquí el profe escribe
            for col_nota in range(3, 6):
                celda_nota = ws.cell(row=row_num, column=col_nota)
                celda_nota.protection = desbloqueado
                
        # Opcional (Si quieres esconder la columna de ID que usa el sistema)
        ws.column_dimensions['A'].hidden = True
        ws.column_dimensions['B'].width = 35

        # ACTIVA LA PROTECION GLOBAL DE LA HOJA
        ws.protection.sheet = True # Esto bloquea todo EXCEPTO las celdas que marcamos como "desbloqueado"

        # Guardar en el disco (Almacenamiento Local Offline First)
        wb.save(ruta_archivo)

        # Enviar archivo al profesor para descargar
        return send_file(
            ruta_archivo,
            as_attachment=True,
            download_name=nombre_archivo,
            mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        )

    except Exception as e:
        return _error_interno(e)

