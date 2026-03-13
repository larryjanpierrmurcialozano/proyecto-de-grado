// Módulo de Calificaciones: Interfaz Híbrida (Archivos Físicos y Base de Datos)

const CalificacionesModule = {
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
                        <i class='bx bx-sync'></i> Sincronizar Carpetas Reales
                    </button>
                </div>
            </div>
            
            <div class="card card-body">
                <p class="text-muted">
                    Seleccione un grado, grupo y materia para generar o editar la planilla de calificaciones offline.
                    Recuerde que el sistema es "Offline First": usted genera el Excel y cuando esté listo vuelve a subirlo aquí para enviar a base de datos.
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
                        <div class="col-md-2">
                             <button id="btn-generar" class="btn btn-primary w-100 mt-4" disabled>
                                  <i class='bx bxs-file-export'></i> Generar Excel
                             </button>
                        </div>
                    </div>
                </div>

                <hr class="my-4">

                <div class="upload-zone text-center p-4" style="border: 2px dashed #ccc; border-radius: 8px; background: #f8f9fa;">
                    <h4>Subir Planilla Editada</h4>
                    <p class="text-muted">La versión anterior se guardará para siempre en el Archivador Histórico.</p>
                    <div class="d-flex justify-content-center align-items-center flex-column">
                         <input type="file" id="file-excel" accept=".xlsx" class="form-control w-50 mb-3">
                         <button id="btn-subir" class="btn btn-success" disabled>
                              <i class='bx bx-cloud-upload'></i> Procesar e Inyectar a DB
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
        });
        
        document.getElementById('btn-generar').addEventListener('click', this.generarExcel.bind(this));

        const fileInput = document.getElementById('file-excel');
        fileInput.addEventListener('change', () => {
            document.getElementById('btn-subir').disabled = !fileInput.value;
        });

        document.getElementById('btn-subir').addEventListener('click', this.subirExcel.bind(this));
    },

    async sincronizarCarpetas() {
        try {
            const res = await callApi('/api/calificaciones/sincronizar_carpetas', 'POST', {});
            alert(\`Carpetas sincronizadas correctamente. ${res.carpetas_nuevas} creadas localmente.\`);
        } catch (e) {
            console.error(e);
            alert('Error sincronizando carpetas: ' + e);
        }
    },

    async cargarGrados() {
        const select = document.getElementById('calif-grado');
        select.innerHTML = '<option value="">Seleccione Grado...</option>';
        try {
            const res = await callApi('/api/grados');
            res.grados.forEach(g => {
                select.innerHTML += \`<option value="\${g.id_grado}">\${g.numero_grado} - \${g.nombre_grado || ''}</option>\`;
            });
        } catch (e) { console.error(e); }
    },

    async cargarGrupos(e) {
        const gradoId = e.target.value;
        const selectGrupo = document.getElementById('calif-grupo');
        const selectMateria = document.getElementById('calif-materia');
        document.getElementById('btn-generar').disabled = true;

        selectGrupo.innerHTML = '<option value="">Seleccione Grupo...</option>';
        selectMateria.innerHTML = '<option value="">Materia...</option>';
        selectGrupo.disabled = true;
        selectMateria.disabled = true;

        if(!gradoId) return;

        try {
            const res = await callApi(\`/api/grados/\${gradoId}/grupos\`);
            res.grupos.forEach(g => {
                selectGrupo.innerHTML += \`<option value="\${g.id_grupo}">\${g.codigo_grupo}</option>\`;
            });
            selectGrupo.disabled = false;
        } catch(e) { console.error(e); }
    },

    async cargarMaterias() {
        const selectMateria = document.getElementById('calif-materia');
        // Para simplificar asumo que cargamos todas, aunque deberia filtrar por asignacion real.
        // Simulando filtro para MVP Visual
        selectMateria.innerHTML = '<option value="">Seleccione Materia...</option>';
        
        try {
            const res = await callApi('/api/materias');
             res.materias.forEach(m => {
                 selectMateria.innerHTML += \`<option value="\${m.id_materia}">\${m.nombre_materia}</option>\`;
             });
             selectMateria.disabled = false;
        } catch(e) { console.error(e); }
    },

    generarExcel() {
        const grado = document.getElementById('calif-grado').value;
        const grupo = document.getElementById('calif-grupo').value;
        const materia = document.getElementById('calif-materia').value;
        
        // Es un GET form normal para forzar descarga, enlazamos parametros por queryString
        window.location.href = \`/api/calificaciones/generar_planilla?grado_id=\${grado}&grupo_id=\${grupo}&materia_id=\${materia}&periodo_id=1\`;
    },

    async subirExcel() {
        const grado = document.getElementById('calif-grado').value;
        const grupo = document.getElementById('calif-grupo').value;
        const materia = document.getElementById('calif-materia').value;
        const fileInput = document.getElementById('file-excel');

        if (!grado || !grupo || !materia) {
            alert("Por favor seleccione Grado, Grupo y Materia que correspondan al Excel viejo");
            return;
        }

        const formData = new FormData();
        formData.append('grado_id', grado);
        formData.append('grupo_id', grupo);
        formData.append('materia_id', materia);
        formData.append('periodo_id', 1);
        formData.append('archivo_excel', fileInput.files[0]);

        try {
            // No uso el callApi estandar si es JSON-only, uso un fetch para formdata puro.
            const response = await fetch('/api/calificaciones/subir_planilla', {
                 method: 'POST',
                 body: formData
                 // JWT se pasaria manual si implementaron Bearer en fetch
            });
            
            const data = await response.json();
            if (response.ok) {
                 alert(\`Éxito! \${data.message}\\nNotas inyectadas en base de datos: \${data.notas_procesadas}\\n¿Hubo backup del viejo?: \${data.archivo_viejo_respaldado ? 'Si, en Archivador' : 'No había'}\`);
                 fileInput.value = '';
                 document.getElementById('btn-subir').disabled = true;
            } else {
                 alert('Error: ' + (data.error || 'Fallo desconocido'));
            }
        } catch (e) {
             console.error(e);
             alert('Excepción de red al subir.');
        }
    }
};

// Exportar globalmente
window.CalificacionesModule = CalificacionesModule;