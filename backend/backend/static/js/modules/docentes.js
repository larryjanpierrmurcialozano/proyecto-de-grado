// ════════════════════════════════════════════════════════════════════════════════
// DOCSTRY - MÓDULO DOCENTES
// Gestión de docentes y asignaciones de materias
// ════════════════════════════════════════════════════════════════════════════════

let ASIGNACIONES_DOCENTE_TEMP = [];
let DOCENTE_SELECCIONADO = null;

async function renderDocentes() {
    const content = document.getElementById('main-content');
    content.innerHTML = Helpers.loading();

    try {
        const data = await API.getDocentes();
        const docentes = data.docentes || [];

        const filas = docentes.length ? docentes.map(d => {
            const materias = d.materias ? d.materias.split(',').map(m => `<span class="badge badge-cafe">${m.trim()}</span>`).join(' ') : '<span class="badge badge-cafe">Sin asignaciones</span>';
            return `
                <tr>
                    <td>${d.id_usuario}</td>
                    <td>${d.documento || '-'}</td>
                    <td>${Helpers.celdaUsuario(d.nombre, d.apellido)}</td>
                    <td>${d.correo || '-'}</td>
                    <td>${materias}</td>
                    <td>${Helpers.badgeEstado(d.is_activo)}</td>
                    <td>${Helpers.botonesAcciones(d.id_usuario, null, 'abrirModalDocente', null)}</td>
                </tr>
            `;
        }).join('') : '<tr><td colspan="7">' + Helpers.sinDatos('No hay docentes registrados') + '</td></tr>';

        content.innerHTML = `
            <div class="card">
                <div class="card-header-flex">
                    <h2 class="card-title" style="border:none;margin:0;padding:0;">
                        <i class="fas fa-chalkboard-teacher"></i> Gestión de Docentes
                    </h2>
                </div>
                <div class="tabla-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Documento</th>
                                <th>Nombre Completo</th>
                                <th>Correo</th>
                                <th>Materias Asignadas</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>${filas}</tbody>
                    </table>
                </div>
            </div>
        `;

    } catch (error) {
        content.innerHTML = Helpers.error('No se pudieron cargar los docentes.');
    }
}

async function abrirModalDocente(docenteId = null) {
    const overlay = document.getElementById('modal-asignar-docente');
    const body = document.getElementById('asignar-docente-body');
    overlay.classList.add('active');
    body.innerHTML = Helpers.loading();

    try {
        const [docentesRes, gradosRes, materiasRes] = await Promise.all([
            API.getDocentesDisponibles(),
            API.getGrados(),
            API.getMaterias()
        ]);

        const docentes = docentesRes.docentes || [];
        const grados = gradosRes.grados || [];
        const materias = materiasRes.materias || [];

        if (!docentes.length) {
            body.innerHTML = `
                <div style="text-align:center; padding:2rem; color: var(--cafe);">
                    <i class="fas fa-exclamation-circle" style="font-size:2rem; margin-bottom:0.5rem;"></i>
                    <p>No hay docentes activos con rol Profesor disponibles para asignar.</p>
                    <p style="color: var(--cafe-claro); font-size:0.9rem;">Crea un usuario con rol Profesor en el módulo Usuarios.</p>
                    <button class="btn btn-cafe" onclick="cerrarModal('modal-asignar-docente')">Cerrar</button>
                </div>
            `;
            return;
        }

        ASIGNACIONES_DOCENTE_TEMP = [];
        const docenteEnLista = docenteId && docentes.find(d => String(d.id_usuario) === String(docenteId));
        DOCENTE_SELECCIONADO = docenteEnLista ? docenteEnLista.id_usuario : docentes[0].id_usuario;

        const opcionesDocentes = docentes.map(d => {
            const seleccionado = String(d.id_usuario) === String(DOCENTE_SELECCIONADO) ? 'selected' : '';
            return `<option value="${d.id_usuario}" ${seleccionado}>${d.apellido} ${d.nombre} - ${d.documento}</option>`;
        }).join('');
        const opcionesGrados = grados.map(g => `<option value="${g.id_grado}">${g.nombre_grado}</option>`).join('');
        const opcionesMaterias = materias.map(m => `<option value="${m.id_materia}">${m.nombre_materia}</option>`).join('');

        body.innerHTML = `
            <form id="form-asignar-docente">
                <div class="form-group">
                    <label><i class="fas fa-user"></i> Seleccionar Docente</label>
                    <select id="select-docente" required>${opcionesDocentes}</select>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label><i class="fas fa-layer-group"></i> Grado</label>
                        <select id="select-grado">${opcionesGrados}</select>
                    </div>
                    <div class="form-group">
                        <label><i class="fas fa-book"></i> Materia</label>
                        <select id="select-materia">${opcionesMaterias}</select>
                    </div>
                    <div class="form-group" style="min-width:140px;">
                        <label><i class="fas fa-toggle-on"></i> Estado</label>
                        <select id="select-estado">
                            <option value="Activa">Activa</option>
                            <option value="Inactiva">Inactiva</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer" style="justify-content:flex-start; gap: 0.75rem;">
                    <button type="button" class="btn btn-cafe" onclick="agregarAsignacionTemp()">
                        <i class="fas fa-plus"></i> Agregar asignación
                    </button>
                </div>
                <div id="lista-asignaciones-temp" class="pill-container" style="margin: 0.5rem 0 1rem 0;">
                    ${Helpers.sinDatos('Aún no agregas asignaciones')}
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-rojo" onclick="cerrarModal('modal-asignar-docente')">
                        <i class="fas fa-times"></i> Cancelar
                    </button>
                    <button type="submit" class="btn btn-verde">
                        <i class="fas fa-save"></i> Guardar
                    </button>
                </div>
            </form>
        `;

        document.getElementById('select-docente').addEventListener('change', (e) => {
            DOCENTE_SELECCIONADO = e.target.value;
            cargarAsignacionesDocenteSeleccionado();
        });

        document.getElementById('form-asignar-docente').addEventListener('submit', guardarAsignacionesDocente);

        await cargarAsignacionesDocenteSeleccionado();

    } catch (error) {
        console.error('Error cargando modal de docente', error);
        body.innerHTML = Helpers.error(error.message || 'No se pudo cargar la información de docentes.');
    }
}

async function cargarAsignacionesDocenteSeleccionado() {
    if (!DOCENTE_SELECCIONADO) {
        ASIGNACIONES_DOCENTE_TEMP = [];
        renderAsignacionesTemp();
        return;
    }
    try {
        const res = await API.getDocenteAsignaciones(DOCENTE_SELECCIONADO);
        ASIGNACIONES_DOCENTE_TEMP = (res.asignaciones || []).map(a => ({
            id_grado: a.id_grado,
            nombre_grado: a.nombre_grado,
            id_materia: a.id_materia,
            nombre_materia: a.nombre_materia,
            estado: a.estado || 'Activa'
        }));
        renderAsignacionesTemp();
    } catch (error) {
        console.error('Error cargando asignaciones del docente', error);
        mostrarAlerta('No se pudieron cargar las asignaciones existentes', 'error');
        ASIGNACIONES_DOCENTE_TEMP = [];
        renderAsignacionesTemp();
    }
}

function agregarAsignacionTemp() {
    const gradoSelect = document.getElementById('select-grado');
    const materiaSelect = document.getElementById('select-materia');
    const estado = document.getElementById('select-estado').value;
    const grado = gradoSelect.value;
    const materia = materiaSelect.value;

    if (!grado || !materia) return;

    const existe = ASIGNACIONES_DOCENTE_TEMP.some(a => a.id_grado === grado && a.id_materia === materia);
    if (existe) {
        mostrarAlerta('Ya agregaste esa combinación grado/materia', 'info');
        return;
    }

    ASIGNACIONES_DOCENTE_TEMP.push({
        id_grado: grado,
        nombre_grado: gradoSelect.options[gradoSelect.selectedIndex].text,
        id_materia: materia,
        nombre_materia: materiaSelect.options[materiaSelect.selectedIndex].text,
        estado
    });
    renderAsignacionesTemp();
}

function renderAsignacionesTemp() {
    const cont = document.getElementById('lista-asignaciones-temp');
    if (!ASIGNACIONES_DOCENTE_TEMP.length) {
        cont.innerHTML = Helpers.sinDatos('Aún no agregas asignaciones');
        return;
    }
    cont.innerHTML = ASIGNACIONES_DOCENTE_TEMP.map((a, idx) => `
        <div class="pill">
            <span>${a.nombre_grado || ('Grado ' + a.id_grado)} · ${a.nombre_materia || ('Materia ' + a.id_materia)} · ${a.estado}</span>
            <button type="button" onclick="quitarAsignacionTemp(${idx})"><i class="fas fa-times"></i></button>
        </div>
    `).join('');
}

function quitarAsignacionTemp(idx) {
    ASIGNACIONES_DOCENTE_TEMP.splice(idx, 1);
    renderAsignacionesTemp();
}

async function guardarAsignacionesDocente(e) {
    e.preventDefault();
    if (!DOCENTE_SELECCIONADO) {
        mostrarAlerta('Selecciona un docente', 'error');
        return;
    }
    try {
        await API.guardarAsignacionesDocente(DOCENTE_SELECCIONADO, ASIGNACIONES_DOCENTE_TEMP);
        mostrarAlerta('Asignaciones guardadas', 'success');
        cerrarModal('modal-asignar-docente');
        renderDocentes();
    } catch (error) {
        mostrarAlerta(error.message || 'No se pudo guardar', 'error');
    }
}
