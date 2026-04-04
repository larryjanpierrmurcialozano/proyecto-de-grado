--- PLAN DE REFACTORIZACI覰 FUTURO - M覦ULO CALIFICACIONES ---

1. ESTADO ACTUAL (NO BORRAR EL C覦IGO, SOLO DESHABILITAR/MODIFICAR DESPU蒘)
- El sistema utiliza la ruta de 'Escritorio/OneDrive' del dispositivo para guardar los archivos f韘icos de Excel (.xlsx).
- Sincroniza y respalda autom醫icamente los Excel a Google Drive con cada guardado.
- Se mantiene el funcionamiento dual: Base de Datos (醙il) + Excel f韘ico (backup imprimible).

2. CAMBIOS A FUTURO (PARA EL PROYECTO TECN覮OGO)
- [ ] Centralizar el almacenamiento de Excel: Cambiar la funci髇 obtener_ruta_escritorio() para que las planillas se guarden en una carpeta relativa al servidor (ej. ackend/planillas_generadas/) y NO en el escritorio local de Windows.
- [ ] Modificar la subida a Google Drive: En lugar de subir el archivo cada vez que un profesor guarda una nota, dejar que se haga un 鷑ico Backup (Copia de seguridad nocturna o de cierre de periodo) para no saturar las APIs de Google ni crear latencia en la p醙ina.
- [ ] Perfeccionar formato de Impresi髇 PDF/Excel: Garantizar que el sistema guarde y exporte el archivo en el formato exacto exigido para impresiones (m醨genes, logos de la plantilla, bloqueo de celdas), inyectando los datos de la BD a PlantillaCalificaciones.xlsx.
- [ ] Limpieza de c骴igo de interfaz local: Desactivar a futuro las funciones y rutas que exponen el 醨bol de directorios locales (C:\Users\...) a la interfaz web (ej. pi_estructura_carpetas), ya que en producci髇 no tiene sentido navegar el C: del servidor web.

3. ACCIONES REALIZADAS - AISLAMIENTO DE GOOGLE DRIVE (Abril 2026)
- Se deshabilit贸 'servicio_drive.py' (todo el c贸digo fue comentado) para evitar conflictos y redundancias.
- Se coment贸 en 'iniciador.py' la importaci贸n y el registro del Blueprint de Google Drive (drive_bp).
- En 'calificaciones.py', se coment贸 la funci贸n '_subir_excel_a_drive_calificaciones' y el bloque "FASE 4" que sub铆a respaldos autom谩ticos por cada guardado de rutina.
- El sistema ha quedado aislado y operando de forma 100% local a trav茅s de la Base de Datos "谩gil" y el manejo directo de 'PlantillaCalificaciones.xlsx'. El c贸digo "Drive-First" se conserva inhabilitado para futuras referencias.
