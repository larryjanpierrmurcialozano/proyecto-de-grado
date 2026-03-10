let HG_FILTROS = { docente_id: null, grado_id: null, grupo_id: null };
let HG_DATOS   = [];
let HG_GRADOS  = [];
let HG_GRUPOS  = [];

// tengo que cambiar los tres de rango de hora para poner en la grilita
const HG_DIAS  = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes'];
const HG_HORAS = [];
for (let h = 7; h <= 13; h++) {
    HG_HORAS.push(`${String(h).padStart(2,'0')}:00`);
}

// Paleta de colores
const HG_COLORES = [
    '#e8d5b7', '#d4c4a8', '#c9b99a', '#bfae8e', '#f0e2c8',
    '#e0c8a0', '#d5bc94', '#cbb088', '#c1a57c', '#f5edd8',
    '#ddd0b4', '#a68b5b', '#8b7355', '#f2e6d0', '#e6d4b8'
];
let _hgColorIdx = 0;
const _hgColorMap = {};
function hgGetColor(idMateria) {
    if (!_hgColorMap[idMateria]) {
        _hgColorMap[idMateria] = HG_COLORES[_hgColorIdx % HG_COLORES.length];
        _hgColorIdx++;
    }
    return _hgColorMap[idMateria];
}

// ── Render principal ────────────────────────────────────────────────────────

async function renderHorariosGestion() {
    const content = document.getElementById('main-content');
    content.innerHTML = Helpers.loading();

    try {
        const docentesRes = await API.getDocentes();
        const docentes = docentesRes.docentes || [];

        const opDocentes = docentes.map(d =>
            `<option value="${d.id_usuario}" ${d.id_usuario == HG_FILTROS.docente_id ? 'selected' : ''}>${d.apellido} ${d.nombre}</option>`
        ).join('');

        content.innerHTML = `
            <div class="card">
                <div class="card-header-flex">
                    <h2 class="card-title" style="border:none;margin:0;padding:0;">
                        <i class="fas fa-user-clock"></i> Horarios por Docente
                    </h2>
                    <div style="display:flex;gap:.5rem;">
                        <!--
                            ═══════════════════════════════════════════════════════════
                            BOTONES DE EXPORTACIÓN — FUNCIONALIDAD FUTURA
                            Estos botones están preparados para cuando se implemente
                            el sistema de calificaciones y reportes completos.
                            Por ahora solo muestran un mensaje informativo.
                            ═══════════════════════════════════════════════════════════
                        -->
                        <button class="btn btn-verde" onclick="hgExportarExcel()" title="Exportar a Excel (próximamente)">
                            <i class="fas fa-file-excel"></i> Excel
                        </button>
                        <button class="btn btn-rojo" onclick="hgExportarPDF()" title="Exportar a PDF (próximamente)">
                            <i class="fas fa-file-pdf"></i> PDF
                        </button>
                    </div>
                </div>

                <!-- Filtros: Docente → Grado → Grupo -->
                <div class="horario-filtros" style="display:flex;gap:1rem;flex-wrap:wrap;margin-bottom:1rem;">
                    <div class="form-group" style="flex:1;min-width:220px;">
                        <label><i class="fas fa-chalkboard-teacher"></i> Docente</label>
                        <select id="hg-filtro-docente" onchange="hgOnDocenteChange()">
                            <option value="">— Seleccionar docente —</option>
                            ${opDocentes}
                        </select>
                    </div>
                    <div class="form-group" style="flex:1;min-width:160px;">
                        <label><i class="fas fa-layer-group"></i> Grado</label>
                        <select id="hg-filtro-grado" onchange="hgOnGradoChange()" disabled>
                            <option value="">— Primero selecciona docente —</option>
                        </select>
                    </div>
                    <div class="form-group" style="flex:1;min-width:160px;">
                        <label><i class="fas fa-users"></i> Grupo</label>
                        <select id="hg-filtro-grupo" onchange="hgOnGrupoChange()" disabled>
                            <option value="">— Primero selecciona grado —</option>
                        </select>
                    </div>
                </div>

                <!-- Contenedor de la grilla -->
                <div id="hg-grilla-container">
                    <div style="text-align:center;padding:3rem;color:var(--cafe-claro);">
                        <i class="fas fa-user-clock" style="font-size:3rem;margin-bottom:1rem;display:block;opacity:.4;"></i>
                        <p>Selecciona un <strong>docente</strong> para ver su horario asignado.</p>
                    </div>
                </div>
            </div>
        `;

        // Restaurar filtros si ya había selección
        if (HG_FILTROS.docente_id) {
            await hgOnDocenteChange(true);
        }
    } catch (error) {
        content.innerHTML = Helpers.error('No se pudieron cargar los datos.');
        console.error(error);
    }
}

// ── Eventos de filtros ──────────────────────────────────────────────────────

async function hgOnDocenteChange(preserveGrado = false) {
    const docenteId  = document.getElementById('hg-filtro-docente').value;
    const gradoSel   = document.getElementById('hg-filtro-grado');
    const grupoSel   = document.getElementById('hg-filtro-grupo');

    HG_FILTROS.docente_id = docenteId || null;
    if (!preserveGrado) {
        HG_FILTROS.grado_id = null;
        HG_FILTROS.grupo_id = null;
    }

    if (!docenteId) {
        gradoSel.innerHTML = '<option value="">— Primero selecciona docente —</option>';
        gradoSel.disabled = true;
        grupoSel.innerHTML = '<option value="">— Primero selecciona grado —</option>';
        grupoSel.disabled = true;
        hgRenderVacio();
        return;
    }

    try {
        // Obtener grados y grupos donde el docente tiene asignaciones activas
        const res = await API.request(`/api/docentes/${docenteId}/grados-grupos`);
        HG_GRADOS = res.grados || [];
        HG_GRUPOS = res.grupos || [];

        gradoSel.disabled = false;
        gradoSel.innerHTML = '<option value="">— Todos los grados —</option>' +
            HG_GRADOS.map(g =>
                `<option value="${g.id_grado}" ${g.id_grado == HG_FILTROS.grado_id ? 'selected' : ''}>${g.nombre_grado}</option>`
            ).join('');

        // Mostrar todos los grupos del docente o filtrar por grado
        hgActualizarGrupos();
    } catch (e) {
        console.error('Error cargando grados/grupos del docente:', e);
        gradoSel.innerHTML = '<option value="">Error al cargar</option>';
        return;
    }

    // Cargar grilla del docente (separado para que un error aquí no rompa los filtros)
    try {
        await hgCargarGrilla();
    } catch (e) {
        console.error('Error cargando grilla:', e);
    }
}

function hgOnGradoChange() {
    HG_FILTROS.grado_id = document.getElementById('hg-filtro-grado').value || null;
    HG_FILTROS.grupo_id = null;
    hgActualizarGrupos();
    hgCargarGrilla();
}

function hgOnGrupoChange() {
    HG_FILTROS.grupo_id = document.getElementById('hg-filtro-grupo').value || null;
    hgCargarGrilla();
}

function hgActualizarGrupos() {
    const grupoSel = document.getElementById('hg-filtro-grupo');
    let gruposFiltrados = HG_GRUPOS;

    if (HG_FILTROS.grado_id) {
        gruposFiltrados = HG_GRUPOS.filter(g => String(g.id_grado) === String(HG_FILTROS.grado_id));
    }

    grupoSel.disabled = false;
    grupoSel.innerHTML = '<option value="">— Todos los grupos —</option>' +
        gruposFiltrados.map(g =>
            `<option value="${g.id_grupo}" ${g.id_grupo == HG_FILTROS.grupo_id ? 'selected' : ''}>${g.codigo_grupo}</option>`
        ).join('');
}

function hgRenderVacio() {
    document.getElementById('hg-grilla-container').innerHTML = `
        <div style="text-align:center;padding:3rem;color:var(--cafe-claro);">
            <i class="fas fa-user-clock" style="font-size:3rem;margin-bottom:1rem;display:block;opacity:.4;"></i>
            <p>Selecciona un <strong>docente</strong> para ver su horario asignado.</p>
        </div>
    `;
}

// ── Cargar y renderizar la grilla ───────────────────────────────────────────

async function hgCargarGrilla() {
    const container = document.getElementById('hg-grilla-container');
    container.innerHTML = Helpers.loading();

    try {
        const params = new URLSearchParams();
        if (HG_FILTROS.docente_id) params.set('docente_id', HG_FILTROS.docente_id);
        if (HG_FILTROS.grupo_id)   params.set('grupo_id', HG_FILTROS.grupo_id);

        const res = await API.request(`/api/horarios?${params.toString()}`);
        HG_DATOS = res.horarios || [];

        // Si filtro por grado sin grupo, filtrar en frontend
        if (HG_FILTROS.grado_id && !HG_FILTROS.grupo_id) {
            HG_DATOS = HG_DATOS.filter(b => String(b.id_grado) === String(HG_FILTROS.grado_id));
        }

        hgRenderGrilla();
    } catch (e) {
        container.innerHTML = Helpers.error('Error al cargar horario.');
        console.error(e);
    }
}

function hgRenderGrilla() {
    const container = document.getElementById('hg-grilla-container');

    // Nombre del docente seleccionado
    const selDocente = document.getElementById('hg-filtro-docente');
    const docenteNom = selDocente.options[selDocente.selectedIndex]?.text || 'Docente';

    let html = `
        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:.75rem;">
            <span style="color:var(--cafe);font-weight:600;">
                <i class="fas fa-calendar-week"></i> Horario de ${docenteNom}
            </span>
            <span style="font-size:.85rem;color:var(--cafe-claro);">
                ${HG_DATOS.length} bloque(s) registrado(s)
            </span>
        </div>
        <div class="horario-scroll" style="overflow-x:auto;">
        <table class="horario-grid">
            <thead>
                <tr>
                    <th class="hora-col">Hora</th>
                    ${HG_DIAS.map(d => `<th>${d}</th>`).join('')}
                </tr>
            </thead>
            <tbody>
    `;

    HG_HORAS.forEach(hora => {
        const horaNum = parseInt(hora.split(':')[0]);
        const horaFin = `${String(horaNum + 1).padStart(2,'0')}:00`;

        html += `<tr>`;
        html += `<td class="hora-col"><strong>${hora}</strong><br><span style="font-size:.75rem;color:var(--cafe-claro)">${horaFin}</span></td>`;

        HG_DIAS.forEach(dia => {
            const bloques = HG_DATOS.filter(b => {
                const bi = b.hora_inicio.substring(0, 5);
                const bf = b.hora_fin.substring(0, 5);
                return b.dia_semana === dia && bi <= hora && bf > hora;
            });

            if (bloques.length > 0) {
                const b = bloques[0];
                const bi = b.hora_inicio.substring(0, 5);
                if (bi === hora) {
                    const bfH = parseInt(b.hora_fin.substring(0, 2));
                    const biH = parseInt(b.hora_inicio.substring(0, 2));
                    const span = bfH - biH;
                    const color = hgGetColor(b.id_materia);
                    html += `<td class="horario-celda ocupada" rowspan="${span}" style="background:${color};">
                        <div class="horario-bloque">
                            <strong class="horario-materia">${b.nombre_materia}</strong>
                            <span class="horario-grupo-info">${b.nombre_grado || ''} — ${b.codigo_grupo || ''}</span>
                            <span class="horario-hora">${bi} - ${b.hora_fin.substring(0,5)}</span>
                            ${b.aula ? `<span class="horario-aula"><i class="fas fa-door-open"></i> ${b.aula}</span>` : ''}
                            <div class="horario-acciones" style="margin-top:.3rem;">
                                <button onclick="hgIrAEditar(${b.id_grupo}, '${b.id_grado}', '${b.docente_nombre} ${b.docente_apellido}')" title="Editar en Horarios" class="btn-editar-hg">
                                    <i class="fas fa-edit"></i> Editar
                                </button>
                            </div>
                        </div>
                    </td>`;
                }
            } else {
                html += `<td class="horario-celda vacia-readonly"></td>`;
            }
        });
        html += `</tr>`;
    });

    html += `</tbody></table></div>`;

    // Leyenda
    if (HG_DATOS.length > 0) {
        const materiasUnicas = [...new Map(HG_DATOS.map(b => [b.id_materia, b.nombre_materia])).entries()];
        html += `<div class="horario-leyenda" style="margin-top:1rem;display:flex;flex-wrap:wrap;gap:.5rem;">`;
        materiasUnicas.forEach(([id, nombre]) => {
            html += `<span class="badge" style="background:${hgGetColor(id)};color:#4a3728;padding:.25rem .75rem;border-radius:12px;font-size:.8rem;">${nombre}</span>`;
        });
        html += `</div>`;
    }

    container.innerHTML = html;
}

// ── Ir a editar (redirige al módulo Horarios Académico con filtros) ─────────

function hgIrAEditar(grupoId, gradoId) {
    // Guardar filtros para que el módulo Horarios los use al cargar
    HORARIO_FILTROS.grado_id  = gradoId;
    HORARIO_FILTROS.grupo_id  = grupoId;
    HORARIO_FILTROS.docente_id = HG_FILTROS.docente_id;

    // Navegar al módulo de Horarios (sección Académico)
    cargarPagina('horarios');

    // Marcar el item correcto en el sidebar
    document.querySelectorAll('.sidebar-item').forEach(i => {
        i.classList.toggle('active', i.dataset.page === 'horarios');
    });
}

// ── Exportar (placeholders para funcionalidad futura) ───────────────────────

/**
 * ═══════════════════════════════════════════════════════════════════════════
 * EXPORTAR A EXCEL — FUNCIONALIDAD PENDIENTE
 * Este botón está preparado para implementarse en el futuro junto con el
 * sistema de calificaciones. Cuando esté disponible, se generará un archivo
 * .xlsx con el horario del docente seleccionado, incluyendo las materias,
 * grupos, aulas y franjas horarias.
 * Librería sugerida: SheetJS (xlsx) o backend con openpyxl.
 * ═══════════════════════════════════════════════════════════════════════════
 */
function hgExportarExcel() {
    mostrarAlerta('Exportar a Excel estará disponible próximamente junto con el sistema de calificaciones.', 'info');
}

/**
 * ═══════════════════════════════════════════════════════════════════════════
 * EXPORTAR A PDF — FUNCIONALIDAD PENDIENTE
 * Este botón está preparado para implementarse en el futuro junto con el
 * sistema de calificaciones. Cuando esté disponible, se generará un archivo
 * .pdf con formato de grilla del horario del docente, listo para imprimir.
 * Librería sugerida: jsPDF + html2canvas o backend con reportlab/weasyprint.
 * ═══════════════════════════════════════════════════════════════════════════
 */
function hgExportarPDF() {
    mostrarAlerta('Exportar a PDF estará disponible próximamente junto con el sistema de calificaciones.', 'info');
}
