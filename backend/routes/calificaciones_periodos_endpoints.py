# ════════════════════════════════════════════════════════════════════════════════
# ENDPOINTS DE DESCARGA POR PERÍODO
# Agregar estos endpoints al final de calificaciones.py
# ════════════════════════════════════════════════════════════════════════════════

# @calificaciones_bp.route('/api/calificaciones/periodos/<int:periodo_id>/listar', methods=['GET'])
# def api_listar_periodo(periodo_id):
#     """Lista todos los archivos Excel de un período específico."""
#     try:
#         conn = get_db()
#         cursor = conn.cursor(dictionary=True)
#         
#         # Validar que el período existe
#         cursor.execute("SELECT numero_periodo FROM periodos WHERE id_periodo = %s", (periodo_id,))
#         periodo = cursor.fetchone()
#         if not periodo:
#             cursor.close()
#             conn.close()
#             return jsonify({'error': 'Período no encontrado'}), 404
#         
#         cursor.close()
#         conn.close()
#         
#         PERIODOS_DIR = os.path.join(ESCRITORIO, 'Periodos_DocstrY')
#         periodo_folder = os.path.join(PERIODOS_DIR, f"Período_{periodo['numero_periodo']}")
#         
#         if not os.path.exists(periodo_folder):
#             return jsonify({'error': 'Carpeta del período no existe. Sincroniza primero.'}), 404
#         
#         # Construir lista de archivos
#         archivos = []
#         for root, dirs, files in os.walk(periodo_folder):
#             for file in files:
#                 if file.endswith('.xlsx'):
#                     ruta_completa = os.path.join(root, file)
#                     ruta_relativa = os.path.relpath(ruta_completa, PERIODOS_DIR)
#                     tamaño = os.path.getsize(ruta_completa)
#                     archivos.append({
#                         'nombre': file,
#                         'ruta_relativa': ruta_relativa,
#                         'tamaño_kb': round(tamaño / 1024, 2),
#                         'modificado': datetime.fromtimestamp(os.path.getmtime(ruta_completa)).isoformat()
#                     })
#         
#         return jsonify({
#             'status': 'ok',
#             'periodo_id': periodo_id,
#             'numero_periodo': periodo['numero_periodo'],
#             'total_archivos': len(archivos),
#             'archivos': sorted(archivos, key=lambda x: x['nombre'])
#         }), 200
#     except Exception as e:
#         return _error_interno(e)


# @calificaciones_bp.route('/api/calificaciones/periodos/descargar_archivo', methods=['GET'])
# def api_descargar_archivo_periodo():
#     """
#     Descarga un archivo Excel individual de la estructura de períodos.
#     Parámetros: periodo_id, ruta_relativa (desde Periodos_DocstrY)
#     """
#     try:
#         from urllib.parse import unquote
#         
#         periodo_id = request.args.get('periodo_id', type=int)
#         ruta_relativa = unquote(request.args.get('ruta', ''))
#         
#         if not periodo_id or not ruta_relativa:
#             return jsonify({'error': 'Faltan parámetros: periodo_id y ruta'}), 400
#         
#         PERIODOS_DIR = os.path.join(ESCRITORIO, 'Periodos_DocstrY')
#         
#         # Validar que la ruta esté dentro de PERIODOS_DIR (seguridad)
#         ruta_completa = os.path.normpath(os.path.join(PERIODOS_DIR, ruta_relativa))
#         
#         if not ruta_completa.startswith(os.path.normpath(PERIODOS_DIR)):
#             return jsonify({'error': 'Acceso denegado: ruta inválida'}), 403
#         
#         if not os.path.exists(ruta_completa):
#             return jsonify({'error': 'Archivo no encontrado'}), 404
#         
#         nombre_archivo = os.path.basename(ruta_completa)
#         
#         return send_file(
#             ruta_completa,
#             mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
#             as_attachment=True,
#             download_name=nombre_archivo
#         )
#     except Exception as e:
#         return _error_interno(e)


# @calificaciones_bp.route('/api/calificaciones/periodos/<int:periodo_id>/descargar_zip', methods=['GET'])
# def api_descargar_zip_periodo(periodo_id):
#     """Descarga todos los archivos Excel de un período comprimidos en ZIP."""
#     try:
#         from io import BytesIO
#         import zipfile
#         from datetime import datetime
#         
#         conn = get_db()
#         cursor = conn.cursor(dictionary=True)
#         
#         # Validar que el período existe
#         cursor.execute("SELECT numero_periodo FROM periodos WHERE id_periodo = %s", (periodo_id,))
#         periodo = cursor.fetchone()
#         if not periodo:
#             cursor.close()
#             conn.close()
#             return jsonify({'error': 'Período no encontrado'}), 404
#         
#         cursor.close()
#         conn.close()
#         
#         PERIODOS_DIR = os.path.join(ESCRITORIO, 'Periodos_DocstrY')
#         periodo_folder = os.path.join(PERIODOS_DIR, f"Período_{periodo['numero_periodo']}")
#         
#         if not os.path.exists(periodo_folder):
#             return jsonify({'error': 'Carpeta del período no existe'}), 404
#         
#         # Crear ZIP en memoria
#         zip_buffer = BytesIO()
#         with zipfile.ZipFile(zip_buffer, 'w', zipfile.ZIP_DEFLATED) as zip_file:
#             for root, dirs, files in os.walk(periodo_folder):
#                 for file in files:
#                     if file.endswith('.xlsx'):
#                         ruta_archivo = os.path.join(root, file)
#                         # Ruta relativa dentro del ZIP (mantener estructura)
#                         arcname = os.path.relpath(ruta_archivo, PERIODOS_DIR)
#                         zip_file.write(ruta_archivo, arcname=arcname)
#         
#         zip_buffer.seek(0)
#         fecha_hoy = datetime.now().strftime('%Y%m%d')
#         nombre_zip = f"Calificaciones_Periodo_{periodo['numero_periodo']}_{fecha_hoy}.zip"
#         
#         return send_file(
#             zip_buffer,
#             mimetype='application/zip',
#             as_attachment=True,
#             download_name=nombre_zip
#         )
#     except Exception as e:
#         return _error_interno(e)
