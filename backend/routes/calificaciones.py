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
#       grado 6/
#           calificaciones.xlsx
#       grado 7/
#           calificaciones.xlsx 
#       grado 8/
#           calificaciones.xlsx
#       grado 9/
#           calificaciones.xlsx
#       grado 10/
#           calificaciones.xlsx
#       grado 11/
#           calificaciones.xlsx / todo para cada curso
#  el chiste de todo es usar archivos excel como referencia, que sean editable dentro de la aplicacion 
# y que se puedan descargar o subir al sistema para asi mantener cierta flexibilidad y facilidad de uso.
# este sistema tambien podra incluir funcionalidades como el calculo de promedios, la generacion de reportes, la exportacion a pdf, etc.
# todo se tendra una ruta para cada funcionalidad, por ejemplo:
#   /calificaciones/grado_6/
#       GET: devuelve el archivo excel con las calificaciones del grado 6
#       POST: recibe un archivo excel con las calificaciones del grado 6, y lo guarda en el archivo correspondiente
#       PUT: actualiza las calificaciones del grado 6, basadas en el archivo excel recibido
#       DELETE: elimina el archivo excel con las calificaciones del grado 6
# sin embargo la idea es que se autogeneren estas funcionalidad de manera dinamica, es decir, 
# que se tenga una ruta general para cada curso, y que se maneje el archivo excel de manera dinamica, 
# sin necesidad de tener una ruta especifica para cada curso, esto con el fin de evitar la redundancia y facilitar el mantenimiento del codigo.
# tambien hay que tener claro que lo que se busca es que al generar el excel de cada grado se autogenere con el valor seleccionado salido de la lista, tipo en caso de seleccionar el grado 7, que se genera
from typing import List
import mysql.connector
from flask import Blueprint, jsonify, request, session
from utils.database import get_db
from utils.helpers import _error_interno
