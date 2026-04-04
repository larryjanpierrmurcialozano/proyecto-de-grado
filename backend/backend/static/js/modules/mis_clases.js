// ════════════════════════════════════════════════════════════════════════════════
// MÓDULO MIS CLASES
// Versión compacta del módulo Calificaciones filtrada para docentes
// Muestra solo las clases asignadas y sus notas
// ════════════════════════════════════════════════════════════════════════════════

const MisClasesModule = {
    clases: [],
    claseActualExpandida: null,
    
    async init() {
        await this.render();
    },

    async render() {
        const container = document.getElementById('main-content');
        container.innerHTML = Helpers.loading();
        
        await this.cargarClases();
        this.renderUI();
    },

    async cargarClases() {
        try {
            const res = await API.request('/api/mis_clases');
            this.clases = res.clases || [];
        } catch (error) {
            console.error('[MisClases] Error cargando clases:', error);
            this.clases = [];
        }
    },

    renderUI() {
        const container = document.getElementById('main-content');
        if (!this.clases.length) {
            container.innerHTML = `
                <div style="padding: 40px; text-align: center;">
                    <i class="fas fa-book-open fa-3x" style="color: #ccc; margin-bottom: 20px; display: block;"></i>
                    <p style="color: #999;">No tienes clases asignadas en este período.</p>
                </div>
            `;
            return;
        }

        let html = `
            <div style="padding: 20px;">
                <h2 style="margin-bottom: 20px;">Mis Clases</h2>
                <table style="width: 100%; border-collapse: collapse; background: white;">
                    <thead>
                        <tr style="background: #4a3728; color: white;">
                            <th style="padding: 12px; text-align: left; border-bottom: 2px solid #ddd;">Grado</th>
                            <th style="padding: 12px; text-align: left; border-bottom: 2px solid #ddd;">Grupo</th>
                            <th style="padding: 12px; text-align: left; border-bottom: 2px solid #ddd;">Materia</th>
                            <th style="padding: 12px; text-align: center; border-bottom: 2px solid #ddd;">Estudiantes</th>
                            <th style="padding: 12px; text-align: center; border-bottom: 2px solid #ddd;">Acción</th>
                        </tr>
                    </thead>
                    <tbody>
        `;

        this.clases.forEach((clase, idx) => {
            const esExpandida = this.claseActualExpandida === clase.id_asignacion;
            const btnClass = esExpandida ? 'fa-chevron-up' : 'fa-chevron-down';
            
            html += `
                <tr style="border-bottom: 1px solid #ddd;">
                    <td style="padding: 12px;">${clase.grado}</td>
                    <td style="padding: 12px;">${clase.grupo}</td>
                    <td style="padding: 12px;">${clase.materia}</td>
                    <td style="padding: 12px; text-align: center;">
                        <span style="background: #667eea; color: white; padding: 4px 8px; border-radius: 4px; font-size: 12px;">
                            ${clase.numero_estudiantes}
                        </span>
                    </td>
                    <td style="padding: 12px; text-align: center;">
                        <button class="btn-expandir-clase" data-id-asignacion="${clase.id_asignacion}" 
                                style="background: none; border: none; cursor: pointer; font-size: 18px; color: #667eea;">
                            <i class="fas ${btnClass}"></i>
                        </button>
                    </td>
                </tr>
                <tr id="detalle-${clase.id_asignacion}" style="display: ${esExpandida ? 'table-row' : 'none'}; background: #f9f9f9;">
                    <td colspan="5" style="padding: 20px;">
                        <div id="contenido-${clase.id_asignacion}">Cargando...</div>
                    </td>
                </tr>
            `;
        });

        html += `
                    </tbody>
                </table>
            </div>
        `;

        container.innerHTML = html;
        this.bindEvents();

        // Si hay clase expandida, cargar sus calificaciones
        if (this.claseActualExpandida) {
            this.cargarCalificacionesClase(this.claseActualExpandida);
        }
    },

    bindEvents() {
        document.querySelectorAll('.btn-expandir-clase').forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.preventDefault();
                const idAsignacion = parseInt(btn.dataset.idAsignacion);
                
                if (this.claseActualExpandida === idAsignacion) {
                    // Colapsar
                    this.claseActualExpandida = null;
                } else {
                    // Expandir
                    this.claseActualExpandida = idAsignacion;
                }
                
                this.renderUI();
            });
        });
    },

    async cargarCalificacionesClase(idAsignacion) {
        try {
            const res = await API.request(`/api/mis_clases/${idAsignacion}/calificaciones`);
            const { estudiantes, actividades, notas, clase } = res;

            let html = this.renderTablaCalificaciones(clase, estudiantes, actividades, notas);
            
            const contenedor = document.getElementById(`contenido-${idAsignacion}`);
            if (contenedor) {
                contenedor.innerHTML = html;
            }
        } catch (error) {
            console.error('[MisClases] Error cargando calificaciones:', error);
            const contenedor = document.getElementById(`contenido-${idAsignacion}`);
            if (contenedor) {
                contenedor.innerHTML = '<p style="color: red;">Error al cargar calificaciones</p>';
            }
        }
    },

    renderTablaCalificaciones(clase, estudiantes, actividades, notas) {
        if (!estudiantes.length) {
            return `
                <div style="text-align: center; padding: 20px; color: #999;">
                    <i class="fas fa-user-slash fa-2x" style="margin-bottom: 10px; display: block;"></i>
                    <p>No hay estudiantes activos en este grupo.</p>
                </div>
            `;
        }

        if (!actividades.length) {
            return `
                <div style="text-align: center; padding: 20px; color: #999;">
                    <i class="fas fa-tasks fa-2x" style="margin-bottom: 10px; display: block;"></i>
                    <p>No hay actividades registradas para esta materia.</p>
                </div>
            `;
        }

        let html = `
            <div style="margin-bottom: 15px; font-size: 14px; color: #666;">
                <strong>${clase.materia}</strong> • Período ${clase.periodo} • ${estudiantes.length} estudiantes
            </div>

            <div style="overflow-x: auto; border-radius: 4px; background: white;">
                <table style="width: 100%; border-collapse: collapse; font-size: 13px;">
                    <thead>
                        <tr style="background: #667eea; color: white;">
                            <th style="padding: 10px; text-align: left; min-width: 150px;">Estudiante</th>
        `;

        // Encabezados de actividades
        actividades.forEach(act => {
            html += `
                <th style="padding: 10px; text-align: center; min-width: 120px; border-left: 1px solid rgba(255,255,255,0.2);">
                    <div style="font-weight: bold; margin-bottom: 3px;">${act.nombre_actividad}</div>
                    <div style="font-size: 11px; opacity: 0.8;">${act.tipo_actividad} - ${act.ponderacion}%</div>
                </th>
            `;
        });

        html += `
                            <th style="padding: 10px; text-align: center; min-width: 100px; border-left: 1px solid rgba(255,255,255,0.2);">
                                <strong>Nota Final</strong>
                            </th>
                        </tr>
                    </thead>
                    <tbody>
        `;

        // Filas de estudiantes
        estudiantes.forEach((est, idx) => {
            html += `
                <tr style="border-bottom: 1px solid #ddd; ${idx % 2 === 0 ? 'background: #f9f9f9;' : ''}">
                    <td style="padding: 10px; font-weight: 500;">
                        ${est.apellido}, ${est.nombre}
                    </td>
            `;

            // Calcular nota final
            let sumaFinal = 0;
            let conNotas = 0;

            // Cada actividad
            actividades.forEach(act => {
                const key = `${est.id_estudiante}_${act.id_actividad}`;
                const valor = notas[key] || null;

                let bgColor = '#f9f9f9';
                let textColor = '#999';

                if (valor !== null && valor !== undefined) {
                    const sobre5 = (parseFloat(valor) / parseFloat(act.puntaje_maximo)) * 5;
                    
                    if (sobre5 < 3.0) {
                        bgColor = '#ffebee';
                        textColor = '#c62828';
                    } else if (sobre5 < 4.0) {
                        bgColor = '#fff3e0';
                        textColor = '#e65100';
                    } else if (sobre5 < 4.6) {
                        bgColor = '#e8f5e9';
                        textColor = '#2e7d32';
                    } else {
                        bgColor = '#e3f2fd';
                        textColor = '#1565c0';
                    }

                    sumaFinal += (parseFloat(valor) / parseFloat(act.puntaje_maximo)) * parseFloat(act.ponderacion);
                    conNotas += 1;
                }

                html += `
                    <td style="padding: 10px; text-align: center; background: ${bgColor}; color: ${textColor}; font-weight: bold;">
                        ${valor !== null && valor !== undefined ? parseFloat(valor).toFixed(2) : '—'}
                    </td>
                `;
            });

            // Nota final
            let notaFinal = '—';
            let bgFinal = '#f9f9f9';
            let textFinal = '#999';

            if (conNotas > 0) {
                const sobre5Final = (sumaFinal / 100) * 5;
                notaFinal = sobre5Final.toFixed(2);

                if (sobre5Final < 3.0) {
                    bgFinal = '#ffebee';
                    textFinal = '#c62828';
                } else if (sobre5Final < 4.0) {
                    bgFinal = '#fff3e0';
                    textFinal = '#e65100';
                } else if (sobre5Final < 4.6) {
                    bgFinal = '#e8f5e9';
                    textFinal = '#2e7d32';
                } else {
                    bgFinal = '#e3f2fd';
                    textFinal = '#1565c0';
                }
            }

            html += `
                    <td style="padding: 10px; text-align: center; background: ${bgFinal}; color: ${textFinal}; font-weight: bold; border-left: 2px solid #667eea;">
                        ${notaFinal}
                    </td>
                </tr>
            `;
        });

        html += `
                    </tbody>
                </table>
            </div>
        `;

        return html;
    }
};

window.MisClasesModule = MisClasesModule;

// Inicializar cuando DOM esté listo
document.addEventListener('DOMContentLoaded', () => {
  const misClases = new MisClasesModule();
  misClases.init();
});
