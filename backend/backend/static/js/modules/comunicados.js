// ════════════════════════════════════════════════════════════════════════════════
// DOCSTRY - MÓDULO COMUNICADOS
// CRUD de comunicados institucionales con filtros y roles
// ════════════════════════════════════════════════════════════════════════════════

let comunicadosCargados = [];

function renderComunicados() {
    const esAdmin = ['server_admin', 'rector', 'coordinador'].includes(USUARIO.rol);
    const esProfesor = USUARIO.rol.toLowerCase() === 'profesor' || USUARIO.rol.toLowerCase() === 'docente';
    const totalCols = esAdmin ? 7 : (esProfesor ? 6 : 6);
    const content = document.getElementById('main-content');
    content.innerHTML = `
        <!-- HEADER -->
        <div class="com-header">
            <div>
                <h1><i class="fas fa-bullhorn"></i> ${esProfesor ? 'Comunicados' : 'Gestión de Comunicados'}</h1>
                <p>${esProfesor ? 'Comunicados dirigidos al equipo docente' : 'Administra los comunicados institucionales'}</p>
            </div>
            ${esAdmin ? `<button class="btn btn-verde" onclick="abrirModalComunicado()">
                <i class="fas fa-plus"></i> Nuevo Comunicado
            </button>` : ''}
        </div>

        <!-- LAYOUT PRINCIPAL -->
        <div class="com-layout">
            <!-- FILTROS LATERALES -->
            <div class="com-filtros">
                <div class="com-filtro-grupo">
                    <label>Tipo</label>
                    <select id="filtro-com-tipo" onchange="filtrarComunicados()">
                        <option value="">Todos</option>
                        <option value="Circular">Circular</option>
                        <option value="Aviso">Aviso</option>
                        <option value="Información">Información</option>
                        <option value="Advertencia">Advertencia</option>
                    </select>
                </div>
                ${!esProfesor ? `<div class="com-filtro-grupo">
                    <label>Dirigido a</label>
                    <select id="filtro-com-audiencia" onchange="filtrarComunicados()">
                        <option value="">Todos</option>
                        <option value="General">General</option>
                        <option value="Docentes">Docentes</option>
                        <option value="Coordinación">Coordinación</option>
                        <option value="Administrativo">Administrativo</option>
                    </select>
                </div>` : ''}
                <div class="com-filtro-grupo">
                    <label>Prioridad</label>
                    <select id="filtro-com-prioridad" onchange="filtrarComunicados()">
                        <option value="">Todas</option>
                        <option value="Urgente">Urgente</option>
                        <option value="Alta">Alta</option>
                        <option value="Media">Media</option>
                        <option value="Baja">Baja</option>
                    </select>
                </div>
                <button class="btn btn-cafe" style="width:100%;" onclick="limpiarFiltrosCom()">
                    <i class="fas fa-redo"></i> Limpiar
                </button>
            </div>

            <!-- TABLA -->
            <div class="com-tabla-wrap">
                <table class="com-tabla">
                    <thead>
                        <tr>
                            <th>Título</th>
                            <th>Tipo</th>
                            ${!esProfesor ? '<th>Dirigido a</th>' : ''}
                            <th>Prioridad</th>
                            <th>Fecha</th>
                            <th>Estado</th>
                            ${esAdmin ? '<th>Acciones</th>' : (esProfesor ? '<th>Ver</th>' : '')}
                        </tr>
                    </thead>
                    <tbody id="com-tbody">
                        <tr>
                            <td colspan="${totalCols}" style="text-align:center;padding:2rem;color:#999;">
                                <i class="fas fa-spinner fa-spin"></i> Cargando...
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    `;
    cargarComunicados();
}

async function cargarComunicados() {
    const esAdmin = ['server_admin', 'rector', 'coordinador'].includes(USUARIO.rol);
    let comunicados = [];

    try {
        const data = await API.request('/api/comunicados');
        comunicados = data.comunicados || data || [];
    } catch (e) {
        mostrarAlerta('No se pudieron cargar los comunicados', 'error');
    }

    comunicadosCargados = comunicados;
    renderTablaComunicados(comunicados, esAdmin);
}

function renderTablaComunicados(comunicados, esAdmin) {
    const esProfesor = USUARIO.rol.toLowerCase() === 'profesor' || USUARIO.rol.toLowerCase() === 'docente';
    const totalCols = esAdmin ? 7 : (esProfesor ? 6 : 6);
    const tbody = document.getElementById('com-tbody');

    if (comunicados.length === 0) {
        tbody.innerHTML = `<tr><td colspan="${totalCols}" style="text-align:center;padding:2rem;color:#999;">
            <i class="fas fa-inbox" style="font-size:1.5rem;"></i><br>No hay comunicados
        </td></tr>`;
        return;
    }

    tbody.innerHTML = comunicados.map(c => {
        const prioridadBadge = { 'Urgente': 'badge-rojo', 'Alta': 'badge-naranja', 'Media': 'badge-amarillo', 'Baja': 'badge-verde' }[c.prioridad] || 'badge-gris';
        const estadoBadge = c.activo ? 'badge-verde' : 'badge-gris';
        const estadoTexto = c.activo ? 'Activo' : 'Inactivo';

        return `<tr>
            <td><strong>${c.titulo}</strong></td>
            <td><span class="badge badge-azul">${c.tipo_comunicado}</span></td>
            ${!esProfesor ? `<td><span class="badge badge-gris">${c.audiencia}</span></td>` : ''}
            <td><span class="badge ${prioridadBadge}">${c.prioridad}</span></td>
            <td>${new Date(c.fecha_publicacion).toLocaleDateString('es-ES')}</td>
            <td><span class="badge ${estadoBadge}">${estadoTexto}</span></td>
            ${esAdmin ? `<td class="com-acciones">
                <button class="com-btn-accion com-btn-ver" onclick="verComunicado(${c.id_comunicado})" title="Ver"><i class="fas fa-eye"></i></button>
                <button class="com-btn-accion com-btn-editar" onclick="editarComunicado(${c.id_comunicado})" title="Editar"><i class="fas fa-edit"></i></button>
                <button class="com-btn-accion com-btn-eliminar" onclick="eliminarComunicado(${c.id_comunicado})" title="Eliminar"><i class="fas fa-trash"></i></button>
            </td>` : (esProfesor ? `<td class="com-acciones">
                <button class="com-btn-accion com-btn-ver" onclick="verComunicado(${c.id_comunicado})" title="Ver"><i class="fas fa-eye"></i></button>
            </td>` : '')}
        </tr>`;
    }).join('');
}

function filtrarComunicados() {
    const esAdmin = ['server_admin', 'rector', 'coordinador'].includes(USUARIO.rol);
    const tipo = document.getElementById('filtro-com-tipo').value;
    const audienciaEl = document.getElementById('filtro-com-audiencia');
    const audiencia = audienciaEl ? audienciaEl.value : '';
    const prioridad = document.getElementById('filtro-com-prioridad').value;

    let filtrados = comunicadosCargados.filter(c => {
        if (tipo && c.tipo_comunicado !== tipo) return false;
        if (audiencia && c.audiencia !== audiencia) return false;
        if (prioridad && c.prioridad !== prioridad) return false;
        return true;
    });

    renderTablaComunicados(filtrados, esAdmin);
}

function limpiarFiltrosCom() {
    document.getElementById('filtro-com-tipo').value = '';
    const audienciaEl = document.getElementById('filtro-com-audiencia');
    if (audienciaEl) audienciaEl.value = '';
    document.getElementById('filtro-com-prioridad').value = '';
    filtrarComunicados();
}

function verComunicado(id) {
    const c = comunicadosCargados.find(x => x.id_comunicado === id);
    if (!c) return mostrarAlerta('Comunicado no encontrado', 'error');

    const prioridadColor = { 'Urgente': '#e53935', 'Alta': '#ff9800', 'Media': '#fbc02d', 'Baja': '#43a047' }[c.prioridad] || '#888';
    document.getElementById('ver-comunicado-body').innerHTML = `
        <div style="margin-bottom:1rem;">
            <h3 style="margin:0 0 0.5rem 0;color:#fff;font-size:1.2rem;">${c.titulo}</h3>
            <div style="display:flex;gap:0.5rem;flex-wrap:wrap;margin-bottom:1rem;">
                <span class="badge badge-azul">${c.tipo_comunicado}</span>
                <span class="badge badge-gris">${c.audiencia}</span>
                <span class="badge" style="background:${prioridadColor};color:#fff;">${c.prioridad}</span>
                <span class="badge ${c.activo ? 'badge-verde' : 'badge-gris'}">${c.activo ? 'Activo' : 'Inactivo'}</span>
            </div>
        </div>
        <div style="background:#f9f5f0;padding:1.2rem 1.5rem;border-radius:8px;border:1px solid #e8ddd0;white-space:pre-wrap;word-wrap:break-word;overflow-wrap:break-word;line-height:1.7;color:#3d2a1b;font-size:0.95rem;min-height:120px;max-width:100%;box-sizing:border-box;">
            ${c.contenido}
        </div>
        <div style="margin-top:1rem;font-size:0.85rem;color:#ccc;">
            <i class="fas fa-calendar"></i> Publicado: ${new Date(c.fecha_publicacion).toLocaleDateString('es-ES', { day: 'numeric', month: 'long', year: 'numeric' })}
            ${c.autor_nombre ? ` · <i class="fas fa-user"></i> ${c.autor_nombre} ${c.autor_apellido || ''}` : ''}
        </div>
    `;
    document.getElementById('modal-ver-comunicado').classList.add('active');
}

function abrirModalComunicado(id = null) {
    document.getElementById('com-id').value = '';
    document.getElementById('com-titulo').value = '';
    document.getElementById('com-tipo').value = 'Información';
    document.getElementById('com-audiencia').value = 'General';
    document.getElementById('com-prioridad').value = 'Media';
    document.getElementById('com-contenido').value = '';

    if (id) {
        const c = comunicadosCargados.find(x => x.id_comunicado === id);
        if (c) {
            document.getElementById('modal-comunicado-titulo').innerHTML = '<i class="fas fa-edit"></i> Editar Comunicado';
            document.getElementById('com-id').value = c.id_comunicado;
            document.getElementById('com-titulo').value = c.titulo;
            document.getElementById('com-tipo').value = c.tipo_comunicado;
            document.getElementById('com-audiencia').value = c.audiencia;
            document.getElementById('com-prioridad').value = c.prioridad;
            document.getElementById('com-contenido').value = c.contenido;
        }
    } else {
        document.getElementById('modal-comunicado-titulo').innerHTML = '<i class="fas fa-bullhorn"></i> Nuevo Comunicado';
    }
    document.getElementById('modal-comunicado').classList.add('active');
}

function editarComunicado(id) {
    abrirModalComunicado(id);
}

async function guardarComunicado(e) {
    e.preventDefault();
    const id = document.getElementById('com-id').value;
    const datos = {
        titulo: document.getElementById('com-titulo').value.trim(),
        contenido: document.getElementById('com-contenido').value.trim(),
        tipo_comunicado: document.getElementById('com-tipo').value,
        audiencia: document.getElementById('com-audiencia').value,
        prioridad: document.getElementById('com-prioridad').value
    };

    if (!datos.titulo || !datos.contenido) {
        return mostrarAlerta('Título y contenido son obligatorios', 'error');
    }

    try {
        const url = id ? `/api/comunicados/${id}` : '/api/comunicados';
        const method = id ? 'PUT' : 'POST';
        await API.request(url, {
            method,
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(datos)
        });
        mostrarAlerta(id ? 'Comunicado actualizado' : 'Comunicado creado', 'success');
        cerrarModal('modal-comunicado');
        cargarComunicados();
    } catch (err) {
        mostrarAlerta(err.message || 'Error al guardar comunicado', 'error');
    }
}

async function eliminarComunicado(id) {
    document.getElementById('btn-confirmar-eliminar-com').onclick = async () => {
        cerrarModal('modal-eliminar-comunicado');
        try {
            await API.request(`/api/comunicados/${id}`, { method: 'DELETE' });
            mostrarAlerta('Comunicado eliminado', 'success');
            cargarComunicados();
        } catch (err) {
            mostrarAlerta(err.message || 'Error al eliminar comunicado', 'error');
        }
    };
    document.getElementById('modal-eliminar-comunicado').classList.add('active');
}
