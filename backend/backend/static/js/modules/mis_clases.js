/**
 * MÓDULO: MIS CLASES
 * Portal personal de docentes para ver todas sus clases asignadas
 * Permite: descargar Excel, ver estudiantes, subir acuerdos pedagógicos
 */

class MisClasesModule {
  constructor() {
    this.currentUser = null;
    this.clases = [];
    this.expandedClases = new Set(); // IDs de clases expandidas
  }

  /**
   * Inicializar el módulo
   */
  async init() {
    console.log('[MisClases] Inicializando módulo...');
    
    // 1. Cargar datos
    await this.cargarClases();
    
    // 2. Renderizar UI
    this.renderUI();
    
    // 3. Registrar event listeners
    this.registrarEventos();
  }

  /**
   * Obtener todas las clases del docente actual
   */
  async cargarClases() {
    try {
      const response = await fetch('/api/mis_clases', {
        method: 'GET',
        credentials: 'include'
      });

      if (!response.ok) {
        console.error('[MisClases] Error:', response.statusText);
        if (response.status === 401) {
          showNotification('No autenticado. Por favor, inicia sesión.', 'error');
        }
        return;
      }

      const data = await response.json();
      this.currentUser = data.docente;
      this.clases = data.clases;

      console.log(`[MisClases] ${this.clases.length} clases cargadas para ${this.currentUser.nombre_completo}`);
    } catch (error) {
      console.error('[MisClases] Error cargando clases:', error);
      showNotification('Error al cargar tus clases', 'error');
    }
  }

  /**
   * Renderizar la interfaz completa
   */
  renderUI() {
    const container = document.getElementById('module-content');
    if (!container) {
      console.error('[MisClases] No encontré #module-content');
      return;
    }

    // Header
    const header = this.renderHeader();
    
    // Tabla de clases
    const tabla = this.renderTablaClases();
    
    // Estadísticas
    const stats = this.renderEstadisticas();

    container.innerHTML = header + stats + tabla;
  }

  /**
   * Renderizar header con nombre del docente
   */
  renderHeader() {
    return `
      <div class="mis-clases-header">
        <h2>📚 Mis Clases</h2>
        <p class="docente-info">
          <i class="fas fa-user-tie"></i>
          Docente: <strong>${this.currentUser.nombre_completo}</strong>
        </p>
      </div>
    `;
  }

  /**
   * Renderizar estadísticas rápidas
   */
  renderEstadisticas() {
    let totalEstudiantes = 0;
    this.clases.forEach(clase => {
      totalEstudiantes += clase.numero_estudiantes;
    });

    return `
      <div class="mis-clases-stats">
        <div class="stat-card">
          <div class="stat-number">${this.clases.length}</div>
          <div class="stat-label">Clases Asignadas</div>
        </div>
        <div class="stat-card">
          <div class="stat-number">${totalEstudiantes}</div>
          <div class="stat-label">Estudiantes Total</div>
        </div>
        <div class="stat-card">
          <div class="stat-number">${this.clases.length > 0 ? (totalEstudiantes / this.clases.length).toFixed(0) : 0}</div>
          <div class="stat-label">Promedio por clase</div>
        </div>
      </div>
    `;
  }

  /**
   * Renderizar tabla de clases
   */
  renderTablaClases() {
    if (this.clases.length === 0) {
      return `
        <div class="mis-clases-vacio">
          <i class="fas fa-inbox"></i>
          <p>No tienes clases asignadas en este período</p>
        </div>
      `;
    }

    let html = `
      <div class="mis-clases-tabla-container">
        <table class="mis-clases-tabla">
          <thead>
            <tr>
              <th>Grado</th>
              <th>Grupo</th>
              <th>Materia</th>
              <th>Estudiantes</th>
              <th>Estado</th>
              <th>Acciones</th>
            </tr>
          </thead>
          <tbody>
    `;

    this.clases.forEach(clase => {
      const isExpanded = this.expandedClases.has(clase.id_asignacion);
      const expandClass = isExpanded ? 'expanded' : '';
      
      html += `
        <tr class="clase-row ${expandClass}" data-asignacion-id="${clase.id_asignacion}">
          <td>${clase.grado}</td>
          <td>${clase.grupo}</td>
          <td>${clase.materia}</td>
          <td><span class="badge badge-info">${clase.numero_estudiantes}</span></td>
          <td><span class="badge badge-${clase.estado === 'Activa' ? 'success' : 'warning'}">${clase.estado}</span></td>
          <td class="acciones-celda">
            <button class="btn-expandir" title="Ver estudiantes">
              <i class="fas fa-${isExpanded ? 'chevron-up' : 'chevron-down'}"></i>
            </button>
            <button class="btn-descargar" title="Descargar Excel">
              <i class="fas fa-download"></i>
            </button>
          </td>
        </tr>
      `;

      // Fila expandida con estudiantes
      if (isExpanded) {
        html += `
          <tr class="clase-expandida-row" data-asignacion-id="${clase.id_asignacion}">
            <td colspan="6">
              <div class="clase-expandida-content">
                <div id="estudiantes-${clase.id_asignacion}">
                  <div class="loading"><i class="fas fa-spinner fa-spin"></i> Cargando estudiantes...</div>
                </div>
              </div>
            </td>
          </tr>
        `;
      }
    });

    html += `
          </tbody>
        </table>
      </div>
    `;

    return html;
  }

  /**
   * Registrar event listeners
   */
  registrarEventos() {
    // Click en botones expandir
    document.querySelectorAll('.btn-expandir').forEach(btn => {
      btn.addEventListener('click', (e) => {
        e.stopPropagation();
        const row = btn.closest('.clase-row');
        const asignacionId = row.dataset.asignacionId;
        this.toggleExpandir(asignacionId);
      });
    });

    // Click en botones descargar
    document.querySelectorAll('.btn-descargar').forEach(btn => {
      btn.addEventListener('click', (e) => {
        e.stopPropagation();
        const row = btn.closest('.clase-row');
        const asignacionId = row.dataset.asignacionId;
        this.descargarExcel(asignacionId);
      });
    });
  }

  /**
   * Toggle expandir/contraer una clase
   */
  toggleExpandir(asignacionId) {
    if (this.expandedClases.has(asignacionId)) {
      this.expandedClases.delete(asignacionId);
    } else {
      this.expandedClases.add(asignacionId);
      this.cargarEstudiantes(asignacionId);
    }

    this.renderUI();
    this.registrarEventos();
  }

  /**
   * Cargar estudiantes de una clase
   */
  async cargarEstudiantes(asignacionId) {
    const container = document.getElementById(`estudiantes-${asignacionId}`);
    if (!container) return;

    try {
      const response = await fetch(`/api/mis_clases/${asignacionId}`, {
        credentials: 'include'
      });

      if (!response.ok) throw new Error(`Error ${response.status}`);

      const data = await response.json();
      const clase = data.clase;
      const estudiantes = data.estudiantes;

      let html = `
        <div class="clase-detalle">
          <div class="clase-info">
            <h4>${clase.materia}</h4>
            <p>${clase.grado} - Grupo ${clase.grupo}</p>
            <p class="text-muted">Total: ${estudiantes.length} estudiantes</p>
          </div>
          <div class="estudiantes-lista">
      `;

      if (estudiantes.length === 0) {
        html += '<p class="text-muted">No hay estudiantes en esta clase</p>';
      } else {
        html += '<ul>';
        estudiantes.forEach(est => {
          const estadoClass = est.estado === 'Activo' ? 'text-success' : 'text-warning';
          html += `
            <li class="${estadoClass}">
              <i class="fas fa-user"></i>
              ${est.nombre_completo}
              <span class="documento">(${est.documento})</span>
            </li>
          `;
        });
        html += '</ul>';
      }

      html += `
          </div>
          <div class="clase-acciones">
            <button class="btn btn-sm btn-primary btn-subir-acuerdo" data-asignacion-id="${asignacionId}">
              <i class="fas fa-file-pdf"></i> Acuerdo Pedagógico
            </button>
          </div>
        </div>
      `;

      container.innerHTML = html;

      // Registrar evento de acuerdo pedagógico
      container.querySelector('.btn-subir-acuerdo')?.addEventListener('click', () => {
        this.mostrarModalAcuerdo(asignacionId);
      });

    } catch (error) {
      console.error('[MisClases] Error cargando estudiantes:', error);
      container.innerHTML = `<div class="text-danger">Error al cargar estudiantes</div>`;
    }
  }

  /**
   * Descargar Excel de una clase
   */
  async descargarExcel(asignacionId) {
    const clase = this.clases.find(c => c.id_asignacion === asignacionId);
    if (!clase) return;

    try {
      const url = `/api/mis_clases/${asignacionId}/descargar-excel?periodo=${clase.periodo_actual}`;
      const response = await fetch(url, { credentials: 'include' });

      if (!response.ok) {
        showNotification(`Error al descargar: ${response.statusText}`, 'error');
        return;
      }

      // Descargar archivo
      const blob = await response.blob();
      const downloadUrl = window.URL.createObjectURL(blob);
      const a = document.createElement('a');
      a.href = downloadUrl;
      a.download = `${clase.materia}_P${clase.periodo_actual}.xlsx`;
      document.body.appendChild(a);
      a.click();
      window.URL.revokeObjectURL(downloadUrl);
      document.body.removeChild(a);

      showNotification(`✅ ${clase.materia} descargado`, 'success');
    } catch (error) {
      console.error('[MisClases] Error descargando:', error);
      showNotification('Error al descargar el archivo', 'error');
    }
  }

  /**
   * Mostrar modal para subir acuerdo pedagógico
   */
  mostrarModalAcuerdo(asignacionId) {
    const clase = this.clases.find(c => c.id_asignacion === asignacionId);
    if (!clase) return;

    alert(`[TODO] Modal para subir acuerdo pedagógico de ${clase.materia}\nFase 3.2 - Acuerdos Pedagógicos`);
  }
}

// Inicializar cuando DOM esté listo
document.addEventListener('DOMContentLoaded', () => {
  const misClases = new MisClasesModule();
  misClases.init();
});
