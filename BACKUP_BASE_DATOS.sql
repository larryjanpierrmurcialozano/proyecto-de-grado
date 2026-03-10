-- BACKUP BASE DE DATOS anexo_de_datos
-- Fecha: 2026-03-01 18:13:01
-- Estructura y datos de la base de datos

SET FOREIGN_KEY_CHECKS=0;

CREATE TABLE `actividades` (
  `id_actividad` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_grupo` int NOT NULL,
  `id_materia` int NOT NULL,
  `nombre_actividad` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `tipo_actividad` enum('Tarea','Quiz','Proyecto','Evaluación','Clase') COLLATE utf8mb4_unicode_ci DEFAULT 'Tarea',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_vencimiento` datetime DEFAULT NULL,
  `puntaje_maximo` decimal(5,2) DEFAULT '100.00',
  `ponderacion` decimal(5,2) DEFAULT '10.00' COMMENT 'Peso porcentual de la actividad en la nota final',
  `estado` enum('Abierta','Cerrada','Calificada') COLLATE utf8mb4_unicode_ci DEFAULT 'Abierta',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_actividad`),
  KEY `idx_id_usuario` (`id_usuario`),
  KEY `idx_id_grupo` (`id_grupo`),
  KEY `idx_id_materia` (`id_materia`),
  CONSTRAINT `fk_actividades_grupo` FOREIGN KEY (`id_grupo`) REFERENCES `grupos` (`id_grupo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_actividades_materia` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_actividades_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (4,14,1,14,'Tarea 1 - Cinemática','Ejercicios de movimiento rectilíneo','Tarea','2026-01-11 20:10:11',NULL,'100.00','10.00','Abierta','2026-01-11 20:10:11','2026-01-11 20:10:11');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (5,14,1,14,'Quiz 1 - Física','Evaluación corta conceptos básicos','Quiz','2026-01-11 20:10:11',NULL,'50.00','15.00','Abierta','2026-01-11 20:10:11','2026-01-11 20:10:11');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (6,14,1,14,'Parcial 1 - Física','Examen parcial primer corte','Evaluación','2026-01-11 20:10:11',NULL,'100.00','25.00','Abierta','2026-01-11 20:10:11','2026-01-11 20:10:11');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (7,14,1,12,'Laboratorio 1 - Química','Práctica de laboratorio','Proyecto','2026-01-11 20:10:11',NULL,'100.00','20.00','Abierta','2026-01-11 20:10:11','2026-01-11 20:10:11');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (8,14,4,16,'Taller Estadística','Ejercicios de probabilidad','Tarea','2026-01-11 20:10:11',NULL,'100.00','15.00','Abierta','2026-01-11 20:10:11','2026-01-11 20:10:11');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (9,14,17,8,'Proyecto Excel','Manejo básico de hojas de cálculo','Proyecto','2026-01-11 20:10:11',NULL,'100.00','30.00','Abierta','2026-01-11 20:10:11','2026-01-11 20:10:11');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (10,14,21,21,'Tarea 1 - Ecuaciones','Resolución de ecuaciones lineales','Tarea','2026-01-11 20:17:30',NULL,'100.00','10.00','Abierta','2026-01-11 20:17:30','2026-01-11 20:17:30');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (11,14,21,21,'Quiz 1 - Matemáticas','Evaluación operaciones básicas','Quiz','2026-01-11 20:17:30',NULL,'50.00','15.00','Abierta','2026-01-11 20:17:30','2026-01-11 20:17:30');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (12,14,21,23,'Laboratorio - Célula','Observación microscópica de células','Proyecto','2026-01-11 20:17:30',NULL,'100.00','20.00','Abierta','2026-01-11 20:17:30','2026-01-11 20:17:30');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (13,14,23,21,'Tarea 1 - Funciones','Ejercicios de funciones lineales','Tarea','2026-01-11 20:17:30',NULL,'100.00','10.00','Abierta','2026-01-11 20:17:30','2026-01-11 20:17:30');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (14,14,23,21,'Parcial 1 - Matemáticas','Examen parcial primer corte','Evaluación','2026-01-11 20:17:30',NULL,'100.00','25.00','Abierta','2026-01-11 20:17:30','2026-01-11 20:17:30');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (15,14,23,26,'Taller Triángulos','Propiedades de triángulos','Tarea','2026-01-11 20:17:30',NULL,'100.00','15.00','Abierta','2026-01-11 20:17:30','2026-01-11 20:17:30');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (16,14,17,21,'Tarea Numeros','Operaciones','Tarea','2026-01-11 20:23:41',NULL,'100.00','10.00','Abierta','2026-01-11 20:23:41','2026-01-11 20:23:41');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (17,14,17,23,'Quiz Ecosistemas','Evaluacion','Quiz','2026-01-11 20:23:41',NULL,'50.00','15.00','Abierta','2026-01-11 20:23:41','2026-01-11 20:23:41');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (18,14,18,21,'Tarea Fracciones','Operaciones','Tarea','2026-01-11 20:23:41',NULL,'100.00','10.00','Abierta','2026-01-11 20:23:41','2026-01-11 20:23:41');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (19,14,18,22,'Ensayo Narrativo','Cuento corto','Tarea','2026-01-11 20:23:41',NULL,'100.00','20.00','Abierta','2026-01-11 20:23:41','2026-01-11 20:23:41');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (20,14,19,21,'Parcial Algebra','Expresiones','Evaluación','2026-01-11 20:23:41',NULL,'100.00','25.00','Abierta','2026-01-11 20:23:41','2026-01-11 20:23:41');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (21,14,19,8,'Proyecto Excel','Hoja calculo','Proyecto','2026-01-11 20:23:41',NULL,'100.00','30.00','Abierta','2026-01-11 20:23:41','2026-01-11 20:23:41');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (22,14,20,21,'Tarea Ecuaciones','Resolver','Tarea','2026-01-11 20:23:41',NULL,'100.00','10.00','Abierta','2026-01-11 20:23:41','2026-01-11 20:23:41');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (23,14,20,23,'Lab Celula','Microscopio','Proyecto','2026-01-11 20:23:41',NULL,'100.00','25.00','Abierta','2026-01-11 20:23:41','2026-01-11 20:23:41');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (24,14,3,14,'Tarea Cinematica','MRU','Tarea','2026-01-11 20:23:41',NULL,'100.00','10.00','Abierta','2026-01-11 20:23:41','2026-01-11 20:23:41');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (25,14,3,12,'Lab Reacciones','Quimica','Proyecto','2026-01-11 20:23:41',NULL,'100.00','25.00','Abierta','2026-01-11 20:23:41','2026-01-11 20:23:41');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (26,14,5,16,'Parcial Estadistica','Probabilidad','Evaluación','2026-01-11 20:23:41',NULL,'100.00','25.00','Abierta','2026-01-11 20:23:41','2026-01-11 20:23:41');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (27,14,5,7,'Essay','Writing','Tarea','2026-01-11 20:23:41',NULL,'100.00','20.00','Abierta','2026-01-11 20:23:41','2026-01-11 20:23:41');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (28,14,6,16,'Proyecto','Analisis','Proyecto','2026-01-11 20:23:41',NULL,'100.00','30.00','Abierta','2026-01-11 20:23:41','2026-01-11 20:23:41');
INSERT INTO actividades (id_actividad,id_usuario,id_grupo,id_materia,nombre_actividad,descripcion,tipo_actividad,fecha_creacion,fecha_vencimiento,puntaje_maximo,ponderacion,estado,created_at,updated_at) VALUES (29,14,6,7,'Oral','Speaking','Evaluación','2026-01-11 20:23:41',NULL,'100.00','25.00','Abierta','2026-01-11 20:23:41','2026-01-11 20:23:41');

CREATE TABLE `asignaciones_docente` (
  `id_asignacion` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_materia` int NOT NULL,
  `id_grado` int NOT NULL,
  `id_grupo` int NOT NULL,
  `año_lectivo` int DEFAULT '2025',
  `estado` enum('Activa','Inactiva','Suspendida') COLLATE utf8mb4_unicode_ci DEFAULT 'Activa',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_asignacion`),
  UNIQUE KEY `uk_usuario_materia_grado_grupo` (`id_usuario`,`id_materia`,`id_grado`,`id_grupo`),
  KEY `idx_id_usuario` (`id_usuario`),
  KEY `idx_id_materia` (`id_materia`),
  KEY `idx_id_grado` (`id_grado`),
  CONSTRAINT `fk_asignaciones_grado` FOREIGN KEY (`id_grado`) REFERENCES `grados` (`id_grado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_asignaciones_grupo` FOREIGN KEY (`id_grupo`) REFERENCES `grupos` (`id_grupo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_asignaciones_materia` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_asignaciones_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `asistencia` (
  `id_asistencia` int NOT NULL AUTO_INCREMENT,
  `id_estudiante` int NOT NULL,
  `id_grupo` int NOT NULL,
  `id_periodo` int NOT NULL,
  `fecha_asistencia` date NOT NULL,
  `tipo_registro` enum('Día','Hora') COLLATE utf8mb4_unicode_ci DEFAULT 'Día' COMMENT 'Especifica si el registro es diario o por hora de clase',
  `hora_inicio` time DEFAULT NULL COMMENT 'Hora de inicio de la clase (si es por hora)',
  `hora_fin` time DEFAULT NULL COMMENT 'Hora de fin de la clase (si es por hora)',
  `estado` enum('Presente','Ausente','Tardío','Justificado') COLLATE utf8mb4_unicode_ci DEFAULT 'Presente',
  `observaciones` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_asistencia`),
  UNIQUE KEY `uk_estudiante_fecha` (`id_estudiante`,`fecha_asistencia`),
  KEY `idx_id_grupo` (`id_grupo`),
  KEY `idx_id_periodo` (`id_periodo`),
  KEY `idx_tipo_registro` (`tipo_registro`),
  CONSTRAINT `fk_asistencia_estudiante` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`id_estudiante`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_asistencia_grupo` FOREIGN KEY (`id_grupo`) REFERENCES `grupos` (`id_grupo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_asistencia_periodo` FOREIGN KEY (`id_periodo`) REFERENCES `periodos` (`id_periodo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `asistencias_diarias` (
  `id_asistencia_diaria` int NOT NULL AUTO_INCREMENT,
  `id_plantilla` int NOT NULL,
  `id_materia` int NOT NULL,
  `id_docente` int NOT NULL,
  `id_grupo` int NOT NULL,
  `fecha_registro` date NOT NULL,
  `hora_clase` time DEFAULT NULL COMMENT 'Hora de la clase registrada',
  `estado` enum('activa','cancelada','en_revision') COLLATE utf8mb4_unicode_ci DEFAULT 'activa',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_asistencia_diaria`),
  UNIQUE KEY `uk_registro_asistencia` (`id_plantilla`,`id_materia`,`fecha_registro`),
  KEY `idx_fecha_registro` (`fecha_registro`),
  KEY `idx_docente` (`id_docente`),
  KEY `idx_materia` (`id_materia`),
  KEY `idx_grupo` (`id_grupo`),
  CONSTRAINT `fk_asistencias_diarias_docente` FOREIGN KEY (`id_docente`) REFERENCES `usuarios` (`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_asistencias_diarias_grupo` FOREIGN KEY (`id_grupo`) REFERENCES `grupos` (`id_grupo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_asistencias_diarias_materia` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_asistencias_diarias_plantilla` FOREIGN KEY (`id_plantilla`) REFERENCES `plantillas_docente` (`id_plantilla`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla de control diario de asistencias por clase';

CREATE TABLE `asistencias_por_periodo` (
  `id_asistencia_periodo` int NOT NULL AUTO_INCREMENT,
  `id_estudiante` int NOT NULL,
  `id_materia` int NOT NULL,
  `id_periodo` int NOT NULL,
  `total_presencias` int DEFAULT '0',
  `total_ausencias` int DEFAULT '0',
  `total_tardios` int DEFAULT '0',
  `total_no_registrados` int DEFAULT '0',
  `total_clases_programadas` int DEFAULT '0',
  `porcentaje_asistencia` decimal(5,2) DEFAULT '0.00',
  `estado_asistencia` enum('excelente','bueno','regular','deficiente','critico') COLLATE utf8mb4_unicode_ci DEFAULT 'regular',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_asistencia_periodo`),
  UNIQUE KEY `uk_asistencia_periodo` (`id_estudiante`,`id_materia`,`id_periodo`),
  KEY `idx_periodo` (`id_periodo`),
  KEY `idx_materia` (`id_materia`),
  KEY `idx_estado` (`estado_asistencia`),
  CONSTRAINT `fk_asistencias_periodo_estudiante` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`id_estudiante`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_asistencias_periodo_materia` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_asistencias_periodo_periodo` FOREIGN KEY (`id_periodo`) REFERENCES `periodos` (`id_periodo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Resumen de asistencias consolidadas por período académico';

CREATE TABLE `auditoria_asistencias` (
  `id_auditoria` int NOT NULL AUTO_INCREMENT,
  `id_asistencia_diaria` int NOT NULL,
  `id_docente_registrador` int NOT NULL,
  `accion` enum('creada','modificada','cancelada','finalizada') COLLATE utf8mb4_unicode_ci DEFAULT 'creada',
  `cambios_realizados` json DEFAULT NULL COMMENT 'JSON con cambios realizados',
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_accion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_auditoria`),
  KEY `idx_asistencia_diaria` (`id_asistencia_diaria`),
  KEY `idx_docente` (`id_docente_registrador`),
  KEY `idx_accion` (`accion`),
  KEY `idx_fecha_accion` (`fecha_accion`),
  CONSTRAINT `fk_auditoria_asistencia` FOREIGN KEY (`id_asistencia_diaria`) REFERENCES `asistencias_diarias` (`id_asistencia_diaria`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_auditoria_docente` FOREIGN KEY (`id_docente_registrador`) REFERENCES `usuarios` (`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Auditoría de cambios en asistencias';

CREATE TABLE `comunicados_rectoria` (
  `id_comunicado` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `titulo` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contenido` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_comunicado` enum('Circular','Aviso','Información','Advertencia') COLLATE utf8mb4_unicode_ci DEFAULT 'Información',
  `audiencia` enum('Todos','Estudiantes','Docentes','Padres','Administrativo') COLLATE utf8mb4_unicode_ci DEFAULT 'Todos',
  `prioridad` enum('Baja','Media','Alta','Urgente') COLLATE utf8mb4_unicode_ci DEFAULT 'Media',
  `fecha_publicacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `activo` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_comunicado`),
  KEY `idx_id_usuario` (`id_usuario`),
  CONSTRAINT `fk_comunicados_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `criterios_plantilla` (
  `id_criterio` int NOT NULL AUTO_INCREMENT,
  `id_plantilla` int NOT NULL,
  `nombre_criterio` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `peso_porcentaje` decimal(5,2) DEFAULT '0.00',
  `orden` int DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_criterio`),
  KEY `idx_id_plantilla` (`id_plantilla`),
  CONSTRAINT `fk_criterios_plantilla` FOREIGN KEY (`id_plantilla`) REFERENCES `plantillas_docente` (`id_plantilla`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO criterios_plantilla (id_criterio,id_plantilla,nombre_criterio,descripcion,peso_porcentaje,orden,created_at,updated_at) VALUES (6,2,'Participación en clase','Participación activa y aportes','10.00',1,'2026-01-11 20:09:42','2026-01-11 20:09:42');
INSERT INTO criterios_plantilla (id_criterio,id_plantilla,nombre_criterio,descripcion,peso_porcentaje,orden,created_at,updated_at) VALUES (7,2,'Tareas y trabajos','Entrega de tareas asignadas','20.00',2,'2026-01-11 20:09:42','2026-01-11 20:09:42');
INSERT INTO criterios_plantilla (id_criterio,id_plantilla,nombre_criterio,descripcion,peso_porcentaje,orden,created_at,updated_at) VALUES (8,2,'Quiz/Evaluaciones cortas','Evaluaciones cortas periódicas','20.00',3,'2026-01-11 20:09:42','2026-01-11 20:09:42');
INSERT INTO criterios_plantilla (id_criterio,id_plantilla,nombre_criterio,descripcion,peso_porcentaje,orden,created_at,updated_at) VALUES (9,2,'Examen parcial','Evaluación parcial del período','25.00',4,'2026-01-11 20:09:42','2026-01-11 20:09:42');
INSERT INTO criterios_plantilla (id_criterio,id_plantilla,nombre_criterio,descripcion,peso_porcentaje,orden,created_at,updated_at) VALUES (10,2,'Examen final','Evaluación final del período','20.00',5,'2026-01-11 20:09:42','2026-01-11 20:09:42');
INSERT INTO criterios_plantilla (id_criterio,id_plantilla,nombre_criterio,descripcion,peso_porcentaje,orden,created_at,updated_at) VALUES (11,2,'Autoevaluación','Autoevaluación del estudiante','5.00',6,'2026-01-11 20:09:42','2026-01-11 20:09:42');

CREATE TABLE `detalle_asistencia` (
  `id_detalle_asistencia` int NOT NULL AUTO_INCREMENT,
  `id_asistencia_diaria` int NOT NULL,
  `id_estudiante` int NOT NULL,
  `asistio` enum('presente','ausente','tardio','no_registrado') COLLATE utf8mb4_unicode_ci DEFAULT 'no_registrado',
  `justificante_id` int DEFAULT NULL COMMENT 'ID del justificante si existe',
  `comentario` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_detalle_asistencia`),
  UNIQUE KEY `uk_asistencia_estudiante` (`id_asistencia_diaria`,`id_estudiante`),
  KEY `idx_estudiante` (`id_estudiante`),
  KEY `idx_estado_asistencia` (`asistio`),
  KEY `idx_justificante` (`justificante_id`),
  CONSTRAINT `fk_detalle_asistencia_diaria` FOREIGN KEY (`id_asistencia_diaria`) REFERENCES `asistencias_diarias` (`id_asistencia_diaria`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_detalle_asistencia_estudiante` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`id_estudiante`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_detalle_asistencia_justificante` FOREIGN KEY (`justificante_id`) REFERENCES `justificantes_ausencia` (`id_justificante`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla de detalle de asistencias por estudiante';

CREATE TABLE `documentos_secretaria` (
  `id_documento` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `tipo_documento` enum('Certificado','Constancia','Acta','Acuerdo','Otro') COLLATE utf8mb4_unicode_ci DEFAULT 'Otro',
  `titulo_documento` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `archivo_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_documento` date DEFAULT NULL,
  `estado` enum('Borrador','Publicado','Archivado') COLLATE utf8mb4_unicode_ci DEFAULT 'Borrador',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_documento`),
  KEY `idx_id_usuario` (`id_usuario`),
  CONSTRAINT `fk_documentos_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `estudiantes` (
  `id_estudiante` int NOT NULL AUTO_INCREMENT,
  `documento` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `genero` enum('M','F','Otro') COLLATE utf8mb4_unicode_ci DEFAULT 'M',
  `id_grupo` int NOT NULL,
  `acudiente_nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acudiente_telefono` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` enum('Activo','Inactivo','Egresado') COLLATE utf8mb4_unicode_ci DEFAULT 'Activo' COMMENT 'Estado del estudiante en la institución',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_estudiante`),
  UNIQUE KEY `uk_documento` (`documento`),
  UNIQUE KEY `uq_corre` (`correo`),
  KEY `idx_id_grupo` (`id_grupo`),
  KEY `idx_estado` (`estado`),
  CONSTRAINT `fk_estudiantes_grupo` FOREIGN KEY (`id_grupo`) REFERENCES `grupos` (`id_grupo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=287 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (101,'1001001001','Carlos','García López',NULL,'M',1,'María López','3001234567','carlosgarcia@gmail.com','Calle 1 #10-20','Activo','2026-01-11 20:02:33','2026-02-13 09:22:15');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (102,'1001001002','Ana María','Rodríguez Pérez','2008-05-22','F',1,'Pedro Rodríguez','3002345678',NULL,'Cra 5 #15-30','Activo','2026-01-11 20:02:33','2026-01-11 20:02:33');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (103,'1001001003','Juan David','Martínez Ruiz','2008-01-10','M',1,'Laura Ruiz','3003456789',NULL,'Av 10 #20-40','Activo','2026-01-11 20:02:33','2026-01-11 20:02:33');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (104,'1001001004','Valentina','Hernández Torres','2008-07-28','F',1,'José Hernández','3004567890',NULL,'Calle 8 #5-12','Activo','2026-01-11 20:02:33','2026-01-11 20:02:33');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (105,'1001001005','Santiago','López Vargas','2008-11-03','M',1,'Carmen Vargas','3005678901',NULL,'Cra 12 #8-45','Activo','2026-01-11 20:02:33','2026-01-11 20:02:33');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (106,'1001001006','Sofía','Díaz Moreno',NULL,'F',2,'Roberto Díaz','3006789012','sofiadiaz@gmail.com','Calle 15 #22-10','Activo','2026-01-11 20:02:33','2026-02-13 09:34:12');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (107,'1001001007','Mateo','Torres Silva','2008-09-25','M',2,'Patricia Torres','3007890123',NULL,'Av 5 #30-55','Activo','2026-01-11 20:02:33','2026-01-11 20:02:33');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (108,'1001001008','Isabella','Sánchez Rojas','2008-02-14','F',2,'Miguel Sánchez','3008901234',NULL,'Cra 20 #18-30','Activo','2026-01-11 20:02:33','2026-01-11 20:02:33');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (109,'1001001009','Sebastián','Ramírez Castro','2008-06-30','M',2,'Gloria Ramírez','3009012345',NULL,'Calle 25 #12-65','Activo','2026-01-11 20:02:33','2026-01-11 20:02:33');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (110,'1001001010','Mariana','Flores Ortiz',NULL,'F',2,'Luis Flores','3010123456','marianaflores@gmail.com','Av 8 #40-20','Activo','2026-01-11 20:02:33','2026-02-13 09:34:28');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (111,'1101001001','Andrés Felipe','Gómez Parra',NULL,'M',4,'Marta Parra','3011234567','andresgomez@gmail.com','Calle 30 #5-10','Activo','2026-01-11 20:02:33','2026-02-13 09:40:03');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (112,'1101001002','Camila Andrea','Reyes Mendoza','2007-03-08','F',4,'Carlos Reyes','3012345678',NULL,'Cra 15 #25-40','Activo','2026-01-11 20:02:33','2026-01-11 20:02:33');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (113,'1101001003','Daniel Alejandro','Cruz Vega',NULL,'M',4,'Diana Cruz','3013456789','danielcruzvega@gmail.com','Av 12 #8-22','Activo','2026-01-11 20:02:33','2026-02-13 09:37:31');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (114,'1101001004','Laura Daniela','Vargas Luna','2007-07-24','F',4,'Fernando Vargas','3014567890',NULL,'Calle 18 #30-15','Activo','2026-01-11 20:02:33','2026-01-11 20:02:33');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (115,'1101001005','Nicolás','Moreno Arias','2007-09-02','M',4,'Sandra Moreno','3015678901',NULL,'Cra 8 #42-50','Activo','2026-01-11 20:02:33','2026-01-11 20:02:33');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (116,'0601001001','Kevin','Castro Mejía',NULL,'M',24,'Rosa Castr','30167890','kevincastro@gmail.com','Calle 5 #10-30','Activo','2026-01-11 20:02:33','2026-02-13 09:19:33');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (117,'0601001002','Paula','Ríos Guzmán',NULL,'F',17,'Juan Ríos','3017890123','lacra@gmai.com','Av 3 #15-25','Activo','2026-01-11 20:02:33','2026-02-12 21:03:01');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (118,'0601001003','Miguel Ángel','Peña Núñez',NULL,'M',17,'Elena Peña','3018901234','langostamutante@gmail.com','Cra 10 #20-45','Activo','2026-01-11 20:02:33','2026-02-12 18:58:53');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (119,'0601001004','Sara','Ospina Duart',NULL,'F',17,'Andrés Ospina','3019012345','shanyaherrera3@gmail.com','Calle 12 #8-18','Activo','2026-01-11 20:02:33','2026-02-12 21:00:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (121,'0701001001','Alejandra','Jiménez Leal','2012-01-12','F',19,'Ricardo Jiménez','3021234567',NULL,'Calle 22 #14-20','Activo','2026-01-11 20:02:33','2026-01-11 20:02:33');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (122,'0701001002','Felipe','Correa Suárez',NULL,'M',19,'Adriana Correa','3022345678','felipecorrea@gmail.com','Cra 6 #28-35','Activo','2026-01-11 20:02:33','2026-02-13 08:59:40');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (123,'0701001003','Natalia','Rincón Herrera','2012-05-18','F',19,'Jorge Rincón','3023456789',NULL,'Av 15 #10-42','Activo','2026-01-11 20:02:33','2026-01-11 20:02:33');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (124,'0701001004','David','Parra Guerrero','2012-07-30','M',19,'Claudia Parra','3024567890',NULL,'Calle 8 #45-12','Activo','2026-01-11 20:02:33','2026-01-11 20:02:33');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (125,'0701001005','Carolina','Vera Montoya','2012-09-14','F',19,'Alberto Vera','3025678901',NULL,'Cra 18 #22-55','Activo','2026-01-11 20:02:33','2026-01-11 20:02:33');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (126,'0801001001','Luis Fernando','Arango Mesa',NULL,'M',21,'Clara Mesa','3101234567','luisarango@gmail.com','Calle 40 #12-30','Activo','2026-01-11 20:15:10','2026-02-13 09:03:40');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (127,'0801001002','María José','Benavides Ruiz',NULL,'F',21,'Jorge Benavides','3102345678','mariabenavides@gmail.com','Cra 25 #8-15','Activo','2026-01-11 20:15:10','2026-02-13 09:04:00');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (128,'0801001003','Pedro Pablo','Castaño López',NULL,'M',21,'Ana López','3103456789','pedrocastano@gmail.com','Av 18 #22-40','Activo','2026-01-11 20:15:10','2026-02-13 09:04:30');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (129,'0801001004','Juliana','Duarte Peña','2011-08-28','F',21,'Ramiro Duarte','3104567890',NULL,'Calle 15 #5-12','Activo','2026-01-11 20:15:10','2026-01-11 20:15:10');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (130,'0801001005','Esteban','Escobar Vargas','2011-10-03','M',21,'Martha Vargas','3105678901',NULL,'Cra 30 #18-45','Activo','2026-01-11 20:15:10','2026-01-11 20:15:10');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (131,'0802001001','Daniela','Franco Mejía',NULL,'F',22,'Gustavo Franco','3106789012','danielafranco@gmail.com','Calle 22 #14-10','Activo','2026-01-11 20:15:10','2026-02-13 09:06:07');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (132,'0802001002','Gabriel','Giraldo Silva',NULL,'M',22,'Lucía Giraldo','3107890123','gabrielgiraldo@gmail.com','Av 12 #30-55','Activo','2026-01-11 20:15:10','2026-02-13 09:06:22');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (133,'0802001003','Valeria','Henao Rojas',NULL,'F',22,'Andrés Henao','3108901234','valeriahenao@gmail.com','Cra 8 #18-30','Activo','2026-01-11 20:15:10','2026-02-13 09:06:40');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (134,'0802001004','Martín','Ibarra Castro','2011-07-30','M',22,'Sandra Ibarra','3109012345',NULL,'Calle 35 #12-65','Activo','2026-01-11 20:15:10','2026-01-11 20:15:10');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (135,'0802001005','Luciana','Jaramillo Ortiz','2011-09-12','F',22,'Felipe Jaramillo','3110123456',NULL,'Av 20 #40-20','Activo','2026-01-11 20:15:10','2026-01-11 20:15:10');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (136,'0901001001','Sebastián','Largo Parra',NULL,'M',23,'Teresa Parra','3111234567','sebastianlargo@gmail.com','Calle 50 #5-10','Activo','2026-01-11 20:15:10','2026-02-13 09:08:12');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (137,'0901001002','Isabella','Montoya Mendoza','2010-03-08','F',23,'Roberto Montoya','3112345678',NULL,'Cra 35 #25-40','Activo','2026-01-11 20:15:10','2026-01-11 20:15:10');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (138,'0901001003','Nicolás','Naranjo Vega','2010-05-16','M',23,'Diana Naranjo','3113456789',NULL,'Av 28 #8-22','Activo','2026-01-11 20:15:10','2026-01-11 20:15:10');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (139,'0901001004','Mariana','Ocampo Luna','2010-07-24','F',23,'Fernando Ocampo','3114567890',NULL,'Calle 28 #30-15','Activo','2026-01-11 20:15:10','2026-01-11 20:15:10');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (140,'0901001005','Alejandro','Pineda Arias','2010-09-02','M',23,'Gloria Pineda','3115678901',NULL,'Cra 18 #42-50','Activo','2026-01-11 20:15:10','2026-01-11 20:15:10');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (141,'0902001001','Sofía','Quintero Mejía','2010-02-28','F',24,'Juan Quintero','3116789012',NULL,'Calle 45 #10-30','Activo','2026-01-11 20:15:10','2026-01-11 20:15:10');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (142,'0902001002','Diego','Ramírez Guzmán','2010-04-15','M',24,'Carmen Ramírez','3117890123',NULL,'Av 15 #15-25','Activo','2026-01-11 20:15:10','2026-01-11 20:15:10');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (143,'0902001003','Valentina','Salazar Núñez','2010-06-22','F',24,'Pedro Salazar','3118901234',NULL,'Cra 22 #20-45','Activo','2026-01-11 20:15:10','2026-01-11 20:15:10');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (144,'0902001004','Tomás','Torres Duarte','2010-08-10','M',24,'Marcela Torres','3119012345',NULL,'Calle 32 #8-18','Activo','2026-01-11 20:15:10','2026-01-11 20:15:10');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (145,'0902001005','Camila','Uribe Pineda','2010-10-05','F',24,'Alberto Uribe','3120123456',NULL,'Av 25 #35-60','Activo','2026-01-11 20:15:10','2026-01-11 20:15:10');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (146,'1000001800','Tomás','Ortiz Pérez','2012-10-18','M',18,'Valentina Ortiz','3191805323',NULL,'Calle 34 #29-71','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (147,'1000001801','Ana','Chávez Sánchez',NULL,'F',18,'Rosa Chávez','3187245333','anachavez@gmail.com','Calle 10 #28-96','Activo','2026-01-11 20:21:20','2026-02-13 08:52:35');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (148,'1000001802','Manuel','Rivera Rodríguez','2012-08-26','M',18,'Samuel Rivera','3151911550',NULL,'Calle 49 #15-56','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (149,'1000001803','Laura','Morales Díaz','2012-06-03','F',18,'Vicente Morales','3186853685',NULL,'Calle 21 #10-30','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (150,'1000001804','Manuel','Reyes Flores','2012-02-11','M',18,'Isabella Reyes','3106488847',NULL,'Calle 49 #8-23','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (151,'1000001805','Elena','Díaz Ramírez',NULL,'F',18,'Tatiana Díaz','3181743309','elenadiaz@gmail.com','Calle 46 #16-17','Activo','2026-01-11 20:21:20','2026-02-13 08:53:09');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (152,'1000001806','Iván','García Gutiérrez',NULL,'M',18,'Fernanda García','3197203495','ivangarcia@gmail.com','Calle 21 #12-82','Activo','2026-01-11 20:21:20','2026-02-13 08:53:48');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (153,'1000001807','Fernanda','López Martínez',NULL,'F',18,'Diego López','3126651824','fernandalopez@gmail.com','Calle 33 #5-10','Activo','2026-01-11 20:21:20','2026-02-13 08:54:03');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (154,'1000001808','Samuel','Reyes García','2012-01-28','M',18,'Rosa Reyes','3103689509',NULL,'Calle 50 #20-36','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (155,'1000001809','Laura','Flores Díaz',NULL,'F',18,'Samuel Flores','3124993057','lauraflorez@gmail.com','Calle 1 #15-35','Activo','2026-01-11 20:21:20','2026-02-13 08:53:27');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (156,'1000002000','Hugo','González Morales',NULL,'M',20,'Tomás González','3127695036','hugogonzales@gmail.com','Calle 5 #11-36','Activo','2026-01-11 20:21:20','2026-02-13 09:02:30');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (157,'1000002001','Paula','Ortiz Morales',NULL,'F',20,'Rosa Ortiz','3184817732','paulaortiz@gmail.com','Calle 23 #22-45','Activo','2026-01-11 20:21:20','2026-02-13 09:02:50');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (158,'1000002002','Eduardo','Ramírez García','2011-09-03','M',20,'Rosa Ramírez','3102023643',NULL,'Calle 41 #12-6','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (159,'1000002003','Olga','Ramírez Ortiz','2011-06-01','F',20,'Fernanda Ramírez','3165524608',NULL,'Calle 35 #24-34','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (160,'1000002004','Nicolás','García Hernández',NULL,'M',20,'Javier García','3103005991','nicolasgarcia@gmail.com','Calle 14 #16-69','Activo','2026-01-11 20:21:20','2026-02-13 09:01:41');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (161,'1000002005','Karen','Pérez Hernández','2011-08-03','F',20,'Javier Pérez','3121917745',NULL,'Calle 19 #14-96','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (162,'1000002006','Pablo','Flores Chávez',NULL,'M',20,'Helena Flores','3137720791','pabloflores@gmail.com','Calle 28 #14-89','Activo','2026-01-11 20:21:20','2026-02-13 09:01:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (163,'1000002007','Beatriz','Díaz González',NULL,'F',20,'Camila Díaz','3107142773','beatrizdiaz@gmail.com','Calle 25 #1-37','Activo','2026-01-11 20:21:20','2026-02-13 09:01:07');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (164,'1000002008','David','Torres Gómez','2011-09-27','M',20,'Laura Torres','3139234637',NULL,'Calle 21 #14-29','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (165,'1000002009','Natalia','Rivera Sánchez','2011-07-18','F',20,'Gabriel Rivera','3185464226',NULL,'Calle 38 #23-10','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (166,'1000000300','Nicolás','Díaz Gutiérrez',NULL,'M',3,'Felipe Díaz','3136653156','nicolasdiaz@gmail.com','Calle 1 #25-43','Activo','2026-01-11 20:21:20','2026-02-13 09:36:26');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (167,'1000000301','María','Flores Hernández',NULL,'F',3,'Javier Flores','3118552522','mariaflorez@gmail.com','Calle 5 #7-79','Activo','2026-01-11 20:21:20','2026-02-13 09:36:38');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (168,'1000000302','Carlos','Rodríguez Flores','2009-06-07','M',3,'Julia Rodríguez','3146957822',NULL,'Calle 44 #16-50','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (169,'1000000303','Ana','Morales Gómez','2009-08-08','F',3,'Tomás Morales','3133142879',NULL,'Calle 45 #3-6','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (170,'1000000304','Felipe','Martínez Chávez','2009-01-27','M',3,'Andrés Martínez','3136668458',NULL,'Calle 15 #15-90','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (171,'1000000305','Valentina','Chávez Flores',NULL,'F',3,'Pablo Chávez','3185140846','valentinachavez@gmail.com','Calle 33 #15-33','Activo','2026-01-11 20:21:20','2026-02-13 09:35:48');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (172,'1000000306','Vicente','Díaz Díaz',NULL,'M',3,'Julia Díaz','3105002224','vicentediaz@gmail.com','Calle 45 #29-94','Activo','2026-01-11 20:21:20','2026-02-13 09:36:12');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (173,'1000000307','Helena','Hernández Pérez','2009-02-10','F',3,'Felipe Hernández','3168161149',NULL,'Calle 25 #30-54','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (174,'1000000308','Carlos','Cruz Ramírez',NULL,'M',3,'Javier Cruz','3123200806','carloscruz@gmail.com','Calle 14 #24-32','Activo','2026-01-11 20:21:20','2026-02-13 09:36:01');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (175,'1000000309','Fernanda','Ortiz Ramírez','2009-01-14','F',3,'David Ortiz','3168935367',NULL,'Calle 18 #24-51','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (176,'1000000500','David','García Gómez',NULL,'M',5,'Leonardo García','3177545685','davidgarcia@gmail.com','Calle 35 #3-47','Activo','2026-01-11 20:21:20','2026-02-13 09:41:00');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (177,'1000000501','Julia','Gómez Ramírez',NULL,'F',5,'Hugo Gómez','3194262817','juliagomez@gmail.com','Calle 7 #10-14','Activo','2026-01-11 20:21:20','2026-02-13 09:41:15');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (178,'1000000502','Eduardo','Rivera González','2008-01-04','M',5,'Leonardo Rivera','3194690465',NULL,'Calle 22 #4-66','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (179,'1000000503','Elena','Morales González','2008-06-20','F',5,'Tatiana Morales','3124998620',NULL,'Calle 5 #7-79','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (180,'1000000504','Andrés','Cruz Díaz',NULL,'M',5,'Valentina Cruz','3142127925','andrescruz@gmail.com','Calle 32 #2-9','Activo','2026-01-11 20:21:20','2026-02-13 09:40:33');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (181,'1000000505','Ana','Cruz Cruz',NULL,'F',5,'Valentina Cruz','3149544473','anacruz@gmail.com','Calle 28 #1-2','Activo','2026-01-11 20:21:20','2026-02-13 09:40:22');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (182,'1000000506','Carlos','López Flores','2008-12-19','M',5,'Ana López','3142092209',NULL,'Calle 5 #17-66','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (183,'1000000507','Valentina','Flores Torres',NULL,'F',5,'Rosa Flores','3118775492','valentinaflorez@gmail.com','Calle 30 #15-60','Activo','2026-01-11 20:21:20','2026-02-13 09:40:46');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (184,'1000000508','Nicolás','González Rodríguez','2008-04-20','M',5,'Felipe González','3152687760',NULL,'Calle 50 #28-59','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (185,'1000000509','Natalia','Ortiz García','2008-02-17','F',5,'Pablo Ortiz','3185849030',NULL,'Calle 25 #2-20','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (186,'1000000600','Eduardo','Cruz Pérez',NULL,'M',6,'Ana Cruz','3136630064','eduardocruz@gmail.com','Calle 2 #16-80','Activo','2026-01-11 20:21:20','2026-02-13 09:41:47');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (187,'1000000601','Rosa','García Sánchez',NULL,'F',6,'Tomás García','3122868211','rosagarcia@gmail.com','Calle 3 #5-44','Activo','2026-01-11 20:21:20','2026-02-13 09:43:23');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (188,'1000000602','Pablo','García Reyes',NULL,'M',6,'Nicolás García','3123696150','pablogarcia@gmail.com','Calle 44 #2-23','Activo','2026-01-11 20:21:20','2026-02-13 09:42:24');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (189,'1000000603','Ana','Flores Sánchez',NULL,'F',6,'Tomás Flores','3186461243','anaflorez@gmail.com','Calle 11 #22-73','Activo','2026-01-11 20:21:20','2026-02-13 09:42:08');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (190,'1000000604','David','Pérez Morales','2008-02-07','M',6,'Fernanda Pérez','3114583997',NULL,'Calle 43 #11-80','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (191,'1000000605','Camila','López Reyes','2008-06-08','F',6,'Camila López','3116691332',NULL,'Calle 11 #1-8','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (193,'1000000607','Isabella','Gutiérrez Torres','2008-06-19','F',6,'David Gutiérrez','3148019324',NULL,'Calle 33 #19-66','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (194,'1000000608','Hugo','Flores Rodríguez',NULL,'M',6,'Fernanda Flores','3107669130','hugoflorez@gmail.com','Calle 44 #26-81','Activo','2026-01-11 20:21:20','2026-02-13 09:41:58');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (195,'1000000609','Olga','Ramírez Reyes','2008-08-16','F',6,'Ana Ramírez','3183821244',NULL,'Calle 18 #15-47','Activo','2026-01-11 20:21:20','2026-01-11 20:21:20');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (196,'2000001700','Alejandro','Torres Morales',NULL,'M',17,'Rafael Torres','3183796985','alejamdrotorres@gmail.com','Calle 41 #7-91','Activo','2026-01-11 20:21:42','2026-02-13 08:50:34');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (199,'2000001703','Natali','Martínez Cruz',NULL,'F',18,'Vicente Martínez','3113085318',NULL,'Calle 8 #2-27','Activo','2026-01-11 20:21:42','2026-02-02 16:41:47');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (200,'2000001704','Eduardo','Mendoza Reyes',NULL,'M',18,'Oscar Mendoza','3187471347',NULL,'Calle 8 #4-79','Activo','2026-01-11 20:21:42','2026-02-02 16:41:58');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (202,'2000001706','Gabriel','Torres Reyes',NULL,'M',17,'Elena Torres','3156314058','gabrieltorres@gmail.com','Calle 31 #19-28','Activo','2026-01-11 20:21:42','2026-02-13 08:52:07');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (205,'2000001709','Laura','Rodríguez Gómez',NULL,'F',17,'Pablo Rodríguez','3128079501','laura@gmail.com','Calle 27 #20-40','Activo','2026-01-11 20:21:42','2026-02-13 08:50:01');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (206,'2000001900','Andrés','González Rodríguez',NULL,'M',19,'Hugo González','3178366359','andresgonzales@gmail.com','Calle 39 #21-56','Activo','2026-01-11 20:21:42','2026-02-13 09:00:53');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (207,'2000001901','Karen','Chávez Rojas',NULL,'F',19,'Sofía Chávez','3125750156','karenchavez@gmail.com','Calle 23 #9-73','Activo','2026-01-11 20:21:42','2026-02-13 08:59:17');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (208,'2000001902','Samuel','Mendoza Torres','2011-10-10','M',19,'Elena Mendoza','3105479474',NULL,'Calle 20 #23-9','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (209,'2000001903','Daniela','Torres Gómez','2011-01-12','F',19,'Sofía Torres','3142508873',NULL,'Calle 11 #16-38','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (210,'2000001904','Kevin','Díaz Díaz',NULL,'M',19,'Daniela Díaz','3153153897','kevindiaz@gmail.com','Calle 27 #27-24','Activo','2026-01-11 20:21:42','2026-02-13 08:59:57');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (211,'2000001905','Isabella','Vargas Herrera','2011-11-15','F',19,'Oscar Vargas','3176461202',NULL,'Calle 14 #20-50','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (212,'2000001906','Tomás','González Torres','2011-12-18','M',19,'Valentina González','3117523353',NULL,'Calle 16 #9-34','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (213,'2000001907','Luciana','Sánchez Díaz','2011-02-23','F',19,'Natalia Sánchez','3133385827',NULL,'Calle 42 #23-44','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (214,'2000001908','Pablo','Herrera Hernández','2011-12-15','M',19,'Valentina Herrera','3124467195',NULL,'Calle 33 #10-14','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (215,'2000001909','Daniela','Chávez Cruz',NULL,'F',19,'Gabriela Chávez','3169370709','danielasanchez@gmail.com','Calle 8 #23-48','Activo','2026-01-11 20:21:42','2026-02-13 08:58:06');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (216,'2000002100','Daniel','Castro Rojas',NULL,'M',21,'María Castro','3154649920','danielcastro@gmail.com','Calle 30 #30-9','Activo','2026-01-11 20:21:42','2026-02-13 09:05:03');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (217,'2000002101','Daniela','Torres Rojas','2010-08-20','F',21,'Leonardo Torres','3158534794',NULL,'Calle 10 #1-46','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (220,'2000002104','Andrés','Ramírez Hernández','2010-05-12','M',21,'Daniel Ramírez','3179591387',NULL,'Calle 49 #18-88','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (221,'2000002105','Isabella','López Chávez','2010-02-05','F',21,'Daniel López','3111710937',NULL,'Calle 49 #13-31','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (222,'2000002106','Eduardo','Mendoza Castro','2010-06-19','M',21,'Gabriela Mendoza','3124419252',NULL,'Calle 3 #25-50','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (223,'2000002107','Natalia','Castro Ortiz',NULL,'F',21,'Eduardo Castro','3142036037','nataliacastro@gmail.com','Calle 40 #7-15','Activo','2026-01-11 20:21:42','2026-02-13 09:04:45');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (224,'2000002108','Pablo','Cruz Torres','2010-08-10','M',21,'Helena Cruz','3114762267',NULL,'Calle 16 #7-81','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (225,'2000002109','Tatiana','Ortiz Vargas','2010-10-23','F',21,'Ana Ortiz','3115403343',NULL,'Calle 29 #23-73','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (226,'2000002200','Leonardo','Castro Gutiérrez',NULL,'M',22,'Manuel Castro','3188398502','leonardocastro@gmail.com','Calle 40 #3-43','Activo','2026-01-11 20:21:42','2026-02-13 09:05:37');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (227,'2000002201','Paula','Vargas Torres','2010-06-09','F',22,'Diego Vargas','3148387629',NULL,'Calle 46 #14-44','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (228,'2000002202','Santiago','Ortiz Torres','2010-11-24','M',22,'Ana Ortiz','3113790234',NULL,'Calle 34 #17-38','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (229,'2000002203','Elena','Hernández Gutiérrez','2010-02-14','F',22,'Gabriel Hernández','3191554503',NULL,'Calle 3 #8-28','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (230,'2000002204','Manuel','Reyes Rojas','2010-12-20','M',22,'Paula Reyes','3112227782',NULL,'Calle 21 #23-76','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (231,'2000002205','Isabella','Rojas López','2010-06-11','F',22,'Pablo Rojas','3163100370',NULL,'Calle 14 #2-5','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (232,'2000002206','Alejandro','Rodríguez Mendoza','2010-07-25','M',22,'Diego Rodríguez','3106866138',NULL,'Calle 7 #2-26','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (233,'2000002207','Catalina','Ortiz Chávez','2010-11-21','F',22,'Hugo Ortiz','3181497147',NULL,'Calle 27 #6-46','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (234,'2000002208','Santiago','Chávez Cruz',NULL,'M',22,'Iván Chávez','3144960182','santiagochavez@gmail.com','Calle 23 #15-88','Activo','2026-01-11 20:21:42','2026-02-13 09:05:51');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (235,'2000002209','Sara','Morales Mendoza','2010-06-24','F',22,'Mateo Morales','3161743861',NULL,'Calle 45 #13-98','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (236,'2000002300','Gabriel','Martínez Flores',NULL,'M',23,'Fernanda Martínez','3161642506','gabierlmartinez@gmail.com','Calle 50 #22-91','Activo','2026-01-11 20:21:42','2026-02-13 09:08:32');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (237,'2000002301','Gabriela','Rivera Díaz','2009-04-09','F',23,'Ana Rivera','3136231372',NULL,'Calle 21 #11-77','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (238,'2000002302','Rafael','Ramírez Morales','2009-11-27','M',23,'Mariana Ramírez','3191733573',NULL,'Calle 48 #17-11','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (239,'2000002303','Elena','Mendoza Rojas',NULL,'F',23,'Catalina Mendoza','3159373878','elenarojas@gmail.com','Calle 32 #18-95','Activo','2026-01-11 20:21:42','2026-02-13 09:18:37');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (240,'2000002304','Sebastián','Gómez Rivera',NULL,'M',23,'Catalina Gómez','3157175603','sebastiangomez@gmail.com','Calle 43 #14-15','Activo','2026-01-11 20:21:42','2026-02-13 09:07:36');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (241,'2000002305','Daniela','Martínez Rodríguez',NULL,'F',23,'Kevin Martínez','3199853648','danielamartinez@gmail.com','Calle 29 #8-88','Activo','2026-01-11 20:21:42','2026-02-13 09:18:08');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (242,'2000002306','Carlos','Gómez Ramírez',NULL,'M',23,'Javier Gómez','3184543416','carlosgomez@gmail.com','Calle 31 #27-9','Activo','2026-01-11 20:21:42','2026-02-13 09:07:22');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (243,'2000002307','Andrea','Ramírez Castro','2009-01-01','F',23,'Olga Ramírez','3142980411',NULL,'Calle 37 #4-55','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (244,'2000002308','Samuel','Ortiz Rivera','2009-11-28','M',23,'Tomás Ortiz','3156378431',NULL,'Calle 35 #29-88','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (245,'2000002309','Fernanda','Rodríguez Mendoza','2009-10-17','F',23,'Valentina Rodríguez','3145425470',NULL,'Calle 30 #20-75','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (246,'2000002400','Sebastián','Rodríguez Torres','2009-01-04','M',24,'Daniel Rodríguez','3142584427',NULL,'Calle 11 #16-85','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (247,'2000002401','Andrea','Ortiz López','2009-06-12','F',24,'Nicolás Ortiz','3111465507',NULL,'Calle 26 #22-54','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (248,'2000002402','Javier','González Hernández',NULL,'M',24,'Nicolás González','3159178394','javiergonzales@gmail.com','Calle 14 #29-58','Activo','2026-01-11 20:21:42','2026-02-13 09:20:41');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (249,'2000002403','Helena','Castro Sánchez',NULL,'F',24,'Oscar Castro','3188185564','helenacastro@gmail.com','Calle 38 #11-48','Activo','2026-01-11 20:21:42','2026-02-13 09:19:50');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (250,'2000002404','Eduardo','Castro Torres',NULL,'M',24,'Elena Castro','3114344989','eduardocastro@gmail.com','Calle 50 #1-34','Activo','2026-01-11 20:21:42','2026-02-13 09:20:04');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (251,'2000002405','Olga','Hernández Sánchez','2009-06-16','F',24,'Camila Hernández','3125361535',NULL,'Calle 20 #2-16','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (252,'2000002406','Kevin','Reyes Torres','2009-05-16','M',24,'Nicolás Reyes','3107997421',NULL,'Calle 37 #4-18','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (253,'2000002407','Paula','López Rojas','2009-10-07','F',24,'María López','3123102077',NULL,'Calle 1 #22-76','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (254,'2000002408','Daniel','Cruz Cruz',NULL,'M',24,'Andrea Cruz','3167415810','danielcruz@gmail.com','Calle 5 #21-51','Activo','2026-01-11 20:21:42','2026-02-13 09:20:25');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (255,'2000002409','Isabella','Ramírez Castro','2009-05-06','F',24,'Julia Ramírez','3157849390',NULL,'Calle 8 #15-68','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (256,'2000000100','Sebastián','Ramírez Castro','2008-07-16','M',1,'Leonardo Ramírez','3166736587',NULL,'Calle 32 #15-87','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (257,'2000000101','Laura','Ramírez Ramírez','2008-02-11','F',1,'Valentina Ramírez','3187495739',NULL,'Calle 14 #8-86','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (258,'2000000102','Alejandro','Ramírez Hernández','2008-02-14','M',1,'Tatiana Ramírez','3144865216',NULL,'Calle 12 #16-24','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (259,'2000000103','Karen','Gutiérrez Ramírez',NULL,'F',1,'Catalina Gutiérrez','3129980618','karengutierrez@gmail.com','Calle 29 #15-77','Activo','2026-01-11 20:21:42','2026-02-13 09:30:35');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (260,'2000000104','Rafael','Herrera González','2008-03-20','M',1,'Samuel Herrera','3152105519',NULL,'Calle 25 #3-87','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (261,'2000000105','Ana','Morales Torres','2008-09-04','F',1,'Manuel Morales','3112022458',NULL,'Calle 5 #19-45','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (262,'2000000106','Felipe','Torres López','2008-05-07','M',1,'Daniela Torres','3192578581',NULL,'Calle 25 #16-91','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (263,'2000000107','Fernanda','Gómez Reyes',NULL,'F',1,'Daniela Gómez','3165349746','fernandagomez@gmail.com','Calle 10 #14-5','Activo','2026-01-11 20:21:42','2026-02-13 09:29:31');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (264,'2000000108','Daniel','Cruz Martínez',NULL,'M',1,'Kevin Cruz','3182916667','danielcruzmartinez@gmail.com','Calle 34 #28-25','Activo','2026-01-11 20:21:42','2026-02-13 09:21:15');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (265,'2000000109','Tatiana','Flores Torres',NULL,'F',1,'Paula Flores','3151339427','tatianaflores@gmail.com','Calle 43 #9-92','Activo','2026-01-11 20:21:42','2026-02-13 09:21:31');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (266,'2000000200','Carlos','Hernández Rivera',NULL,'M',2,'Daniela Hernández','3176091142','carloshernandez@gmail.com','Calle 8 #4-21','Activo','2026-01-11 20:21:42','2026-02-13 09:34:43');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (267,'2000000201','Tatiana','Vargas Mendoza','2008-02-02','F',2,'Nicolás Vargas','3167391679',NULL,'Calle 4 #20-63','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (268,'2000000202','Andrés','Vargas Chávez','2008-01-28','M',2,'Laura Vargas','3169322141',NULL,'Calle 32 #14-43','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (269,'2000000203','Laura','López Castro',NULL,'F',2,'Kevin López','3112414050','lauralopez@gmail.com','Calle 43 #29-6','Activo','2026-01-11 20:21:42','2026-02-13 09:35:00');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (270,'2000000204','Oscar','López Flores',NULL,'M',2,'Gabriela López','3115282789','oscarlopez@gmail.com','Calle 20 #14-62','Activo','2026-01-11 20:21:42','2026-02-13 09:35:10');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (271,'2000000205','Beatriz','Ramírez Rivera','2008-05-25','F',2,'Santiago Ramírez','3174332550',NULL,'Calle 23 #22-15','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (272,'2000000206','Rafael','Ortiz López','2008-08-10','M',2,'Catalina Ortiz','3151426722',NULL,'Calle 37 #13-25','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (273,'2000000207','Beatriz','Martínez Mendoza',NULL,'F',2,'Kevin Martínez','3184458286','beatrizmartinez@gmail.com','Calle 23 #9-91','Activo','2026-01-11 20:21:42','2026-02-13 09:35:28');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (274,'2000000208','Carlos','Mendoza García','2008-07-17','M',2,'Catalina Mendoza','3156910364',NULL,'Calle 46 #25-74','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (275,'2000000209','Olga','Vargas Ortiz','2008-12-07','F',2,'Sofía Vargas','3178254525',NULL,'Calle 45 #9-43','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (276,'2000000400','Felipe','Reyes Hernández','2007-02-26','M',4,'Camila Reyes','3192972315',NULL,'Calle 13 #2-98','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (277,'2000000401','Natalia','Gómez Martínez',NULL,'F',4,'Luciana Gómez','3167841743','nataliagomez@gmail.com','Calle 8 #5-21','Activo','2026-01-11 20:21:42','2026-02-13 09:39:24');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (278,'2000000402','Santiago','López García','2007-02-25','M',4,'Daniela López','3112184984',NULL,'Calle 2 #28-80','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (279,'2000000403','Helena','Rivera Vargas','2007-04-13','F',4,'Diego Rivera','3107509728',NULL,'Calle 28 #6-60','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (280,'2000000404','Rafael','Torres Sánchez','2007-02-26','M',4,'Pablo Torres','3163464922',NULL,'Calle 39 #27-47','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (281,'2000000405','Elena','Herrera Gutiérrez','2007-01-02','F',4,'Iván Herrera','3128732642',NULL,'Calle 43 #16-61','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (282,'2000000406','Diego','Mendoza Chávez','2007-04-20','M',4,'Pablo Mendoza','3175715528',NULL,'Calle 24 #24-10','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (283,'2000000407','Natalia','Chávez Flores',NULL,'F',4,'Gabriel Chávez','3126822126','nataliachavez@gmail.com','Calle 7 #20-74','Activo','2026-01-11 20:21:42','2026-02-13 09:36:56');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (284,'2000000408','Tomás','Morales Sánchez','2007-08-23','M',4,'Andrea Morales','3173095029',NULL,'Calle 30 #26-93','Activo','2026-01-11 20:21:42','2026-01-11 20:21:42');
INSERT INTO estudiantes (id_estudiante,documento,nombre,apellido,fecha_nacimiento,genero,id_grupo,acudiente_nombre,acudiente_telefono,correo,direccion,estado,created_at,updated_at) VALUES (285,'2000000409','Fernanda','Flores González',NULL,'F',4,'Tomás Flores','3183875045','fernanadaflores@gmail.com','Calle 21 #23-78','Activo','2026-01-11 20:21:42','2026-02-13 09:39:09');

CREATE TABLE `grados` (
  `id_grado` int NOT NULL AUTO_INCREMENT,
  `numero_grado` int NOT NULL,
  `id_nivel` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `nombre_grado` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_grado`),
  UNIQUE KEY `uk_numero_grado` (`numero_grado`),
  KEY `idx_id_nivel` (`id_nivel`),
  CONSTRAINT `fk_grados_nivel` FOREIGN KEY (`id_nivel`) REFERENCES `niveles` (`id_nivel`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO grados (id_grado,numero_grado,id_nivel,created_at,updated_at,nombre_grado) VALUES (6,6,2,NULL,'2026-02-11 21:13:38','6vo');
INSERT INTO grados (id_grado,numero_grado,id_nivel,created_at,updated_at,nombre_grado) VALUES (7,7,2,NULL,'2026-01-14 18:09:44','7vo');
INSERT INTO grados (id_grado,numero_grado,id_nivel,created_at,updated_at,nombre_grado) VALUES (8,8,2,NULL,'2026-01-14 18:09:44','8vo');
INSERT INTO grados (id_grado,numero_grado,id_nivel,created_at,updated_at,nombre_grado) VALUES (9,9,2,NULL,'2026-01-14 18:09:44','9vo');
INSERT INTO grados (id_grado,numero_grado,id_nivel,created_at,updated_at,nombre_grado) VALUES (10,10,3,NULL,'2026-01-14 18:09:44','10vo');
INSERT INTO grados (id_grado,numero_grado,id_nivel,created_at,updated_at,nombre_grado) VALUES (11,11,3,NULL,'2026-01-14 18:09:44','11vo');

CREATE TABLE `grupos` (
  `id_grupo` int NOT NULL AUTO_INCREMENT,
  `codigo_grupo` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_grado` int NOT NULL,
  `capacidad_maxima` int DEFAULT '40',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_grupo`),
  UNIQUE KEY `uk_codigo_grupo` (`codigo_grupo`),
  KEY `idx_id_grado` (`id_grado`),
  CONSTRAINT `fk_grupos_grado` FOREIGN KEY (`id_grado`) REFERENCES `grados` (`id_grado`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO grupos (id_grupo,codigo_grupo,id_grado,capacidad_maxima,created_at,updated_at) VALUES (1,'10-01',10,40,NULL,NULL);
INSERT INTO grupos (id_grupo,codigo_grupo,id_grado,capacidad_maxima,created_at,updated_at) VALUES (2,'10-02',10,40,NULL,NULL);
INSERT INTO grupos (id_grupo,codigo_grupo,id_grado,capacidad_maxima,created_at,updated_at) VALUES (3,'10-03',10,40,NULL,NULL);
INSERT INTO grupos (id_grupo,codigo_grupo,id_grado,capacidad_maxima,created_at,updated_at) VALUES (4,'11-01',11,40,NULL,NULL);
INSERT INTO grupos (id_grupo,codigo_grupo,id_grado,capacidad_maxima,created_at,updated_at) VALUES (5,'11-02',11,40,NULL,NULL);
INSERT INTO grupos (id_grupo,codigo_grupo,id_grado,capacidad_maxima,created_at,updated_at) VALUES (6,'11-03',11,40,NULL,NULL);
INSERT INTO grupos (id_grupo,codigo_grupo,id_grado,capacidad_maxima,created_at,updated_at) VALUES (17,'6-Aa',6,40,NULL,'2026-01-14 18:34:01');
INSERT INTO grupos (id_grupo,codigo_grupo,id_grado,capacidad_maxima,created_at,updated_at) VALUES (18,'6-B',6,40,NULL,NULL);
INSERT INTO grupos (id_grupo,codigo_grupo,id_grado,capacidad_maxima,created_at,updated_at) VALUES (19,'7-A',7,40,NULL,NULL);
INSERT INTO grupos (id_grupo,codigo_grupo,id_grado,capacidad_maxima,created_at,updated_at) VALUES (20,'7-B',7,40,NULL,NULL);
INSERT INTO grupos (id_grupo,codigo_grupo,id_grado,capacidad_maxima,created_at,updated_at) VALUES (21,'8-A',8,40,NULL,NULL);
INSERT INTO grupos (id_grupo,codigo_grupo,id_grado,capacidad_maxima,created_at,updated_at) VALUES (22,'8-B',8,40,NULL,NULL);
INSERT INTO grupos (id_grupo,codigo_grupo,id_grado,capacidad_maxima,created_at,updated_at) VALUES (23,'9-A',9,40,'2026-01-11 20:14:17','2026-01-11 20:14:17');
INSERT INTO grupos (id_grupo,codigo_grupo,id_grado,capacidad_maxima,created_at,updated_at) VALUES (24,'9-B',9,40,'2026-01-11 20:14:17','2026-01-11 20:14:17');

CREATE TABLE `horarios` (
  `id_horario` int NOT NULL AUTO_INCREMENT,
  `id_asignacion` int NOT NULL,
  `id_grupo` int NOT NULL,
  `dia_semana` enum('Lunes','Martes','Miércoles','Jueves','Viernes') COLLATE utf8mb4_unicode_ci NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  `numero_bloque` int DEFAULT NULL COMMENT 'Número del bloque horario (Ej: 1, 2, 3...)',
  `aula` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Número o identificación del aula',
  `observaciones` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_horario`),
  KEY `idx_id_asignacion` (`id_asignacion`),
  KEY `idx_id_grupo` (`id_grupo`),
  KEY `idx_dia_semana` (`dia_semana`),
  CONSTRAINT `fk_horarios_asignacion` FOREIGN KEY (`id_asignacion`) REFERENCES `asignaciones_docente` (`id_asignacion`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_horarios_grupo` FOREIGN KEY (`id_grupo`) REFERENCES `grupos` (`id_grupo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `justificantes_ausencia` (
  `id_justificante` int NOT NULL AUTO_INCREMENT,
  `id_asistencia` int NOT NULL,
  `id_estudiante` int NOT NULL,
  `tipo_justificante` enum('Médico','Familiar','Administrativo','Otro') COLLATE utf8mb4_unicode_ci DEFAULT 'Otro',
  `archivo_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Ruta del archivo del justificante',
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `aprobado` tinyint(1) DEFAULT '0' COMMENT 'Si el justificante ha sido aprobado',
  `aprobado_por` int DEFAULT NULL COMMENT 'ID del usuario que aprobó',
  `fecha_aprobacion` datetime DEFAULT NULL COMMENT 'Fecha de aprobación',
  `fecha_documento` date DEFAULT NULL COMMENT 'Fecha del documento justificante',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_justificante`),
  KEY `idx_id_asistencia` (`id_asistencia`),
  KEY `idx_id_estudiante` (`id_estudiante`),
  KEY `idx_aprobado_por` (`aprobado_por`),
  CONSTRAINT `fk_justificantes_aprobado` FOREIGN KEY (`aprobado_por`) REFERENCES `usuarios` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_justificantes_asistencia` FOREIGN KEY (`id_asistencia`) REFERENCES `asistencia` (`id_asistencia`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_justificantes_estudiante` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`id_estudiante`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `log_registro` (
  `id_log` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `tipo_accion` enum('Login','Logout','CREATE','READ','UPDATE','DELETE','Export','Import','Error') COLLATE utf8mb4_unicode_ci DEFAULT 'CREATE',
  `tabla_afectada` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `registro_id` int DEFAULT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `timestamp_accion` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_log`),
  KEY `idx_id_usuario` (`id_usuario`),
  KEY `idx_tipo_accion` (`tipo_accion`),
  KEY `idx_timestamp` (`timestamp_accion`),
  CONSTRAINT `fk_log_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO log_registro (id_log,id_usuario,tipo_accion,tabla_afectada,registro_id,descripcion,ip_address,user_agent,timestamp_accion,created_at) VALUES (1,12,'Export',NULL,NULL,'Envió consolidado a 1 destinatario(s)',NULL,NULL,'2026-02-12 19:03:17','2026-02-12 19:03:17');
INSERT INTO log_registro (id_log,id_usuario,tipo_accion,tabla_afectada,registro_id,descripcion,ip_address,user_agent,timestamp_accion,created_at) VALUES (2,12,'Export',NULL,NULL,'Envió boletin a 1 destinatario(s)',NULL,NULL,'2026-02-12 19:50:09','2026-02-12 19:50:09');
INSERT INTO log_registro (id_log,id_usuario,tipo_accion,tabla_afectada,registro_id,descripcion,ip_address,user_agent,timestamp_accion,created_at) VALUES (3,12,'Export',NULL,NULL,'Envió boletin a 1 destinatario(s)',NULL,NULL,'2026-02-12 19:52:16','2026-02-12 19:52:16');
INSERT INTO log_registro (id_log,id_usuario,tipo_accion,tabla_afectada,registro_id,descripcion,ip_address,user_agent,timestamp_accion,created_at) VALUES (4,12,'Export',NULL,NULL,'Envió consolidado a 2 destinatario(s)',NULL,NULL,'2026-02-12 20:06:47','2026-02-12 20:06:47');
INSERT INTO log_registro (id_log,id_usuario,tipo_accion,tabla_afectada,registro_id,descripcion,ip_address,user_agent,timestamp_accion,created_at) VALUES (5,12,'Export',NULL,NULL,'Envió boletin a 1 destinatario(s)',NULL,NULL,'2026-02-12 20:08:28','2026-02-12 20:08:28');
INSERT INTO log_registro (id_log,id_usuario,tipo_accion,tabla_afectada,registro_id,descripcion,ip_address,user_agent,timestamp_accion,created_at) VALUES (6,12,'Export',NULL,NULL,'Envió consolidado a 2 destinatario(s)',NULL,NULL,'2026-02-12 20:08:51','2026-02-12 20:08:51');
INSERT INTO log_registro (id_log,id_usuario,tipo_accion,tabla_afectada,registro_id,descripcion,ip_address,user_agent,timestamp_accion,created_at) VALUES (7,12,'Export',NULL,NULL,'Envió boletin a 1 destinatario(s)',NULL,NULL,'2026-02-12 20:11:22','2026-02-12 20:11:22');
INSERT INTO log_registro (id_log,id_usuario,tipo_accion,tabla_afectada,registro_id,descripcion,ip_address,user_agent,timestamp_accion,created_at) VALUES (8,12,'Export',NULL,NULL,'Envió asistencia_diaria a 2 destinatario(s)',NULL,NULL,'2026-02-12 20:28:54','2026-02-12 20:28:54');

CREATE TABLE `materias` (
  `id_materia` int NOT NULL AUTO_INCREMENT,
  `nombre_materia` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `codigo_materia` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `intensidad_horaria` int DEFAULT '4',
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_materia`),
  UNIQUE KEY `uk_nombre_materia` (`nombre_materia`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO materias (id_materia,nombre_materia,codigo_materia,intensidad_horaria,descripcion,created_at,updated_at) VALUES (6,'Educación Artística','EDA-001',2,'Artes plásticas, música, teatro',NULL,NULL);
INSERT INTO materias (id_materia,nombre_materia,codigo_materia,intensidad_horaria,descripcion,created_at,updated_at) VALUES (7,'Inglés','ING-001',3,'Idioma extranjero',NULL,NULL);
INSERT INTO materias (id_materia,nombre_materia,codigo_materia,intensidad_horaria,descripcion,created_at,updated_at) VALUES (8,'Informática','INF-001',3,'Computación y tecnología',NULL,NULL);
INSERT INTO materias (id_materia,nombre_materia,codigo_materia,intensidad_horaria,descripcion,created_at,updated_at) VALUES (9,'Filosofía','FIL-001',2,'Pensamiento crítico',NULL,NULL);
INSERT INTO materias (id_materia,nombre_materia,codigo_materia,intensidad_horaria,descripcion,created_at,updated_at) VALUES (10,'Ética','ETI-001',2,'Valores y convivencia',NULL,NULL);
INSERT INTO materias (id_materia,nombre_materia,codigo_materia,intensidad_horaria,descripcion,created_at,updated_at) VALUES (11,'Religión','REL-001',2,'Educación religiosa y valores',NULL,NULL);
INSERT INTO materias (id_materia,nombre_materia,codigo_materia,intensidad_horaria,descripcion,created_at,updated_at) VALUES (12,'Química','QUI-001',4,'Reacciones y elementos químicos',NULL,NULL);
INSERT INTO materias (id_materia,nombre_materia,codigo_materia,intensidad_horaria,descripcion,created_at,updated_at) VALUES (13,'Biología','BIO-001',4,'Organismos vivos y ecosistemas',NULL,NULL);
INSERT INTO materias (id_materia,nombre_materia,codigo_materia,intensidad_horaria,descripcion,created_at,updated_at) VALUES (14,'Física','FIS-001',4,'Movimiento y energía',NULL,NULL);
INSERT INTO materias (id_materia,nombre_materia,codigo_materia,intensidad_horaria,descripcion,created_at,updated_at) VALUES (15,'Literatura','LIT-001',3,'Análisis de obras literarias',NULL,NULL);
INSERT INTO materias (id_materia,nombre_materia,codigo_materia,intensidad_horaria,descripcion,created_at,updated_at) VALUES (16,'Estadística','EST-001',3,'Análisis de datos',NULL,NULL);
INSERT INTO materias (id_materia,nombre_materia,codigo_materia,intensidad_horaria,descripcion,created_at,updated_at) VALUES (17,'Larry Jan Pierr','',2,'','2026-01-07 15:00:49','2026-01-07 15:00:49');
INSERT INTO materias (id_materia,nombre_materia,codigo_materia,intensidad_horaria,descripcion,created_at,updated_at) VALUES (18,'Test','TST',4,'','2026-01-07 15:24:57','2026-01-07 15:24:57');
INSERT INTO materias (id_materia,nombre_materia,codigo_materia,intensidad_horaria,descripcion,created_at,updated_at) VALUES (19,'11','',111,'','2026-01-07 15:30:04','2026-01-07 15:30:04');
INSERT INTO materias (id_materia,nombre_materia,codigo_materia,intensidad_horaria,descripcion,created_at,updated_at) VALUES (20,'mate','601A',4,'matematicas','2026-01-08 10:57:11','2026-01-08 10:57:11');
INSERT INTO materias (id_materia,nombre_materia,codigo_materia,intensidad_horaria,descripcion,created_at,updated_at) VALUES (21,'Matemáticas','MAT-001',5,'Matemáticas básicas y avanzadas','2026-01-11 20:14:36','2026-01-11 20:14:36');
INSERT INTO materias (id_materia,nombre_materia,codigo_materia,intensidad_horaria,descripcion,created_at,updated_at) VALUES (22,'Lengua Castellana','LEN-001',5,'Español y comunicación','2026-01-11 20:14:36','2026-01-11 20:14:36');
INSERT INTO materias (id_materia,nombre_materia,codigo_materia,intensidad_horaria,descripcion,created_at,updated_at) VALUES (23,'Ciencias Naturales','NAT-001',4,'Ciencias de la naturaleza','2026-01-11 20:14:36','2026-01-11 20:14:36');
INSERT INTO materias (id_materia,nombre_materia,codigo_materia,intensidad_horaria,descripcion,created_at,updated_at) VALUES (24,'Ciencias Sociales','SOC-001',4,'Historia, geografía y civismo','2026-01-11 20:14:36','2026-01-11 20:14:36');
INSERT INTO materias (id_materia,nombre_materia,codigo_materia,intensidad_horaria,descripcion,created_at,updated_at) VALUES (25,'Educación Física','EDF-001',2,'Deportes y actividad física','2026-01-11 20:14:36','2026-01-11 20:14:36');
INSERT INTO materias (id_materia,nombre_materia,codigo_materia,intensidad_horaria,descripcion,created_at,updated_at) VALUES (26,'Geometría','GEO-001',3,'Geometría y trigonometría','2026-01-11 20:14:36','2026-01-11 20:14:36');
INSERT INTO materias (id_materia,nombre_materia,codigo_materia,intensidad_horaria,descripcion,created_at,updated_at) VALUES (27,'Álgebra','ALG-001',3,'Álgebra y funciones','2026-01-11 20:14:36','2026-01-11 20:14:36');

CREATE TABLE `niveles` (
  `id_nivel` int NOT NULL AUTO_INCREMENT,
  `nombre_nivel` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_nivel`),
  UNIQUE KEY `uk_nombre_nivel` (`nombre_nivel`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO niveles (id_nivel,nombre_nivel,descripcion,created_at,updated_at) VALUES (1,'Primaria','Grados 1-5',NULL,NULL);
INSERT INTO niveles (id_nivel,nombre_nivel,descripcion,created_at,updated_at) VALUES (2,'Secundaria','Grados 6-9',NULL,NULL);
INSERT INTO niveles (id_nivel,nombre_nivel,descripcion,created_at,updated_at) VALUES (3,'Bachillerato','Grados 10-11',NULL,NULL);

CREATE TABLE `notas` (
  `id_nota` int NOT NULL AUTO_INCREMENT,
  `id_estudiante` int NOT NULL,
  `id_actividad` int NOT NULL,
  `id_materia` int NOT NULL,
  `id_periodo` int NOT NULL,
  `puntaje_obtenido` decimal(5,2) DEFAULT NULL,
  `porcentaje` decimal(5,2) DEFAULT NULL,
  `calificacion` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `observaciones` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_calificacion` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_nota`),
  UNIQUE KEY `uk_estudiante_actividad` (`id_estudiante`,`id_actividad`),
  KEY `idx_id_estudiante` (`id_estudiante`),
  KEY `idx_id_actividad` (`id_actividad`),
  KEY `idx_id_materia` (`id_materia`),
  KEY `idx_id_periodo` (`id_periodo`),
  CONSTRAINT `fk_notas_actividad` FOREIGN KEY (`id_actividad`) REFERENCES `actividades` (`id_actividad`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_notas_estudiante` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`id_estudiante`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_notas_materia` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_notas_periodo` FOREIGN KEY (`id_periodo`) REFERENCES `periodos` (`id_periodo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=222 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (2,101,4,14,1,'95.00','23.75','Superior','Buen trabajo','2026-01-11 20:10:54','2026-01-11 20:10:54','2026-01-11 20:10:54');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (3,101,5,14,1,'90.00','22.50','Superior','Buen trabajo','2026-01-11 20:10:54','2026-01-11 20:10:54','2026-01-11 20:10:54');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (4,101,6,14,1,'85.00','21.25','Superior','Buen trabajo','2026-01-11 20:10:54','2026-01-11 20:10:54','2026-01-11 20:10:54');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (5,102,4,14,1,'85.00','21.25','Alto','Buen trabajo','2026-01-11 20:10:54','2026-01-11 20:10:54','2026-01-11 20:10:54');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (6,102,5,14,1,'80.00','20.00','Alto','Buen trabajo','2026-01-11 20:10:54','2026-01-11 20:10:54','2026-01-11 20:10:54');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (7,102,6,14,1,'75.00','18.75','Alto','Buen trabajo','2026-01-11 20:10:54','2026-01-11 20:10:54','2026-01-11 20:10:54');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (8,103,4,14,1,'70.00','17.50','Básico','Buen trabajo','2026-01-11 20:10:54','2026-01-11 20:10:54','2026-01-11 20:10:54');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (9,103,5,14,1,'65.00','16.25','Básico','Buen trabajo','2026-01-11 20:10:54','2026-01-11 20:10:54','2026-01-11 20:10:54');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (10,103,6,14,1,'60.00','15.00','Básico','Buen trabajo','2026-01-11 20:10:54','2026-01-11 20:10:54','2026-01-11 20:10:54');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (11,104,4,14,1,'82.00','20.50','Alto','Buen trabajo','2026-01-11 20:10:54','2026-01-11 20:10:54','2026-01-11 20:10:54');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (12,104,5,14,1,'77.00','19.25','Alto','Buen trabajo','2026-01-11 20:10:54','2026-01-11 20:10:54','2026-01-11 20:10:54');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (13,104,6,14,1,'72.00','18.00','Alto','Buen trabajo','2026-01-11 20:10:54','2026-01-11 20:10:54','2026-01-11 20:10:54');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (14,105,4,14,1,'92.00','23.00','Superior','Buen trabajo','2026-01-11 20:10:54','2026-01-11 20:10:54','2026-01-11 20:10:54');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (15,105,5,14,1,'87.00','21.75','Superior','Buen trabajo','2026-01-11 20:10:54','2026-01-11 20:10:54','2026-01-11 20:10:54');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (16,105,6,14,1,'82.00','20.50','Superior','Buen trabajo','2026-01-11 20:10:54','2026-01-11 20:10:54','2026-01-11 20:10:54');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (17,126,10,21,1,'90.00','22.50','Superior','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (18,126,11,21,1,'82.00','20.50','Alto','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (19,126,12,23,1,'89.00','22.25','Alto','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (20,127,10,21,1,'68.00','17.00','Básico','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (21,127,11,21,1,'79.00','19.75','Básico','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (22,127,12,23,1,'82.00','20.50','Alto','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (23,128,10,21,1,'72.00','18.00','Básico','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (24,128,11,21,1,'72.00','18.00','Básico','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (25,128,12,23,1,'79.00','19.75','Básico','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (26,129,10,21,1,'72.00','18.00','Básico','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (27,129,11,21,1,'82.00','20.50','Alto','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (28,129,12,23,1,'94.00','23.50','Superior','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (29,130,10,21,1,'73.00','18.25','Básico','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (30,130,11,21,1,'89.00','22.25','Alto','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (31,130,12,23,1,'85.00','21.25','Alto','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (32,136,13,21,1,'84.00','21.00','Alto','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (33,136,14,21,1,'77.00','19.25','Básico','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (34,136,15,26,1,'75.00','18.75','Básico','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (35,137,13,21,1,'91.00','22.75','Superior','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (36,137,14,21,1,'84.00','21.00','Alto','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (37,137,15,26,1,'89.00','22.25','Alto','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (38,138,13,21,1,'73.00','18.25','Básico','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (39,138,14,21,1,'67.00','16.75','Básico','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (40,138,15,26,1,'77.00','19.25','Básico','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (41,139,13,21,1,'98.00','24.50','Superior','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (42,139,14,21,1,'79.00','19.75','Básico','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (43,139,15,26,1,'77.00','19.25','Básico','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (44,140,13,21,1,'76.00','19.00','Básico','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (45,140,14,21,1,'91.00','22.75','Superior','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (46,140,15,26,1,'91.00','22.75','Superior','Buen desempeño','2026-01-11 20:18:52','2026-01-11 20:18:52','2026-01-11 20:18:52');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (47,116,9,8,1,'97.00','24.25','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (48,117,9,8,1,'58.00','14.50','Bajo','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (49,118,9,8,1,'81.00','20.25','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (50,119,9,8,1,'65.00','16.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (52,196,9,8,1,'67.00','16.75','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (55,199,9,8,1,'73.00','18.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (56,200,9,8,1,'64.00','16.00','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (58,202,9,8,1,'92.00','23.00','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (61,205,9,8,1,'69.00','17.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (62,116,16,21,1,'73.00','18.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (63,117,16,21,1,'86.00','21.50','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (64,118,16,21,1,'58.00','14.50','Bajo','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (65,119,16,21,1,'68.00','17.00','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (67,196,16,21,1,'98.00','24.50','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (70,199,16,21,1,'60.00','15.00','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (71,200,16,21,1,'63.00','15.75','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (73,202,16,21,1,'73.00','18.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (76,205,16,21,1,'58.00','14.50','Bajo','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (77,116,17,23,1,'88.00','22.00','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (78,117,17,23,1,'69.00','17.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (79,118,17,23,1,'56.00','14.00','Bajo','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (80,119,17,23,1,'56.00','14.00','Bajo','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (82,196,17,23,1,'72.00','18.00','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (85,199,17,23,1,'64.00','16.00','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (86,200,17,23,1,'57.00','14.25','Bajo','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (88,202,17,23,1,'61.00','15.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (91,205,17,23,1,'73.00','18.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (92,146,18,21,1,'79.00','19.75','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (93,147,18,21,1,'88.00','22.00','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (94,148,18,21,1,'56.00','14.00','Bajo','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (95,149,18,21,1,'92.00','23.00','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (96,150,18,21,1,'85.00','21.25','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (97,151,18,21,1,'58.00','14.50','Bajo','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (98,152,18,21,1,'71.00','17.75','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (99,153,18,21,1,'77.00','19.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (100,154,18,21,1,'98.00','24.50','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (101,155,18,21,1,'61.00','15.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (102,146,19,22,1,'79.00','19.75','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (103,147,19,22,1,'69.00','17.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (104,148,19,22,1,'100.00','25.00','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (105,149,19,22,1,'68.00','17.00','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (106,150,19,22,1,'62.00','15.50','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (107,151,19,22,1,'84.00','21.00','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (108,152,19,22,1,'87.00','21.75','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (109,153,19,22,1,'58.00','14.50','Bajo','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (110,154,19,22,1,'73.00','18.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (111,155,19,22,1,'71.00','17.75','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (112,121,20,21,1,'68.00','17.00','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (113,122,20,21,1,'66.00','16.50','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (114,123,20,21,1,'87.00','21.75','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (115,124,20,21,1,'88.00','22.00','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (116,125,20,21,1,'81.00','20.25','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (117,206,20,21,1,'66.00','16.50','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (118,207,20,21,1,'77.00','19.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (119,208,20,21,1,'61.00','15.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (120,209,20,21,1,'73.00','18.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (121,210,20,21,1,'76.00','19.00','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (122,211,20,21,1,'83.00','20.75','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (123,212,20,21,1,'83.00','20.75','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (124,213,20,21,1,'58.00','14.50','Bajo','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (125,214,20,21,1,'65.00','16.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (126,215,20,21,1,'79.00','19.75','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (127,121,21,8,1,'64.00','16.00','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (128,122,21,8,1,'99.00','24.75','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (129,123,21,8,1,'58.00','14.50','Bajo','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (130,124,21,8,1,'90.00','22.50','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (131,125,21,8,1,'86.00','21.50','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (132,206,21,8,1,'94.00','23.50','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (133,207,21,8,1,'65.00','16.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (134,208,21,8,1,'99.00','24.75','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (135,209,21,8,1,'58.00','14.50','Bajo','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (136,210,21,8,1,'94.00','23.50','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (137,211,21,8,1,'69.00','17.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (138,212,21,8,1,'89.00','22.25','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (139,213,21,8,1,'70.00','17.50','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (140,214,21,8,1,'56.00','14.00','Bajo','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (141,215,21,8,1,'75.00','18.75','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (142,156,22,21,1,'80.00','20.00','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (143,157,22,21,1,'89.00','22.25','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (144,158,22,21,1,'92.00','23.00','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (145,159,22,21,1,'72.00','18.00','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (146,160,22,21,1,'92.00','23.00','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (147,161,22,21,1,'91.00','22.75','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (148,162,22,21,1,'90.00','22.50','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (149,163,22,21,1,'77.00','19.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (150,164,22,21,1,'96.00','24.00','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (151,165,22,21,1,'84.00','21.00','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (152,156,23,23,1,'65.00','16.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (153,157,23,23,1,'72.00','18.00','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (154,158,23,23,1,'83.00','20.75','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (155,159,23,23,1,'92.00','23.00','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (156,160,23,23,1,'91.00','22.75','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (157,161,23,23,1,'72.00','18.00','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (158,162,23,23,1,'98.00','24.50','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (159,163,23,23,1,'80.00','20.00','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (160,164,23,23,1,'85.00','21.25','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (161,165,23,23,1,'56.00','14.00','Bajo','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (162,166,24,14,1,'96.00','24.00','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (163,167,24,14,1,'58.00','14.50','Bajo','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (164,168,24,14,1,'65.00','16.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (165,169,24,14,1,'90.00','22.50','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (166,170,24,14,1,'100.00','25.00','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (167,171,24,14,1,'78.00','19.50','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (168,172,24,14,1,'88.00','22.00','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (169,173,24,14,1,'86.00','21.50','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (170,174,24,14,1,'85.00','21.25','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (171,175,24,14,1,'72.00','18.00','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (172,166,25,12,1,'64.00','16.00','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (173,167,25,12,1,'63.00','15.75','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (174,168,25,12,1,'93.00','23.25','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (175,169,25,12,1,'100.00','25.00','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (176,170,25,12,1,'74.00','18.50','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (177,171,25,12,1,'58.00','14.50','Bajo','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (178,172,25,12,1,'81.00','20.25','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (179,173,25,12,1,'70.00','17.50','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (180,174,25,12,1,'91.00','22.75','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (181,175,25,12,1,'94.00','23.50','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (182,176,26,16,1,'94.00','23.50','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (183,177,26,16,1,'86.00','21.50','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (184,178,26,16,1,'80.00','20.00','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (185,179,26,16,1,'96.00','24.00','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (186,180,26,16,1,'80.00','20.00','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (187,181,26,16,1,'84.00','21.00','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (188,182,26,16,1,'82.00','20.50','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (189,183,26,16,1,'81.00','20.25','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (190,184,26,16,1,'92.00','23.00','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (191,185,26,16,1,'100.00','25.00','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (192,176,27,7,1,'58.00','14.50','Bajo','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (193,177,27,7,1,'93.00','23.25','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (194,178,27,7,1,'63.00','15.75','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (195,179,27,7,1,'70.00','17.50','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (196,180,27,7,1,'95.00','23.75','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (197,181,27,7,1,'84.00','21.00','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (198,182,27,7,1,'61.00','15.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (199,183,27,7,1,'84.00','21.00','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (200,184,27,7,1,'67.00','16.75','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (201,185,27,7,1,'60.00','15.00','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (202,186,28,16,1,'99.00','24.75','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (203,187,28,16,1,'76.00','19.00','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (204,188,28,16,1,'87.00','21.75','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (205,189,28,16,1,'74.00','18.50','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (206,190,28,16,1,'64.00','16.00','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (207,191,28,16,1,'97.00','24.25','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (209,193,28,16,1,'65.00','16.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (210,194,28,16,1,'87.00','21.75','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (211,195,28,16,1,'81.00','20.25','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (212,186,29,7,1,'75.00','18.75','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (213,187,29,7,1,'85.00','21.25','Alto','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (214,188,29,7,1,'93.00','23.25','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (215,189,29,7,1,'76.00','19.00','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (216,190,29,7,1,'65.00','16.25','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (217,191,29,7,1,'67.00','16.75','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (219,193,29,7,1,'74.00','18.50','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (220,194,29,7,1,'63.00','15.75','Basico','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');
INSERT INTO notas (id_nota,id_estudiante,id_actividad,id_materia,id_periodo,puntaje_obtenido,porcentaje,calificacion,observaciones,fecha_calificacion,created_at,updated_at) VALUES (221,195,29,7,1,'95.00','23.75','Superior','Buen trabajo','2026-01-11 20:24:09','2026-01-11 20:24:09','2026-01-11 20:24:09');

CREATE TABLE `observador` (
  `id_observacion` int NOT NULL AUTO_INCREMENT,
  `id_estudiante` int NOT NULL,
  `id_usuario` int NOT NULL,
  `tipo_observacion` enum('Positiva','Negativa','Neutra') COLLATE utf8mb4_unicode_ci DEFAULT 'Neutra',
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_observacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_observacion`),
  KEY `idx_id_estudiante` (`id_estudiante`),
  KEY `idx_id_usuario` (`id_usuario`),
  CONSTRAINT `fk_observador_estudiante` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`id_estudiante`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_observador_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `periodos` (
  `id_periodo` int NOT NULL AUTO_INCREMENT,
  `numero_periodo` int NOT NULL,
  `nombre_periodo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `estado` enum('Abierto','Cerrado','Cancelado') COLLATE utf8mb4_unicode_ci DEFAULT 'Abierto',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_periodo`),
  UNIQUE KEY `uk_numero_periodo` (`numero_periodo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO periodos (id_periodo,numero_periodo,nombre_periodo,fecha_inicio,fecha_fin,estado,created_at,updated_at) VALUES (1,1,'Período 1','2025-01-20','2025-03-31','Abierto',NULL,NULL);
INSERT INTO periodos (id_periodo,numero_periodo,nombre_periodo,fecha_inicio,fecha_fin,estado,created_at,updated_at) VALUES (2,2,'Período 2','2025-04-01','2025-06-30','Abierto',NULL,NULL);
INSERT INTO periodos (id_periodo,numero_periodo,nombre_periodo,fecha_inicio,fecha_fin,estado,created_at,updated_at) VALUES (3,3,'Período 3','2025-07-01','2025-09-30','Abierto',NULL,NULL);
INSERT INTO periodos (id_periodo,numero_periodo,nombre_periodo,fecha_inicio,fecha_fin,estado,created_at,updated_at) VALUES (4,4,'Período 4','2025-10-01','2025-11-30','Abierto',NULL,NULL);

CREATE TABLE `permisos` (
  `id_permiso` int NOT NULL AUTO_INCREMENT,
  `id_rol` int NOT NULL,
  `nombre_permiso` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `modulo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Módulo al que pertenece (Ej: estudiantes, notas, etc)',
  `accion` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Acción permitida (Ej: crear, leer, actualizar, eliminar)',
  `permitido` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_permiso`),
  UNIQUE KEY `uk_rol_permiso` (`id_rol`,`nombre_permiso`),
  KEY `idx_id_rol` (`id_rol`),
  KEY `idx_modulo` (`modulo`),
  KEY `idx_accion` (`accion`),
  CONSTRAINT `fk_permisos_rol` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (1,1,'gestionar_usuarios','Crear, editar, eliminar usuarios','usuarios','CRUD',1,'2026-01-07 13:40:12','2026-01-07 13:40:12');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (2,1,'gestionar_roles','Gestionar roles y asignaciones','roles','CRUD',1,'2026-01-07 13:40:12','2026-01-07 13:40:12');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (3,1,'gestionar_permisos','Configurar permisos por rol','permisos','CRUD',1,'2026-01-07 13:40:12','2026-01-07 13:40:12');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (4,1,'ver_reportes','Acceder a reportes del sistema','reportes','READ',1,'2026-01-07 13:40:12','2026-01-07 13:40:12');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (5,1,'exportar_datos','Exportar datos de la base de datos','datos','EXPORT',1,'2026-01-07 13:40:12','2026-01-07 13:40:12');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (6,1,'auditoría','Ver logs de auditoría','auditoria','READ',1,'2026-01-07 13:40:12','2026-01-07 13:40:12');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (7,2,'ver_estudiantes','Ver información de estudiantes','estudiantes','READ',1,'2026-01-07 13:40:12','2026-01-07 13:40:12');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (8,2,'ver_calificaciones','Ver calificaciones y notas','notas','READ',1,'2026-01-07 13:40:12','2026-01-07 13:40:12');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (9,2,'gestionar_periodos','Crear y gestionar períodos académicos','periodos','CRUD',1,'2026-01-07 13:40:12','2026-01-07 13:40:12');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (10,2,'ver_reportes','Acceder a reportes académicos','reportes','READ',1,'2026-01-07 13:40:12','2026-01-07 13:40:12');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (11,2,'comunicados','Enviar comunicados','comunicados','CREATE',1,'2026-01-07 13:40:12','2026-01-07 13:40:12');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (16,4,'crear_actividades','Crear tareas y actividades','actividades','CREATE',1,'2026-01-07 13:40:12','2026-01-07 13:40:12');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (17,4,'calificar','Calificar actividades','notas','CREATE',1,'2026-01-07 13:40:12','2026-01-07 13:40:12');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (18,4,'ver_asistencia','Ver registro de asistencia','asistencia','READ',1,'2026-01-07 13:40:12','2026-01-07 13:40:12');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (19,4,'registrar_asistencia','Registrar asistencia','asistencia','CREATE',1,'2026-01-07 13:40:12','2026-01-07 13:40:12');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (20,4,'crear_observaciones','Crear observaciones de estudiantes','observador','CREATE',1,'2026-01-07 13:40:12','2026-01-07 13:40:12');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (30,6,'crear_planilla','Crear nuevas planillas de calificación','planillas','crear',1,'2026-01-07 20:54:53','2026-01-07 20:54:53');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (31,6,'editar_planilla','Editar planillas de calificación existentes','planillas','editar',1,'2026-01-07 20:54:53','2026-01-07 20:54:53');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (32,6,'borrar_planilla','Eliminar planillas de calificación','planillas','borrar',1,'2026-01-07 20:54:53','2026-01-07 20:54:53');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (33,1,'crear_planilla','Crear nuevas planillas de calificación','planillas','crear',1,'2026-01-07 20:55:05','2026-01-07 20:55:05');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (34,2,'crear_planilla','Crear nuevas planillas de calificación','planillas','crear',1,'2026-01-07 20:55:05','2026-01-07 20:55:05');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (35,4,'crear_planilla','Crear nuevas planillas de calificación','planillas','crear',1,'2026-01-07 20:55:05','2026-01-07 20:55:05');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (36,1,'editar_planilla','Editar planillas de calificación existentes','planillas','editar',1,'2026-01-07 20:55:05','2026-01-07 20:55:05');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (37,2,'editar_planilla','Editar planillas de calificación existentes','planillas','editar',1,'2026-01-07 20:55:05','2026-01-07 20:55:05');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (38,4,'editar_planilla','Editar planillas de calificación existentes','planillas','editar',1,'2026-01-07 20:55:05','2026-01-07 20:55:05');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (39,1,'borrar_planilla','Eliminar planillas de calificación','planillas','borrar',1,'2026-01-07 20:55:05','2026-01-07 20:55:05');
INSERT INTO permisos (id_permiso,id_rol,nombre_permiso,descripcion,modulo,accion,permitido,created_at,updated_at) VALUES (40,2,'borrar_planilla','Eliminar planillas de calificación','planillas','borrar',1,'2026-01-07 20:55:05','2026-01-07 20:55:05');

CREATE TABLE `plantillas_docente` (
  `id_plantilla` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `nombre_plantilla` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `criterios_count` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ruta_archivo` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Ruta del archivo Excel almacenado',
  `tamaño_archivo` int DEFAULT '0' COMMENT 'Tamaño del archivo en bytes',
  `id_materia` int DEFAULT NULL COMMENT 'ID de la materia asociada',
  `id_periodo` int DEFAULT NULL COMMENT 'ID del período académico asociado',
  PRIMARY KEY (`id_plantilla`),
  KEY `idx_id_usuario` (`id_usuario`),
  KEY `idx_materia` (`id_materia`),
  KEY `idx_periodo` (`id_periodo`),
  KEY `idx_ruta_archivo` (`ruta_archivo`),
  CONSTRAINT `fk_plantillas_materia` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_plantillas_periodo` FOREIGN KEY (`id_periodo`) REFERENCES `periodos` (`id_periodo`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_plantillas_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO plantillas_docente (id_plantilla,id_usuario,nombre_plantilla,descripcion,criterios_count,created_at,updated_at,ruta_archivo,tamaño_archivo,id_materia,id_periodo) VALUES (2,14,'Plantilla Física 10°','Evaluación período académico Física',4,'2026-01-11 20:09:42','2026-01-11 20:09:42',NULL,0,14,1);
INSERT INTO plantillas_docente (id_plantilla,id_usuario,nombre_plantilla,descripcion,criterios_count,created_at,updated_at,ruta_archivo,tamaño_archivo,id_materia,id_periodo) VALUES (3,14,'Plantilla Química 10°','Evaluación período académico Química',4,'2026-01-11 20:09:42','2026-01-11 20:09:42',NULL,0,12,1);
INSERT INTO plantillas_docente (id_plantilla,id_usuario,nombre_plantilla,descripcion,criterios_count,created_at,updated_at,ruta_archivo,tamaño_archivo,id_materia,id_periodo) VALUES (4,14,'Plantilla Estadística 11°','Evaluación período académico Estadística',4,'2026-01-11 20:09:42','2026-01-11 20:09:42',NULL,0,16,1);
INSERT INTO plantillas_docente (id_plantilla,id_usuario,nombre_plantilla,descripcion,criterios_count,created_at,updated_at,ruta_archivo,tamaño_archivo,id_materia,id_periodo) VALUES (5,14,'Plantilla Inglés','Evaluación período académico Inglés',4,'2026-01-11 20:09:42','2026-01-11 20:09:42',NULL,0,7,1);

CREATE TABLE `reportes_inasistencias` (
  `id_reporte_inasistencia` int NOT NULL AUTO_INCREMENT,
  `id_estudiante` int NOT NULL,
  `id_materia` int NOT NULL,
  `id_periodo` int NOT NULL,
  `total_inasistencias` int NOT NULL DEFAULT '0',
  `inasistencias_sin_justificar` int NOT NULL DEFAULT '0',
  `inasistencias_justificadas` int NOT NULL DEFAULT '0',
  `porcentaje_inasistencia` decimal(5,2) DEFAULT '0.00',
  `es_critica` tinyint(1) DEFAULT '0' COMMENT 'Si supera el 20% de inasistencias',
  `estado_reporte` enum('abierto','en_atencion','resuelto','cerrado') COLLATE utf8mb4_unicode_ci DEFAULT 'abierto',
  `acciones_tomadas` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Registro de acciones (notificaciones, sanciones, etc)',
  `fecha_reporte` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_reporte_inasistencia`),
  KEY `idx_estudiante` (`id_estudiante`),
  KEY `idx_periodo` (`id_periodo`),
  KEY `idx_critica` (`es_critica`),
  KEY `idx_estado_reporte` (`estado_reporte`),
  KEY `fk_reportes_materia` (`id_materia`),
  CONSTRAINT `fk_reportes_estudiante` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`id_estudiante`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_reportes_materia` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_reportes_periodo` FOREIGN KEY (`id_periodo`) REFERENCES `periodos` (`id_periodo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Reportes de inasistencias críticas para seguimiento';

CREATE TABLE `roles` (
  `id_rol` int NOT NULL AUTO_INCREMENT,
  `nombre_rol` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `permisos` json DEFAULT NULL COMMENT 'Permisos específicos del rol en formato JSON',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_rol`),
  UNIQUE KEY `uk_nombre_rol` (`nombre_rol`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO roles (id_rol,nombre_rol,descripcion,permisos,created_at,updated_at) VALUES (1,'Rector','Administrador de la institución educativa','{"auditoría": true, "documentos": true, "comunicados": true, "ver_reportes": true, "exportar_datos": true, "gestionar_datos": true, "gestionar_roles": true, "gestionar_usuarios": true}','2025-10-30 22:42:38','2025-10-30 22:42:38');
INSERT INTO roles (id_rol,nombre_rol,descripcion,permisos,created_at,updated_at) VALUES (2,'Coordinador','Coordinador académico de grados/áreas','{"comunicados": true, "asignaciones": true, "ver_reportes": true, "ver_estudiantes": true, "gestionar_periodos": true, "ver_calificaciones": true}','2025-10-30 22:42:38','2025-10-30 22:42:38');
INSERT INTO roles (id_rol,nombre_rol,descripcion,permisos,created_at,updated_at) VALUES (4,'Profesor','Docente que imparte asignaturas','{"calificar": true, "crear_notas": true, "observaciones": true, "ver_asistencia": true, "crear_actividades": true, "ver_estudiantes_asignados": true}','2025-10-30 22:42:38','2025-10-30 22:42:38');
INSERT INTO roles (id_rol,nombre_rol,descripcion,permisos,created_at,updated_at) VALUES (6,'server_admin','Administrador del Sistema',NULL,'2026-01-07 14:13:25','2026-01-07 14:13:25');

CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `documento` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contrasena_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_rol` int NOT NULL,
  `is_activo` tinyint(1) DEFAULT '1',
  `ultimo_acceso` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `uk_documento` (`documento`),
  UNIQUE KEY `uk_correo` (`correo`),
  KEY `idx_id_rol` (`id_rol`),
  KEY `idx_is_activo` (`is_activo`),
  CONSTRAINT `fk_usuarios_rol` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO usuarios (id_usuario,documento,nombre,apellido,correo,contrasena_hash,id_rol,is_activo,ultimo_acceso,created_at,updated_at) VALUES (12,'121221221','larry','janpier','larryjanpier@gmail.com','$2b$12$hs9.EBAh9g67/YIw5jQIeOIZhgONiP6Gg3WosDX0LMjBL42turbdK',6,1,NULL,'2026-01-07 16:10:58','2026-01-14 17:21:07');
INSERT INTO usuarios (id_usuario,documento,nombre,apellido,correo,contrasena_hash,id_rol,is_activo,ultimo_acceso,created_at,updated_at) VALUES (13,'12312313','Larry Jan Pierr','Murcia Lozano','langostamutante@gmail.com','$2b$12$hs9.EBAh9g67/YIw5jQIeOIZhgONiP6Gg3WosDX0LMjBL42turbdK',1,1,NULL,'2026-01-07 18:28:37','2026-01-07 18:28:37');
INSERT INTO usuarios (id_usuario,documento,nombre,apellido,correo,contrasena_hash,id_rol,is_activo,ultimo_acceso,created_at,updated_at) VALUES (14,'123123123','larry','aaaaaa','jakyovonkiroskavi@gmail.com','$2b$12$hs9.EBAh9g67/YIw5jQIeOIZhgONiP6Gg3WosDX0LMjBL42turbdK',4,1,NULL,'2026-01-07 18:41:53','2026-02-02 17:06:33');
INSERT INTO usuarios (id_usuario,documento,nombre,apellido,correo,contrasena_hash,id_rol,is_activo,ultimo_acceso,created_at,updated_at) VALUES (15,'1111','Larry','murcia','larryjanpierr@gmail.com','$2b$12$hs9.EBAh9g67/YIw5jQIeOIZhgONiP6Gg3WosDX0LMjBL42turbdK',2,1,NULL,'2026-01-07 19:01:59','2026-01-11 20:59:02');
INSERT INTO usuarios (id_usuario,documento,nombre,apellido,correo,contrasena_hash,id_rol,is_activo,ultimo_acceso,created_at,updated_at) VALUES (22,'a','a','a','d@gmail.com','$2b$12$hs9.EBAh9g67/YIw5jQIeOIZhgONiP6Gg3WosDX0LMjBL42turbdK',4,1,NULL,'2026-01-11 22:16:12','2026-01-11 22:16:12');
INSERT INTO usuarios (id_usuario,documento,nombre,apellido,correo,contrasena_hash,id_rol,is_activo,ultimo_acceso,created_at,updated_at) VALUES (27,'111111','l','a','la@gmail.com','$2b$12$hs9.EBAh9g67/YIw5jQIeOIZhgONiP6Gg3WosDX0LMjBL42turbdK',4,1,NULL,'2026-01-22 16:05:44','2026-01-22 16:05:44');

SET FOREIGN_KEY_CHECKS=1;
