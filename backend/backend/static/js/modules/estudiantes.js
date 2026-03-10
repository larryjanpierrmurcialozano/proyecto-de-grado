// ════════════════════════════════════════════════════════════════════════════════
// DOCSTRY - MÓDULO ESTUDIANTES
// CRUD completo de estudiantes
// ════════════════════════════════════════════════════════════════════════════════

let ESTUDIANTES_CACHE = [];
let GRUPOS_CACHE_EST = []; // Cache local para evitar conflictos

async function renderEstudiantes() {
    const content = document.getElementById('main-content');
    content.innerHTML = Helpers.loading();

    try {
        const [estudiantesRes, gruposRes] = await Promise.all([
            API.getEstudiantes(),
            API.getGrupos()
        ]);

        ESTUDIANTES_CACHE = estudiantesRes.estudiantes || [];
        GRUPOS_CACHE_EST = gruposRes.grupos || [];

        const opcionesGrado = Array.from(new Set(GRUPOS_CACHE_EST.map(g => g.nombre_grado))).filter(Boolean);
        const opcionesGrupo = GRUPOS_CACHE_EST.map(g => ({ id: g.id_grupo, nombre: g.codigo_grupo, grado: g.nombre_grado }));

        content.innerHTML = `
            <div class="card">
                <div class="card-header-flex">
                    <h2 class="card-title" style="border:none;margin:0;padding:0;">
                        <i class="fas fa-user-graduate"></i> Gestión de Estudiantes
                    </h2>
                    <button class="btn btn-verde" onclick="abrirModalEstudiante()">
                        <i class="fas fa-plus"></i> Nuevo Estudiante
                    </button>
                </div>
                <div class="filtros-container">
                    <div class="busqueda-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="filtro-estudiante-buscar" placeholder="Buscar por nombre, apellido o documento">
                    </div>
                    <select class="filtro-select" id="filtro-estudiante-grado">
                        <option value="">Todos los grados</option>
                        ${opcionesGrado.map(g => `<option value="${g}">${g}</option>`).join('')}
                    </select>
                    <select class="filtro-select" id="filtro-estudiante-grupo">
                        <option value="">Todos los grupos</option>
                        ${opcionesGrupo.map(g => `<option value="${g.id}">${g.nombre} (${g.grado})</option>`).join('')}
                    </select>
                    <select class="filtro-select" id="filtro-estudiante-estado">
                        <option value="">Todos los estados</option>
                        <option value="Activo">Activo</option>
                        <option value="Inactivo">Inactivo</option>
                    </select>
                </div>
                <div class="tabla-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Documento</th>
                                <th>Nombre Completo</th>
                                <th>Grado / Grupo</th>
                                <th>Acudiente</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody id="tbody-estudiantes"></tbody>
                    </table>
                </div>
            </div>
        `;

        document.getElementById('filtro-estudiante-buscar').addEventListener('input', aplicarFiltrosEstudiantes);
        document.getElementById('filtro-estudiante-grado').addEventListener('change', aplicarFiltrosEstudiantes);
        document.getElementById('filtro-estudiante-grupo').addEventListener('change', aplicarFiltrosEstudiantes);
        document.getElementById('filtro-estudiante-estado').addEventListener('change', aplicarFiltrosEstudiantes);

        aplicarFiltrosEstudiantes();
    } catch (error) {
        console.error('Error renderEstudiantes', error);
        content.innerHTML = Helpers.error('No se pudieron cargar los estudiantes.');
    }
}

function aplicarFiltrosEstudiantes() {
    const buscar = (document.getElementById('filtro-estudiante-buscar')?.value || '').toLowerCase();
    const grado = document.getElementById('filtro-estudiante-grado')?.value || '';
    const grupo = document.getElementById('filtro-estudiante-grupo')?.value || '';
    const estado = document.getElementById('filtro-estudiante-estado')?.value || '';

    const filtrados = ESTUDIANTES_CACHE.filter(e => {
        const coincideBusqueda = !buscar || `${e.nombre} ${e.apellido} ${e.documento}`.toLowerCase().includes(buscar);
        const grupoData = GRUPOS_CACHE_EST.find(g => String(g.id_grupo) === String(e.id_grupo));
        const nombreGrado = grupoData ? grupoData.nombre_grado : e.nombre_grado;
        const coincideGrado = !grado || nombreGrado === grado;
        const coincideGrupo = !grupo || String(e.id_grupo) === String(grupo);
        const coincideEstado = !estado || String(e.estado).toLowerCase() === estado.toLowerCase();
        return coincideBusqueda && coincideGrado && coincideGrupo && coincideEstado;
    });

    dibujarTablaEstudiantes(filtrados);
}

function dibujarTablaEstudiantes(lista) {
    const tbody = document.getElementById('tbody-estudiantes');
    if (!tbody) return;

    if (!lista.length) {
        tbody.innerHTML = `<tr><td colspan="7">${Helpers.sinDatos('No hay estudiantes')}</td></tr>`;
        return;
    }

    tbody.innerHTML = lista.map(e => {
        const grupoData = GRUPOS_CACHE_EST.find(g => String(g.id_grupo) === String(e.id_grupo));
        const gradoGrupo = grupoData ? `${grupoData.nombre_grado} / ${grupoData.codigo_grupo}` : `${e.nombre_grado || ''} / ${e.codigo_grupo || ''}`;
        const acudiente = e.acudiente_nombre ? `${e.acudiente_nombre}${e.acudiente_telefono ? ' - ' + e.acudiente_telefono : ''}` : '-';
        return `
            <tr>
                <td>${e.id_estudiante}</td>
                <td>${e.documento || '-'}</td>
                <td>${Helpers.celdaUsuario(e.nombre, e.apellido)}</td>
                <td>${gradoGrupo}</td>
                <td>${acudiente}</td>
                <td>${Helpers.badgeEstado(e.estado)}</td>
                <td>${Helpers.botonesAcciones(e.id_estudiante, 'verEstudiante', 'abrirModalEstudiante', 'eliminarEstudiante')}</td>
            </tr>
        `;
    }).join('');
}

async function abrirModalEstudiante(id = null) {
    const overlay = document.getElementById('modal-estudiante');
    overlay.classList.add('active');
    document.getElementById('modal-estudiante-titulo').textContent = id ? 'Editar Estudiante' : 'Nuevo Estudiante';
    document.getElementById('form-estudiante').reset();
    document.getElementById('estudiante-id').value = id || '';

    if (!GRUPOS_CACHE_EST.length) {
        try {
            const gruposRes = await API.getGrupos();
            GRUPOS_CACHE_EST = gruposRes.grupos || [];
        } catch (err) {
            mostrarAlerta('No se pudieron cargar los grupos', 'error');
            return;
        }
    }

    _poblarSelectGruposEstudiante();

    if (id) {
        try {
            const res = await API.getEstudiante(id);
            const e = res.estudiante;
            if (!e) throw new Error('Estudiante no encontrado');

            document.getElementById('estudiante-documento').value = e.documento || '';
            document.getElementById('estudiante-nombre').value = e.nombre || '';
            document.getElementById('estudiante-apellido').value = e.apellido || '';

            const fechaElement = document.getElementById('estudiante-fecha-nacimiento');
            if (fechaElement && e.fecha_nacimiento) {
                fechaElement.value = e.fecha_nacimiento.substring(0, 10);
            }

            document.getElementById('estudiante-correo').value = e.correo || '';
            document.getElementById('estudiante-genero').value = e.genero || 'M';
            document.getElementById('estudiante-grupo').value = e.id_grupo;
            document.getElementById('estudiante-acudiente-nombre').value = e.acudiente_nombre || '';
            document.getElementById('estudiante-acudiente-telefono').value = e.acudiente_telefono || '';
            document.getElementById('estudiante-direccion').value = e.direccion || '';
            document.getElementById('estudiante-estado').value = e.estado || 'Activo';
        } catch (error) {
            console.error('Error cargando estudiante', error);
            mostrarAlerta('No se pudo cargar el estudiante', 'error');
            cerrarModal('modal-estudiante');
            return;
        }
    } else {
        document.getElementById('estudiante-estado').value = 'Activo';
    }

    document.getElementById('form-estudiante').onsubmit = _submitEstudiante;
}

function _poblarSelectGruposEstudiante() {
    const select = document.getElementById('estudiante-grupo');
    if (!select) return;
    select.innerHTML = GRUPOS_CACHE_EST.map(g => `<option value="${g.id_grupo}">${g.codigo_grupo} - ${g.nombre_grado}</option>`).join('');
}

async function _submitEstudiante(event) {
    event.preventDefault();
    const id = document.getElementById('estudiante-id').value;

    const payload = {
        documento: document.getElementById('estudiante-documento').value,
        nombre: document.getElementById('estudiante-nombre').value,
        apellido: document.getElementById('estudiante-apellido').value,
        correo: document.getElementById('estudiante-correo').value,
        fecha_nacimiento: document.getElementById('estudiante-fecha-nacimiento').value || null,
        genero: document.getElementById('estudiante-genero').value,
        id_grupo: document.getElementById('estudiante-grupo').value,
        acudiente_nombre: document.getElementById('estudiante-acudiente-nombre').value,
        acudiente_telefono: document.getElementById('estudiante-acudiente-telefono').value,
        direccion: document.getElementById('estudiante-direccion').value,
        estado: document.getElementById('estudiante-estado').value
    };

    try {
        if (id) {
            await API.actualizarEstudiante(id, payload);
            mostrarAlerta('Estudiante actualizado', 'success');
        } else {
            await API.crearEstudiante(payload);
            mostrarAlerta('Estudiante creado', 'success');
        }
        cerrarModal('modal-estudiante');
        renderEstudiantes();
    } catch (error) {
        mostrarAlerta(error.message || 'No se pudo guardar el estudiante', 'error');
    }
}

async function eliminarEstudiante(id) {
    const overlay = document.getElementById('modal-eliminar-estudiante');
    overlay.classList.add('active');

    const btnEliminar = document.getElementById('btn-confirmar-eliminar-estudiante');
    const btnInactivar = document.getElementById('btn-inactivar-estudiante');

    const nuevoEliminar = btnEliminar.cloneNode(true);
    btnEliminar.parentNode.replaceChild(nuevoEliminar, btnEliminar);
    const nuevoInactivar = btnInactivar.cloneNode(true);
    btnInactivar.parentNode.replaceChild(nuevoInactivar, btnInactivar);

    nuevoEliminar.onclick = async () => {
        try {
            await API.eliminarEstudiante(id);
            mostrarAlerta('Estudiante eliminado', 'success');
            cerrarModal('modal-eliminar-estudiante');
            renderEstudiantes();
        } catch (error) {
            mostrarAlerta(error.message || 'No se pudo eliminar', 'error');
        }
    };

    nuevoInactivar.onclick = async () => {
        try {
            const res = await API.getEstudiante(id);
            const e = res.estudiante;
            if (!e) throw new Error('No encontrado');
            await API.actualizarEstudiante(id, {
                documento: e.documento, nombre: e.nombre, apellido: e.apellido,
                correo: e.correo, id_grupo: e.id_grupo,
                acudiente_nombre: e.acudiente_nombre, acudiente_telefono: e.acudiente_telefono,
                direccion: e.direccion, estado: 'Inactivo'
            });
            mostrarAlerta('Estudiante marcado como inactivo', 'success');
            cerrarModal('modal-eliminar-estudiante');
            renderEstudiantes();
        } catch (error) {
            mostrarAlerta(error.message || 'No se pudo inactivar', 'error');
        }
    };
}

async function verEstudiante(id) {
    const overlay = document.getElementById('modal-ver-estudiante');
    const body = document.getElementById('ver-estudiante-body');
    overlay.classList.add('active');
    body.innerHTML = Helpers.loading();

    try {
        const res = await API.getEstudiante(id);
        const e = res.estudiante;
        if (!e) throw new Error('No encontrado');
        const grupoData = GRUPOS_CACHE_EST.find(g => String(g.id_grupo) === String(e.id_grupo));
        const gradoGrupo = grupoData ? `${grupoData.nombre_grado} / ${grupoData.codigo_grupo}` : `${e.nombre_grado || ''} / ${e.codigo_grupo || ''}`;
        const fechaNac = e.fecha_nacimiento ? e.fecha_nacimiento.split('T')[0] : '-';

        body.innerHTML = `
            <div class="detalle-info">
                <div class="detalle-item"><i class="fas fa-id-card"></i><div><label>Documento</label><span>${e.documento || '-'}</span></div></div>
                <div class="detalle-item"><i class="fas fa-envelope"></i><div><label>Correo</label><span>${e.correo || '-'}</span></div></div>
                <div class="detalle-item"><i class="fas fa-user"></i><div><label>Nombre</label><span>${e.nombre} ${e.apellido}</span></div></div>
                <div class="detalle-item"><i class="fas fa-calendar"></i><div><label>Fecha de nacimiento</label><span>${fechaNac}</span></div></div>
                <div class="detalle-item"><i class="fas fa-venus-mars"></i><div><label>Género</label><span>${e.genero || '-'}</span></div></div>
                <div class="detalle-item"><i class="fas fa-users"></i><div><label>Grupo</label><span>${gradoGrupo}</span></div></div>
                <div class="detalle-item"><i class="fas fa-toggle-on"></i><div><label>Estado</label><span>${e.estado}</span></div></div>
                <div class="detalle-item"><i class="fas fa-user-friends"></i><div><label>Acudiente</label><span>${e.acudiente_nombre || '-'}${e.acudiente_telefono ? ' - ' + e.acudiente_telefono : ''}</span></div></div>
                <div class="detalle-item"><i class="fas fa-home"></i><div><label>Dirección</label><span>${e.direccion || '-'}</span></div></div>
            </div>
        `;
    } catch (error) {
        body.innerHTML = Helpers.error('No se pudo cargar el estudiante');
    }
}
