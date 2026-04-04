// ════════════════════════════════════════════════════════════════════════════════
// MÓDULO MIS CLASES
// Versión filtrada de Calificaciones para docentes: solo sus clases asignadas
// ════════════════════════════════════════════════════════════════════════════════

const MisClasesModule = {
    // Estado
    grados: [],
    grupos: [],
    materias: [],
    periodos: [],
    estudiantes: [],
    actividades: [],
    notas: {},
    notasModificadas: new Set(),
    filtros: { grado: null, grupo: null, materia: null, periodo: null },
    
    // Clases del docente
    clasesDocente: [],

    async init() {
        await this.render();
        this.bindEvents();
        this.cargarFiltrosBase();
    },

    async render() {
        const container = document.getElementById('main-content');
        container.innerHTML = Helpers.loading();
        
        try {
            const htmlRes = await fetch('/templates/modules html/mis-clases.html');
            if (!htmlRes.ok) throw new Error('Error cargando la vista de mis clases');
            container.innerHTML = await htmlRes.text();
            
        } catch (error) {
            console.error('Error render MisClases:', error);
            container.innerHTML = Helpers.error('No se pudo cargar la vista de mis clases.');
        }
    },

    bindEvents() {
        document.getElementById('btn-agregar-actividad-mis')?.addEventListener('click', () => this.abrirModalActividad());
        document.getElementById('btn-guardar-todo-mis')?.addEventListener('click', () => this.guardarTodo());
        document.getElementById('btn-abrir-linea-mis')?.addEventListener('click', () => this.cargarTabla());
        document.getElementById('btn-descargar-mis')?.addEventListener('click', () => this.descargarExcel());
        document.getElementById('btn-sincronizar-mis')?.addEventListener('click', () => this.sincronizarCarpetas());

        document.getElementById('mc-filtro-grado')?.addEventListener('change', (e) => this.cambiarGrado(e.target.value));
        document.getElementById('mc-filtro-grupo')?.addEventListener('change', (e) => this.cambiarGrupo(e.target.value));
        document.getElementById('mc-filtro-materia')?.addEventListener('change', (e) => this.cambiarMateria(e.target.value));
        document.getElementById('mc-filtro-periodo')?.addEventListener('change', (e) => this.cambiarPeriodo(e.target.value));

        document.getElementById('form-mis-actividad')?.addEventListener('submit', (e) => this.submitActividad(e));
        document.getElementById('btn-cerrar-modal-mis')?.addEventListener('click', () => this.cerrarModalActividad());
        document.getElementById('btn-cancelar-modal-mis')?.addEventListener('click', () => this.cerrarModalActividad());
    },

    async cargarFiltrosBase() {
        try {
            // Obtener clases del docente
            const res = await API.request('/api/mis_clases');
            this.clasesDocente = res.clases || [];
            
            // Extraer grados únicos
            const gradosUnicos = {};
            this.clasesDocente.forEach(c => {
                if (!gradosUnicos[c.grado]) {
                    gradosUnicos[c.grado] = { numero: c.grado.match(/\d+/)[0], texto: c.grado };
                }
            });
            
            this.grados = Object.values(gradosUnicos).sort((a, b) => a.numero - b.numero);

            // Períodos
            const resP = await API.request('/api/calificaciones/filtros');
            this.periodos = resP.periodos || [];
            const periodoAbierto = this.periodos.find(p => p.estado === 'Abierto');
            this.filtros.periodo = periodoAbierto ? periodoAbierto.id_periodo : (this.periodos[0]?.id_periodo || null);

            this.renderSelectGrados();
            this.renderSelectPeriodos();
            this.actualizarBotones();
        } catch (error) {
            mostrarAlerta('Error cargando filtros de mis clases', 'error');
        }
    },

    renderSelectGrados() {
        const sel = document.getElementById('mc-filtro-grado');
        sel.innerHTML = '<option value="">Todas mis clases...</option>' +
            this.grados.map(g => `<option value="${g.texto}">${g.texto}</option>`).join('');
    },

    renderSelectPeriodos() {
        const sel = document.getElementById('mc-filtro-periodo');
        sel.innerHTML = this.periodos.map(p => {
            const activo = p.estado === 'Abierto' ? ' (Activo)' : '';
            const selected = String(p.id_periodo) === String(this.filtros.periodo) ? 'selected' : '';
            return `<option value="${p.id_periodo}" ${selected}>${p.numero_periodo}${activo}</option>`;
        }).join('');
    },

    cambiarGrado(gradoTexto) {
        this.filtros.grado = gradoTexto;
        this.filtros.grupo = null;
        this.filtros.materia = null;
        
        // Filtrar grupos por grado
        const clasesDelGrado = this.clasesDocente.filter(c => c.grado === gradoTexto || !gradoTexto);
        const gruposUnicos = [...new Set(clasesDelGrado.map(c => c.grupo))];
        
        const selGrupo = document.getElementById('mc-filtro-grupo');
        selGrupo.innerHTML = '<option value="">Seleccionar grupo...</option>' +
            gruposUnicos.sort().map(g => `<option value="${g}">${g}</option>`).join('');
        selGrupo.disabled = !gradoTexto;
        
        const selMateria = document.getElementById('mc-filtro-materia');
        selMateria.innerHTML = '<option value="">Seleccionar materia...</option>';
        selMateria.disabled = true;
    },

    cambiarGrupo(grupoTexto) {
        this.filtros.grupo = grupoTexto;
        this.filtros.materia = null;
        
        // Filtrar materias por grado y grupo
        const clasesDelGrupo = this.clasesDocente.filter(c => 
            (!this.filtros.grado || c.grado === this.filtros.grado) && c.grupo === grupoTexto
        );
        const materiasUnicas = clasesDelGrupo.map(c => ({
            id_materia: c.id_materia,
            nombre: c.materia
        }));
        
        const selMateria = document.getElementById('mc-filtro-materia');
        selMateria.innerHTML = '<option value="">Seleccionar materia...</option>' +
            materiasUnicas.map(m => `<option value="${m.id_materia}">${m.nombre}</option>`).join('');
        selMateria.disabled = !grupoTexto;
    },

    cambiarMateria(idMateria) {
        this.filtros.materia = idMateria;
        this.limpiarUI();
        this.actualizarBotones();
    },

    cambiarPeriodo(idPeriodo) {
        this.filtros.periodo = idPeriodo;
        this.limpiarUI();
        this.actualizarBotones();
    },

    actualizarBotones() {
        const btnAbrir = document.getElementById('btn-abrir-linea-mis');
        const btnDescargar = document.getElementById('btn-descargar-mis');
        
        const puedeEditar = this.filtros.grado && this.filtros.grupo && this.filtros.materia && this.filtros.periodo;
        
        if (btnAbrir) btnAbrir.disabled = !puedeEditar;
        if (btnDescargar) btnDescargar.disabled = !puedeEditar;
    },

    limpiarUI() {
        const wrapper = document.getElementById('mc-tabla-wrapper');
        if (wrapper) {
            wrapper.innerHTML = `
                <div class="cal-placeholder">
                    <i class="fas fa-hand-point-up fa-3x"></i>
                    <p>Selecciona Grado, Grupo y Materia; luego usa Editar Notas Aquí.</p>
                </div>
            `;
        }
    },

    async cargarTabla() {
        if (!this.filtros.materia || !this.filtros.periodo || !this.filtros.grupo) {
            mostrarAlerta('Debes seleccionar Grado, Grupo, Materia y Período', 'warning');
            return;
        }

        try {
            // Buscar la asignación del docente por grupo, materia y grado
            const clase = this.clasesDocente.find(c => 
                c.id_materia == this.filtros.materia && 
                c.grupo === this.filtros.grupo &&
                c.grado === this.filtros.grado
            );

            if (!clase) {
                mostrarAlerta('No tienes acceso a esta clase', 'error');
                return;
            }

            // Cargar calificaciones
            const res = await API.request(`/api/mis_clases/${clase.id_asignacion}/calificaciones`);
            
            this.estudiantes = res.estudiantes || [];
            this.actividades = res.actividades || [];
            this.notas = res.notas || {};
            this.notasModificadas.clear();

            this.renderTabla();
            this.mostrarPonderacion();
        } catch (error) {
            console.error('Error cargando tabla:', error);
            mostrarAlerta('Error al cargar las notas', 'error');
        }
    },

    renderTabla() {
        const wrapper = document.getElementById('mc-tabla-wrapper');
        if (!this.estudiantes.length) {
            wrapper.innerHTML = `
                <div class="cal-placeholder">
                    <i class="fas fa-user-slash fa-3x"></i>
                    <p>No hay estudiantes activos en este grupo.</p>
                </div>
            `;
            return;
        }

        if (!this.actividades.length) {
            wrapper.innerHTML = `
                <div class="cal-placeholder">
                    <i class="fas fa-tasks fa-3x"></i>
                    <p>No hay actividades registradas para esta materia.</p>
                </div>
            `;
            return;
        }

        let html = `<div class="cal-tabla-header">
            <select id="mc-activity-filter" class="cal-activity-filter">
                <option value="">Ver: Todas las actividades</option>
        `;
        this.actividades.forEach(a => {
            html += `<option value="${a.id_actividad}">${a.nombre_actividad}</option>`;
        });
        html += `</select></div>`;

        html += `<div class="cal-table-strict"><div class="cal-excel-container"><table class="cal-excel-table"><thead><tr>
            <th class="cal-th-num">#</th>
            <th class="cal-th-estudiante">Estudiante</th>`;

        this.actividades.forEach(a => {
            html += `
                <th class="cal-th-actividad" data-actividad-id="${a.id_actividad}">
                    <div class="cal-actividad-header">
                        <span class="cal-actividad-nombre" title="${a.nombre_actividad}">${a.nombre_actividad}</span>
                        <span class="cal-actividad-meta">${a.tipo_actividad} · ${parseFloat(a.ponderacion).toFixed(2)}%</span>
                        <span class="cal-actividad-meta">Máx: ${parseFloat(a.puntaje_maximo).toFixed(2)}</span>
                    </div>
                </th>
            `;
        });

        html += `<th class="cal-th-final">Nota Final</th></tr></thead><tbody>`;

        this.estudiantes.forEach((est, idx) => {
            html += `<tr><td class="cal-td-num">${idx + 1}</td>`;
            html += `
                <td class="cal-td-estudiante">
                    <div class="cal-estudiante-cell">
                        <div class="avatar">${Helpers.getIniciales(est.nombre, est.apellido)}</div>
                        <span>${est.apellido}, ${est.nombre}</span>
                    </div>
                </td>
            `;

            let sumaFinal = 0;
            let conNotas = 0;

            this.actividades.forEach(act => {
                const key = `${est.id_estudiante}_${act.id_actividad}`;
                const valor = this.notas[key] !== null && this.notas[key] !== undefined ? this.notas[key] : '';
                let clase = '';

                if (valor !== '') {
                    const sobre5 = (parseFloat(valor) / parseFloat(act.puntaje_maximo)) * 5;
                    if (sobre5 < 3.0) clase = 'cal-nota-bajo';
                    else if (sobre5 < 4.0) clase = 'cal-nota-basico';
                    else if (sobre5 < 4.6) clase = 'cal-nota-alto';
                    else clase = 'cal-nota-superior';

                    sumaFinal += (parseFloat(valor) / parseFloat(act.puntaje_maximo)) * parseFloat(act.ponderacion);
                    conNotas += 1;
                }

                html += `
                    <td class="cal-td-nota ${clase}" data-actividad-id="${act.id_actividad}">
                        <input
                            type="number"
                            class="cal-input-nota"
                            value="${valor}"
                            min="0"
                            max="${act.puntaje_maximo}"
                            step="0.01"
                            data-estudiante="${est.id_estudiante}"
                            data-actividad="${act.id_actividad}"
                            data-max="${act.puntaje_maximo}"
                            placeholder="—"
                        >
                    </td>
                `;
            });

            const pct = conNotas > 0 ? `${sumaFinal.toFixed(2)}%` : '—';
            const sobre5Final = conNotas > 0 ? ((sumaFinal / 100) * 5).toFixed(2) : '—';
            let claseFinal = '';
            if (conNotas > 0) {
                const nf = parseFloat(sobre5Final);
                if (nf < 3.0) claseFinal = 'cal-final-bajo';
                else if (nf < 4.0) claseFinal = 'cal-final-basico';
                else if (nf < 4.6) claseFinal = 'cal-final-alto';
                else claseFinal = 'cal-final-superior';
            }

            html += `
                <td class="cal-td-final ${claseFinal}">
                    <span class="cal-final-nota">${sobre5Final}</span>
                </td>
            </tr>`;
        });

        html += `</tbody></table></div></div>`;

        wrapper.innerHTML = html;
        
        // Registrar cambios de notas
        wrapper.querySelectorAll('.cal-input-nota').forEach(input => {
            input.addEventListener('change', (e) => {
                const key = `${e.target.dataset.estudiante}_${e.target.dataset.actividad}`;
                this.notasModificadas.add(key);
                document.getElementById('btn-guardar-todo-mis').style.display = 'inline-block';
            });
        });

        // Filtro de actividades
        document.getElementById('mc-activity-filter')?.addEventListener('change', (e) => {
            const actividadId = e.target.value;
            wrapper.querySelectorAll('.cal-th-actividad, .cal-td-nota').forEach(el => {
                if (actividadId && el.dataset.actividadId !== actividadId) {
                    el.style.display = 'none';
                } else {
                    el.style.display = '';
                }
            });
        });

        document.getElementById('btn-agregar-actividad-mis').style.display = 'inline-block';
        document.getElementById('mc-leyenda').style.display = 'flex';
    },

    mostrarPonderacion() {
        let totalPonderacion = 0;
        this.actividades.forEach(a => {
            totalPonderacion += parseFloat(a.ponderacion) || 0;
        });

        const barEl = document.getElementById('mc-ponderacion-bar');
        if (barEl) {
            barEl.style.display = 'flex';
            document.getElementById('mc-ponderacion-valor').textContent = totalPonderacion.toFixed(2);
            document.getElementById('mc-ponderacion-fill').style.width = `${Math.min(totalPonderacion, 100)}%`;
        }
    },

    async guardarTodo() {
        if (!this.notasModificadas.size) {
            mostrarAlerta('No hay cambios para guardar', 'info');
            return;
        }

        try {
            const batch = [];
            this.notasModificadas.forEach(key => {
                const [idEst, idAct] = key.split('_');
                const input = document.querySelector(`input[data-estudiante="${idEst}"][data-actividad="${idAct}"]`);
                if (input) {
                    batch.push({
                        id_estudiante: parseInt(idEst),
                        id_actividad: parseInt(idAct),
                        puntaje_obtenido: parseFloat(input.value) || null,
                        id_periodo: this.filtros.periodo
                    });
                }
            });

            await API.request('/api/calificaciones/guardar-batch', {
                method: 'POST',
                body: JSON.stringify({ notas: batch })
            });

            mostrarAlerta('✅ Notas guardadas correctamente', 'success');
            this.notasModificadas.clear();
            document.getElementById('btn-guardar-todo-mis').style.display = 'none';
        } catch (error) {
            mostrarAlerta('Error al guardar notas', 'error');
            console.error(error);
        }
    },

    abrirModalActividad() {
        const modal = document.getElementById('modal-mis-actividad');
        if (modal) {
            modal.classList.add('active');
            document.getElementById('modal-mis-actividad-titulo').textContent = 'Nueva Actividad';
            document.getElementById('mis-actividad-id').value = '';
            document.getElementById('form-mis-actividad').reset();
        }
    },

    cerrarModalActividad() {
        const modal = document.getElementById('modal-mis-actividad');
        if (modal) modal.classList.remove('active');
    },

    async submitActividad(e) {
        e.preventDefault();
        // Implementar creación de actividad si es necesario
        mostrarAlerta('Función aún en desarrollo', 'info');
    },

    async descargarExcel() {
        if (!this.filtros.materia || !this.filtros.grupo) {
            mostrarAlerta('Selecciona una materia primero', 'warning');
            return;
        }

        const clase = this.clasesDocente.find(c => 
            c.id_materia == this.filtros.materia && 
            c.grupo === this.filtros.grupo &&
            c.grado === this.filtros.grado
        );
        
        if (!clase) {
            mostrarAlerta('No encontramos esa clase', 'error');
            return;
        }

        try {
            const url = `/api/mis_clases/${clase.id_asignacion}/descargar-excel?periodo=${this.filtros.periodo}`;
            const response = await fetch(url, { credentials: 'include' });

            if (!response.ok) throw new Error('Error descargando');

            const blob = await response.blob();
            const downloadUrl = window.URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = downloadUrl;
            a.download = `${clase.materia}.xlsx`;
            document.body.appendChild(a);
            a.click();
            window.URL.revokeObjectURL(downloadUrl);
            document.body.removeChild(a);

            mostrarAlerta('✅ Descargado correctamente', 'success');
        } catch (error) {
            console.error('Error descargando:', error);
            mostrarAlerta('Error al descargar el archivo', 'error');
        }
    },

    async sincronizarCarpetas() {
        const btn = document.getElementById('btn-sincronizar-mis');
        const textoOriginal = btn.innerHTML;
        
        try {
            btn.disabled = true;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Sincronizando...';

            const res = await API.request('/api/mis_clases/sincronizar-carpetas', {
                method: 'POST'
            });

            mostrarAlerta(`✅ ${res.message} - Archivos: ${res.archivos}`, 'success');
        } catch (error) {
            console.error('Error sincronizando:', error);
            mostrarAlerta('Error al sincronizar carpetas', 'error');
        } finally {
            btn.disabled = false;
            btn.innerHTML = textoOriginal;
        }
    }
};

window.MisClasesModule = MisClasesModule;

// Inicializar cuando DOM esté listo
document.addEventListener('DOMContentLoaded', () => {
  const misClases = new MisClasesModule();
  misClases.init();
});
