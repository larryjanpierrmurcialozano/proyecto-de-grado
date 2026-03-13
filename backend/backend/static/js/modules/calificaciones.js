// Módulo de Calificaciones: Interfaz Híbrida (Archivos Físicos y Base de Datos)
// Permite Sincronización Masiva en Escritorio, Descarga y Edición Visual de Excel.

const CalificacionesModule = {
    alumnosActuales: [], // Guarda la data de la tabla en memoria

    init: function() {
        console.log("Módulo de calificaciones inicializado");
        this.render();
        this.bindEvents();
        this.cargarGrados();
    },

    render: function() {
        // Estructura visual para interactuar con los Excels
        const container = document.getElementById('main-content');
        container.innerHTML = `
            <div class="content-header">
                <h1 class="page-title">Gestión de Calificaciones (Planillas Excel)</h1>
                <div class="action-buttons">
                    <button id="btn-sincronizar" class="btn btn-secondary">
                        <i class='bx bx-sync'></i> Sincronización Total (Escritorio)
                    </button>
                </div>
            </div>
            
            <div class="card card-body">
                <p class="text-muted">
                    Seleccione un grado, grupo y materia. Puede optar por descargar el <b>Excel Físico</b> para trabajar offline 
                    y volver a subirlo con el botón de abajo, o <b>Abrir en línea</b> para ver y editar la planilla incrustada aquí mismo.
                </p>

                <div class="filter-row">
                    <div class="form-group row align-items-end g-3">
                        <div class="col-md-3">
                            <label>Grado:</label>
                            <select id="calif-grado" class="form-control" required></select>
                        </div>
                        <div class="col-md-3">
                            <label>Grupo:</label>
                            <select id="calif-grupo" class="form-control" disabled required></select>
                        </div>
                        <div class="col-md-4">
                            <label>Materia/Asignación:</label>
                            <select id="calif-materia" class="form-control" disabled required></select>
                        </div>
                    </div>
                    
                    <div class="row mt-3">
                        <div class="col-md-6">
                            <button id="btn-generar" class="btn btn-primary w-100" disabled>
                                <i class="fas fa-file-excel"></i> Descargar Excel Físico
                            </button>
                        </div>
                        <div class="col-md-6">
                            <button id="btn-abrir-linea" class="btn btn-info w-100" disabled>
                                <i class="fas fa-edit"></i> Abrir / Editar aquí
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Visor en línea de Excel -->
                <div id="excel-viewer-container" class="mt-4" style="display: none;">
                    <hr>
                    <h4 class="mb-3">Planilla Activa (Sincronizada con el archivo físico)</h4>
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped">
                            <thead style="background-color: #3B82F6; color: white;">
                                <tr>
                                    <th>ID</th>
                                    <th>Apellidos y Nombres</th>
                                    <th>Act 1</th>
                                    <th>Act 2</th>
                                    <th>Act 3</th>
                                    <th>Act 4</th>
                                    <th>Nota Final</th>
                                </tr>
                            </thead>
                            <tbody id="excel-tbody">
                                <!-- Filas asíncronas -->
                            </tbody>
                        </table>
                    </div>
                    <div class="text-end mt-2">
                        <button id="btn-guardar-linea" class="btn btn-verde">
                            <i class="fas fa-save"></i> Inyectar a Excel y DB
                        </button>
                    </div>
                </div>

                <hr class="my-4">

                <!-- ZONA DE CARGA OFFLINE FIRST -->
                <div class="upload-zone text-center p-4" style="border: 2px dashed #ccc; border-radius: 8px; background: #f8f9fa;">
                    <h4>Subir Planilla Editada (Modo Offline)</h4>
                    <p class="text-muted">Si trabajaste el Excel fuera del sistema, súbelo aquí. La versión anterior irá al Archivador Histórico.</p>
                    <div class="d-flex justify-content-center align-items-center flex-column">
                         <input type="file" id="file-excel" accept=".xlsx" class="form-control w-50 mb-3">
                         <button id="btn-subir" class="btn btn-success" disabled>
                              <i class="fas fa-cloud-upload-alt"></i> Procesar Archivo 
                         </button>
                    </div>
                </div>
            </div>
        `;
    },

    bindEvents: function() {
        document.getElementById('btn-sincronizar').addEventListener('click', this.sincronizarCarpetas.bind(this));
        document.getElementById('calif-grado').addEventListener('change', this.cargarGrupos.bind(this));
        document.getElementById('calif-grupo').addEventListener('change', this.cargarMaterias.bind(this));
        
        document.getElementById('calif-materia').addEventListener('change', () => {
             document.getElementById('btn-generar').disabled = false;
             document.getElementById('btn-abrir-linea').disabled = false;
             // Si el visor estaba abierto, lo cerramos al cambiar materia
             document.getElementById('excel-viewer-container').style.display = 'none';
        });
        
        document.getElementById('btn-generar').addEventListener('click', this.generarExcel.bind(this));
        document.getElementById('btn-abrir-linea').addEventListener('click', this.leerExcelEnLinea.bind(this));
        document.getElementById('btn-guardar-linea').addEventListener('click', this.guardarExcelEnLinea.bind(this));

        const fileInput = document.getElementById('file-excel');
        fileInput.addEventListener('change', () => {
            document.getElementById('btn-subir').disabled = !fileInput.value;
        });

        document.getElementById('btn-subir').addEventListener('click', this.subirExcel.bind(this));
    },

    // Usa fetch nativo para evitar dependencia con Helpers específicos fuera de panel.js
    async fetchData(url, options = {}) {
        try {
             const res = await fetch(url, options);
             const data = await res.json();
             if (!res.ok) throw new Error(data.error || 'Error HTTP ' + res.status);
             return data;
        } catch(e) {
             throw e;
        }
    },

    async sincronizarCarpetas() {
        try {
            document.getElementById('btn-sincronizar').innerHTML = '<i class="fas fa-spinner fa-spin"></i> Creando...';
            document.getElementById('btn-sincronizar').disabled = true;

            const res = await this.fetchData('/api/calificaciones/sincronizar_carpetas', { method: 'POST' });
            alert(`${res.message}\nArchivos nuevos generados/verificados: ${res.archivos_en_sistema || 'N/A'}`);
        } catch (e) {
            console.error(e);
            alert('Error sincronizando: ' + e.message);
        } finally {
            document.getElementById('btn-sincronizar').innerHTML = "<i class='bx bx-sync'></i> Sincronización Total (Escritorio)";
            document.getElementById('btn-sincronizar').disabled = false;
        }
    },

    async cargarGrados() {
        const select = document.getElementById('calif-grado');
        select.innerHTML = '<option value="">Seleccione Grado...</option>';
        try {
            const res = await this.fetchData('/api/grados');
            res.grados.forEach(g => {
                select.innerHTML += `<option value="${g.id_grado}">${g.numero_grado} - ${g.nombre_grado || ''}</option>`;
            });
        } catch (e) { console.error(e); }
    },

    async cargarGrupos(e) {
        const gradoId = e.target.value;
        const selectGrupo = document.getElementById('calif-grupo');
        const selectMateria = document.getElementById('calif-materia');
        
        document.getElementById('btn-generar').disabled = true;
        document.getElementById('btn-abrir-linea').disabled = true;

        selectGrupo.innerHTML = '<option value="">Seleccione Grupo...</option>';
        selectMateria.innerHTML = '<option value="">Materia...</option>';
        selectGrupo.disabled = true;
        selectMateria.disabled = true;

        if(!gradoId) return;

        try {
            const res = await this.fetchData(`/api/grados/${gradoId}/grupos`);
            res.grupos.forEach(g => {
                selectGrupo.innerHTML += `<option value="${g.id_grupo}">${g.codigo_grupo}</option>`;
            });
            selectGrupo.disabled = false;
        } catch(e) { console.error(e); }
    },

    async cargarMaterias() {
        const selectMateria = document.getElementById('calif-materia');
        selectMateria.innerHTML = '<option value="">Seleccione Materia...</option>';
        
        try {
            const res = await this.fetchData('/api/materias');
             res.materias.forEach(m => {
                 selectMateria.innerHTML += `<option value="${m.id_materia}">${m.nombre_materia}</option>`;
             });
             selectMateria.disabled = false;
        } catch(e) { console.error(e); }
    },

    generarExcel() {
        const grado = document.getElementById('calif-grado').value;
        const grupo = document.getElementById('calif-grupo').value;
        const materia = document.getElementById('calif-materia').value;
        
        window.location.href = `/api/calificaciones/generar_planilla?grado_id=${grado}&grupo_id=${grupo}&materia_id=${materia}&periodo_id=1`;
    },

    async leerExcelEnLinea() {
        const grado = document.getElementById('calif-grado').value;
        const grupo = document.getElementById('calif-grupo').value;
        const materia = document.getElementById('calif-materia').value;
        
        try {
            document.getElementById('excel-viewer-container').style.display = 'block';
            document.getElementById('excel-tbody').innerHTML = '<tr><td colspan="3" class="text-center"><i class="fas fa-spinner fa-spin"></i> Leyendo Excel Físico del Escritorio...</td></tr>';
            
            const res = await this.fetchData(`/api/calificaciones/leer_planilla?grado_id=${grado}&grupo_id=${grupo}&materia_id=${materia}&periodo_id=1`);
            
            this.alumnosActuales = res.alumnos || [];
            this.dibujarTablaDirecta();
            
        } catch (e) {
            console.error(e);
            document.getElementById('excel-tbody').innerHTML = `<tr><td colspan="3" class="text-center text-danger">Error: ${e.message}</td></tr>`;
        }
    },

    dibujarTablaDirecta() {
        const tbody = document.getElementById('excel-tbody');
        tbody.innerHTML = '';
        
        this.alumnosActuales.forEach((alumno, idx) => {
             const val = alumno.nota !== null && alumno.nota !== undefined ? alumno.nota : '';
             tbody.innerHTML += `
                <tr>
                    <td>${alumno.id_estudiante}</td>
                    <td>${alumno.nombre}</td>
                    <td contenteditable="true" 
                        class="celda-nota-editable" 
                        style="background-color:#ffffcc; cursor:text; text-align:center; font-weight:bold"
                        data-id="${alumno.id_estudiante}"
                        data-idx="${idx}">
                        ${val}
                    </td>
                </tr>
             `;
        });

        // Actualizar array en memoria cuando tabulan/escriben
        document.querySelectorAll('.celda-nota-editable').forEach(celda => {
             celda.addEventListener('blur', (e) => {
                 const i = e.target.getAttribute('data-idx');
                 this.alumnosActuales[i].nota = e.target.innerText;
             });
        });
    },

    async guardarExcelEnLinea() {
        const btn = document.getElementById('btn-guardar-linea');
        btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Guardando...';
        btn.disabled = true;

        const data = {
             grado_id: document.getElementById('calif-grado').value,
             grupo_id: document.getElementById('calif-grupo').value,
             materia_id: document.getElementById('calif-materia').value,
             periodo_id: 1,
             alumnos: this.alumnosActuales
        };

        try {
            const res = await fetch('/api/calificaciones/guardar_planilla_web', {
                 method: 'POST',
                 headers: {'Content-Type': 'application/json'},
                 body: JSON.stringify(data)
            });
            const result = await res.json();
            
            if (res.ok) alert("¡Éxito! " + result.message);
            else alert("Error: " + result.error);
        } catch(e) {
            alert('Fallo de red al intentar guardar');
        } finally {
            btn.innerHTML = '<i class="fas fa-save"></i> Inyectar a Excel y DB';
            btn.disabled = false;
        }
    },

    async subirExcel() {
        const grado = document.getElementById('calif-grado').value;
        const grupo = document.getElementById('calif-grupo').value;
        const materia = document.getElementById('calif-materia').value;
        const fileInput = document.getElementById('file-excel');

        if (!grado || !grupo || !materia) {
            alert("Seleccione Grado, Grupo y Materia para este Excel.");
            return;
        }

        const formData = new FormData();
        formData.append('grado_id', grado);
        formData.append('grupo_id', grupo);
        formData.append('materia_id', materia);
        formData.append('periodo_id', 1);
        formData.append('archivo_excel', fileInput.files[0]);

        try {
            const response = await fetch('/api/calificaciones/subir_planilla', {
                 method: 'POST',
                 body: formData
            });
            
            const data = await response.json();
            if (response.ok) {
                 alert(`¡Éxito! ${data.message}\nNotas inyectadas en base de datos: ${data.notas_procesadas}\nBackup en Archivador: ${data.archivo_viejo_respaldado ? 'Sí' : 'No'}`);
                 fileInput.value = '';
                 document.getElementById('btn-subir').disabled = true;
                 
                 // Si estaba el visor web abierto, lo refrescamos para mostrar lo del archivo nuevo
                 if (document.getElementById('excel-viewer-container').style.display !== 'none') {
                     this.leerExcelEnLinea();
                 }
            } else {
                 alert('Error del Servidor: ' + (data.error || 'Fallo desconocido'));
            }
        } catch (e) {
             console.error(e);
             alert('Excepción de red al subir.');
        }
    }
};

window.CalificacionesModule = CalificacionesModule;