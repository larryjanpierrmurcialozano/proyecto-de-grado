// ════════════════════════════════════════════════════════════════════════════════
// DOCSTRY - MÓDULO USUARIOS
// CRUD completo de usuarios del sistema
// ════════════════════════════════════════════════════════════════════════════════

async function renderUsuarios() {
    const content = document.getElementById('main-content');
    content.innerHTML = Helpers.loading();

    try {
        const data = await API.getUsuarios();
        const usuarios = data.usuarios;

        content.innerHTML = `
            <div class="card">
                <div class="card-header-flex">
                    <h2 class="card-title" style="border:none;margin:0;padding:0;">
                        <i class="fas fa-users"></i> Gestión de Usuarios
                    </h2>
                    <button class="btn btn-verde" onclick="abrirModalUsuario()">
                        <i class="fas fa-plus"></i> Nuevo Usuario
                    </button>
                </div>
                <div class="filtros-container">
                    <div class="busqueda-box">
                        <i class="fas fa-search"></i>
                        <input type="text" id="buscar-usuario" placeholder="Buscar por nombre, email o documento...">
                    </div>
                    <select id="filtro-rol" class="filtro-select">
                        <option value="">Todos los roles</option>
                        <option value="server_admin">Administrador</option>
                        <option value="Rector">Rector</option>
                        <option value="Coordinador">Coordinador</option>
                        <option value="Profesor">Profesor</option>
                    </select>
                    <select id="filtro-estado" class="filtro-select">
                        <option value="">Todos los estados</option>
                        <option value="1">Activo</option>
                        <option value="0">Inactivo</option>
                    </select>
                </div>
                <div class="tabla-container">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nombre Completo</th>
                                <th>Email</th>
                                <th>Documento</th>
                                <th>Rol</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody id="tabla-usuarios-body">
                            ${generarFilasUsuarios(usuarios)}
                        </tbody>
                    </table>
                </div>
            </div>
        `;

        document.getElementById('buscar-usuario').addEventListener('input', () => filtrarUsuarios(usuarios));
        document.getElementById('filtro-rol').addEventListener('change', () => filtrarUsuarios(usuarios));
        document.getElementById('filtro-estado').addEventListener('change', () => filtrarUsuarios(usuarios));
    } catch (error) {
        content.innerHTML = Helpers.error('No se pudieron cargar los usuarios.');
    }
}

function generarFilasUsuarios(usuarios) {
    if (usuarios.length === 0) {
        return '<tr><td colspan="7">' + Helpers.sinDatos('No se encontraron usuarios.') + '</td></tr>';
    }
    return usuarios.map(u => `
        <tr>
            <td>${u.id_usuario}</td>
            <td>${Helpers.celdaUsuario(u.nombre, u.apellido)}</td>
            <td>${u.correo}</td>
            <td>${u.documento}</td>
            <td>${Helpers.badgeRol(u.nombre_rol)}</td>
            <td>${Helpers.badgeEstado(u.is_activo)}</td>
            <td>${Helpers.botonesAcciones(u.id_usuario, 'verUsuario', 'abrirModalUsuario', 'confirmarEliminacion')}</td>
        </tr>
    `).join('');
}

function filtrarUsuarios(usuarios) {
    const busqueda = document.getElementById('buscar-usuario').value.toLowerCase();
    const rol = document.getElementById('filtro-rol').value;
    const estado = document.getElementById('filtro-estado').value;

    const filtrados = usuarios.filter(u => {
        const nombreCompleto = `${u.nombre} ${u.apellido}`.toLowerCase();
        const email = u.correo.toLowerCase();
        const documento = u.documento.toLowerCase();
        const coincideBusqueda = nombreCompleto.includes(busqueda) || email.includes(busqueda) || documento.includes(busqueda);
        const coincideRol = !rol || u.nombre_rol === rol;
        const coincideEstado = estado === '' || u.is_activo.toString() === estado;
        return coincideBusqueda && coincideRol && coincideEstado;
    });

    document.getElementById('tabla-usuarios-body').innerHTML = generarFilasUsuarios(filtrados);
}

async function abrirModalUsuario(id = null) {
    const form = document.getElementById('form-usuario');
    form.reset();
    document.getElementById('usuario-id').value = id || '';

    const titulo = document.getElementById('modal-usuario-titulo');
    const inputPassword = document.getElementById('usuario-password');

    if (id) {
        titulo.textContent = 'Editar Usuario';
        inputPassword.placeholder = 'Dejar vacío para no cambiar';
        inputPassword.required = false;

        try {
            const data = await API.getUsuario(id);
            const u = data.usuario;
            document.getElementById('usuario-nombre').value = u.nombre;
            document.getElementById('usuario-apellido').value = u.apellido;
            document.getElementById('usuario-email').value = u.correo;
            document.getElementById('usuario-documento').value = u.documento;
            document.getElementById('usuario-rol').value = u.id_rol;
            document.getElementById('usuario-estado').value = u.is_activo;
        } catch (error) {
            mostrarAlerta('Error al cargar datos del usuario', 'error');
            return;
        }
    } else {
        titulo.textContent = 'Nuevo Usuario';
        inputPassword.placeholder = 'Mínimo 6 caracteres';
        inputPassword.required = true;
    }

    document.getElementById('modal-usuario').classList.add('active');
}

document.getElementById('form-usuario').addEventListener('submit', async function (e) {
    e.preventDefault();
    const id = document.getElementById('usuario-id').value;
    const data = {
        nombre: document.getElementById('usuario-nombre').value,
        apellido: document.getElementById('usuario-apellido').value,
        correo: document.getElementById('usuario-email').value,
        documento: document.getElementById('usuario-documento').value,
        id_rol: document.getElementById('usuario-rol').value,
        is_activo: document.getElementById('usuario-estado').value,
        password: document.getElementById('usuario-password').value
    };

    try {
        if (id) {
            if (!data.password) delete data.password;
            await API.actualizarUsuario(id, data);
            mostrarAlerta('Usuario actualizado con éxito', 'success');
        } else {
            await API.crearUsuario(data);
            mostrarAlerta('Usuario creado con éxito', 'success');
        }
        cerrarModal('modal-usuario');
        renderUsuarios();
    } catch (error) {
        mostrarAlerta(error.message || 'Error al guardar usuario', 'error');
    }
});

function confirmarEliminacion(id) {
    const modal = document.getElementById('modal-eliminar');
    modal.classList.add('active');

    const btnConfirmar = modal.querySelector('.btn-rojo');
    const newBtn = btnConfirmar.cloneNode(true);
    btnConfirmar.parentNode.replaceChild(newBtn, btnConfirmar);

    newBtn.onclick = async () => {
        try {
            await API.eliminarUsuario(id);
            mostrarAlerta('Usuario eliminado (marcado como inactivo)', 'success');
            cerrarModal('modal-eliminar');
            renderUsuarios();
        } catch (error) {
            mostrarAlerta(error.message || 'Error al eliminar usuario', 'error');
        }
    };
}

async function verUsuario(id) {
    const modal = document.getElementById('modal-ver-usuario');
    const contenido = modal.querySelector('.detalle-usuario');
    contenido.innerHTML = Helpers.loading();
    modal.classList.add('active');

    try {
        const data = await API.getUsuario(id);
        const u = data.usuario;
        contenido.innerHTML = `
            <div class="detalle-avatar">
                <div class="avatar-grande">${Helpers.getIniciales(u.nombre, u.apellido)}</div>
                <h3>${u.nombre} ${u.apellido}</h3>
                ${Helpers.badgeRol(u.nombre_rol)}
            </div>
            <div class="detalle-info">
                <div class="detalle-item">
                    <i class="fas fa-envelope"></i>
                    <div><label>Correo</label><span>${u.correo}</span></div>
                </div>
                <div class="detalle-item">
                    <i class="fas fa-id-card"></i>
                    <div><label>Documento</label><span>${u.documento}</span></div>
                </div>
                <div class="detalle-item">
                    <i class="fas fa-calendar"></i>
                    <div><label>Fecha de Registro</label><span>${Helpers.formatearFecha(u.created_at)}</span></div>
                </div>
                <div class="detalle-item">
                    <i class="fas fa-circle" style="color: ${u.is_activo ? '#4caf50' : '#e53935'};"></i>
                    <div><label>Estado</label><span>${u.is_activo ? 'Activo' : 'Inactivo'}</span></div>
                </div>
            </div>
        `;
    } catch (error) {
        contenido.innerHTML = Helpers.error('No se pudo cargar el detalle del usuario.');
    }
}
