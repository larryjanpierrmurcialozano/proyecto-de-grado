-- Trigger to log student deletions into log_registro
-- Uses session variables set by the app:
--   @app_user_id, @app_ip, @app_agent

DELIMITER $$

DROP TRIGGER IF EXISTS trg_estudiantes_before_delete$$

CREATE TRIGGER trg_estudiantes_before_delete
BEFORE DELETE ON estudiantes
FOR EACH ROW
BEGIN
  DECLARE v_detalle_asistencia INT DEFAULT 0;
  DECLARE v_asistencia INT DEFAULT 0;
  DECLARE v_asistencias_periodo INT DEFAULT 0;
  DECLARE v_justificantes INT DEFAULT 0;
  DECLARE v_reportes INT DEFAULT 0;
  DECLARE v_observador INT DEFAULT 0;
  DECLARE v_notas INT DEFAULT 0;

  SELECT COUNT(*) INTO v_detalle_asistencia FROM detalle_asistencia WHERE id_estudiante = OLD.id_estudiante;
  SELECT COUNT(*) INTO v_asistencia FROM asistencia WHERE id_estudiante = OLD.id_estudiante;
  SELECT COUNT(*) INTO v_asistencias_periodo FROM asistencias_por_periodo WHERE id_estudiante = OLD.id_estudiante;
  SELECT COUNT(*) INTO v_justificantes FROM justificantes_ausencia WHERE id_estudiante = OLD.id_estudiante;
  SELECT COUNT(*) INTO v_reportes FROM reportes_inasistencias WHERE id_estudiante = OLD.id_estudiante;
  SELECT COUNT(*) INTO v_observador FROM observador WHERE id_estudiante = OLD.id_estudiante;
  SELECT COUNT(*) INTO v_notas FROM notas WHERE id_estudiante = OLD.id_estudiante;

  INSERT INTO log_registro (
    id_usuario,
    tipo_accion,
    tabla_afectada,
    registro_id,
    descripcion,
    ip_address,
    user_agent,
    timestamp_accion
  ) VALUES (
    @app_user_id,
    'DELETE',
    'estudiantes',
    OLD.id_estudiante,
    CONCAT(
      'Eliminacion estudiante: ',
      'documento=', IFNULL(OLD.documento, ''),
      ', nombre=', IFNULL(OLD.nombre, ''),
      ', apellido=', IFNULL(OLD.apellido, ''),
      ', fecha_nacimiento=', IFNULL(DATE_FORMAT(OLD.fecha_nacimiento, '%Y-%m-%d'), ''),
      ', genero=', IFNULL(OLD.genero, ''),
      ', id_grupo=', IFNULL(OLD.id_grupo, 0),
      ', acudiente_nombre=', IFNULL(OLD.acudiente_nombre, ''),
      ', acudiente_telefono=', IFNULL(OLD.acudiente_telefono, ''),
      ', correo=', IFNULL(OLD.correo, ''),
      ', direccion=', IFNULL(OLD.direccion, ''),
      ', estado=', IFNULL(OLD.estado, ''),
      ' | relaciones_borradas: ',
      'detalle_asistencia=', v_detalle_asistencia,
      ', asistencia=', v_asistencia,
      ', asistencias_por_periodo=', v_asistencias_periodo,
      ', justificantes_ausencia=', v_justificantes,
      ', reportes_inasistencias=', v_reportes,
      ', observador=', v_observador,
      ', notas=', v_notas
    ),
    @app_ip,
    @app_agent,
    NOW()
  );
END$$

DELIMITER ;
