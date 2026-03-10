// ════════════════════════════════════════════════════════════════════════════════
// DOCSTRY - MÓDULO REPORTES
// Generación y envío de reportes por correo electrónico
// ════════════════════════════════════════════════════════════════════════════════

function renderReportes() {
    const content = document.getElementById('main-content');
    content.innerHTML = `
        <div class="card">
            <div class="card-header-flex">
                <h2 class="card-title" style="border:none;margin:0;padding:0;">
                    <i class="fas fa-file-pdf"></i> Generador de Reportes
                </h2>
            </div>

            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-bottom: 2rem;">
                <!-- COLUMNA IZQUIERDA: Opciones de Reportes -->
                <div>
                    <h3 style="margin-bottom: 1rem; color: var(--cafe-oscuro);"><i class="fas fa-list"></i> Tipos de Reportes</h3>
                    <div class="reportes-grid" style="display: flex; flex-direction: column; gap: 1rem;">
                        <div class="reporte-categoria">
                            <h4 style="margin-bottom: 0.5rem;"><i class="fas fa-graduation-cap"></i> Académicos</h4>
                            <div class="reporte-item" onclick="seleccionarReporte('boletin')" style="margin: 0.5rem 0; padding: 0.75rem; cursor: pointer; border-radius: 5px; background: #f5f5f5;">
                                <div style="display: flex; align-items: center; gap: 0.5rem;">
                                    <input type="radio" name="tipo-reporte" value="boletin" id="radio-boletin">
                                    <label for="radio-boletin" style="margin: 0; cursor: pointer;">Boletín de Calificaciones</label>
                                </div>
                            </div>
                            <div class="reporte-item" onclick="seleccionarReporte('consolidado')" style="margin: 0.5rem 0; padding: 0.75rem; cursor: pointer; border-radius: 5px; background: #f5f5f5;">
                                <div style="display: flex; align-items: center; gap: 0.5rem;">
                                    <input type="radio" name="tipo-reporte" value="consolidado" id="radio-consolidado">
                                    <label for="radio-consolidado" style="margin: 0; cursor: pointer;">Consolidado de Notas</label>
                                </div>
                            </div>
                        </div>
                        <div class="reporte-categoria">
                            <h4 style="margin-bottom: 0.5rem;"><i class="fas fa-clipboard-check"></i> Asistencia</h4>
                            <div class="reporte-item" onclick="seleccionarReporte('asistencia_diaria')" style="margin: 0.5rem 0; padding: 0.75rem; cursor: pointer; border-radius: 5px; background: #f5f5f5;">
                                <div style="display: flex; align-items: center; gap: 0.5rem;">
                                    <input type="radio" name="tipo-reporte" value="asistencia_diaria" id="radio-asistencia_diaria">
                                    <label for="radio-asistencia_diaria" style="margin: 0; cursor: pointer;">Asistencia Diaria</label>
                                </div>
                            </div>
                        </div>
                        <div class="reporte-categoria">
                            <h4 style="margin-bottom: 0.5rem;"><i class="fas fa-building"></i> Institucionales</h4>
                            <div class="reporte-item" onclick="seleccionarReporte('estudiantes')" style="margin: 0.5rem 0; padding: 0.75rem; cursor: pointer; border-radius: 5px; background: #f5f5f5;">
                                <div style="display: flex; align-items: center; gap: 0.5rem;">
                                    <input type="radio" name="tipo-reporte" value="estudiantes" id="radio-estudiantes-rep">
                                    <label for="radio-estudiantes-rep" style="margin: 0; cursor: pointer;">Lista de Estudiantes</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- COLUMNA DERECHA: Formulario de Envío -->
                <div>
                    <h3 style="margin-bottom: 1rem; color: var(--cafe-oscuro);"><i class="fas fa-envelope"></i> Enviar Reporte por Correo</h3>
                    <form id="form-enviar-reporte" style="display: flex; flex-direction: column; gap: 1rem;">
                        <div class="form-group">
                            <label><i class="fas fa-user"></i> Remitente</label>
                            <input type="email" id="reporte-remitente" placeholder="ejemplo@gmail.com" value="" style="width: 100%;">
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-file-pdf"></i> Selecciona tipo de reporte</label>
                            <select id="reporte-tipo-select" style="width: 100%;">
                                <option value="">-- Selecciona un reporte --</option>
                                <option value="boletin">Boletín de Calificaciones</option>
                                <option value="consolidado">Consolidado de Notas</option>
                                <option value="asistencia_diaria">Asistencia Diaria</option>
                                <option value="estudiantes">Lista de Estudiantes</option>
                            </select>
                        </div>
                        <div style="border-top: 1px solid #ddd; padding-top: 1rem;">
                            <div class="form-group">
                                <label><i class="fas fa-radio-alt"></i> Destinatario</label>
                            </div>
                            <div style="display: flex; align-items: center; gap: 1rem; margin-bottom: 1rem;">
                                <input type="radio" name="tipo-destinatario" value="especifico" id="radio-especifico" checked>
                                <label for="radio-especifico" style="margin: 0;">Correo específico</label>
                            </div>
                            <div id="container-correo-especifico" style="margin-bottom: 1rem;">
                                <input type="email" id="reporte-correo-especifico" placeholder="padre@gmail.com" style="width: 100%;">
                            </div>
                            <div style="display: flex; align-items: center; gap: 1rem; margin-bottom: 1rem;">
                                <input type="radio" name="tipo-destinatario" value="grupo" id="radio-grupo">
                                <label for="radio-grupo" style="margin: 0;">Todos los correos de un grupo</label>
                            </div>
                            <div id="container-grupo" style="margin-bottom: 1rem; display: none;">
                                <select id="reporte-grupo-select" style="width: 100%;">
                                    <option value="">-- Selecciona un grupo --</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-message"></i> Mensaje</label>
                            <textarea id="reporte-mensaje" placeholder="Escribe el mensaje que deseas enviar..." style="width: 100%; min-height: 120px; padding: 0.75rem; border: 1px solid #ddd; border-radius: 5px; font-family: inherit;"></textarea>
                        </div>
                        <button type="submit" class="btn btn-verde" style="width: 100%;">
                            <i class="fas fa-send"></i> Enviar Correo
                        </button>
                    </form>
                </div>
            </div>
        </div>
    `;

    cargarGruposReporte();

    // Eventos de radio buttons de tipo de reporte
    document.querySelectorAll('input[name="tipo-reporte"]').forEach(radio => {
        radio.addEventListener('change', function () {
            document.querySelectorAll('.reporte-item').forEach(item => {
                item.style.backgroundColor = '#f5f5f5';
            });
            if (this.checked) {
                this.closest('.reporte-item').style.backgroundColor = '#E3F2FD';
                document.getElementById('reporte-tipo-select').value = this.value;
            }
        });
    });

    // Sincronizar select con radio buttons
    document.getElementById('reporte-tipo-select').addEventListener('change', function () {
        if (this.value) {
            seleccionarReporte(this.value);
        } else {
            document.querySelectorAll('.reporte-item').forEach(item => {
                item.style.backgroundColor = '#f5f5f5';
            });
            document.querySelectorAll('input[name="tipo-reporte"]').forEach(r => r.checked = false);
        }
    });

    // Eventos de radio buttons de destinatario
    document.getElementById('radio-especifico').addEventListener('change', () => {
        document.getElementById('container-correo-especifico').style.display = 'block';
        document.getElementById('container-grupo').style.display = 'none';
    });

    document.getElementById('radio-grupo').addEventListener('change', () => {
        document.getElementById('container-correo-especifico').style.display = 'none';
        document.getElementById('container-grupo').style.display = 'block';
    });

    document.getElementById('form-enviar-reporte').addEventListener('submit', enviarReportePorCorreo);
}

async function cargarGruposReporte() {
    try {
        const res = await API.getGruposReportes();
        const grupos = res.grupos || [];
        const select = document.getElementById('reporte-grupo-select');
        select.innerHTML = '<option value="">-- Selecciona un grupo --</option>' +
            grupos.map(grp => `<option value="${grp.id_grupo}">${grp.codigo_grupo} (${grp.nombre_grado})</option>`).join('');
    } catch (e) {
        mostrarAlerta('No se pudieron cargar los grupos', 'error');
    }
}

function seleccionarReporte(tipo) {
    document.getElementById('reporte-tipo-select').value = tipo;

    document.querySelectorAll('.reporte-item').forEach(item => {
        item.style.backgroundColor = '#f5f5f5';
    });

    document.querySelectorAll('input[name="tipo-reporte"]').forEach(r => r.checked = false);

    const radioButton = document.getElementById('radio-' + tipo);
    if (radioButton) {
        radioButton.checked = true;
        radioButton.closest('.reporte-item').style.backgroundColor = '#E3F2FD';
    }
}

async function enviarReportePorCorreo(e) {
    e.preventDefault();

    const remitente = document.getElementById('reporte-remitente').value;
    const tipoReporte = document.getElementById('reporte-tipo-select').value;
    const tipoDestinatario = document.querySelector('input[name="tipo-destinatario"]:checked').value;
    const mensaje = document.getElementById('reporte-mensaje').value;

    if (!remitente) {
        mostrarAlerta('Por favor ingresa el correo remitente', 'error');
        return;
    }
    if (!tipoReporte) {
        mostrarAlerta('Por favor selecciona un tipo de reporte', 'error');
        return;
    }
    if (!mensaje.trim()) {
        mostrarAlerta('Por favor escribe un mensaje', 'error');
        return;
    }

    let correos = [];

    if (tipoDestinatario === 'especifico') {
        const correoEspecifico = document.getElementById('reporte-correo-especifico').value;
        if (!correoEspecifico) {
            mostrarAlerta('Por favor ingresa el correo destinatario', 'error');
            return;
        }
        correos = [correoEspecifico];
    } else {
        const grupoId = document.getElementById('reporte-grupo-select').value;
        if (!grupoId) {
            mostrarAlerta('Por favor selecciona un grupo', 'error');
            return;
        }
        try {
            const data = await API.getCorreosPorGrupo(grupoId);
            correos = data.correos || [];
            if (correos.length === 0) {
                mostrarAlerta('No hay correos disponibles para este grupo', 'error');
                return;
            }
        } catch (err) {
            mostrarAlerta(err.message || 'Error al obtener correos del grupo', 'error');
            return;
        }
    }

    try {
        const dataEnvio = { remitente, tipoReporte, correos, mensaje };
        await API.enviarReportePorCorreo(dataEnvio);
        mostrarAlerta(`Reporte enviado a ${correos.length} destinatario(s)`, 'success');
        document.getElementById('form-enviar-reporte').reset();
    } catch (error) {
        console.error('Error:', error);
        mostrarAlerta(error.message || 'Error al enviar el reporte', 'error');
    }
}
