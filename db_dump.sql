-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: anexo_de_datos
-- ------------------------------------------------------
-- Server version	8.4.4

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `anexo_de_datos`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `anexo_de_datos` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `anexo_de_datos`;

--
-- Table structure for table `actividades`
--

DROP TABLE IF EXISTS `actividades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actividades` (
  `id_actividad` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_grupo` int NOT NULL,
  `id_materia` int NOT NULL,
  `nombre_actividad` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `tipo_actividad` enum('Tarea','Quiz','Proyecto','Evaluación','Clase') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Tarea',
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `fecha_vencimiento` datetime DEFAULT NULL,
  `puntaje_maximo` decimal(5,2) DEFAULT '100.00',
  `ponderacion` decimal(5,2) DEFAULT '10.00' COMMENT 'Peso porcentual de la actividad en la nota final',
  `estado` enum('Abierta','Cerrada','Calificada') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Abierta',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_actividad`),
  KEY `idx_id_usuario` (`id_usuario`),
  KEY `idx_id_grupo` (`id_grupo`),
  KEY `idx_id_materia` (`id_materia`),
  CONSTRAINT `fk_actividades_grupo` FOREIGN KEY (`id_grupo`) REFERENCES `grupos` (`id_grupo`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_actividades_materia` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_actividades_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividades`
--

LOCK TABLES `actividades` WRITE;
/*!40000 ALTER TABLE `actividades` DISABLE KEYS */;
INSERT INTO `actividades` VALUES (7,14,1,12,'Laboratorio 1 - Química','Práctica de laboratorio','Proyecto','2026-01-11 20:10:11',NULL,100.00,20.00,'Abierta','2026-01-12 01:10:11','2026-01-12 01:10:11'),(8,14,4,16,'Taller Estadística','Ejercicios de probabilidad','Tarea','2026-01-11 20:10:11',NULL,100.00,15.00,'Abierta','2026-01-12 01:10:11','2026-01-12 01:10:11'),(9,14,17,8,'Proyecto Excel','Manejo básico de hojas de cálculo','Proyecto','2026-01-11 20:10:11',NULL,100.00,30.00,'Abierta','2026-01-12 01:10:11','2026-01-12 01:10:11'),(10,14,21,21,'Tarea 1 - Ecuaciones','Resolución de ecuaciones lineales','Tarea','2026-01-11 20:17:30',NULL,100.00,10.00,'Abierta','2026-01-12 01:17:30','2026-01-12 01:17:30'),(11,14,21,21,'Quiz 1 - Matemáticas','Evaluación operaciones básicas','Quiz','2026-01-11 20:17:30',NULL,50.00,15.00,'Abierta','2026-01-12 01:17:30','2026-01-12 01:17:30'),(12,14,21,23,'Laboratorio - Célula','Observación microscópica de células','Proyecto','2026-01-11 20:17:30',NULL,100.00,20.00,'Abierta','2026-01-12 01:17:30','2026-01-12 01:17:30'),(13,14,23,21,'Tarea 1 - Funciones','Ejercicios de funciones lineales','Tarea','2026-01-11 20:17:30',NULL,100.00,10.00,'Abierta','2026-01-12 01:17:30','2026-01-12 01:17:30'),(14,14,23,21,'Parcial 1 - Matemáticas','Examen parcial primer corte','Evaluación','2026-01-11 20:17:30',NULL,100.00,25.00,'Abierta','2026-01-12 01:17:30','2026-01-12 01:17:30'),(15,14,23,26,'Taller Triángulos','Propiedades de triángulos','Tarea','2026-01-11 20:17:30',NULL,100.00,15.00,'Abierta','2026-01-12 01:17:30','2026-01-12 01:17:30'),(16,14,17,21,'Tarea Numeros','Operaciones','Tarea','2026-01-11 20:23:41',NULL,100.00,10.00,'Abierta','2026-01-12 01:23:41','2026-01-12 01:23:41'),(17,14,17,23,'Quiz Ecosistemas',NULL,'Quiz','2026-01-11 20:23:41','2026-04-03 00:00:00',5.00,15.00,'Abierta','2026-01-12 01:23:41','2026-04-03 00:37:46'),(18,14,18,21,'Tarea Fracciones','Operaciones','Tarea','2026-01-11 20:23:41',NULL,100.00,10.00,'Abierta','2026-01-12 01:23:41','2026-01-12 01:23:41'),(19,14,18,22,'Ensayo Narrativo','Cuento corto','Tarea','2026-01-11 20:23:41',NULL,100.00,20.00,'Abierta','2026-01-12 01:23:41','2026-01-12 01:23:41'),(20,14,19,21,'Parcial Algebra','Expresiones','Evaluación','2026-01-11 20:23:41',NULL,100.00,25.00,'Abierta','2026-01-12 01:23:41','2026-01-12 01:23:41'),(21,14,19,8,'Proyecto Excel','Hoja calculo','Proyecto','2026-01-11 20:23:41',NULL,100.00,30.00,'Abierta','2026-01-12 01:23:41','2026-01-12 01:23:41'),(22,14,20,21,'Tarea Ecuaciones','Resolver','Tarea','2026-01-11 20:23:41',NULL,100.00,10.00,'Abierta','2026-01-12 01:23:41','2026-01-12 01:23:41'),(23,14,20,23,'Lab Celula','Microscopio','Proyecto','2026-01-11 20:23:41',NULL,100.00,25.00,'Abierta','2026-01-12 01:23:41','2026-01-12 01:23:41'),(25,14,3,12,'Lab Reacciones','Quimica','Proyecto','2026-01-11 20:23:41',NULL,100.00,25.00,'Abierta','2026-01-12 01:23:41','2026-01-12 01:23:41'),(26,14,5,16,'Parcial Estadistica','Probabilidad','Evaluación','2026-01-11 20:23:41',NULL,100.00,25.00,'Abierta','2026-01-12 01:23:41','2026-01-12 01:23:41'),(27,14,5,7,'Essay','Writing','Tarea','2026-01-11 20:23:41',NULL,100.00,20.00,'Abierta','2026-01-12 01:23:41','2026-01-12 01:23:41'),(28,14,6,16,'Proyecto','Analisis','Proyecto','2026-01-11 20:23:41',NULL,100.00,30.00,'Abierta','2026-01-12 01:23:41','2026-01-12 01:23:41'),(29,14,6,7,'Oral','Speaking','Evaluación','2026-01-11 20:23:41',NULL,100.00,25.00,'Abierta','2026-01-12 01:23:41','2026-01-12 01:23:41'),(32,12,17,27,'quiz 1',NULL,'Tarea','2026-04-02 20:04:18','2026-04-03 00:00:00',5.00,5.00,'Abierta','2026-04-03 01:04:18','2026-04-05 03:07:07'),(33,12,17,27,'Quiz',NULL,'Tarea','2026-04-02 20:04:18','2026-04-03 00:00:00',5.00,10.00,'Abierta','2026-04-03 01:04:18','2026-04-03 21:58:17'),(34,12,17,27,'tarea',NULL,'Tarea','2026-04-02 20:04:18','2026-04-03 00:00:00',5.00,5.00,'Abierta','2026-04-03 01:04:18','2026-04-05 02:59:49'),(35,12,17,27,'Quiz Polinomios',NULL,'Tarea','2026-04-02 20:04:18','2026-04-03 00:00:00',5.00,10.00,'Abierta','2026-04-03 01:04:18','2026-04-03 21:58:29'),(36,12,17,27,'quiz Ecuaciones e Inecuaciones',NULL,'Tarea','2026-04-02 20:04:18','2026-04-03 00:00:00',5.00,15.00,'Abierta','2026-04-03 01:04:18','2026-04-03 21:58:35'),(37,12,17,27,'Evaluacion Final',NULL,'Tarea','2026-04-02 20:04:18','2026-04-03 00:00:00',5.00,45.00,'Abierta','2026-04-03 01:04:18','2026-04-03 21:58:45'),(39,12,17,23,'1215',NULL,'Evaluación','2026-04-03 17:03:09','2026-04-03 00:00:00',5.00,14.00,'Abierta','2026-04-03 22:03:09','2026-04-03 22:03:09'),(40,12,17,27,'123123',NULL,'Evaluación','2026-04-03 23:07:16','2026-04-04 00:00:00',5.00,100.00,'Abierta','2026-04-04 04:07:16','2026-04-04 04:07:16'),(41,12,17,16,'quiz 1',NULL,'Quiz','2026-04-04 01:09:47','2026-04-04 00:00:00',5.00,100.00,'Abierta','2026-04-04 06:09:47','2026-04-04 06:09:47');
/*!40000 ALTER TABLE `actividades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actividades_periodo`
--

DROP TABLE IF EXISTS `actividades_periodo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actividades_periodo` (
  `id_actividad_periodo` int NOT NULL AUTO_INCREMENT,
  `id_actividad` int NOT NULL,
  `id_periodo` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_actividad_periodo`),
  UNIQUE KEY `uk_actividad_periodo` (`id_actividad`,`id_periodo`),
  KEY `idx_ap_periodo` (`id_periodo`),
  KEY `idx_ap_actividad` (`id_actividad`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividades_periodo`
--

LOCK TABLES `actividades_periodo` WRITE;
/*!40000 ALTER TABLE `actividades_periodo` DISABLE KEYS */;
INSERT INTO `actividades_periodo` VALUES (2,17,1,'2026-04-03 00:37:26'),(3,12,1,'2026-04-03 00:41:32'),(4,23,1,'2026-04-03 00:41:34'),(6,32,1,'2026-04-03 01:04:18'),(7,33,1,'2026-04-03 01:04:18'),(8,34,1,'2026-04-03 01:04:18'),(9,35,1,'2026-04-03 01:04:18'),(10,36,1,'2026-04-03 01:04:18'),(11,37,1,'2026-04-03 01:04:18'),(13,39,1,'2026-04-03 22:03:09'),(14,40,2,'2026-04-04 04:07:16'),(15,9,1,'2026-04-04 05:59:59'),(16,16,1,'2026-04-04 05:59:59'),(17,19,1,'2026-04-04 06:00:00'),(18,18,1,'2026-04-04 06:00:00'),(19,21,1,'2026-04-04 06:00:01'),(20,20,1,'2026-04-04 06:00:01'),(21,22,1,'2026-04-04 06:00:02'),(22,10,1,'2026-04-04 06:00:02'),(23,11,1,'2026-04-04 06:00:02'),(24,15,1,'2026-04-04 06:00:03'),(25,13,1,'2026-04-04 06:00:03'),(26,14,1,'2026-04-04 06:00:03'),(27,7,1,'2026-04-04 06:00:04'),(28,25,1,'2026-04-04 06:00:05'),(29,8,1,'2026-04-04 06:00:05'),(30,26,1,'2026-04-04 06:00:06'),(31,27,1,'2026-04-04 06:00:06'),(32,28,1,'2026-04-04 06:00:06'),(33,29,1,'2026-04-04 06:00:06'),(34,41,1,'2026-04-04 06:09:48');
/*!40000 ALTER TABLE `actividades_periodo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asignaciones_docente`
--

DROP TABLE IF EXISTS `asignaciones_docente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asignaciones_docente` (
  `id_asignacion` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_materia` int NOT NULL,
  `id_grado` int NOT NULL,
  `id_grupo` int NOT NULL,
  `año_lectivo` int DEFAULT '2025',
  `estado` enum('Activa','Inactiva','Suspendida') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Activa',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_asignacion`),
  UNIQUE KEY `uk_usuario_materia_grado_grupo` (`id_usuario`,`id_materia`,`id_grado`,`id_grupo`),
  KEY `idx_id_usuario` (`id_usuario`),
  KEY `idx_id_materia` (`id_materia`),
  KEY `idx_id_grado` (`id_grado`),
  KEY `fk_asignaciones_grupo` (`id_grupo`),
  CONSTRAINT `fk_asignaciones_grado` FOREIGN KEY (`id_grado`) REFERENCES `grados` (`id_grado`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_asignaciones_grupo` FOREIGN KEY (`id_grupo`) REFERENCES `grupos` (`id_grupo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_asignaciones_materia` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_asignaciones_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asignaciones_docente`
--

LOCK TABLES `asignaciones_docente` WRITE;
/*!40000 ALTER TABLE `asignaciones_docente` DISABLE KEYS */;
INSERT INTO `asignaciones_docente` VALUES (57,14,27,7,19,2026,'Inactiva','2026-03-02 02:00:24','2026-03-02 02:21:46'),(58,14,27,6,17,2026,'Activa','2026-03-02 02:21:55','2026-03-02 02:21:55'),(62,14,24,10,2,2026,'Activa','2026-03-02 02:43:43','2026-03-02 02:43:43'),(63,14,23,9,24,2026,'Activa','2026-03-02 02:52:40','2026-03-02 02:52:40'),(64,14,27,9,23,2026,'Activa','2026-03-03 02:14:50','2026-03-03 02:14:50'),(65,14,27,6,32,2026,'Activa','2026-03-04 02:45:00','2026-03-04 02:45:00'),(67,22,13,8,21,2026,'Activa','2026-03-04 05:48:37','2026-03-04 05:48:37'),(68,22,24,8,21,2026,'Activa','2026-03-04 05:48:37','2026-03-04 05:48:37'),(69,22,27,7,19,2026,'Inactiva','2026-03-04 05:48:37','2026-03-04 05:48:37'),(70,22,27,6,17,2026,'Inactiva','2026-03-04 05:48:37','2026-03-08 02:59:02'),(71,27,23,8,21,2026,'Activa','2026-03-04 05:48:55','2026-03-04 05:48:55'),(72,27,27,8,21,2026,'Activa','2026-03-04 05:48:55','2026-03-04 05:48:55'),(73,27,27,6,17,2026,'Inactiva','2026-03-04 05:48:55','2026-03-08 02:58:52'),(74,27,27,10,1,2026,'Activa','2026-03-04 05:48:55','2026-03-04 05:48:55'),(75,27,27,11,4,2026,'Activa','2026-03-04 05:48:55','2026-03-04 05:48:55'),(76,27,27,9,23,2026,'Activa','2026-03-04 05:48:55','2026-03-04 05:48:55'),(77,22,34,6,17,2026,'Activa','2026-03-07 22:32:35','2026-03-07 22:32:35'),(78,27,34,7,19,2026,'Activa','2026-03-07 22:32:40','2026-03-07 22:32:40'),(79,14,34,6,18,2026,'Activa','2026-03-07 22:32:45','2026-03-07 22:32:45'),(80,27,34,7,20,2026,'Activa','2026-03-07 22:32:50','2026-03-07 22:32:50'),(81,29,34,6,32,2026,'Activa','2026-03-07 22:32:55','2026-03-07 22:32:55'),(82,29,34,8,21,2026,'Activa','2026-03-07 22:33:01','2026-03-07 22:33:01'),(83,22,34,8,22,2026,'Activa','2026-03-07 22:33:08','2026-03-07 22:33:08'),(84,27,34,9,23,2026,'Activa','2026-03-08 01:59:15','2026-03-08 01:59:15'),(85,14,34,9,24,2026,'Activa','2026-03-08 01:59:20','2026-03-08 01:59:20'),(86,22,34,10,1,2026,'Activa','2026-03-08 01:59:26','2026-03-08 01:59:26'),(87,27,34,10,2,2026,'Activa','2026-03-08 01:59:32','2026-03-08 01:59:32'),(88,29,34,10,3,2026,'Activa','2026-03-08 01:59:36','2026-03-08 01:59:36'),(89,22,34,11,4,2026,'Activa','2026-03-08 02:00:05','2026-03-08 02:00:05'),(90,14,34,11,5,2026,'Activa','2026-03-08 02:00:11','2026-03-08 02:00:11'),(91,27,34,11,6,2026,'Activa','2026-03-08 02:00:16','2026-03-08 02:00:16'),(92,27,13,8,22,2026,'Activa','2026-03-08 02:00:33','2026-03-08 02:00:33'),(93,22,13,6,17,2026,'Activa','2026-03-08 02:00:36','2026-03-08 02:00:36'),(94,27,13,7,19,2026,'Activa','2026-03-08 02:00:40','2026-03-08 02:00:40'),(95,22,13,7,20,2026,'Activa','2026-03-08 02:00:51','2026-03-08 02:00:51'),(96,27,13,6,18,2026,'Activa','2026-03-08 02:01:04','2026-03-08 02:01:04'),(97,29,13,6,32,2026,'Activa','2026-03-08 02:01:08','2026-03-08 02:01:08'),(98,22,13,9,23,2026,'Activa','2026-03-08 02:01:17','2026-03-08 02:01:17'),(99,14,13,9,24,2026,'Activa','2026-03-08 02:01:21','2026-03-08 02:01:21'),(100,27,13,10,2,2026,'Activa','2026-03-08 02:01:26','2026-03-08 02:01:26'),(101,27,13,10,1,2026,'Activa','2026-03-08 02:01:30','2026-03-08 02:01:30'),(102,29,13,10,3,2026,'Activa','2026-03-08 02:01:35','2026-03-08 02:01:35'),(103,22,13,11,6,2026,'Activa','2026-03-08 02:01:41','2026-03-08 02:01:41'),(104,22,13,11,4,2026,'Activa','2026-03-08 02:01:45','2026-03-08 02:01:45'),(105,27,13,11,5,2026,'Activa','2026-03-08 02:01:49','2026-03-08 02:01:49'),(106,27,23,6,17,2026,'Activa','2026-03-08 02:02:00','2026-03-08 02:02:00'),(107,14,23,6,18,2026,'Activa','2026-03-08 02:02:04','2026-03-08 02:02:04'),(108,14,23,6,32,2026,'Activa','2026-03-08 02:02:08','2026-03-08 02:02:08'),(109,22,23,7,19,2026,'Activa','2026-03-08 02:02:15','2026-03-08 02:02:15'),(110,22,23,7,20,2026,'Activa','2026-03-08 02:02:19','2026-03-08 02:02:19'),(111,14,23,8,22,2026,'Activa','2026-03-08 02:02:31','2026-03-08 02:02:31'),(112,29,23,9,23,2026,'Activa','2026-03-08 02:02:40','2026-03-08 02:02:40'),(113,14,23,10,1,2026,'Activa','2026-03-08 02:02:45','2026-03-08 02:02:45'),(114,27,23,10,2,2026,'Activa','2026-03-08 02:02:54','2026-03-08 02:02:54'),(115,29,23,10,3,2026,'Activa','2026-03-08 02:02:59','2026-03-08 02:02:59'),(116,14,23,11,4,2026,'Activa','2026-03-08 02:03:07','2026-03-08 02:03:07'),(117,27,23,11,5,2026,'Activa','2026-03-08 02:03:12','2026-03-08 02:03:12'),(118,29,23,11,6,2026,'Activa','2026-03-08 02:03:16','2026-03-08 02:03:16'),(119,22,24,6,17,2026,'Activa','2026-03-08 02:39:14','2026-03-08 02:39:14'),(120,22,24,6,18,2026,'Activa','2026-03-08 02:39:19','2026-03-08 02:39:19'),(121,14,24,6,32,2026,'Activa','2026-03-08 02:39:26','2026-03-08 02:39:26'),(122,27,24,7,19,2026,'Activa','2026-03-08 02:39:30','2026-03-08 02:39:30'),(123,14,24,7,20,2026,'Activa','2026-03-08 02:39:35','2026-03-08 02:39:35'),(124,22,24,8,22,2026,'Activa','2026-03-08 02:39:42','2026-03-08 02:39:42'),(125,27,24,9,23,2026,'Activa','2026-03-08 02:39:46','2026-03-08 02:39:46'),(126,29,24,9,24,2026,'Activa','2026-03-08 02:39:50','2026-03-08 02:39:50'),(127,27,24,10,1,2026,'Activa','2026-03-08 02:39:55','2026-03-08 02:39:55'),(128,14,24,10,3,2026,'Activa','2026-03-08 02:39:59','2026-03-08 02:39:59'),(129,22,24,11,4,2026,'Activa','2026-03-08 02:40:22','2026-03-08 02:40:22'),(130,14,24,11,5,2026,'Activa','2026-03-08 02:40:26','2026-03-08 02:40:26'),(131,27,24,11,6,2026,'Activa','2026-03-08 02:40:30','2026-03-08 02:40:30'),(132,22,8,6,17,2026,'Inactiva','2026-03-08 02:46:18','2026-03-08 02:46:26'),(133,14,27,8,22,2026,'Activa','2026-03-08 02:59:25','2026-03-08 02:59:25'),(134,27,27,6,18,2026,'Activa','2026-03-08 02:59:45','2026-03-08 02:59:45'),(135,27,16,6,17,2026,'Inactiva','2026-04-04 06:07:36','2026-04-04 06:08:15'),(136,22,16,6,17,2026,'Activa','2026-04-04 06:08:20','2026-04-04 06:08:20'),(137,22,16,6,18,2026,'Activa','2026-04-04 06:08:44','2026-04-04 06:08:44'),(138,22,16,6,32,2026,'Activa','2026-04-04 06:08:50','2026-04-04 06:08:50'),(139,27,16,7,19,2026,'Activa','2026-04-08 23:06:24','2026-04-08 23:06:24');
/*!40000 ALTER TABLE `asignaciones_docente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asistencia`
--

DROP TABLE IF EXISTS `asistencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asistencia` (
  `id_asistencia` int NOT NULL AUTO_INCREMENT,
  `id_estudiante` int NOT NULL,
  `id_grupo` int NOT NULL,
  `id_periodo` int NOT NULL,
  `fecha_asistencia` date NOT NULL,
  `tipo_registro` enum('Día','Hora') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Día' COMMENT 'Especifica si el registro es diario o por hora de clase',
  `hora_inicio` time DEFAULT NULL COMMENT 'Hora de inicio de la clase (si es por hora)',
  `hora_fin` time DEFAULT NULL COMMENT 'Hora de fin de la clase (si es por hora)',
  `estado` enum('Presente','Ausente','Tardío','Justificado') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Presente',
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
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencia`
--

LOCK TABLES `asistencia` WRITE;
/*!40000 ALTER TABLE `asistencia` DISABLE KEYS */;
INSERT INTO `asistencia` VALUES (2,119,17,1,'2026-04-07','Día',NULL,NULL,'Ausente','','2026-04-07 01:14:19','2026-04-07 01:19:31'),(3,118,17,1,'2026-04-07','Día',NULL,NULL,'Ausente','adasd','2026-04-07 01:14:19','2026-04-07 01:19:31'),(4,117,17,1,'2026-04-07','Día',NULL,NULL,'Ausente','','2026-04-07 01:14:19','2026-04-07 01:19:31'),(5,205,17,1,'2026-04-07','Día',NULL,NULL,'Presente','','2026-04-07 01:14:19','2026-04-07 01:19:31'),(6,196,17,1,'2026-04-07','Día',NULL,NULL,'Ausente','','2026-04-07 01:14:19','2026-04-07 01:19:31'),(7,202,17,1,'2026-04-07','Día',NULL,NULL,'Tardío','','2026-04-07 01:14:19','2026-04-07 01:19:31'),(32,287,17,1,'2026-04-08','Día',NULL,NULL,'Ausente','','2026-04-08 13:09:13','2026-04-08 22:49:33'),(33,119,17,1,'2026-04-08','Día',NULL,NULL,'Ausente','','2026-04-08 13:09:13','2026-04-08 22:49:33'),(34,118,17,1,'2026-04-08','Día',NULL,NULL,'Presente','','2026-04-08 13:09:13','2026-04-08 22:49:33'),(35,117,17,1,'2026-04-08','Día',NULL,NULL,'Presente','','2026-04-08 13:09:13','2026-04-08 22:49:33'),(36,205,17,1,'2026-04-08','Día',NULL,NULL,'Presente','','2026-04-08 13:09:13','2026-04-08 22:49:33'),(37,196,17,1,'2026-04-08','Día',NULL,NULL,'Presente','','2026-04-08 13:09:13','2026-04-08 22:49:33'),(38,202,17,1,'2026-04-08','Día',NULL,NULL,'Presente','','2026-04-08 13:09:13','2026-04-08 22:49:33'),(46,287,17,1,'2026-04-09','Día',NULL,NULL,'Justificado','dsadsads','2026-04-09 15:14:11','2026-04-09 15:15:47'),(47,119,17,1,'2026-04-09','Día',NULL,NULL,'Ausente','','2026-04-09 15:14:11','2026-04-09 15:14:11'),(48,118,17,1,'2026-04-09','Día',NULL,NULL,'Ausente','','2026-04-09 15:14:11','2026-04-09 15:14:11'),(49,117,17,1,'2026-04-09','Día',NULL,NULL,'Ausente','','2026-04-09 15:14:11','2026-04-09 15:14:11'),(50,205,17,1,'2026-04-09','Día',NULL,NULL,'Ausente','','2026-04-09 15:14:11','2026-04-09 15:14:11'),(51,196,17,1,'2026-04-09','Día',NULL,NULL,'Ausente','','2026-04-09 15:14:11','2026-04-09 15:14:11'),(52,202,17,1,'2026-04-09','Día',NULL,NULL,'Ausente','','2026-04-09 15:14:11','2026-04-09 15:14:11');
/*!40000 ALTER TABLE `asistencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asistencias_diarias`
--

DROP TABLE IF EXISTS `asistencias_diarias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asistencias_diarias` (
  `id_asistencia_diaria` int NOT NULL AUTO_INCREMENT,
  `id_plantilla` int NOT NULL,
  `id_materia` int NOT NULL,
  `id_docente` int NOT NULL,
  `id_grupo` int NOT NULL,
  `fecha_registro` date NOT NULL,
  `hora_clase` time DEFAULT NULL COMMENT 'Hora de la clase registrada',
  `estado` enum('activa','cancelada','en_revision') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'activa',
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
  CONSTRAINT `fk_asistencias_diarias_plantillas_asistencias` FOREIGN KEY (`id_plantilla`) REFERENCES `plantillas_asistencias` (`id_plantilla`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla de control diario de asistencias por clase';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencias_diarias`
--

LOCK TABLES `asistencias_diarias` WRITE;
/*!40000 ALTER TABLE `asistencias_diarias` DISABLE KEYS */;
INSERT INTO `asistencias_diarias` VALUES (1,1,27,12,17,'2026-04-07',NULL,'activa','2026-04-07 01:14:19','2026-04-07 01:14:19'),(2,2,13,12,17,'2026-04-07',NULL,'activa','2026-04-07 01:17:11','2026-04-07 01:17:11'),(3,1,27,12,17,'2026-04-08',NULL,'activa','2026-04-08 13:09:13','2026-04-08 13:09:13'),(4,1,27,12,17,'2026-04-09',NULL,'activa','2026-04-09 15:14:11','2026-04-09 15:14:11');
/*!40000 ALTER TABLE `asistencias_diarias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asistencias_por_periodo`
--

DROP TABLE IF EXISTS `asistencias_por_periodo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
  `estado_asistencia` enum('excelente','bueno','regular','deficiente','critico') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'regular',
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
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Resumen de asistencias consolidadas por período académico';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencias_por_periodo`
--

LOCK TABLES `asistencias_por_periodo` WRITE;
/*!40000 ALTER TABLE `asistencias_por_periodo` DISABLE KEYS */;
INSERT INTO `asistencias_por_periodo` VALUES (1,119,27,1,0,1,0,1,3,0.00,'critico','2026-04-07 01:14:19','2026-04-09 15:14:11'),(2,118,27,1,1,0,0,1,3,33.33,'critico','2026-04-07 01:14:19','2026-04-09 15:14:11'),(3,117,27,1,1,1,0,1,3,33.33,'critico','2026-04-07 01:14:19','2026-04-09 15:14:11'),(4,205,27,1,1,1,0,1,3,33.33,'critico','2026-04-07 01:14:19','2026-04-09 15:14:11'),(5,196,27,1,1,1,0,1,3,33.33,'critico','2026-04-07 01:14:19','2026-04-09 15:14:11'),(6,202,27,1,1,1,0,1,3,33.33,'critico','2026-04-07 01:14:19','2026-04-09 15:14:11'),(13,119,13,1,0,1,0,0,1,0.00,'critico','2026-04-07 01:17:11','2026-04-07 01:17:11'),(14,118,13,1,0,0,0,0,1,0.00,'critico','2026-04-07 01:17:11','2026-04-07 01:19:30'),(15,117,13,1,0,1,0,0,1,0.00,'critico','2026-04-07 01:17:11','2026-04-07 01:17:11'),(16,205,13,1,1,0,0,0,1,100.00,'excelente','2026-04-07 01:17:11','2026-04-07 01:17:11'),(17,196,13,1,0,1,0,0,1,0.00,'critico','2026-04-07 01:17:11','2026-04-07 01:17:11'),(18,202,13,1,0,0,1,0,1,0.00,'critico','2026-04-07 01:17:11','2026-04-07 01:17:11'),(34,287,27,1,0,1,0,0,2,0.00,'critico','2026-04-08 13:09:13','2026-04-09 15:15:47');
/*!40000 ALTER TABLE `asistencias_por_periodo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auditoria_asistencias`
--

DROP TABLE IF EXISTS `auditoria_asistencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditoria_asistencias` (
  `id_auditoria` int NOT NULL AUTO_INCREMENT,
  `id_asistencia_diaria` int NOT NULL,
  `id_docente_registrador` int NOT NULL,
  `accion` enum('creada','modificada','cancelada','finalizada') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'creada',
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditoria_asistencias`
--

LOCK TABLES `auditoria_asistencias` WRITE;
/*!40000 ALTER TABLE `auditoria_asistencias` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditoria_asistencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `boletin_puestos`
--

DROP TABLE IF EXISTS `boletin_puestos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `boletin_puestos` (
  `id_boletin_puesto` int NOT NULL AUTO_INCREMENT,
  `id_estudiante` int NOT NULL,
  `id_grupo` int NOT NULL,
  `id_periodo` int NOT NULL,
  `es_definitiva` tinyint(1) DEFAULT '0',
  `promedio` decimal(5,2) DEFAULT NULL,
  `total_fallas` int DEFAULT '0',
  `puesto` int DEFAULT NULL,
  `fecha_generado` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_boletin_puesto`),
  UNIQUE KEY `uk_boletin_puesto` (`id_estudiante`,`id_grupo`,`id_periodo`,`es_definitiva`),
  KEY `idx_boletin_grupo` (`id_grupo`,`id_periodo`)
) ENGINE=InnoDB AUTO_INCREMENT=29265 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boletin_puestos`
--

LOCK TABLES `boletin_puestos` WRITE;
/*!40000 ALTER TABLE `boletin_puestos` DISABLE KEYS */;
INSERT INTO `boletin_puestos` VALUES (1,287,17,1,0,0.75,1,7,'2026-04-09 10:20:03'),(2,287,17,2,0,1.00,0,5,'2026-04-09 10:20:03'),(3,287,17,3,0,NULL,0,NULL,'2026-04-09 10:20:03'),(4,287,17,4,0,NULL,0,NULL,'2026-04-09 10:20:03'),(5,287,17,0,1,0.88,1,7,'2026-04-09 10:20:03'),(6,119,17,1,0,3.35,2,1,'2026-04-09 10:20:05'),(7,119,17,2,0,1.00,0,5,'2026-04-09 10:20:05'),(8,119,17,3,0,NULL,0,NULL,'2026-04-09 10:20:05'),(9,119,17,4,0,NULL,0,NULL,'2026-04-09 10:20:05'),(10,119,17,0,1,2.17,2,6,'2026-04-09 10:20:05'),(11,118,17,1,0,3.05,0,3,'2026-04-09 10:20:08'),(12,118,17,2,0,5.00,0,1,'2026-04-09 10:20:08'),(13,118,17,3,0,NULL,0,NULL,'2026-04-09 10:20:08'),(14,118,17,4,0,NULL,0,NULL,'2026-04-09 10:20:08'),(15,118,17,0,1,4.03,0,1,'2026-04-09 10:20:08'),(16,117,17,1,0,2.96,2,5,'2026-04-09 10:20:10'),(17,117,17,2,0,2.00,0,4,'2026-04-09 10:20:10'),(18,117,17,3,0,NULL,0,NULL,'2026-04-09 10:20:10'),(19,117,17,4,0,NULL,0,NULL,'2026-04-09 10:20:10'),(20,117,17,0,1,2.48,2,5,'2026-04-09 10:20:10'),(21,205,17,1,0,2.88,1,6,'2026-04-09 10:20:12'),(22,205,17,2,0,3.00,0,3,'2026-04-09 10:20:12'),(23,205,17,3,0,NULL,0,NULL,'2026-04-09 10:20:12'),(24,205,17,4,0,NULL,0,NULL,'2026-04-09 10:20:12'),(25,205,17,0,1,2.94,1,4,'2026-04-09 10:20:12'),(26,196,17,1,0,3.08,2,2,'2026-04-09 10:20:15'),(27,196,17,2,0,4.00,0,2,'2026-04-09 10:20:15'),(28,196,17,3,0,NULL,0,NULL,'2026-04-09 10:20:15'),(29,196,17,4,0,NULL,0,NULL,'2026-04-09 10:20:15'),(30,196,17,0,1,3.54,2,3,'2026-04-09 10:20:15'),(31,202,17,1,0,2.97,1,4,'2026-04-09 10:20:17'),(32,202,17,2,0,5.00,0,1,'2026-04-09 10:20:17'),(33,202,17,3,0,NULL,0,NULL,'2026-04-09 10:20:17'),(34,202,17,4,0,NULL,0,NULL,'2026-04-09 10:20:17'),(35,202,17,0,1,3.99,1,2,'2026-04-09 10:20:17'),(36,147,18,1,0,NULL,0,NULL,'2026-04-09 10:20:20'),(37,147,18,2,0,NULL,0,NULL,'2026-04-09 10:20:20'),(38,147,18,3,0,NULL,0,NULL,'2026-04-09 10:20:20'),(39,147,18,4,0,NULL,0,NULL,'2026-04-09 10:20:20'),(40,147,18,0,1,NULL,0,NULL,'2026-04-09 10:20:20'),(41,151,18,1,0,NULL,0,NULL,'2026-04-09 10:20:23'),(42,151,18,2,0,NULL,0,NULL,'2026-04-09 10:20:23'),(43,151,18,3,0,NULL,0,NULL,'2026-04-09 10:20:23'),(44,151,18,4,0,NULL,0,NULL,'2026-04-09 10:20:23'),(45,151,18,0,1,NULL,0,NULL,'2026-04-09 10:20:23'),(51,155,18,1,0,NULL,0,NULL,'2026-04-09 10:20:26'),(52,155,18,2,0,NULL,0,NULL,'2026-04-09 10:20:26'),(53,155,18,3,0,NULL,0,NULL,'2026-04-09 10:20:26'),(54,155,18,4,0,NULL,0,NULL,'2026-04-09 10:20:26'),(55,155,18,0,1,NULL,0,NULL,'2026-04-09 10:20:26'),(66,152,18,1,0,NULL,0,NULL,'2026-04-09 10:20:29'),(67,152,18,2,0,NULL,0,NULL,'2026-04-09 10:20:29'),(68,152,18,3,0,NULL,0,NULL,'2026-04-09 10:20:29'),(69,152,18,4,0,NULL,0,NULL,'2026-04-09 10:20:29'),(70,152,18,0,1,NULL,0,NULL,'2026-04-09 10:20:29'),(76,153,18,1,0,NULL,0,NULL,'2026-04-09 10:20:32'),(77,153,18,2,0,NULL,0,NULL,'2026-04-09 10:20:32'),(78,153,18,3,0,NULL,0,NULL,'2026-04-09 10:20:32'),(79,153,18,4,0,NULL,0,NULL,'2026-04-09 10:20:32'),(80,153,18,0,1,NULL,0,NULL,'2026-04-09 10:20:32'),(91,199,18,1,0,NULL,0,NULL,'2026-04-09 10:20:35'),(92,199,18,2,0,NULL,0,NULL,'2026-04-09 10:20:35'),(93,199,18,3,0,NULL,0,NULL,'2026-04-09 10:20:35'),(94,199,18,4,0,NULL,0,NULL,'2026-04-09 10:20:35'),(95,199,18,0,1,NULL,0,NULL,'2026-04-09 10:20:35'),(101,200,18,1,0,NULL,0,NULL,'2026-04-09 10:20:38'),(102,200,18,2,0,NULL,0,NULL,'2026-04-09 10:20:38'),(103,200,18,3,0,NULL,0,NULL,'2026-04-09 10:20:38'),(104,200,18,4,0,NULL,0,NULL,'2026-04-09 10:20:38'),(105,200,18,0,1,NULL,0,NULL,'2026-04-09 10:20:38'),(111,149,18,1,0,NULL,0,NULL,'2026-04-09 10:20:41'),(112,149,18,2,0,NULL,0,NULL,'2026-04-09 10:20:41'),(113,149,18,3,0,NULL,0,NULL,'2026-04-09 10:20:41'),(114,149,18,4,0,NULL,0,NULL,'2026-04-09 10:20:41'),(115,149,18,0,1,NULL,0,NULL,'2026-04-09 10:20:41'),(121,146,18,1,0,NULL,0,NULL,'2026-04-09 10:20:44'),(122,146,18,2,0,NULL,0,NULL,'2026-04-09 10:20:44'),(123,146,18,3,0,NULL,0,NULL,'2026-04-09 10:20:44'),(124,146,18,4,0,NULL,0,NULL,'2026-04-09 10:20:44'),(125,146,18,0,1,NULL,0,NULL,'2026-04-09 10:20:44'),(131,150,18,1,0,NULL,0,NULL,'2026-04-09 10:20:47'),(132,150,18,2,0,NULL,0,NULL,'2026-04-09 10:20:47'),(133,150,18,3,0,NULL,0,NULL,'2026-04-09 10:20:47'),(134,150,18,4,0,NULL,0,NULL,'2026-04-09 10:20:47'),(135,150,18,0,1,NULL,0,NULL,'2026-04-09 10:20:47'),(141,154,18,1,0,NULL,0,NULL,'2026-04-09 10:20:50'),(142,154,18,2,0,NULL,0,NULL,'2026-04-09 10:20:50'),(143,154,18,3,0,NULL,0,NULL,'2026-04-09 10:20:50'),(144,154,18,4,0,NULL,0,NULL,'2026-04-09 10:20:50'),(145,154,18,0,1,NULL,0,NULL,'2026-04-09 10:20:50'),(151,148,18,1,0,NULL,0,NULL,'2026-04-09 10:20:53'),(152,148,18,2,0,NULL,0,NULL,'2026-04-09 10:20:53'),(153,148,18,3,0,NULL,0,NULL,'2026-04-09 10:20:53'),(154,148,18,4,0,NULL,0,NULL,'2026-04-09 10:20:53'),(155,148,18,0,1,NULL,0,NULL,'2026-04-09 10:20:53'),(161,215,19,1,0,NULL,0,NULL,'2026-04-09 10:20:56'),(162,215,19,2,0,NULL,0,NULL,'2026-04-09 10:20:56'),(163,215,19,3,0,NULL,0,NULL,'2026-04-09 10:20:56'),(164,215,19,4,0,NULL,0,NULL,'2026-04-09 10:20:56'),(165,215,19,0,1,NULL,0,NULL,'2026-04-09 10:20:56'),(171,207,19,1,0,NULL,0,NULL,'2026-04-09 10:20:59'),(172,207,19,2,0,NULL,0,NULL,'2026-04-09 10:20:59'),(173,207,19,3,0,NULL,0,NULL,'2026-04-09 10:20:59'),(174,207,19,4,0,NULL,0,NULL,'2026-04-09 10:20:59'),(175,207,19,0,1,NULL,0,NULL,'2026-04-09 10:20:59'),(176,122,19,1,0,NULL,0,NULL,'2026-04-09 10:21:02'),(177,122,19,2,0,NULL,0,NULL,'2026-04-09 10:21:02'),(178,122,19,3,0,NULL,0,NULL,'2026-04-09 10:21:02'),(179,122,19,4,0,NULL,0,NULL,'2026-04-09 10:21:02'),(180,122,19,0,1,NULL,0,NULL,'2026-04-09 10:21:02'),(186,210,19,1,0,NULL,0,NULL,'2026-04-09 10:21:05'),(187,210,19,2,0,NULL,0,NULL,'2026-04-09 10:21:05'),(188,210,19,3,0,NULL,0,NULL,'2026-04-09 10:21:05'),(189,210,19,4,0,NULL,0,NULL,'2026-04-09 10:21:05'),(190,210,19,0,1,NULL,0,NULL,'2026-04-09 10:21:05'),(196,206,19,1,0,NULL,0,NULL,'2026-04-09 10:21:08'),(197,206,19,2,0,NULL,0,NULL,'2026-04-09 10:21:08'),(198,206,19,3,0,NULL,0,NULL,'2026-04-09 10:21:08'),(199,206,19,4,0,NULL,0,NULL,'2026-04-09 10:21:08'),(200,206,19,0,1,NULL,0,NULL,'2026-04-09 10:21:08'),(206,212,19,1,0,NULL,0,NULL,'2026-04-09 10:21:11'),(207,212,19,2,0,NULL,0,NULL,'2026-04-09 10:21:11'),(208,212,19,3,0,NULL,0,NULL,'2026-04-09 10:21:11'),(209,212,19,4,0,NULL,0,NULL,'2026-04-09 10:21:11'),(210,212,19,0,1,NULL,0,NULL,'2026-04-09 10:21:11'),(216,214,19,1,0,NULL,0,NULL,'2026-04-09 10:21:14'),(217,214,19,2,0,NULL,0,NULL,'2026-04-09 10:21:14'),(218,214,19,3,0,NULL,0,NULL,'2026-04-09 10:21:14'),(219,214,19,4,0,NULL,0,NULL,'2026-04-09 10:21:14'),(220,214,19,0,1,NULL,0,NULL,'2026-04-09 10:21:14'),(226,121,19,1,0,NULL,0,NULL,'2026-04-09 10:21:17'),(227,121,19,2,0,NULL,0,NULL,'2026-04-09 10:21:17'),(228,121,19,3,0,NULL,0,NULL,'2026-04-09 10:21:17'),(229,121,19,4,0,NULL,0,NULL,'2026-04-09 10:21:17'),(230,121,19,0,1,NULL,0,NULL,'2026-04-09 10:21:17'),(236,208,19,1,0,NULL,0,NULL,'2026-04-09 10:21:20'),(237,208,19,2,0,NULL,0,NULL,'2026-04-09 10:21:20'),(238,208,19,3,0,NULL,0,NULL,'2026-04-09 10:21:20'),(239,208,19,4,0,NULL,0,NULL,'2026-04-09 10:21:20'),(240,208,19,0,1,NULL,0,NULL,'2026-04-09 10:21:20'),(246,124,19,1,0,NULL,0,NULL,'2026-04-09 10:21:22'),(247,124,19,2,0,NULL,0,NULL,'2026-04-09 10:21:22'),(248,124,19,3,0,NULL,0,NULL,'2026-04-09 10:21:22'),(249,124,19,4,0,NULL,0,NULL,'2026-04-09 10:21:22'),(250,124,19,0,1,NULL,0,NULL,'2026-04-09 10:21:22'),(256,123,19,1,0,NULL,0,NULL,'2026-04-09 10:21:24'),(257,123,19,2,0,NULL,0,NULL,'2026-04-09 10:21:24'),(258,123,19,3,0,NULL,0,NULL,'2026-04-09 10:21:24'),(259,123,19,4,0,NULL,0,NULL,'2026-04-09 10:21:24'),(260,123,19,0,1,NULL,0,NULL,'2026-04-09 10:21:24'),(266,213,19,1,0,NULL,0,NULL,'2026-04-09 10:21:27'),(267,213,19,2,0,NULL,0,NULL,'2026-04-09 10:21:27'),(268,213,19,3,0,NULL,0,NULL,'2026-04-09 10:21:27'),(269,213,19,4,0,NULL,0,NULL,'2026-04-09 10:21:27'),(270,213,19,0,1,NULL,0,NULL,'2026-04-09 10:21:27'),(276,209,19,1,0,NULL,0,NULL,'2026-04-09 10:21:29'),(277,209,19,2,0,NULL,0,NULL,'2026-04-09 10:21:29'),(278,209,19,3,0,NULL,0,NULL,'2026-04-09 10:21:29'),(279,209,19,4,0,NULL,0,NULL,'2026-04-09 10:21:29'),(280,209,19,0,1,NULL,0,NULL,'2026-04-09 10:21:29'),(286,211,19,1,0,NULL,0,NULL,'2026-04-09 10:21:32'),(287,211,19,2,0,NULL,0,NULL,'2026-04-09 10:21:32'),(288,211,19,3,0,NULL,0,NULL,'2026-04-09 10:21:32'),(289,211,19,4,0,NULL,0,NULL,'2026-04-09 10:21:32'),(290,211,19,0,1,NULL,0,NULL,'2026-04-09 10:21:32'),(296,125,19,1,0,NULL,0,NULL,'2026-04-09 10:21:34'),(297,125,19,2,0,NULL,0,NULL,'2026-04-09 10:21:34'),(298,125,19,3,0,NULL,0,NULL,'2026-04-09 10:21:34'),(299,125,19,4,0,NULL,0,NULL,'2026-04-09 10:21:34'),(300,125,19,0,1,NULL,0,NULL,'2026-04-09 10:21:34'),(301,163,20,1,0,1.00,0,1,'2026-04-09 10:21:36'),(302,163,20,2,0,NULL,0,NULL,'2026-04-09 10:21:36'),(303,163,20,3,0,NULL,0,NULL,'2026-04-09 10:21:36'),(304,163,20,4,0,NULL,0,NULL,'2026-04-09 10:21:36'),(305,163,20,0,1,1.00,0,1,'2026-04-09 10:21:36'),(311,162,20,1,0,1.00,0,1,'2026-04-09 10:21:38'),(312,162,20,2,0,NULL,0,NULL,'2026-04-09 10:21:38'),(313,162,20,3,0,NULL,0,NULL,'2026-04-09 10:21:38'),(314,162,20,4,0,NULL,0,NULL,'2026-04-09 10:21:38'),(315,162,20,0,1,1.00,0,1,'2026-04-09 10:21:38'),(321,160,20,1,0,1.00,0,1,'2026-04-09 10:21:40'),(322,160,20,2,0,NULL,0,NULL,'2026-04-09 10:21:40'),(323,160,20,3,0,NULL,0,NULL,'2026-04-09 10:21:40'),(324,160,20,4,0,NULL,0,NULL,'2026-04-09 10:21:40'),(325,160,20,0,1,1.00,0,1,'2026-04-09 10:21:40'),(326,156,20,1,0,1.00,0,1,'2026-04-09 10:21:42'),(327,156,20,2,0,NULL,0,NULL,'2026-04-09 10:21:42'),(328,156,20,3,0,NULL,0,NULL,'2026-04-09 10:21:42'),(329,156,20,4,0,NULL,0,NULL,'2026-04-09 10:21:42'),(330,156,20,0,1,1.00,0,1,'2026-04-09 10:21:42'),(336,157,20,1,0,1.00,0,1,'2026-04-09 10:21:44'),(337,157,20,2,0,NULL,0,NULL,'2026-04-09 10:21:44'),(338,157,20,3,0,NULL,0,NULL,'2026-04-09 10:21:44'),(339,157,20,4,0,NULL,0,NULL,'2026-04-09 10:21:44'),(340,157,20,0,1,1.00,0,1,'2026-04-09 10:21:44'),(346,161,20,1,0,1.00,0,1,'2026-04-09 10:21:46'),(347,161,20,2,0,NULL,0,NULL,'2026-04-09 10:21:46'),(348,161,20,3,0,NULL,0,NULL,'2026-04-09 10:21:46'),(349,161,20,4,0,NULL,0,NULL,'2026-04-09 10:21:46'),(350,161,20,0,1,1.00,0,1,'2026-04-09 10:21:46'),(351,158,20,1,0,1.00,0,1,'2026-04-09 10:21:47'),(352,158,20,2,0,NULL,0,NULL,'2026-04-09 10:21:47'),(353,158,20,3,0,NULL,0,NULL,'2026-04-09 10:21:47'),(354,158,20,4,0,NULL,0,NULL,'2026-04-09 10:21:47'),(355,158,20,0,1,1.00,0,1,'2026-04-09 10:21:47'),(361,159,20,1,0,1.00,0,1,'2026-04-09 10:21:49'),(362,159,20,2,0,NULL,0,NULL,'2026-04-09 10:21:49'),(363,159,20,3,0,NULL,0,NULL,'2026-04-09 10:21:49'),(364,159,20,4,0,NULL,0,NULL,'2026-04-09 10:21:49'),(365,159,20,0,1,1.00,0,1,'2026-04-09 10:21:49'),(371,165,20,1,0,1.00,0,1,'2026-04-09 10:21:51'),(372,165,20,2,0,NULL,0,NULL,'2026-04-09 10:21:51'),(373,165,20,3,0,NULL,0,NULL,'2026-04-09 10:21:51'),(374,165,20,4,0,NULL,0,NULL,'2026-04-09 10:21:51'),(375,165,20,0,1,1.00,0,1,'2026-04-09 10:21:51'),(381,164,20,1,0,1.00,0,1,'2026-04-09 10:21:53'),(382,164,20,2,0,NULL,0,NULL,'2026-04-09 10:21:53'),(383,164,20,3,0,NULL,0,NULL,'2026-04-09 10:21:53'),(384,164,20,4,0,NULL,0,NULL,'2026-04-09 10:21:53'),(385,164,20,0,1,1.00,0,1,'2026-04-09 10:21:53'),(391,126,21,1,0,1.00,0,1,'2026-04-09 10:21:56'),(392,126,21,2,0,NULL,0,NULL,'2026-04-09 10:21:56'),(393,126,21,3,0,NULL,0,NULL,'2026-04-09 10:21:56'),(394,126,21,4,0,NULL,0,NULL,'2026-04-09 10:21:56'),(395,126,21,0,1,1.00,0,1,'2026-04-09 10:21:56'),(401,127,21,1,0,1.00,0,1,'2026-04-09 10:21:58'),(402,127,21,2,0,NULL,0,NULL,'2026-04-09 10:21:58'),(403,127,21,3,0,NULL,0,NULL,'2026-04-09 10:21:58'),(404,127,21,4,0,NULL,0,NULL,'2026-04-09 10:21:58'),(405,127,21,0,1,1.00,0,1,'2026-04-09 10:21:58'),(416,128,21,1,0,1.00,0,1,'2026-04-09 10:22:01'),(417,128,21,2,0,NULL,0,NULL,'2026-04-09 10:22:01'),(418,128,21,3,0,NULL,0,NULL,'2026-04-09 10:22:01'),(419,128,21,4,0,NULL,0,NULL,'2026-04-09 10:22:01'),(420,128,21,0,1,1.00,0,1,'2026-04-09 10:22:01'),(426,223,21,1,0,1.00,0,1,'2026-04-09 10:22:03'),(427,223,21,2,0,NULL,0,NULL,'2026-04-09 10:22:03'),(428,223,21,3,0,NULL,0,NULL,'2026-04-09 10:22:03'),(429,223,21,4,0,NULL,0,NULL,'2026-04-09 10:22:03'),(430,223,21,0,1,1.00,0,1,'2026-04-09 10:22:03'),(441,216,21,1,0,1.00,0,1,'2026-04-09 10:22:05'),(442,216,21,2,0,NULL,0,NULL,'2026-04-09 10:22:05'),(443,216,21,3,0,NULL,0,NULL,'2026-04-09 10:22:05'),(444,216,21,4,0,NULL,0,NULL,'2026-04-09 10:22:05'),(445,216,21,0,1,1.00,0,1,'2026-04-09 10:22:05'),(456,224,21,1,0,1.00,0,1,'2026-04-09 10:22:08'),(457,224,21,2,0,NULL,0,NULL,'2026-04-09 10:22:08'),(458,224,21,3,0,NULL,0,NULL,'2026-04-09 10:22:08'),(459,224,21,4,0,NULL,0,NULL,'2026-04-09 10:22:08'),(460,224,21,0,1,1.00,0,1,'2026-04-09 10:22:08'),(466,129,21,1,0,1.00,0,1,'2026-04-09 10:22:11'),(467,129,21,2,0,NULL,0,NULL,'2026-04-09 10:22:11'),(468,129,21,3,0,NULL,0,NULL,'2026-04-09 10:22:11'),(469,129,21,4,0,NULL,0,NULL,'2026-04-09 10:22:11'),(470,129,21,0,1,1.00,0,1,'2026-04-09 10:22:11'),(476,130,21,1,0,1.00,0,1,'2026-04-09 10:22:13'),(477,130,21,2,0,NULL,0,NULL,'2026-04-09 10:22:13'),(478,130,21,3,0,NULL,0,NULL,'2026-04-09 10:22:13'),(479,130,21,4,0,NULL,0,NULL,'2026-04-09 10:22:13'),(480,130,21,0,1,1.00,0,1,'2026-04-09 10:22:13'),(486,221,21,1,0,1.00,0,1,'2026-04-09 10:22:15'),(487,221,21,2,0,NULL,0,NULL,'2026-04-09 10:22:15'),(488,221,21,3,0,NULL,0,NULL,'2026-04-09 10:22:15'),(489,221,21,4,0,NULL,0,NULL,'2026-04-09 10:22:15'),(490,221,21,0,1,1.00,0,1,'2026-04-09 10:22:15'),(496,222,21,1,0,1.00,0,1,'2026-04-09 10:22:17'),(497,222,21,2,0,NULL,0,NULL,'2026-04-09 10:22:17'),(498,222,21,3,0,NULL,0,NULL,'2026-04-09 10:22:17'),(499,222,21,4,0,NULL,0,NULL,'2026-04-09 10:22:17'),(500,222,21,0,1,1.00,0,1,'2026-04-09 10:22:17'),(506,225,21,1,0,1.00,0,1,'2026-04-09 10:22:20'),(507,225,21,2,0,NULL,0,NULL,'2026-04-09 10:22:20'),(508,225,21,3,0,NULL,0,NULL,'2026-04-09 10:22:20'),(509,225,21,4,0,NULL,0,NULL,'2026-04-09 10:22:20'),(510,225,21,0,1,1.00,0,1,'2026-04-09 10:22:20'),(516,220,21,1,0,1.00,0,1,'2026-04-09 10:22:22'),(517,220,21,2,0,NULL,0,NULL,'2026-04-09 10:22:22'),(518,220,21,3,0,NULL,0,NULL,'2026-04-09 10:22:22'),(519,220,21,4,0,NULL,0,NULL,'2026-04-09 10:22:22'),(520,220,21,0,1,1.00,0,1,'2026-04-09 10:22:22'),(526,217,21,1,0,1.00,0,1,'2026-04-09 10:22:25'),(527,217,21,2,0,NULL,0,NULL,'2026-04-09 10:22:25'),(528,217,21,3,0,NULL,0,NULL,'2026-04-09 10:22:25'),(529,217,21,4,0,NULL,0,NULL,'2026-04-09 10:22:25'),(530,217,21,0,1,1.00,0,1,'2026-04-09 10:22:25'),(536,226,22,1,0,NULL,0,NULL,'2026-04-09 10:22:27'),(537,226,22,2,0,NULL,0,NULL,'2026-04-09 10:22:27'),(538,226,22,3,0,NULL,0,NULL,'2026-04-09 10:22:27'),(539,226,22,4,0,NULL,0,NULL,'2026-04-09 10:22:27'),(540,226,22,0,1,NULL,0,NULL,'2026-04-09 10:22:27'),(551,234,22,1,0,NULL,0,NULL,'2026-04-09 10:22:30'),(552,234,22,2,0,NULL,0,NULL,'2026-04-09 10:22:30'),(553,234,22,3,0,NULL,0,NULL,'2026-04-09 10:22:30'),(554,234,22,4,0,NULL,0,NULL,'2026-04-09 10:22:30'),(555,234,22,0,1,NULL,0,NULL,'2026-04-09 10:22:30'),(561,131,22,1,0,NULL,0,NULL,'2026-04-09 10:22:33'),(562,131,22,2,0,NULL,0,NULL,'2026-04-09 10:22:33'),(563,131,22,3,0,NULL,0,NULL,'2026-04-09 10:22:33'),(564,131,22,4,0,NULL,0,NULL,'2026-04-09 10:22:33'),(565,131,22,0,1,NULL,0,NULL,'2026-04-09 10:22:33'),(571,132,22,1,0,NULL,0,NULL,'2026-04-09 10:22:35'),(572,132,22,2,0,NULL,0,NULL,'2026-04-09 10:22:35'),(573,132,22,3,0,NULL,0,NULL,'2026-04-09 10:22:35'),(574,132,22,4,0,NULL,0,NULL,'2026-04-09 10:22:35'),(575,132,22,0,1,NULL,0,NULL,'2026-04-09 10:22:35'),(581,133,22,1,0,NULL,0,NULL,'2026-04-09 10:22:38'),(582,133,22,2,0,NULL,0,NULL,'2026-04-09 10:22:38'),(583,133,22,3,0,NULL,0,NULL,'2026-04-09 10:22:38'),(584,133,22,4,0,NULL,0,NULL,'2026-04-09 10:22:38'),(585,133,22,0,1,NULL,0,NULL,'2026-04-09 10:22:38'),(591,229,22,1,0,NULL,0,NULL,'2026-04-09 10:22:41'),(592,229,22,2,0,NULL,0,NULL,'2026-04-09 10:22:41'),(593,229,22,3,0,NULL,0,NULL,'2026-04-09 10:22:41'),(594,229,22,4,0,NULL,0,NULL,'2026-04-09 10:22:41'),(595,229,22,0,1,NULL,0,NULL,'2026-04-09 10:22:41'),(601,134,22,1,0,NULL,0,NULL,'2026-04-09 10:22:43'),(602,134,22,2,0,NULL,0,NULL,'2026-04-09 10:22:43'),(603,134,22,3,0,NULL,0,NULL,'2026-04-09 10:22:43'),(604,134,22,4,0,NULL,0,NULL,'2026-04-09 10:22:43'),(605,134,22,0,1,NULL,0,NULL,'2026-04-09 10:22:43'),(611,135,22,1,0,NULL,0,NULL,'2026-04-09 10:22:46'),(612,135,22,2,0,NULL,0,NULL,'2026-04-09 10:22:46'),(613,135,22,3,0,NULL,0,NULL,'2026-04-09 10:22:46'),(614,135,22,4,0,NULL,0,NULL,'2026-04-09 10:22:46'),(615,135,22,0,1,NULL,0,NULL,'2026-04-09 10:22:46'),(621,235,22,1,0,NULL,0,NULL,'2026-04-09 10:22:49'),(622,235,22,2,0,NULL,0,NULL,'2026-04-09 10:22:49'),(623,235,22,3,0,NULL,0,NULL,'2026-04-09 10:22:49'),(624,235,22,4,0,NULL,0,NULL,'2026-04-09 10:22:49'),(625,235,22,0,1,NULL,0,NULL,'2026-04-09 10:22:49'),(631,233,22,1,0,NULL,0,NULL,'2026-04-09 10:22:53'),(632,233,22,2,0,NULL,0,NULL,'2026-04-09 10:22:53'),(633,233,22,3,0,NULL,0,NULL,'2026-04-09 10:22:53'),(634,233,22,4,0,NULL,0,NULL,'2026-04-09 10:22:53'),(635,233,22,0,1,NULL,0,NULL,'2026-04-09 10:22:53'),(641,228,22,1,0,NULL,0,NULL,'2026-04-09 10:22:55'),(642,228,22,2,0,NULL,0,NULL,'2026-04-09 10:22:55'),(643,228,22,3,0,NULL,0,NULL,'2026-04-09 10:22:55'),(644,228,22,4,0,NULL,0,NULL,'2026-04-09 10:22:55'),(645,228,22,0,1,NULL,0,NULL,'2026-04-09 10:22:55'),(651,230,22,1,0,NULL,0,NULL,'2026-04-09 10:22:58'),(652,230,22,2,0,NULL,0,NULL,'2026-04-09 10:22:58'),(653,230,22,3,0,NULL,0,NULL,'2026-04-09 10:22:58'),(654,230,22,4,0,NULL,0,NULL,'2026-04-09 10:22:58'),(655,230,22,0,1,NULL,0,NULL,'2026-04-09 10:22:58'),(661,232,22,1,0,NULL,0,NULL,'2026-04-09 10:23:01'),(662,232,22,2,0,NULL,0,NULL,'2026-04-09 10:23:01'),(663,232,22,3,0,NULL,0,NULL,'2026-04-09 10:23:01'),(664,232,22,4,0,NULL,0,NULL,'2026-04-09 10:23:01'),(665,232,22,0,1,NULL,0,NULL,'2026-04-09 10:23:01'),(671,231,22,1,0,NULL,0,NULL,'2026-04-09 10:23:04'),(672,231,22,2,0,NULL,0,NULL,'2026-04-09 10:23:04'),(673,231,22,3,0,NULL,0,NULL,'2026-04-09 10:23:04'),(674,231,22,4,0,NULL,0,NULL,'2026-04-09 10:23:04'),(675,231,22,0,1,NULL,0,NULL,'2026-04-09 10:23:04'),(681,227,22,1,0,NULL,0,NULL,'2026-04-09 10:23:07'),(682,227,22,2,0,NULL,0,NULL,'2026-04-09 10:23:07'),(683,227,22,3,0,NULL,0,NULL,'2026-04-09 10:23:07'),(684,227,22,4,0,NULL,0,NULL,'2026-04-09 10:23:07'),(685,227,22,0,1,NULL,0,NULL,'2026-04-09 10:23:07'),(691,242,23,1,0,NULL,0,NULL,'2026-04-09 10:23:10'),(692,242,23,2,0,NULL,0,NULL,'2026-04-09 10:23:10'),(693,242,23,3,0,NULL,0,NULL,'2026-04-09 10:23:10'),(694,242,23,4,0,NULL,0,NULL,'2026-04-09 10:23:10'),(695,242,23,0,1,NULL,0,NULL,'2026-04-09 10:23:10'),(701,240,23,1,0,NULL,0,NULL,'2026-04-09 10:23:13'),(702,240,23,2,0,NULL,0,NULL,'2026-04-09 10:23:13'),(703,240,23,3,0,NULL,0,NULL,'2026-04-09 10:23:13'),(704,240,23,4,0,NULL,0,NULL,'2026-04-09 10:23:13'),(705,240,23,0,1,NULL,0,NULL,'2026-04-09 10:23:13'),(711,136,23,1,0,NULL,0,NULL,'2026-04-09 10:23:16'),(712,136,23,2,0,NULL,0,NULL,'2026-04-09 10:23:16'),(713,136,23,3,0,NULL,0,NULL,'2026-04-09 10:23:16'),(714,136,23,4,0,NULL,0,NULL,'2026-04-09 10:23:16'),(715,136,23,0,1,NULL,0,NULL,'2026-04-09 10:23:16'),(721,236,23,1,0,NULL,0,NULL,'2026-04-09 10:23:19'),(722,236,23,2,0,NULL,0,NULL,'2026-04-09 10:23:19'),(723,236,23,3,0,NULL,0,NULL,'2026-04-09 10:23:19'),(724,236,23,4,0,NULL,0,NULL,'2026-04-09 10:23:19'),(725,236,23,0,1,NULL,0,NULL,'2026-04-09 10:23:19'),(731,241,23,1,0,NULL,0,NULL,'2026-04-09 10:23:22'),(732,241,23,2,0,NULL,0,NULL,'2026-04-09 10:23:22'),(733,241,23,3,0,NULL,0,NULL,'2026-04-09 10:23:22'),(734,241,23,4,0,NULL,0,NULL,'2026-04-09 10:23:22'),(735,241,23,0,1,NULL,0,NULL,'2026-04-09 10:23:22'),(741,239,23,1,0,NULL,0,NULL,'2026-04-09 10:23:25'),(742,239,23,2,0,NULL,0,NULL,'2026-04-09 10:23:25'),(743,239,23,3,0,NULL,0,NULL,'2026-04-09 10:23:25'),(744,239,23,4,0,NULL,0,NULL,'2026-04-09 10:23:25'),(745,239,23,0,1,NULL,0,NULL,'2026-04-09 10:23:25'),(751,137,23,1,0,NULL,0,NULL,'2026-04-09 10:23:28'),(752,137,23,2,0,NULL,0,NULL,'2026-04-09 10:23:28'),(753,137,23,3,0,NULL,0,NULL,'2026-04-09 10:23:28'),(754,137,23,4,0,NULL,0,NULL,'2026-04-09 10:23:28'),(755,137,23,0,1,NULL,0,NULL,'2026-04-09 10:23:28'),(761,138,23,1,0,NULL,0,NULL,'2026-04-09 10:23:31'),(762,138,23,2,0,NULL,0,NULL,'2026-04-09 10:23:31'),(763,138,23,3,0,NULL,0,NULL,'2026-04-09 10:23:31'),(764,138,23,4,0,NULL,0,NULL,'2026-04-09 10:23:31'),(765,138,23,0,1,NULL,0,NULL,'2026-04-09 10:23:31'),(771,139,23,1,0,NULL,0,NULL,'2026-04-09 10:23:33'),(772,139,23,2,0,NULL,0,NULL,'2026-04-09 10:23:33'),(773,139,23,3,0,NULL,0,NULL,'2026-04-09 10:23:33'),(774,139,23,4,0,NULL,0,NULL,'2026-04-09 10:23:33'),(775,139,23,0,1,NULL,0,NULL,'2026-04-09 10:23:33'),(781,244,23,1,0,NULL,0,NULL,'2026-04-09 10:23:36'),(782,244,23,2,0,NULL,0,NULL,'2026-04-09 10:23:36'),(783,244,23,3,0,NULL,0,NULL,'2026-04-09 10:23:36'),(784,244,23,4,0,NULL,0,NULL,'2026-04-09 10:23:36'),(785,244,23,0,1,NULL,0,NULL,'2026-04-09 10:23:36'),(791,140,23,1,0,NULL,0,NULL,'2026-04-09 10:23:39'),(792,140,23,2,0,NULL,0,NULL,'2026-04-09 10:23:39'),(793,140,23,3,0,NULL,0,NULL,'2026-04-09 10:23:39'),(794,140,23,4,0,NULL,0,NULL,'2026-04-09 10:23:39'),(795,140,23,0,1,NULL,0,NULL,'2026-04-09 10:23:39'),(801,243,23,1,0,NULL,0,NULL,'2026-04-09 10:23:42'),(802,243,23,2,0,NULL,0,NULL,'2026-04-09 10:23:42'),(803,243,23,3,0,NULL,0,NULL,'2026-04-09 10:23:42'),(804,243,23,4,0,NULL,0,NULL,'2026-04-09 10:23:42'),(805,243,23,0,1,NULL,0,NULL,'2026-04-09 10:23:42'),(811,238,23,1,0,NULL,0,NULL,'2026-04-09 10:23:45'),(812,238,23,2,0,NULL,0,NULL,'2026-04-09 10:23:45'),(813,238,23,3,0,NULL,0,NULL,'2026-04-09 10:23:45'),(814,238,23,4,0,NULL,0,NULL,'2026-04-09 10:23:45'),(815,238,23,0,1,NULL,0,NULL,'2026-04-09 10:23:45'),(821,237,23,1,0,NULL,0,NULL,'2026-04-09 10:23:48'),(822,237,23,2,0,NULL,0,NULL,'2026-04-09 10:23:48'),(823,237,23,3,0,NULL,0,NULL,'2026-04-09 10:23:48'),(824,237,23,4,0,NULL,0,NULL,'2026-04-09 10:23:48'),(825,237,23,0,1,NULL,0,NULL,'2026-04-09 10:23:48'),(831,245,23,1,0,NULL,0,NULL,'2026-04-09 10:23:51'),(832,245,23,2,0,NULL,0,NULL,'2026-04-09 10:23:51'),(833,245,23,3,0,NULL,0,NULL,'2026-04-09 10:23:51'),(834,245,23,4,0,NULL,0,NULL,'2026-04-09 10:23:51'),(835,245,23,0,1,NULL,0,NULL,'2026-04-09 10:23:51'),(841,116,24,1,0,NULL,0,NULL,'2026-04-09 10:23:54'),(842,116,24,2,0,NULL,0,NULL,'2026-04-09 10:23:54'),(843,116,24,3,0,NULL,0,NULL,'2026-04-09 10:23:54'),(844,116,24,4,0,NULL,0,NULL,'2026-04-09 10:23:54'),(845,116,24,0,1,NULL,0,NULL,'2026-04-09 10:23:54'),(851,249,24,1,0,NULL,0,NULL,'2026-04-09 10:23:57'),(852,249,24,2,0,NULL,0,NULL,'2026-04-09 10:23:57'),(853,249,24,3,0,NULL,0,NULL,'2026-04-09 10:23:57'),(854,249,24,4,0,NULL,0,NULL,'2026-04-09 10:23:57'),(855,249,24,0,1,NULL,0,NULL,'2026-04-09 10:23:57'),(861,250,24,1,0,NULL,0,NULL,'2026-04-09 10:24:00'),(862,250,24,2,0,NULL,0,NULL,'2026-04-09 10:24:00'),(863,250,24,3,0,NULL,0,NULL,'2026-04-09 10:24:00'),(864,250,24,4,0,NULL,0,NULL,'2026-04-09 10:24:00'),(865,250,24,0,1,NULL,0,NULL,'2026-04-09 10:24:00'),(866,254,24,1,0,NULL,0,NULL,'2026-04-09 10:24:02'),(867,254,24,2,0,NULL,0,NULL,'2026-04-09 10:24:02'),(868,254,24,3,0,NULL,0,NULL,'2026-04-09 10:24:02'),(869,254,24,4,0,NULL,0,NULL,'2026-04-09 10:24:02'),(870,254,24,0,1,NULL,0,NULL,'2026-04-09 10:24:02'),(876,248,24,1,0,NULL,0,NULL,'2026-04-09 10:24:05'),(877,248,24,2,0,NULL,0,NULL,'2026-04-09 10:24:05'),(878,248,24,3,0,NULL,0,NULL,'2026-04-09 10:24:05'),(879,248,24,4,0,NULL,0,NULL,'2026-04-09 10:24:05'),(880,248,24,0,1,NULL,0,NULL,'2026-04-09 10:24:05'),(886,251,24,1,0,NULL,0,NULL,'2026-04-09 10:24:08'),(887,251,24,2,0,NULL,0,NULL,'2026-04-09 10:24:08'),(888,251,24,3,0,NULL,0,NULL,'2026-04-09 10:24:08'),(889,251,24,4,0,NULL,0,NULL,'2026-04-09 10:24:08'),(890,251,24,0,1,NULL,0,NULL,'2026-04-09 10:24:08'),(896,253,24,1,0,NULL,0,NULL,'2026-04-09 10:24:11'),(897,253,24,2,0,NULL,0,NULL,'2026-04-09 10:24:11'),(898,253,24,3,0,NULL,0,NULL,'2026-04-09 10:24:11'),(899,253,24,4,0,NULL,0,NULL,'2026-04-09 10:24:11'),(900,253,24,0,1,NULL,0,NULL,'2026-04-09 10:24:11'),(906,247,24,1,0,NULL,0,NULL,'2026-04-09 10:24:13'),(907,247,24,2,0,NULL,0,NULL,'2026-04-09 10:24:13'),(908,247,24,3,0,NULL,0,NULL,'2026-04-09 10:24:13'),(909,247,24,4,0,NULL,0,NULL,'2026-04-09 10:24:13'),(910,247,24,0,1,NULL,0,NULL,'2026-04-09 10:24:13'),(916,141,24,1,0,NULL,0,NULL,'2026-04-09 10:24:16'),(917,141,24,2,0,NULL,0,NULL,'2026-04-09 10:24:16'),(918,141,24,3,0,NULL,0,NULL,'2026-04-09 10:24:16'),(919,141,24,4,0,NULL,0,NULL,'2026-04-09 10:24:16'),(920,141,24,0,1,NULL,0,NULL,'2026-04-09 10:24:16'),(926,255,24,1,0,NULL,0,NULL,'2026-04-09 10:24:19'),(927,255,24,2,0,NULL,0,NULL,'2026-04-09 10:24:19'),(928,255,24,3,0,NULL,0,NULL,'2026-04-09 10:24:19'),(929,255,24,4,0,NULL,0,NULL,'2026-04-09 10:24:19'),(930,255,24,0,1,NULL,0,NULL,'2026-04-09 10:24:19'),(936,142,24,1,0,NULL,0,NULL,'2026-04-09 10:24:22'),(937,142,24,2,0,NULL,0,NULL,'2026-04-09 10:24:22'),(938,142,24,3,0,NULL,0,NULL,'2026-04-09 10:24:22'),(939,142,24,4,0,NULL,0,NULL,'2026-04-09 10:24:22'),(940,142,24,0,1,NULL,0,NULL,'2026-04-09 10:24:22'),(946,252,24,1,0,NULL,0,NULL,'2026-04-09 10:24:24'),(947,252,24,2,0,NULL,0,NULL,'2026-04-09 10:24:24'),(948,252,24,3,0,NULL,0,NULL,'2026-04-09 10:24:24'),(949,252,24,4,0,NULL,0,NULL,'2026-04-09 10:24:24'),(950,252,24,0,1,NULL,0,NULL,'2026-04-09 10:24:24'),(956,246,24,1,0,NULL,0,NULL,'2026-04-09 10:24:27'),(957,246,24,2,0,NULL,0,NULL,'2026-04-09 10:24:27'),(958,246,24,3,0,NULL,0,NULL,'2026-04-09 10:24:27'),(959,246,24,4,0,NULL,0,NULL,'2026-04-09 10:24:27'),(960,246,24,0,1,NULL,0,NULL,'2026-04-09 10:24:27'),(966,143,24,1,0,NULL,0,NULL,'2026-04-09 10:24:30'),(967,143,24,2,0,NULL,0,NULL,'2026-04-09 10:24:30'),(968,143,24,3,0,NULL,0,NULL,'2026-04-09 10:24:30'),(969,143,24,4,0,NULL,0,NULL,'2026-04-09 10:24:30'),(970,143,24,0,1,NULL,0,NULL,'2026-04-09 10:24:30'),(976,144,24,1,0,NULL,0,NULL,'2026-04-09 10:24:33'),(977,144,24,2,0,NULL,0,NULL,'2026-04-09 10:24:33'),(978,144,24,3,0,NULL,0,NULL,'2026-04-09 10:24:33'),(979,144,24,4,0,NULL,0,NULL,'2026-04-09 10:24:33'),(980,144,24,0,1,NULL,0,NULL,'2026-04-09 10:24:33'),(986,145,24,1,0,NULL,0,NULL,'2026-04-09 10:24:36'),(987,145,24,2,0,NULL,0,NULL,'2026-04-09 10:24:36'),(988,145,24,3,0,NULL,0,NULL,'2026-04-09 10:24:36'),(989,145,24,4,0,NULL,0,NULL,'2026-04-09 10:24:36'),(990,145,24,0,1,NULL,0,NULL,'2026-04-09 10:24:36'),(996,264,1,1,0,NULL,0,NULL,'2026-04-09 10:24:39'),(997,264,1,2,0,NULL,0,NULL,'2026-04-09 10:24:39'),(998,264,1,3,0,NULL,0,NULL,'2026-04-09 10:24:39'),(999,264,1,4,0,NULL,0,NULL,'2026-04-09 10:24:39'),(1000,264,1,0,1,NULL,0,NULL,'2026-04-09 10:24:39'),(1006,265,1,1,0,NULL,0,NULL,'2026-04-09 10:24:42'),(1007,265,1,2,0,NULL,0,NULL,'2026-04-09 10:24:42'),(1008,265,1,3,0,NULL,0,NULL,'2026-04-09 10:24:42'),(1009,265,1,4,0,NULL,0,NULL,'2026-04-09 10:24:42'),(1010,265,1,0,1,NULL,0,NULL,'2026-04-09 10:24:42'),(1016,101,1,1,0,NULL,0,NULL,'2026-04-09 10:24:45'),(1017,101,1,2,0,NULL,0,NULL,'2026-04-09 10:24:45'),(1018,101,1,3,0,NULL,0,NULL,'2026-04-09 10:24:45'),(1019,101,1,4,0,NULL,0,NULL,'2026-04-09 10:24:45'),(1020,101,1,0,1,NULL,0,NULL,'2026-04-09 10:24:45'),(1031,263,1,1,0,NULL,0,NULL,'2026-04-09 10:24:48'),(1032,263,1,2,0,NULL,0,NULL,'2026-04-09 10:24:48'),(1033,263,1,3,0,NULL,0,NULL,'2026-04-09 10:24:48'),(1034,263,1,4,0,NULL,0,NULL,'2026-04-09 10:24:48'),(1035,263,1,0,1,NULL,0,NULL,'2026-04-09 10:24:48'),(1041,259,1,1,0,NULL,0,NULL,'2026-04-09 10:24:51'),(1042,259,1,2,0,NULL,0,NULL,'2026-04-09 10:24:51'),(1043,259,1,3,0,NULL,0,NULL,'2026-04-09 10:24:51'),(1044,259,1,4,0,NULL,0,NULL,'2026-04-09 10:24:51'),(1045,259,1,0,1,NULL,0,NULL,'2026-04-09 10:24:51'),(1051,104,1,1,0,NULL,0,NULL,'2026-04-09 10:24:54'),(1052,104,1,2,0,NULL,0,NULL,'2026-04-09 10:24:54'),(1053,104,1,3,0,NULL,0,NULL,'2026-04-09 10:24:54'),(1054,104,1,4,0,NULL,0,NULL,'2026-04-09 10:24:54'),(1055,104,1,0,1,NULL,0,NULL,'2026-04-09 10:24:54'),(1061,260,1,1,0,NULL,0,NULL,'2026-04-09 10:24:57'),(1062,260,1,2,0,NULL,0,NULL,'2026-04-09 10:24:57'),(1063,260,1,3,0,NULL,0,NULL,'2026-04-09 10:24:57'),(1064,260,1,4,0,NULL,0,NULL,'2026-04-09 10:24:57'),(1065,260,1,0,1,NULL,0,NULL,'2026-04-09 10:24:57'),(1071,105,1,1,0,NULL,0,NULL,'2026-04-09 10:25:00'),(1072,105,1,2,0,NULL,0,NULL,'2026-04-09 10:25:00'),(1073,105,1,3,0,NULL,0,NULL,'2026-04-09 10:25:00'),(1074,105,1,4,0,NULL,0,NULL,'2026-04-09 10:25:00'),(1075,105,1,0,1,NULL,0,NULL,'2026-04-09 10:25:00'),(1081,103,1,1,0,NULL,0,NULL,'2026-04-09 10:25:03'),(1082,103,1,2,0,NULL,0,NULL,'2026-04-09 10:25:03'),(1083,103,1,3,0,NULL,0,NULL,'2026-04-09 10:25:03'),(1084,103,1,4,0,NULL,0,NULL,'2026-04-09 10:25:03'),(1085,103,1,0,1,NULL,0,NULL,'2026-04-09 10:25:03'),(1091,261,1,1,0,NULL,0,NULL,'2026-04-09 10:25:06'),(1092,261,1,2,0,NULL,0,NULL,'2026-04-09 10:25:06'),(1093,261,1,3,0,NULL,0,NULL,'2026-04-09 10:25:06'),(1094,261,1,4,0,NULL,0,NULL,'2026-04-09 10:25:06'),(1095,261,1,0,1,NULL,0,NULL,'2026-04-09 10:25:06'),(1101,256,1,1,0,NULL,0,NULL,'2026-04-09 10:25:09'),(1102,256,1,2,0,NULL,0,NULL,'2026-04-09 10:25:09'),(1103,256,1,3,0,NULL,0,NULL,'2026-04-09 10:25:09'),(1104,256,1,4,0,NULL,0,NULL,'2026-04-09 10:25:09'),(1105,256,1,0,1,NULL,0,NULL,'2026-04-09 10:25:09'),(1111,258,1,1,0,NULL,0,NULL,'2026-04-09 10:25:13'),(1112,258,1,2,0,NULL,0,NULL,'2026-04-09 10:25:13'),(1113,258,1,3,0,NULL,0,NULL,'2026-04-09 10:25:13'),(1114,258,1,4,0,NULL,0,NULL,'2026-04-09 10:25:13'),(1115,258,1,0,1,NULL,0,NULL,'2026-04-09 10:25:13'),(1121,257,1,1,0,NULL,0,NULL,'2026-04-09 10:25:15'),(1122,257,1,2,0,NULL,0,NULL,'2026-04-09 10:25:15'),(1123,257,1,3,0,NULL,0,NULL,'2026-04-09 10:25:15'),(1124,257,1,4,0,NULL,0,NULL,'2026-04-09 10:25:15'),(1125,257,1,0,1,NULL,0,NULL,'2026-04-09 10:25:15'),(1131,102,1,1,0,NULL,0,NULL,'2026-04-09 10:25:19'),(1132,102,1,2,0,NULL,0,NULL,'2026-04-09 10:25:19'),(1133,102,1,3,0,NULL,0,NULL,'2026-04-09 10:25:19'),(1134,102,1,4,0,NULL,0,NULL,'2026-04-09 10:25:19'),(1135,102,1,0,1,NULL,0,NULL,'2026-04-09 10:25:19'),(1141,262,1,1,0,NULL,0,NULL,'2026-04-09 10:25:22'),(1142,262,1,2,0,NULL,0,NULL,'2026-04-09 10:25:22'),(1143,262,1,3,0,NULL,0,NULL,'2026-04-09 10:25:22'),(1144,262,1,4,0,NULL,0,NULL,'2026-04-09 10:25:22'),(1145,262,1,0,1,NULL,0,NULL,'2026-04-09 10:25:22'),(1151,106,2,1,0,NULL,0,NULL,'2026-04-09 10:25:24'),(1152,106,2,2,0,NULL,0,NULL,'2026-04-09 10:25:24'),(1153,106,2,3,0,NULL,0,NULL,'2026-04-09 10:25:24'),(1154,106,2,4,0,NULL,0,NULL,'2026-04-09 10:25:24'),(1155,106,2,0,1,NULL,0,NULL,'2026-04-09 10:25:24'),(1161,110,2,1,0,NULL,0,NULL,'2026-04-09 10:25:27'),(1162,110,2,2,0,NULL,0,NULL,'2026-04-09 10:25:27'),(1163,110,2,3,0,NULL,0,NULL,'2026-04-09 10:25:27'),(1164,110,2,4,0,NULL,0,NULL,'2026-04-09 10:25:27'),(1165,110,2,0,1,NULL,0,NULL,'2026-04-09 10:25:27'),(1166,266,2,1,0,NULL,0,NULL,'2026-04-09 10:25:30'),(1167,266,2,2,0,NULL,0,NULL,'2026-04-09 10:25:30'),(1168,266,2,3,0,NULL,0,NULL,'2026-04-09 10:25:30'),(1169,266,2,4,0,NULL,0,NULL,'2026-04-09 10:25:30'),(1170,266,2,0,1,NULL,0,NULL,'2026-04-09 10:25:30'),(1176,269,2,1,0,NULL,0,NULL,'2026-04-09 10:25:32'),(1177,269,2,2,0,NULL,0,NULL,'2026-04-09 10:25:32'),(1178,269,2,3,0,NULL,0,NULL,'2026-04-09 10:25:32'),(1179,269,2,4,0,NULL,0,NULL,'2026-04-09 10:25:32'),(1180,269,2,0,1,NULL,0,NULL,'2026-04-09 10:25:32'),(1186,270,2,1,0,NULL,0,NULL,'2026-04-09 10:25:35'),(1187,270,2,2,0,NULL,0,NULL,'2026-04-09 10:25:35'),(1188,270,2,3,0,NULL,0,NULL,'2026-04-09 10:25:35'),(1189,270,2,4,0,NULL,0,NULL,'2026-04-09 10:25:35'),(1190,270,2,0,1,NULL,0,NULL,'2026-04-09 10:25:35'),(1196,273,2,1,0,NULL,0,NULL,'2026-04-09 10:25:38'),(1197,273,2,2,0,NULL,0,NULL,'2026-04-09 10:25:38'),(1198,273,2,3,0,NULL,0,NULL,'2026-04-09 10:25:38'),(1199,273,2,4,0,NULL,0,NULL,'2026-04-09 10:25:38'),(1200,273,2,0,1,NULL,0,NULL,'2026-04-09 10:25:38'),(1206,274,2,1,0,NULL,0,NULL,'2026-04-09 10:25:40'),(1207,274,2,2,0,NULL,0,NULL,'2026-04-09 10:25:40'),(1208,274,2,3,0,NULL,0,NULL,'2026-04-09 10:25:40'),(1209,274,2,4,0,NULL,0,NULL,'2026-04-09 10:25:40'),(1210,274,2,0,1,NULL,0,NULL,'2026-04-09 10:25:40'),(1211,272,2,1,0,NULL,0,NULL,'2026-04-09 10:25:43'),(1212,272,2,2,0,NULL,0,NULL,'2026-04-09 10:25:43'),(1213,272,2,3,0,NULL,0,NULL,'2026-04-09 10:25:43'),(1214,272,2,4,0,NULL,0,NULL,'2026-04-09 10:25:43'),(1215,272,2,0,1,NULL,0,NULL,'2026-04-09 10:25:43'),(1221,109,2,1,0,NULL,0,NULL,'2026-04-09 10:25:46'),(1222,109,2,2,0,NULL,0,NULL,'2026-04-09 10:25:46'),(1223,109,2,3,0,NULL,0,NULL,'2026-04-09 10:25:46'),(1224,109,2,4,0,NULL,0,NULL,'2026-04-09 10:25:46'),(1225,109,2,0,1,NULL,0,NULL,'2026-04-09 10:25:46'),(1231,271,2,1,0,NULL,0,NULL,'2026-04-09 10:25:49'),(1232,271,2,2,0,NULL,0,NULL,'2026-04-09 10:25:49'),(1233,271,2,3,0,NULL,0,NULL,'2026-04-09 10:25:49'),(1234,271,2,4,0,NULL,0,NULL,'2026-04-09 10:25:49'),(1235,271,2,0,1,NULL,0,NULL,'2026-04-09 10:25:49'),(1241,108,2,1,0,NULL,0,NULL,'2026-04-09 10:25:51'),(1242,108,2,2,0,NULL,0,NULL,'2026-04-09 10:25:51'),(1243,108,2,3,0,NULL,0,NULL,'2026-04-09 10:25:51'),(1244,108,2,4,0,NULL,0,NULL,'2026-04-09 10:25:51'),(1245,108,2,0,1,NULL,0,NULL,'2026-04-09 10:25:51'),(1251,107,2,1,0,NULL,0,NULL,'2026-04-09 10:25:54'),(1252,107,2,2,0,NULL,0,NULL,'2026-04-09 10:25:54'),(1253,107,2,3,0,NULL,0,NULL,'2026-04-09 10:25:54'),(1254,107,2,4,0,NULL,0,NULL,'2026-04-09 10:25:54'),(1255,107,2,0,1,NULL,0,NULL,'2026-04-09 10:25:54'),(1261,268,2,1,0,NULL,0,NULL,'2026-04-09 10:25:57'),(1262,268,2,2,0,NULL,0,NULL,'2026-04-09 10:25:57'),(1263,268,2,3,0,NULL,0,NULL,'2026-04-09 10:25:57'),(1264,268,2,4,0,NULL,0,NULL,'2026-04-09 10:25:57'),(1265,268,2,0,1,NULL,0,NULL,'2026-04-09 10:25:57'),(1271,267,2,1,0,NULL,0,NULL,'2026-04-09 10:26:00'),(1272,267,2,2,0,NULL,0,NULL,'2026-04-09 10:26:00'),(1273,267,2,3,0,NULL,0,NULL,'2026-04-09 10:26:00'),(1274,267,2,4,0,NULL,0,NULL,'2026-04-09 10:26:00'),(1275,267,2,0,1,NULL,0,NULL,'2026-04-09 10:26:00'),(1281,275,2,1,0,NULL,0,NULL,'2026-04-09 10:26:03'),(1282,275,2,2,0,NULL,0,NULL,'2026-04-09 10:26:03'),(1283,275,2,3,0,NULL,0,NULL,'2026-04-09 10:26:03'),(1284,275,2,4,0,NULL,0,NULL,'2026-04-09 10:26:03'),(1285,275,2,0,1,NULL,0,NULL,'2026-04-09 10:26:03'),(1291,171,3,1,0,NULL,0,NULL,'2026-04-09 10:26:05'),(1292,171,3,2,0,NULL,0,NULL,'2026-04-09 10:26:05'),(1293,171,3,3,0,NULL,0,NULL,'2026-04-09 10:26:05'),(1294,171,3,4,0,NULL,0,NULL,'2026-04-09 10:26:05'),(1295,171,3,0,1,NULL,0,NULL,'2026-04-09 10:26:05'),(1301,174,3,1,0,NULL,0,NULL,'2026-04-09 10:26:07'),(1302,174,3,2,0,NULL,0,NULL,'2026-04-09 10:26:07'),(1303,174,3,3,0,NULL,0,NULL,'2026-04-09 10:26:07'),(1304,174,3,4,0,NULL,0,NULL,'2026-04-09 10:26:07'),(1305,174,3,0,1,NULL,0,NULL,'2026-04-09 10:26:07'),(1311,172,3,1,0,NULL,0,NULL,'2026-04-09 10:26:09'),(1312,172,3,2,0,NULL,0,NULL,'2026-04-09 10:26:09'),(1313,172,3,3,0,NULL,0,NULL,'2026-04-09 10:26:09'),(1314,172,3,4,0,NULL,0,NULL,'2026-04-09 10:26:09'),(1315,172,3,0,1,NULL,0,NULL,'2026-04-09 10:26:09'),(1316,166,3,1,0,NULL,0,NULL,'2026-04-09 10:26:11'),(1317,166,3,2,0,NULL,0,NULL,'2026-04-09 10:26:11'),(1318,166,3,3,0,NULL,0,NULL,'2026-04-09 10:26:11'),(1319,166,3,4,0,NULL,0,NULL,'2026-04-09 10:26:11'),(1320,166,3,0,1,NULL,0,NULL,'2026-04-09 10:26:11'),(1326,167,3,1,0,NULL,0,NULL,'2026-04-09 10:26:13'),(1327,167,3,2,0,NULL,0,NULL,'2026-04-09 10:26:13'),(1328,167,3,3,0,NULL,0,NULL,'2026-04-09 10:26:13'),(1329,167,3,4,0,NULL,0,NULL,'2026-04-09 10:26:13'),(1330,167,3,0,1,NULL,0,NULL,'2026-04-09 10:26:13'),(1336,173,3,1,0,NULL,0,NULL,'2026-04-09 10:26:15'),(1337,173,3,2,0,NULL,0,NULL,'2026-04-09 10:26:15'),(1338,173,3,3,0,NULL,0,NULL,'2026-04-09 10:26:15'),(1339,173,3,4,0,NULL,0,NULL,'2026-04-09 10:26:15'),(1340,173,3,0,1,NULL,0,NULL,'2026-04-09 10:26:15'),(1341,170,3,1,0,NULL,0,NULL,'2026-04-09 10:26:17'),(1342,170,3,2,0,NULL,0,NULL,'2026-04-09 10:26:17'),(1343,170,3,3,0,NULL,0,NULL,'2026-04-09 10:26:17'),(1344,170,3,4,0,NULL,0,NULL,'2026-04-09 10:26:17'),(1345,170,3,0,1,NULL,0,NULL,'2026-04-09 10:26:17'),(1351,169,3,1,0,NULL,0,NULL,'2026-04-09 10:26:19'),(1352,169,3,2,0,NULL,0,NULL,'2026-04-09 10:26:19'),(1353,169,3,3,0,NULL,0,NULL,'2026-04-09 10:26:19'),(1354,169,3,4,0,NULL,0,NULL,'2026-04-09 10:26:19'),(1355,169,3,0,1,NULL,0,NULL,'2026-04-09 10:26:19'),(1361,175,3,1,0,NULL,0,NULL,'2026-04-09 10:26:22'),(1362,175,3,2,0,NULL,0,NULL,'2026-04-09 10:26:22'),(1363,175,3,3,0,NULL,0,NULL,'2026-04-09 10:26:22'),(1364,175,3,4,0,NULL,0,NULL,'2026-04-09 10:26:22'),(1365,175,3,0,1,NULL,0,NULL,'2026-04-09 10:26:22'),(1371,168,3,1,0,NULL,0,NULL,'2026-04-09 10:26:24'),(1372,168,3,2,0,NULL,0,NULL,'2026-04-09 10:26:24'),(1373,168,3,3,0,NULL,0,NULL,'2026-04-09 10:26:24'),(1374,168,3,4,0,NULL,0,NULL,'2026-04-09 10:26:24'),(1375,168,3,0,1,NULL,0,NULL,'2026-04-09 10:26:24'),(1381,283,4,1,0,NULL,0,NULL,'2026-04-09 10:26:27'),(1382,283,4,2,0,NULL,0,NULL,'2026-04-09 10:26:27'),(1383,283,4,3,0,NULL,0,NULL,'2026-04-09 10:26:27'),(1384,283,4,4,0,NULL,0,NULL,'2026-04-09 10:26:27'),(1385,283,4,0,1,NULL,0,NULL,'2026-04-09 10:26:27'),(1396,113,4,1,0,NULL,0,NULL,'2026-04-09 10:26:29'),(1397,113,4,2,0,NULL,0,NULL,'2026-04-09 10:26:29'),(1398,113,4,3,0,NULL,0,NULL,'2026-04-09 10:26:29'),(1399,113,4,4,0,NULL,0,NULL,'2026-04-09 10:26:29'),(1400,113,4,0,1,NULL,0,NULL,'2026-04-09 10:26:29'),(1406,285,4,1,0,NULL,0,NULL,'2026-04-09 10:26:32'),(1407,285,4,2,0,NULL,0,NULL,'2026-04-09 10:26:32'),(1408,285,4,3,0,NULL,0,NULL,'2026-04-09 10:26:32'),(1409,285,4,4,0,NULL,0,NULL,'2026-04-09 10:26:32'),(1410,285,4,0,1,NULL,0,NULL,'2026-04-09 10:26:32'),(1421,277,4,1,0,NULL,0,NULL,'2026-04-09 10:26:35'),(1422,277,4,2,0,NULL,0,NULL,'2026-04-09 10:26:35'),(1423,277,4,3,0,NULL,0,NULL,'2026-04-09 10:26:35'),(1424,277,4,4,0,NULL,0,NULL,'2026-04-09 10:26:35'),(1425,277,4,0,1,NULL,0,NULL,'2026-04-09 10:26:35'),(1436,111,4,1,0,NULL,0,NULL,'2026-04-09 10:26:38'),(1437,111,4,2,0,NULL,0,NULL,'2026-04-09 10:26:38'),(1438,111,4,3,0,NULL,0,NULL,'2026-04-09 10:26:38'),(1439,111,4,4,0,NULL,0,NULL,'2026-04-09 10:26:38'),(1440,111,4,0,1,NULL,0,NULL,'2026-04-09 10:26:38'),(1451,281,4,1,0,NULL,0,NULL,'2026-04-09 10:26:40'),(1452,281,4,2,0,NULL,0,NULL,'2026-04-09 10:26:40'),(1453,281,4,3,0,NULL,0,NULL,'2026-04-09 10:26:40'),(1454,281,4,4,0,NULL,0,NULL,'2026-04-09 10:26:40'),(1455,281,4,0,1,NULL,0,NULL,'2026-04-09 10:26:40'),(1461,278,4,1,0,NULL,0,NULL,'2026-04-09 10:26:43'),(1462,278,4,2,0,NULL,0,NULL,'2026-04-09 10:26:43'),(1463,278,4,3,0,NULL,0,NULL,'2026-04-09 10:26:43'),(1464,278,4,4,0,NULL,0,NULL,'2026-04-09 10:26:43'),(1465,278,4,0,1,NULL,0,NULL,'2026-04-09 10:26:43'),(1471,282,4,1,0,NULL,0,NULL,'2026-04-09 10:26:46'),(1472,282,4,2,0,NULL,0,NULL,'2026-04-09 10:26:46'),(1473,282,4,3,0,NULL,0,NULL,'2026-04-09 10:26:46'),(1474,282,4,4,0,NULL,0,NULL,'2026-04-09 10:26:46'),(1475,282,4,0,1,NULL,0,NULL,'2026-04-09 10:26:46'),(1481,284,4,1,0,NULL,0,NULL,'2026-04-09 10:26:49'),(1482,284,4,2,0,NULL,0,NULL,'2026-04-09 10:26:49'),(1483,284,4,3,0,NULL,0,NULL,'2026-04-09 10:26:49'),(1484,284,4,4,0,NULL,0,NULL,'2026-04-09 10:26:49'),(1485,284,4,0,1,NULL,0,NULL,'2026-04-09 10:26:49'),(1491,115,4,1,0,NULL,0,NULL,'2026-04-09 10:19:05'),(1492,115,4,2,0,NULL,0,NULL,'2026-04-09 10:19:05'),(1493,115,4,3,0,NULL,0,NULL,'2026-04-09 10:19:05'),(1494,115,4,4,0,NULL,0,NULL,'2026-04-09 10:19:05'),(1495,115,4,0,1,NULL,0,NULL,'2026-04-09 10:19:05'),(1501,276,4,1,0,NULL,0,NULL,'2026-04-09 10:19:08'),(1502,276,4,2,0,NULL,0,NULL,'2026-04-09 10:19:08'),(1503,276,4,3,0,NULL,0,NULL,'2026-04-09 10:19:08'),(1504,276,4,4,0,NULL,0,NULL,'2026-04-09 10:19:08'),(1505,276,4,0,1,NULL,0,NULL,'2026-04-09 10:19:08'),(1511,112,4,1,0,NULL,0,NULL,'2026-04-09 10:19:11'),(1512,112,4,2,0,NULL,0,NULL,'2026-04-09 10:19:11'),(1513,112,4,3,0,NULL,0,NULL,'2026-04-09 10:19:11'),(1514,112,4,4,0,NULL,0,NULL,'2026-04-09 10:19:11'),(1515,112,4,0,1,NULL,0,NULL,'2026-04-09 10:19:11'),(1531,279,4,1,0,NULL,0,NULL,'2026-04-09 10:19:14'),(1532,279,4,2,0,NULL,0,NULL,'2026-04-09 10:19:14'),(1533,279,4,3,0,NULL,0,NULL,'2026-04-09 10:19:14'),(1534,279,4,4,0,NULL,0,NULL,'2026-04-09 10:19:14'),(1535,279,4,0,1,NULL,0,NULL,'2026-04-09 10:19:14'),(1546,280,4,1,0,NULL,0,NULL,'2026-04-09 10:19:17'),(1547,280,4,2,0,NULL,0,NULL,'2026-04-09 10:19:17'),(1548,280,4,3,0,NULL,0,NULL,'2026-04-09 10:19:17'),(1549,280,4,4,0,NULL,0,NULL,'2026-04-09 10:19:17'),(1550,280,4,0,1,NULL,0,NULL,'2026-04-09 10:19:17'),(1556,114,4,1,0,NULL,0,NULL,'2026-04-09 10:19:20'),(1557,114,4,2,0,NULL,0,NULL,'2026-04-09 10:19:20'),(1558,114,4,3,0,NULL,0,NULL,'2026-04-09 10:19:20'),(1559,114,4,4,0,NULL,0,NULL,'2026-04-09 10:19:20'),(1560,114,4,0,1,NULL,0,NULL,'2026-04-09 10:19:20'),(1566,181,5,1,0,NULL,0,NULL,'2026-04-09 10:19:23'),(1567,181,5,2,0,NULL,0,NULL,'2026-04-09 10:19:23'),(1568,181,5,3,0,NULL,0,NULL,'2026-04-09 10:19:23'),(1569,181,5,4,0,NULL,0,NULL,'2026-04-09 10:19:23'),(1570,181,5,0,1,NULL,0,NULL,'2026-04-09 10:19:23'),(1571,180,5,1,0,NULL,0,NULL,'2026-04-09 10:19:25'),(1572,180,5,2,0,NULL,0,NULL,'2026-04-09 10:19:25'),(1573,180,5,3,0,NULL,0,NULL,'2026-04-09 10:19:25'),(1574,180,5,4,0,NULL,0,NULL,'2026-04-09 10:19:25'),(1575,180,5,0,1,NULL,0,NULL,'2026-04-09 10:19:25'),(1581,183,5,1,0,NULL,0,NULL,'2026-04-09 10:19:27'),(1582,183,5,2,0,NULL,0,NULL,'2026-04-09 10:19:27'),(1583,183,5,3,0,NULL,0,NULL,'2026-04-09 10:19:27'),(1584,183,5,4,0,NULL,0,NULL,'2026-04-09 10:19:27'),(1585,183,5,0,1,NULL,0,NULL,'2026-04-09 10:19:27'),(1586,176,5,1,0,NULL,0,NULL,'2026-04-09 10:19:29'),(1587,176,5,2,0,NULL,0,NULL,'2026-04-09 10:19:29'),(1588,176,5,3,0,NULL,0,NULL,'2026-04-09 10:19:29'),(1589,176,5,4,0,NULL,0,NULL,'2026-04-09 10:19:29'),(1590,176,5,0,1,NULL,0,NULL,'2026-04-09 10:19:29'),(1596,177,5,1,0,NULL,0,NULL,'2026-04-09 10:19:32'),(1597,177,5,2,0,NULL,0,NULL,'2026-04-09 10:19:32'),(1598,177,5,3,0,NULL,0,NULL,'2026-04-09 10:19:32'),(1599,177,5,4,0,NULL,0,NULL,'2026-04-09 10:19:32'),(1600,177,5,0,1,NULL,0,NULL,'2026-04-09 10:19:32'),(1601,184,5,1,0,NULL,0,NULL,'2026-04-09 10:19:34'),(1602,184,5,2,0,NULL,0,NULL,'2026-04-09 10:19:34'),(1603,184,5,3,0,NULL,0,NULL,'2026-04-09 10:19:34'),(1604,184,5,4,0,NULL,0,NULL,'2026-04-09 10:19:34'),(1605,184,5,0,1,NULL,0,NULL,'2026-04-09 10:19:34'),(1611,182,5,1,0,NULL,0,NULL,'2026-04-09 10:19:36'),(1612,182,5,2,0,NULL,0,NULL,'2026-04-09 10:19:36'),(1613,182,5,3,0,NULL,0,NULL,'2026-04-09 10:19:36'),(1614,182,5,4,0,NULL,0,NULL,'2026-04-09 10:19:36'),(1615,182,5,0,1,NULL,0,NULL,'2026-04-09 10:19:36'),(1621,179,5,1,0,NULL,0,NULL,'2026-04-09 10:19:38'),(1622,179,5,2,0,NULL,0,NULL,'2026-04-09 10:19:38'),(1623,179,5,3,0,NULL,0,NULL,'2026-04-09 10:19:38'),(1624,179,5,4,0,NULL,0,NULL,'2026-04-09 10:19:38'),(1625,179,5,0,1,NULL,0,NULL,'2026-04-09 10:19:38'),(1626,185,5,1,0,NULL,0,NULL,'2026-04-09 10:19:40'),(1627,185,5,2,0,NULL,0,NULL,'2026-04-09 10:19:40'),(1628,185,5,3,0,NULL,0,NULL,'2026-04-09 10:19:40'),(1629,185,5,4,0,NULL,0,NULL,'2026-04-09 10:19:40'),(1630,185,5,0,1,NULL,0,NULL,'2026-04-09 10:19:40'),(1646,178,5,1,0,NULL,0,NULL,'2026-04-09 10:19:42'),(1647,178,5,2,0,NULL,0,NULL,'2026-04-09 10:19:42'),(1648,178,5,3,0,NULL,0,NULL,'2026-04-09 10:19:42'),(1649,178,5,4,0,NULL,0,NULL,'2026-04-09 10:19:42'),(1650,178,5,0,1,NULL,0,NULL,'2026-04-09 10:19:42'),(1661,186,6,1,0,NULL,0,NULL,'2026-04-09 10:19:44'),(1662,186,6,2,0,NULL,0,NULL,'2026-04-09 10:19:44'),(1663,186,6,3,0,NULL,0,NULL,'2026-04-09 10:19:44'),(1664,186,6,4,0,NULL,0,NULL,'2026-04-09 10:19:44'),(1665,186,6,0,1,NULL,0,NULL,'2026-04-09 10:19:44'),(1671,194,6,1,0,NULL,0,NULL,'2026-04-09 10:19:46'),(1672,194,6,2,0,NULL,0,NULL,'2026-04-09 10:19:46'),(1673,194,6,3,0,NULL,0,NULL,'2026-04-09 10:19:46'),(1674,194,6,4,0,NULL,0,NULL,'2026-04-09 10:19:46'),(1675,194,6,0,1,NULL,0,NULL,'2026-04-09 10:19:46'),(1681,189,6,1,0,NULL,0,NULL,'2026-04-09 10:19:49'),(1682,189,6,2,0,NULL,0,NULL,'2026-04-09 10:19:49'),(1683,189,6,3,0,NULL,0,NULL,'2026-04-09 10:19:49'),(1684,189,6,4,0,NULL,0,NULL,'2026-04-09 10:19:49'),(1685,189,6,0,1,NULL,0,NULL,'2026-04-09 10:19:49'),(1691,188,6,1,0,NULL,0,NULL,'2026-04-09 10:19:51'),(1692,188,6,2,0,NULL,0,NULL,'2026-04-09 10:19:51'),(1693,188,6,3,0,NULL,0,NULL,'2026-04-09 10:19:51'),(1694,188,6,4,0,NULL,0,NULL,'2026-04-09 10:19:51'),(1695,188,6,0,1,NULL,0,NULL,'2026-04-09 10:19:51'),(1701,187,6,1,0,NULL,0,NULL,'2026-04-09 10:19:53'),(1702,187,6,2,0,NULL,0,NULL,'2026-04-09 10:19:53'),(1703,187,6,3,0,NULL,0,NULL,'2026-04-09 10:19:53'),(1704,187,6,4,0,NULL,0,NULL,'2026-04-09 10:19:53'),(1705,187,6,0,1,NULL,0,NULL,'2026-04-09 10:19:53'),(1711,193,6,1,0,NULL,0,NULL,'2026-04-09 10:19:55'),(1712,193,6,2,0,NULL,0,NULL,'2026-04-09 10:19:55'),(1713,193,6,3,0,NULL,0,NULL,'2026-04-09 10:19:55'),(1714,193,6,4,0,NULL,0,NULL,'2026-04-09 10:19:55'),(1715,193,6,0,1,NULL,0,NULL,'2026-04-09 10:19:55'),(1721,191,6,1,0,NULL,0,NULL,'2026-04-09 10:19:57'),(1722,191,6,2,0,NULL,0,NULL,'2026-04-09 10:19:57'),(1723,191,6,3,0,NULL,0,NULL,'2026-04-09 10:19:57'),(1724,191,6,4,0,NULL,0,NULL,'2026-04-09 10:19:57'),(1725,191,6,0,1,NULL,0,NULL,'2026-04-09 10:19:57'),(1731,190,6,1,0,NULL,0,NULL,'2026-04-09 10:19:59'),(1732,190,6,2,0,NULL,0,NULL,'2026-04-09 10:19:59'),(1733,190,6,3,0,NULL,0,NULL,'2026-04-09 10:19:59'),(1734,190,6,4,0,NULL,0,NULL,'2026-04-09 10:19:59'),(1735,190,6,0,1,NULL,0,NULL,'2026-04-09 10:19:59'),(1741,195,6,1,0,NULL,0,NULL,'2026-04-09 10:20:01'),(1742,195,6,2,0,NULL,0,NULL,'2026-04-09 10:20:01'),(1743,195,6,3,0,NULL,0,NULL,'2026-04-09 10:20:01'),(1744,195,6,4,0,NULL,0,NULL,'2026-04-09 10:20:01'),(1745,195,6,0,1,NULL,0,NULL,'2026-04-09 10:20:01');
/*!40000 ALTER TABLE `boletin_puestos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comunicados_rectoria`
--

DROP TABLE IF EXISTS `comunicados_rectoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comunicados_rectoria` (
  `id_comunicado` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `titulo` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `contenido` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tipo_comunicado` enum('Circular','Aviso','Información','Advertencia') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Información',
  `audiencia` enum('General','Docentes','Coordinación','Administrativo') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'General',
  `prioridad` enum('Baja','Media','Alta','Urgente') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Media',
  `fecha_publicacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `activo` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_comunicado`),
  KEY `idx_id_usuario` (`id_usuario`),
  CONSTRAINT `fk_comunicados_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comunicados_rectoria`
--

LOCK TABLES `comunicados_rectoria` WRITE;
/*!40000 ALTER TABLE `comunicados_rectoria` DISABLE KEYS */;
INSERT INTO `comunicados_rectoria` VALUES (18,12,'ssdfssdffsd','sdfsdsdfsdf','Información','General','Urgente','2026-04-07 23:27:33',1,'2026-04-08 04:27:33','2026-04-08 04:27:33'),(19,12,'7877448','sadasdsad','Advertencia','General','Alta','2026-04-08 16:45:36',1,'2026-04-08 21:45:36','2026-04-08 21:45:36'),(20,12,'adasdadsasad','asdasdsadsad','Circular','Docentes','Baja','2026-04-08 17:49:05',1,'2026-04-08 22:49:05','2026-04-08 22:49:05');
/*!40000 ALTER TABLE `comunicados_rectoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_asistencia`
--

DROP TABLE IF EXISTS `detalle_asistencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_asistencia` (
  `id_detalle_asistencia` int NOT NULL AUTO_INCREMENT,
  `id_asistencia_diaria` int NOT NULL,
  `id_estudiante` int NOT NULL,
  `asistio` enum('presente','ausente','tardio','no_registrado') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'no_registrado',
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
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Tabla de detalle de asistencias por estudiante';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_asistencia`
--

LOCK TABLES `detalle_asistencia` WRITE;
/*!40000 ALTER TABLE `detalle_asistencia` DISABLE KEYS */;
INSERT INTO `detalle_asistencia` VALUES (1,1,119,'ausente',NULL,'','2026-04-07 01:14:19','2026-04-07 01:15:21'),(2,1,118,'ausente',NULL,'','2026-04-07 01:14:19','2026-04-07 01:15:21'),(3,1,117,'ausente',NULL,'','2026-04-07 01:14:19','2026-04-07 01:15:21'),(4,1,205,'ausente',NULL,'','2026-04-07 01:14:19','2026-04-07 01:15:21'),(5,1,196,'ausente',NULL,'','2026-04-07 01:14:19','2026-04-07 01:15:21'),(6,1,202,'ausente',NULL,'','2026-04-07 01:14:19','2026-04-07 01:15:21'),(13,2,119,'ausente',NULL,'','2026-04-07 01:17:11','2026-04-07 01:17:11'),(14,2,118,'ausente',1,'adasd','2026-04-07 01:17:11','2026-04-07 01:19:30'),(15,2,117,'ausente',NULL,'','2026-04-07 01:17:11','2026-04-07 01:17:11'),(16,2,205,'presente',NULL,'','2026-04-07 01:17:11','2026-04-07 01:17:11'),(17,2,196,'ausente',NULL,'','2026-04-07 01:17:11','2026-04-07 01:17:11'),(18,2,202,'tardio',NULL,'','2026-04-07 01:17:11','2026-04-07 01:17:11'),(31,3,287,'ausente',NULL,'','2026-04-08 13:09:13','2026-04-08 22:49:33'),(32,3,119,'ausente',2,'','2026-04-08 13:09:13','2026-04-08 13:11:11'),(33,3,118,'presente',NULL,'','2026-04-08 13:09:13','2026-04-08 13:09:13'),(34,3,117,'presente',NULL,'','2026-04-08 13:09:13','2026-04-08 13:09:13'),(35,3,205,'presente',NULL,'','2026-04-08 13:09:13','2026-04-08 13:09:13'),(36,3,196,'presente',NULL,'','2026-04-08 13:09:13','2026-04-08 13:09:13'),(37,3,202,'presente',NULL,'','2026-04-08 13:09:13','2026-04-08 13:09:13'),(45,4,287,'ausente',3,'dsadsads','2026-04-09 15:14:11','2026-04-09 15:15:35'),(46,4,119,'no_registrado',NULL,'','2026-04-09 15:14:11','2026-04-09 15:14:11'),(47,4,118,'no_registrado',NULL,'','2026-04-09 15:14:11','2026-04-09 15:14:11'),(48,4,117,'no_registrado',NULL,'','2026-04-09 15:14:11','2026-04-09 15:14:11'),(49,4,205,'no_registrado',NULL,'','2026-04-09 15:14:11','2026-04-09 15:14:11'),(50,4,196,'no_registrado',NULL,'','2026-04-09 15:14:11','2026-04-09 15:14:11'),(51,4,202,'no_registrado',NULL,'','2026-04-09 15:14:11','2026-04-09 15:14:11');
/*!40000 ALTER TABLE `detalle_asistencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estudiantes`
--

DROP TABLE IF EXISTS `estudiantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estudiantes` (
  `id_estudiante` int NOT NULL AUTO_INCREMENT,
  `documento` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `apellido` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `genero` enum('M','F','Otro') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'M',
  `id_grupo` int NOT NULL,
  `acudiente_nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `acudiente_telefono` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `estado` enum('Activo','Inactivo','Egresado') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Activo' COMMENT 'Estado del estudiante en la institución',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_estudiante`),
  UNIQUE KEY `uk_documento` (`documento`),
  UNIQUE KEY `uq_corre` (`correo`),
  KEY `idx_id_grupo` (`id_grupo`),
  KEY `idx_estado` (`estado`),
  CONSTRAINT `fk_estudiantes_grupo` FOREIGN KEY (`id_grupo`) REFERENCES `grupos` (`id_grupo`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=288 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estudiantes`
--

LOCK TABLES `estudiantes` WRITE;
/*!40000 ALTER TABLE `estudiantes` DISABLE KEYS */;
INSERT INTO `estudiantes` VALUES (101,'1001001001','Carlos','García López',NULL,'M',1,'María López','3001234567','carlosgarcia@gmail.com','Calle 1 #10-20','Activo','2026-01-12 01:02:33','2026-02-13 14:22:15'),(102,'1001001002','Ana María','Rodríguez Pérez','2008-05-22','F',1,'Pedro Rodríguez','3002345678',NULL,'Cra 5 #15-30','Activo','2026-01-12 01:02:33','2026-01-12 01:02:33'),(103,'1001001003','Juan David','Martínez Ruiz','2008-01-10','M',1,'Laura Ruiz','3003456789',NULL,'Av 10 #20-40','Activo','2026-01-12 01:02:33','2026-01-12 01:02:33'),(104,'1001001004','Valentina','Hernández Torres','2008-07-28','F',1,'José Hernández','3004567890',NULL,'Calle 8 #5-12','Activo','2026-01-12 01:02:33','2026-01-12 01:02:33'),(105,'1001001005','Santiago','López Vargas','2008-11-03','M',1,'Carmen Vargas','3005678901',NULL,'Cra 12 #8-45','Activo','2026-01-12 01:02:33','2026-01-12 01:02:33'),(106,'1001001006','Sofía','Díaz Moreno',NULL,'F',2,'Roberto Díaz','3006789012','sofiadiaz@gmail.com','Calle 15 #22-10','Activo','2026-01-12 01:02:33','2026-02-13 14:34:12'),(107,'1001001007','Mateo','Torres Silva','2008-09-25','M',2,'Patricia Torres','3007890123',NULL,'Av 5 #30-55','Activo','2026-01-12 01:02:33','2026-01-12 01:02:33'),(108,'1001001008','Isabella','Sánchez Rojas','2008-02-14','F',2,'Miguel Sánchez','3008901234',NULL,'Cra 20 #18-30','Activo','2026-01-12 01:02:33','2026-01-12 01:02:33'),(109,'1001001009','Sebastián','Ramírez Castro','2008-06-30','M',2,'Gloria Ramírez','3009012345',NULL,'Calle 25 #12-65','Activo','2026-01-12 01:02:33','2026-01-12 01:02:33'),(110,'1001001010','Mariana','Flores Ortiz',NULL,'F',2,'Luis Flores','3010123456','marianaflores@gmail.com','Av 8 #40-20','Activo','2026-01-12 01:02:33','2026-02-13 14:34:28'),(111,'1101001001','Andrés Felipe','Gómez Parra',NULL,'M',4,'Marta Parra','3011234567','andresgomez@gmail.com','Calle 30 #5-10','Activo','2026-01-12 01:02:33','2026-02-13 14:40:03'),(112,'1101001002','Camila Andrea','Reyes Mendoza','2007-03-08','F',4,'Carlos Reyes','3012345678',NULL,'Cra 15 #25-40','Activo','2026-01-12 01:02:33','2026-01-12 01:02:33'),(113,'1101001003','Daniel Alejandro','Cruz Vega',NULL,'M',4,'Diana Cruz','3013456789','danielcruzvega@gmail.com','Av 12 #8-22','Activo','2026-01-12 01:02:33','2026-02-13 14:37:31'),(114,'1101001004','Laura Daniela','Vargas Luna','2007-07-24','F',4,'Fernando Vargas','3014567890',NULL,'Calle 18 #30-15','Activo','2026-01-12 01:02:33','2026-01-12 01:02:33'),(115,'1101001005','Nicolás','Moreno Arias','2007-09-02','M',4,'Sandra Moreno','3015678901',NULL,'Cra 8 #42-50','Activo','2026-01-12 01:02:33','2026-01-12 01:02:33'),(116,'0601001001','Kevin','Castro Mejía',NULL,'M',24,'Rosa Castr','30167890','kevincastro@gmail.com','Calle 5 #10-30','Activo','2026-01-12 01:02:33','2026-02-13 14:19:33'),(117,'0601001002','Paula','Ríos Guzmán',NULL,'F',17,'Juan Ríos','3017890123','lacra@gmai.com','Av 3 #15-25','Activo','2026-01-12 01:02:33','2026-02-13 02:03:01'),(118,'0601001003','Miguel Ángel','Peña Núñez',NULL,'M',17,'Elena Peña','3018901234','langostamutante@gmail.com','Cra 10 #20-45','Activo','2026-01-12 01:02:33','2026-02-12 23:58:53'),(119,'0601001004','Sara','Ospina Duart','2026-03-30','F',17,'Andrés Ospina','3019012345','shanyaherrera3@gmail.com','Calle 12 #8-18','Activo','2026-01-12 01:02:33','2026-04-08 04:22:08'),(121,'0701001001','Alejandra','Jiménez Leal','2012-01-12','F',19,'Ricardo Jiménez','3021234567',NULL,'Calle 22 #14-20','Activo','2026-01-12 01:02:33','2026-01-12 01:02:33'),(122,'0701001002','Felipe','Correa Suárez',NULL,'M',19,'Adriana Correa','3022345678','felipecorrea@gmail.com','Cra 6 #28-35','Activo','2026-01-12 01:02:33','2026-02-13 13:59:40'),(123,'0701001003','Natalia','Rincón Herrera','2012-05-18','F',19,'Jorge Rincón','3023456789',NULL,'Av 15 #10-42','Activo','2026-01-12 01:02:33','2026-01-12 01:02:33'),(124,'0701001004','David','Parra Guerrero','2012-07-30','M',19,'Claudia Parra','3024567890',NULL,'Calle 8 #45-12','Activo','2026-01-12 01:02:33','2026-01-12 01:02:33'),(125,'0701001005','Carolina','Vera Montoya','2012-09-14','F',19,'Alberto Vera','3025678901',NULL,'Cra 18 #22-55','Activo','2026-01-12 01:02:33','2026-01-12 01:02:33'),(126,'0801001001','Luis Fernando','Arango Mesa',NULL,'M',21,'Clara Mesa','3101234567','luisarango@gmail.com','Calle 40 #12-30','Activo','2026-01-12 01:15:10','2026-02-13 14:03:40'),(127,'0801001002','María José','Benavides Ruiz',NULL,'F',21,'Jorge Benavides','3102345678','mariabenavides@gmail.com','Cra 25 #8-15','Activo','2026-01-12 01:15:10','2026-02-13 14:04:00'),(128,'0801001003','Pedro Pablo','Castaño López',NULL,'M',21,'Ana López','3103456789','pedrocastano@gmail.com','Av 18 #22-40','Activo','2026-01-12 01:15:10','2026-02-13 14:04:30'),(129,'0801001004','Juliana','Duarte Peña','2011-08-28','F',21,'Ramiro Duarte','3104567890',NULL,'Calle 15 #5-12','Activo','2026-01-12 01:15:10','2026-01-12 01:15:10'),(130,'0801001005','Esteban','Escobar Vargas','2011-10-03','M',21,'Martha Vargas','3105678901',NULL,'Cra 30 #18-45','Activo','2026-01-12 01:15:10','2026-01-12 01:15:10'),(131,'0802001001','Daniela','Franco Mejía',NULL,'F',22,'Gustavo Franco','3106789012','danielafranco@gmail.com','Calle 22 #14-10','Activo','2026-01-12 01:15:10','2026-02-13 14:06:07'),(132,'0802001002','Gabriel','Giraldo Silva',NULL,'M',22,'Lucía Giraldo','3107890123','gabrielgiraldo@gmail.com','Av 12 #30-55','Activo','2026-01-12 01:15:10','2026-02-13 14:06:22'),(133,'0802001003','Valeria','Henao Rojas',NULL,'F',22,'Andrés Henao','3108901234','valeriahenao@gmail.com','Cra 8 #18-30','Activo','2026-01-12 01:15:10','2026-02-13 14:06:40'),(134,'0802001004','Martín','Ibarra Castro','2011-07-30','M',22,'Sandra Ibarra','3109012345',NULL,'Calle 35 #12-65','Activo','2026-01-12 01:15:10','2026-01-12 01:15:10'),(135,'0802001005','Luciana','Jaramillo Ortiz','2011-09-12','F',22,'Felipe Jaramillo','3110123456',NULL,'Av 20 #40-20','Activo','2026-01-12 01:15:10','2026-01-12 01:15:10'),(136,'0901001001','Sebastián','Largo Parra',NULL,'M',23,'Teresa Parra','3111234567','sebastianlargo@gmail.com','Calle 50 #5-10','Activo','2026-01-12 01:15:10','2026-02-13 14:08:12'),(137,'0901001002','Isabella','Montoya Mendoza','2010-03-08','F',23,'Roberto Montoya','3112345678',NULL,'Cra 35 #25-40','Activo','2026-01-12 01:15:10','2026-01-12 01:15:10'),(138,'0901001003','Nicolás','Naranjo Vega','2010-05-16','M',23,'Diana Naranjo','3113456789',NULL,'Av 28 #8-22','Activo','2026-01-12 01:15:10','2026-01-12 01:15:10'),(139,'0901001004','Mariana','Ocampo Luna','2010-07-24','F',23,'Fernando Ocampo','3114567890',NULL,'Calle 28 #30-15','Activo','2026-01-12 01:15:10','2026-01-12 01:15:10'),(140,'0901001005','Alejandro','Pineda Arias','2010-09-02','M',23,'Gloria Pineda','3115678901',NULL,'Cra 18 #42-50','Activo','2026-01-12 01:15:10','2026-01-12 01:15:10'),(141,'0902001001','Sofía','Quintero Mejía','2010-02-28','F',24,'Juan Quintero','3116789012',NULL,'Calle 45 #10-30','Activo','2026-01-12 01:15:10','2026-01-12 01:15:10'),(142,'0902001002','Diego','Ramírez Guzmán','2010-04-15','M',24,'Carmen Ramírez','3117890123',NULL,'Av 15 #15-25','Activo','2026-01-12 01:15:10','2026-01-12 01:15:10'),(143,'0902001003','Valentina','Salazar Núñez','2010-06-22','F',24,'Pedro Salazar','3118901234',NULL,'Cra 22 #20-45','Activo','2026-01-12 01:15:10','2026-01-12 01:15:10'),(144,'0902001004','Tomás','Torres Duarte','2010-08-10','M',24,'Marcela Torres','3119012345',NULL,'Calle 32 #8-18','Activo','2026-01-12 01:15:10','2026-01-12 01:15:10'),(145,'0902001005','Camila','Uribe Pineda','2010-10-05','F',24,'Alberto Uribe','3120123456',NULL,'Av 25 #35-60','Activo','2026-01-12 01:15:10','2026-01-12 01:15:10'),(146,'1000001800','Tomás','Ortiz Pérez','2012-10-18','M',18,'Valentina Ortiz','3191805323',NULL,'Calle 34 #29-71','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(147,'1000001801','Ana','Chávez Sánchez',NULL,'F',18,'Rosa Chávez','3187245333','anachavez@gmail.com','Calle 10 #28-96','Activo','2026-01-12 01:21:20','2026-02-13 13:52:35'),(148,'1000001802','Manuel','Rivera Rodríguez','2012-08-26','M',18,'Samuel Rivera','3151911550',NULL,'Calle 49 #15-56','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(149,'1000001803','Laura','Morales Díaz','2012-06-03','F',18,'Vicente Morales','3186853685',NULL,'Calle 21 #10-30','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(150,'1000001804','Manuel','Reyes Flores','2012-02-11','M',18,'Isabella Reyes','3106488847',NULL,'Calle 49 #8-23','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(151,'1000001805','Elena','Díaz Ramírez',NULL,'F',18,'Tatiana Díaz','3181743309','elenadiaz@gmail.com','Calle 46 #16-17','Activo','2026-01-12 01:21:20','2026-02-13 13:53:09'),(152,'1000001806','Iván','García Gutiérrez',NULL,'M',18,'Fernanda García','3197203495','ivangarcia@gmail.com','Calle 21 #12-82','Activo','2026-01-12 01:21:20','2026-02-13 13:53:48'),(153,'1000001807','Fernanda','López Martínez',NULL,'F',18,'Diego López','3126651824','fernandalopez@gmail.com','Calle 33 #5-10','Activo','2026-01-12 01:21:20','2026-02-13 13:54:03'),(154,'1000001808','Samuel','Reyes García','2012-01-28','M',18,'Rosa Reyes','3103689509',NULL,'Calle 50 #20-36','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(155,'1000001809','Laura','Flores Díaz',NULL,'F',18,'Samuel Flores','3124993057','lauraflorez@gmail.com','Calle 1 #15-35','Activo','2026-01-12 01:21:20','2026-02-13 13:53:27'),(156,'1000002000','Hugo','González Morales',NULL,'M',20,'Tomás González','3127695036','hugogonzales@gmail.com','Calle 5 #11-36','Activo','2026-01-12 01:21:20','2026-02-13 14:02:30'),(157,'1000002001','Paula','Ortiz Morales',NULL,'F',20,'Rosa Ortiz','3184817732','paulaortiz@gmail.com','Calle 23 #22-45','Activo','2026-01-12 01:21:20','2026-02-13 14:02:50'),(158,'1000002002','Eduardo','Ramírez García','2011-09-03','M',20,'Rosa Ramírez','3102023643',NULL,'Calle 41 #12-6','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(159,'1000002003','Olga','Ramírez Ortiz','2011-06-01','F',20,'Fernanda Ramírez','3165524608',NULL,'Calle 35 #24-34','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(160,'1000002004','Nicolás','García Hernández',NULL,'M',20,'Javier García','3103005991','nicolasgarcia@gmail.com','Calle 14 #16-69','Activo','2026-01-12 01:21:20','2026-02-13 14:01:41'),(161,'1000002005','Karen','Pérez Hernández','2011-08-03','F',20,'Javier Pérez','3121917745',NULL,'Calle 19 #14-96','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(162,'1000002006','Pablo','Flores Chávez',NULL,'M',20,'Helena Flores','3137720791','pabloflores@gmail.com','Calle 28 #14-89','Activo','2026-01-12 01:21:20','2026-02-13 14:01:20'),(163,'1000002007','Beatriz','Díaz González',NULL,'F',20,'Camila Díaz','3107142773','beatrizdiaz@gmail.com','Calle 25 #1-37','Activo','2026-01-12 01:21:20','2026-02-13 14:01:07'),(164,'1000002008','David','Torres Gómez','2011-09-27','M',20,'Laura Torres','3139234637',NULL,'Calle 21 #14-29','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(165,'1000002009','Natalia','Rivera Sánchez','2011-07-18','F',20,'Gabriel Rivera','3185464226',NULL,'Calle 38 #23-10','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(166,'1000000300','Nicolás','Díaz Gutiérrez',NULL,'M',3,'Felipe Díaz','3136653156','nicolasdiaz@gmail.com','Calle 1 #25-43','Activo','2026-01-12 01:21:20','2026-02-13 14:36:26'),(167,'1000000301','María','Flores Hernández',NULL,'F',3,'Javier Flores','3118552522','mariaflorez@gmail.com','Calle 5 #7-79','Activo','2026-01-12 01:21:20','2026-02-13 14:36:38'),(168,'1000000302','Carlos','Rodríguez Flores','2009-06-07','M',3,'Julia Rodríguez','3146957822',NULL,'Calle 44 #16-50','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(169,'1000000303','Ana','Morales Gómez','2009-08-08','F',3,'Tomás Morales','3133142879',NULL,'Calle 45 #3-6','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(170,'1000000304','Felipe','Martínez Chávez','2009-01-27','M',3,'Andrés Martínez','3136668458',NULL,'Calle 15 #15-90','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(171,'1000000305','Valentina','Chávez Flores',NULL,'F',3,'Pablo Chávez','3185140846','valentinachavez@gmail.com','Calle 33 #15-33','Activo','2026-01-12 01:21:20','2026-02-13 14:35:48'),(172,'1000000306','Vicente','Díaz Díaz',NULL,'M',3,'Julia Díaz','3105002224','vicentediaz@gmail.com','Calle 45 #29-94','Activo','2026-01-12 01:21:20','2026-02-13 14:36:12'),(173,'1000000307','Helena','Hernández Pérez','2009-02-10','F',3,'Felipe Hernández','3168161149',NULL,'Calle 25 #30-54','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(174,'1000000308','Carlos','Cruz Ramírez',NULL,'M',3,'Javier Cruz','3123200806','carloscruz@gmail.com','Calle 14 #24-32','Activo','2026-01-12 01:21:20','2026-02-13 14:36:01'),(175,'1000000309','Fernanda','Ortiz Ramírez','2009-01-14','F',3,'David Ortiz','3168935367',NULL,'Calle 18 #24-51','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(176,'1000000500','David','García Gómez',NULL,'M',5,'Leonardo García','3177545685','davidgarcia@gmail.com','Calle 35 #3-47','Activo','2026-01-12 01:21:20','2026-02-13 14:41:00'),(177,'1000000501','Julia','Gómez Ramírez',NULL,'F',5,'Hugo Gómez','3194262817','juliagomez@gmail.com','Calle 7 #10-14','Activo','2026-01-12 01:21:20','2026-02-13 14:41:15'),(178,'1000000502','Eduardo','Rivera González','2008-01-04','M',5,'Leonardo Rivera','3194690465',NULL,'Calle 22 #4-66','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(179,'1000000503','Elena','Morales González','2008-06-20','F',5,'Tatiana Morales','3124998620',NULL,'Calle 5 #7-79','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(180,'1000000504','Andrés','Cruz Díaz',NULL,'M',5,'Valentina Cruz','3142127925','andrescruz@gmail.com','Calle 32 #2-9','Activo','2026-01-12 01:21:20','2026-02-13 14:40:33'),(181,'1000000505','Ana','Cruz Cruz',NULL,'F',5,'Valentina Cruz','3149544473','anacruz@gmail.com','Calle 28 #1-2','Activo','2026-01-12 01:21:20','2026-02-13 14:40:22'),(182,'1000000506','Carlos','López Flores','2008-12-19','M',5,'Ana López','3142092209',NULL,'Calle 5 #17-66','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(183,'1000000507','Valentina','Flores Torres',NULL,'F',5,'Rosa Flores','3118775492','valentinaflorez@gmail.com','Calle 30 #15-60','Activo','2026-01-12 01:21:20','2026-02-13 14:40:46'),(184,'1000000508','Nicolás','González Rodríguez','2008-04-20','M',5,'Felipe González','3152687760',NULL,'Calle 50 #28-59','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(185,'1000000509','Natalia','Ortiz García','2008-02-17','F',5,'Pablo Ortiz','3185849030',NULL,'Calle 25 #2-20','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(186,'1000000600','Eduardo','Cruz Pérez',NULL,'M',6,'Ana Cruz','3136630064','eduardocruz@gmail.com','Calle 2 #16-80','Activo','2026-01-12 01:21:20','2026-02-13 14:41:47'),(187,'1000000601','Rosa','García Sánchez',NULL,'F',6,'Tomás García','3122868211','rosagarcia@gmail.com','Calle 3 #5-44','Activo','2026-01-12 01:21:20','2026-02-13 14:43:23'),(188,'1000000602','Pablo','García Reyes',NULL,'M',6,'Nicolás García','3123696150','pablogarcia@gmail.com','Calle 44 #2-23','Activo','2026-01-12 01:21:20','2026-02-13 14:42:24'),(189,'1000000603','Ana','Flores Sánchez',NULL,'F',6,'Tomás Flores','3186461243','anaflorez@gmail.com','Calle 11 #22-73','Activo','2026-01-12 01:21:20','2026-02-13 14:42:08'),(190,'1000000604','David','Pérez Morales','2008-02-07','M',6,'Fernanda Pérez','3114583997',NULL,'Calle 43 #11-80','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(191,'1000000605','Camila','López Reyes','2008-06-08','F',6,'Camila López','3116691332',NULL,'Calle 11 #1-8','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(193,'1000000607','Isabella','Gutiérrez Torres','2008-06-19','F',6,'David Gutiérrez','3148019324',NULL,'Calle 33 #19-66','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(194,'1000000608','Hugo','Flores Rodríguez',NULL,'M',6,'Fernanda Flores','3107669130','hugoflorez@gmail.com','Calle 44 #26-81','Activo','2026-01-12 01:21:20','2026-02-13 14:41:58'),(195,'1000000609','Olga','Ramírez Reyes','2008-08-16','F',6,'Ana Ramírez','3183821244',NULL,'Calle 18 #15-47','Activo','2026-01-12 01:21:20','2026-01-12 01:21:20'),(196,'2000001700','Alejandro','Torres Morales',NULL,'M',17,'Rafael Torres','3183796985','alejamdrotorres@gmail.com','Calle 41 #7-91','Activo','2026-01-12 01:21:42','2026-02-13 13:50:34'),(199,'2000001703','Natali','Martínez Cruz',NULL,'F',18,'Vicente Martínez','3113085318',NULL,'Calle 8 #2-27','Activo','2026-01-12 01:21:42','2026-02-02 21:41:47'),(200,'2000001704','Eduardo','Mendoza Reyes',NULL,'M',18,'Oscar Mendoza','3187471347',NULL,'Calle 8 #4-79','Activo','2026-01-12 01:21:42','2026-02-02 21:41:58'),(202,'2000001706','Gabriel','Torres Reyes',NULL,'M',17,'Elena Torres','3156314058','gabrieltorres@gmail.com','Calle 31 #19-28','Activo','2026-01-12 01:21:42','2026-02-13 13:52:07'),(205,'2000001709','Laura','Rodríguez Gómez',NULL,'F',17,'Pablo Rodríguez','3128079501','laura@gmail.com','Calle 27 #20-40','Activo','2026-01-12 01:21:42','2026-02-13 13:50:01'),(206,'2000001900','Andrés','González Rodríguez',NULL,'M',19,'Hugo González','3178366359','andresgonzales@gmail.com','Calle 39 #21-56','Activo','2026-01-12 01:21:42','2026-02-13 14:00:53'),(207,'2000001901','Karen','Chávez Rojas',NULL,'F',19,'Sofía Chávez','3125750156','karenchavez@gmail.com','Calle 23 #9-73','Activo','2026-01-12 01:21:42','2026-02-13 13:59:17'),(208,'2000001902','Samuel','Mendoza Torres','2011-10-10','M',19,'Elena Mendoza','3105479474',NULL,'Calle 20 #23-9','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(209,'2000001903','Daniela','Torres Gómez','2011-01-12','F',19,'Sofía Torres','3142508873',NULL,'Calle 11 #16-38','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(210,'2000001904','Kevin','Díaz Díaz',NULL,'M',19,'Daniela Díaz','3153153897','kevindiaz@gmail.com','Calle 27 #27-24','Activo','2026-01-12 01:21:42','2026-02-13 13:59:57'),(211,'2000001905','Isabella','Vargas Herrera','2011-11-15','F',19,'Oscar Vargas','3176461202',NULL,'Calle 14 #20-50','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(212,'2000001906','Tomás','González Torres','2011-12-18','M',19,'Valentina González','3117523353',NULL,'Calle 16 #9-34','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(213,'2000001907','Luciana','Sánchez Díaz','2011-02-23','F',19,'Natalia Sánchez','3133385827',NULL,'Calle 42 #23-44','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(214,'2000001908','Pablo','Herrera Hernández','2011-12-15','M',19,'Valentina Herrera','3124467195',NULL,'Calle 33 #10-14','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(215,'2000001909','Daniela','Chávez Cruz',NULL,'F',19,'Gabriela Chávez','3169370709','danielasanchez@gmail.com','Calle 8 #23-48','Activo','2026-01-12 01:21:42','2026-02-13 13:58:06'),(216,'2000002100','Daniel','Castro Rojas',NULL,'M',21,'María Castro','3154649920','danielcastro@gmail.com','Calle 30 #30-9','Activo','2026-01-12 01:21:42','2026-02-13 14:05:03'),(217,'2000002101','Daniela','Torres Rojas','2010-08-20','F',21,'Leonardo Torres','3158534794',NULL,'Calle 10 #1-46','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(220,'2000002104','Andrés','Ramírez Hernández','2010-05-12','M',21,'Daniel Ramírez','3179591387',NULL,'Calle 49 #18-88','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(221,'2000002105','Isabella','López Chávez','2010-02-05','F',21,'Daniel López','3111710937',NULL,'Calle 49 #13-31','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(222,'2000002106','Eduardo','Mendoza Castro','2010-06-19','M',21,'Gabriela Mendoza','3124419252',NULL,'Calle 3 #25-50','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(223,'2000002107','Natalia','Castro Ortiz',NULL,'F',21,'Eduardo Castro','3142036037','nataliacastro@gmail.com','Calle 40 #7-15','Activo','2026-01-12 01:21:42','2026-02-13 14:04:45'),(224,'2000002108','Pablo','Cruz Torres','2010-08-10','M',21,'Helena Cruz','3114762267',NULL,'Calle 16 #7-81','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(225,'2000002109','Tatiana','Ortiz Vargas','2010-10-23','F',21,'Ana Ortiz','3115403343',NULL,'Calle 29 #23-73','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(226,'2000002200','Leonardo','Castro Gutiérrez',NULL,'M',22,'Manuel Castro','3188398502','leonardocastro@gmail.com','Calle 40 #3-43','Activo','2026-01-12 01:21:42','2026-02-13 14:05:37'),(227,'2000002201','Paula','Vargas Torres','2010-06-09','F',22,'Diego Vargas','3148387629',NULL,'Calle 46 #14-44','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(228,'2000002202','Santiago','Ortiz Torres','2010-11-24','M',22,'Ana Ortiz','3113790234',NULL,'Calle 34 #17-38','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(229,'2000002203','Elena','Hernández Gutiérrez','2010-02-14','F',22,'Gabriel Hernández','3191554503',NULL,'Calle 3 #8-28','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(230,'2000002204','Manuel','Reyes Rojas','2010-12-20','M',22,'Paula Reyes','3112227782',NULL,'Calle 21 #23-76','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(231,'2000002205','Isabella','Rojas López','2010-06-11','F',22,'Pablo Rojas','3163100370',NULL,'Calle 14 #2-5','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(232,'2000002206','Alejandro','Rodríguez Mendoza','2010-07-25','M',22,'Diego Rodríguez','3106866138',NULL,'Calle 7 #2-26','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(233,'2000002207','Catalina','Ortiz Chávez','2010-11-21','F',22,'Hugo Ortiz','3181497147',NULL,'Calle 27 #6-46','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(234,'2000002208','Santiago','Chávez Cruz',NULL,'M',22,'Iván Chávez','3144960182','santiagochavez@gmail.com','Calle 23 #15-88','Activo','2026-01-12 01:21:42','2026-02-13 14:05:51'),(235,'2000002209','Sara','Morales Mendoza','2010-06-24','F',22,'Mateo Morales','3161743861',NULL,'Calle 45 #13-98','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(236,'2000002300','Gabriel','Martínez Flores',NULL,'M',23,'Fernanda Martínez','3161642506','gabierlmartinez@gmail.com','Calle 50 #22-91','Activo','2026-01-12 01:21:42','2026-02-13 14:08:32'),(237,'2000002301','Gabriela','Rivera Díaz','2009-04-09','F',23,'Ana Rivera','3136231372',NULL,'Calle 21 #11-77','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(238,'2000002302','Rafael','Ramírez Morales','2009-11-27','M',23,'Mariana Ramírez','3191733573',NULL,'Calle 48 #17-11','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(239,'2000002303','Elena','Mendoza Rojas',NULL,'F',23,'Catalina Mendoza','3159373878','elenarojas@gmail.com','Calle 32 #18-95','Activo','2026-01-12 01:21:42','2026-02-13 14:18:37'),(240,'2000002304','Sebastián','Gómez Rivera',NULL,'M',23,'Catalina Gómez','3157175603','sebastiangomez@gmail.com','Calle 43 #14-15','Activo','2026-01-12 01:21:42','2026-02-13 14:07:36'),(241,'2000002305','Daniela','Martínez Rodríguez',NULL,'F',23,'Kevin Martínez','3199853648','danielamartinez@gmail.com','Calle 29 #8-88','Activo','2026-01-12 01:21:42','2026-02-13 14:18:08'),(242,'2000002306','Carlos','Gómez Ramírez',NULL,'M',23,'Javier Gómez','3184543416','carlosgomez@gmail.com','Calle 31 #27-9','Activo','2026-01-12 01:21:42','2026-02-13 14:07:22'),(243,'2000002307','Andrea','Ramírez Castro','2009-01-01','F',23,'Olga Ramírez','3142980411',NULL,'Calle 37 #4-55','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(244,'2000002308','Samuel','Ortiz Rivera','2009-11-28','M',23,'Tomás Ortiz','3156378431',NULL,'Calle 35 #29-88','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(245,'2000002309','Fernanda','Rodríguez Mendoza','2009-10-17','F',23,'Valentina Rodríguez','3145425470',NULL,'Calle 30 #20-75','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(246,'2000002400','Sebastián','Rodríguez Torres','2009-01-04','M',24,'Daniel Rodríguez','3142584427',NULL,'Calle 11 #16-85','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(247,'2000002401','Andrea','Ortiz López','2009-06-12','F',24,'Nicolás Ortiz','3111465507',NULL,'Calle 26 #22-54','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(248,'2000002402','Javier','González Hernández',NULL,'M',24,'Nicolás González','3159178394','javiergonzales@gmail.com','Calle 14 #29-58','Activo','2026-01-12 01:21:42','2026-02-13 14:20:41'),(249,'2000002403','Helena','Castro Sánchez',NULL,'F',24,'Oscar Castro','3188185564','helenacastro@gmail.com','Calle 38 #11-48','Activo','2026-01-12 01:21:42','2026-02-13 14:19:50'),(250,'2000002404','Eduardo','Castro Torres',NULL,'M',24,'Elena Castro','3114344989','eduardocastro@gmail.com','Calle 50 #1-34','Activo','2026-01-12 01:21:42','2026-02-13 14:20:04'),(251,'2000002405','Olga','Hernández Sánchez','2009-06-16','F',24,'Camila Hernández','3125361535',NULL,'Calle 20 #2-16','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(252,'2000002406','Kevin','Reyes Torres','2009-05-16','M',24,'Nicolás Reyes','3107997421',NULL,'Calle 37 #4-18','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(253,'2000002407','Paula','López Rojas','2009-10-07','F',24,'María López','3123102077',NULL,'Calle 1 #22-76','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(254,'2000002408','Daniel','Cruz Cruz',NULL,'M',24,'Andrea Cruz','3167415810','danielcruz@gmail.com','Calle 5 #21-51','Activo','2026-01-12 01:21:42','2026-02-13 14:20:25'),(255,'2000002409','Isabella','Ramírez Castro','2009-05-06','F',24,'Julia Ramírez','3157849390',NULL,'Calle 8 #15-68','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(256,'2000000100','Sebastián','Ramírez Castro','2008-07-16','M',1,'Leonardo Ramírez','3166736587',NULL,'Calle 32 #15-87','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(257,'2000000101','Laura','Ramírez Ramírez','2008-02-11','F',1,'Valentina Ramírez','3187495739',NULL,'Calle 14 #8-86','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(258,'2000000102','Alejandro','Ramírez Hernández','2008-02-14','M',1,'Tatiana Ramírez','3144865216',NULL,'Calle 12 #16-24','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(259,'2000000103','Karen','Gutiérrez Ramírez',NULL,'F',1,'Catalina Gutiérrez','3129980618','karengutierrez@gmail.com','Calle 29 #15-77','Activo','2026-01-12 01:21:42','2026-02-13 14:30:35'),(260,'2000000104','Rafael','Herrera González','2008-03-20','M',1,'Samuel Herrera','3152105519',NULL,'Calle 25 #3-87','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(261,'2000000105','Ana','Morales Torres','2008-09-04','F',1,'Manuel Morales','3112022458',NULL,'Calle 5 #19-45','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(262,'2000000106','Felipe','Torres López','2008-05-07','M',1,'Daniela Torres','3192578581',NULL,'Calle 25 #16-91','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(263,'2000000107','Fernanda','Gómez Reyes',NULL,'F',1,'Daniela Gómez','3165349746','fernandagomez@gmail.com','Calle 10 #14-5','Activo','2026-01-12 01:21:42','2026-02-13 14:29:31'),(264,'2000000108','Daniel','Cruz Martínez',NULL,'M',1,'Kevin Cruz','3182916667','danielcruzmartinez@gmail.com','Calle 34 #28-25','Activo','2026-01-12 01:21:42','2026-02-13 14:21:15'),(265,'2000000109','Tatiana','Flores Torres',NULL,'F',1,'Paula Flores','3151339427','tatianaflores@gmail.com','Calle 43 #9-92','Activo','2026-01-12 01:21:42','2026-02-13 14:21:31'),(266,'2000000200','Carlos','Hernández Rivera',NULL,'M',2,'Daniela Hernández','3176091142','carloshernandez@gmail.com','Calle 8 #4-21','Activo','2026-01-12 01:21:42','2026-02-13 14:34:43'),(267,'2000000201','Tatiana','Vargas Mendoza','2008-02-02','F',2,'Nicolás Vargas','3167391679',NULL,'Calle 4 #20-63','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(268,'2000000202','Andrés','Vargas Chávez','2008-01-28','M',2,'Laura Vargas','3169322141',NULL,'Calle 32 #14-43','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(269,'2000000203','Laura','López Castro',NULL,'F',2,'Kevin López','3112414050','lauralopez@gmail.com','Calle 43 #29-6','Activo','2026-01-12 01:21:42','2026-02-13 14:35:00'),(270,'2000000204','Oscar','López Flores',NULL,'M',2,'Gabriela López','3115282789','oscarlopez@gmail.com','Calle 20 #14-62','Activo','2026-01-12 01:21:42','2026-02-13 14:35:10'),(271,'2000000205','Beatriz','Ramírez Rivera','2008-05-25','F',2,'Santiago Ramírez','3174332550',NULL,'Calle 23 #22-15','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(272,'2000000206','Rafael','Ortiz López','2008-08-10','M',2,'Catalina Ortiz','3151426722',NULL,'Calle 37 #13-25','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(273,'2000000207','Beatriz','Martínez Mendoza',NULL,'F',2,'Kevin Martínez','3184458286','beatrizmartinez@gmail.com','Calle 23 #9-91','Activo','2026-01-12 01:21:42','2026-02-13 14:35:28'),(274,'2000000208','Carlos','Mendoza García','2008-07-17','M',2,'Catalina Mendoza','3156910364',NULL,'Calle 46 #25-74','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(275,'2000000209','Olga','Vargas Ortiz','2008-12-07','F',2,'Sofía Vargas','3178254525',NULL,'Calle 45 #9-43','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(276,'2000000400','Felipe','Reyes Hernández','2007-02-26','M',4,'Camila Reyes','3192972315',NULL,'Calle 13 #2-98','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(277,'2000000401','Natalia','Gómez Martínez',NULL,'F',4,'Luciana Gómez','3167841743','nataliagomez@gmail.com','Calle 8 #5-21','Activo','2026-01-12 01:21:42','2026-02-13 14:39:24'),(278,'2000000402','Santiago','López García','2007-02-25','M',4,'Daniela López','3112184984',NULL,'Calle 2 #28-80','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(279,'2000000403','Helena','Rivera Vargas','2007-04-13','F',4,'Diego Rivera','3107509728',NULL,'Calle 28 #6-60','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(280,'2000000404','Rafael','Torres Sánchez','2007-02-26','M',4,'Pablo Torres','3163464922',NULL,'Calle 39 #27-47','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(281,'2000000405','Elena','Herrera Gutiérrez','2007-01-02','F',4,'Iván Herrera','3128732642',NULL,'Calle 43 #16-61','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(282,'2000000406','Diego','Mendoza Chávez','2007-04-20','M',4,'Pablo Mendoza','3175715528',NULL,'Calle 24 #24-10','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(283,'2000000407','Natalia','Chávez Flores',NULL,'F',4,'Gabriel Chávez','3126822126','nataliachavez@gmail.com','Calle 7 #20-74','Activo','2026-01-12 01:21:42','2026-02-13 14:36:56'),(284,'2000000408','Tomás','Morales Sánchez','2007-08-23','M',4,'Andrea Morales','3173095029',NULL,'Calle 30 #26-93','Activo','2026-01-12 01:21:42','2026-01-12 01:21:42'),(285,'2000000409','Fernanda','Flores González',NULL,'F',4,'Tomás Flores','3183875045','fernanadaflores@gmail.com','Calle 21 #23-78','Activo','2026-01-12 01:21:42','2026-02-13 14:39:09'),(287,'3123213213','12312213','12312312','2026-03-02','Otro',17,'13123123','123123213','asadsaddsadsa@gmail.com','123123123','Activo','2026-04-08 04:22:39','2026-04-08 04:24:32');
/*!40000 ALTER TABLE `estudiantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grados`
--

DROP TABLE IF EXISTS `grados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grados` (
  `id_grado` int NOT NULL AUTO_INCREMENT,
  `numero_grado` int NOT NULL,
  `id_nivel` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `nombre_grado` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id_grado`),
  UNIQUE KEY `uk_numero_grado` (`numero_grado`),
  KEY `idx_id_nivel` (`id_nivel`),
  CONSTRAINT `fk_grados_nivel` FOREIGN KEY (`id_nivel`) REFERENCES `niveles` (`id_nivel`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grados`
--

LOCK TABLES `grados` WRITE;
/*!40000 ALTER TABLE `grados` DISABLE KEYS */;
INSERT INTO `grados` VALUES (6,6,2,NULL,'2026-04-08 23:06:10','6vo'),(7,7,2,NULL,'2026-01-14 23:09:44','7vo'),(8,8,2,NULL,'2026-01-14 23:09:44','8vo'),(9,9,2,NULL,'2026-01-14 23:09:44','9vo'),(10,10,3,NULL,'2026-01-14 23:09:44','10vo'),(11,11,3,NULL,'2026-01-14 23:09:44','11vo');
/*!40000 ALTER TABLE `grados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupos`
--

DROP TABLE IF EXISTS `grupos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupos`
--

LOCK TABLES `grupos` WRITE;
/*!40000 ALTER TABLE `grupos` DISABLE KEYS */;
INSERT INTO `grupos` VALUES (1,'10-01',10,40,NULL,NULL),(2,'10-02',10,40,NULL,NULL),(3,'10-03',10,40,NULL,NULL),(4,'11-01',11,40,NULL,NULL),(5,'11-02',11,40,NULL,NULL),(6,'11-03',11,40,NULL,NULL),(17,'6-Aa',6,40,NULL,'2026-01-14 23:34:01'),(18,'6-B',6,40,NULL,NULL),(19,'7-A',7,40,NULL,NULL),(20,'7-B',7,40,NULL,NULL),(21,'8-A',8,40,NULL,NULL),(22,'8-B',8,40,NULL,NULL),(23,'9-A',9,40,'2026-01-12 01:14:17','2026-01-12 01:14:17'),(24,'9-B',9,40,'2026-01-12 01:14:17','2026-01-12 01:14:17'),(32,'6-C',6,38,'2026-03-04 02:38:54','2026-03-04 02:39:04');
/*!40000 ALTER TABLE `grupos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horarios`
--

DROP TABLE IF EXISTS `horarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `horarios` (
  `id_horario` int NOT NULL AUTO_INCREMENT,
  `id_asignacion` int NOT NULL,
  `id_grupo` int NOT NULL,
  `dia_semana` enum('Lunes','Martes','Miércoles','Jueves','Viernes') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=164 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horarios`
--

LOCK TABLES `horarios` WRITE;
/*!40000 ALTER TABLE `horarios` DISABLE KEYS */;
INSERT INTO `horarios` VALUES (141,58,17,'Lunes','07:00:00','08:00:00',NULL,'','','2026-04-04 01:10:13','2026-04-04 01:10:13'),(142,58,17,'Martes','07:00:00','08:00:00',NULL,'','','2026-04-04 01:10:42','2026-04-04 01:10:42'),(143,58,17,'Miércoles','07:00:00','08:00:00',NULL,'','','2026-04-04 01:10:43','2026-04-04 01:10:43'),(147,77,17,'Lunes','08:00:00','09:00:00',NULL,'','','2026-04-04 01:11:50','2026-04-04 01:11:50'),(148,106,17,'Lunes','09:00:00','10:00:00',NULL,'','','2026-04-04 01:11:54','2026-04-04 01:11:54'),(149,119,17,'Martes','08:00:00','09:00:00',NULL,'','','2026-04-04 01:11:58','2026-04-04 01:11:58'),(150,119,17,'Miércoles','08:00:00','09:00:00',NULL,'','','2026-04-04 01:12:04','2026-04-04 01:12:04'),(151,93,17,'Jueves','07:00:00','08:00:00',NULL,'','','2026-04-04 01:12:08','2026-04-04 01:12:08'),(152,93,17,'Jueves','08:00:00','09:00:00',NULL,'','','2026-04-04 01:12:11','2026-04-04 01:12:11'),(155,112,23,'Lunes','07:00:00','08:00:00',NULL,'','','2026-04-08 09:22:25','2026-04-08 09:22:25'),(156,106,17,'Viernes','07:00:00','08:00:00',NULL,'','asdsad','2026-04-08 22:59:50','2026-04-08 22:59:50'),(157,106,17,'Viernes','10:00:00','11:00:00',NULL,'','asdsad','2026-04-08 23:00:09','2026-04-08 23:00:09'),(158,106,17,'Jueves','10:00:00','11:00:00',NULL,'','asdsad','2026-04-08 23:00:24','2026-04-08 23:00:24'),(159,58,17,'Viernes','08:00:00','09:00:00',NULL,'','','2026-04-08 23:02:04','2026-04-08 23:02:04'),(160,58,17,'Viernes','09:00:00','10:00:00',NULL,'','','2026-04-08 23:02:13','2026-04-08 23:02:13'),(161,58,17,'Jueves','09:00:00','10:00:00',NULL,'','','2026-04-08 23:02:27','2026-04-08 23:02:27'),(162,77,17,'Martes','09:00:00','10:00:00',NULL,'','','2026-04-08 23:06:45','2026-04-08 23:06:45'),(163,119,17,'Martes','10:00:00','11:00:00',NULL,'','','2026-04-08 23:07:17','2026-04-08 23:07:17');
/*!40000 ALTER TABLE `horarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `justificantes_ausencia`
--

DROP TABLE IF EXISTS `justificantes_ausencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `justificantes_ausencia` (
  `id_justificante` int NOT NULL AUTO_INCREMENT,
  `id_asistencia` int NOT NULL,
  `id_estudiante` int NOT NULL,
  `tipo_justificante` enum('Médico','Familiar','Administrativo','Otro') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Otro',
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `justificantes_ausencia`
--

LOCK TABLES `justificantes_ausencia` WRITE;
/*!40000 ALTER TABLE `justificantes_ausencia` DISABLE KEYS */;
INSERT INTO `justificantes_ausencia` VALUES (1,3,118,'Médico','uploads/justificantes/just_3_9cdb750d78e14adbafa6f48fbb26243f.pdf','le dio sida',1,12,'2026-04-06 20:17:46','2026-04-07','2026-04-07 01:17:34','2026-04-07 01:18:56'),(2,33,119,'Médico','uploads/justificantes/just_33_5e56c05a9f664cc780c39d23350f523a.pdf','La estudiante Sara Ospina no pudo asistir el día 08 de Abril del 2026 debido a qué estaba incapacitada por dolor crónico.',1,12,'2026-04-08 08:11:21','2026-04-08','2026-04-08 13:11:11','2026-04-08 13:11:21'),(3,46,287,'Médico','uploads/justificantes/just_46_12b6fa4599514994af870fef24995f12.pdf','dsadsads',1,12,'2026-04-09 10:15:47','2026-04-09','2026-04-09 15:15:35','2026-04-09 15:15:47');
/*!40000 ALTER TABLE `justificantes_ausencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_registro`
--

DROP TABLE IF EXISTS `log_registro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_registro` (
  `id_log` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int DEFAULT NULL,
  `tipo_accion` enum('Login','Logout','CREATE','READ','UPDATE','DELETE','Export','Import','Error') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'CREATE',
  `tabla_afectada` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `registro_id` int DEFAULT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exito` tinyint(1) NOT NULL DEFAULT '1',
  `timestamp_accion` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_log`),
  KEY `idx_id_usuario` (`id_usuario`),
  KEY `idx_tipo_accion` (`tipo_accion`),
  KEY `idx_timestamp` (`timestamp_accion`),
  CONSTRAINT `fk_log_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_registro`
--

LOCK TABLES `log_registro` WRITE;
/*!40000 ALTER TABLE `log_registro` DISABLE KEYS */;
INSERT INTO `log_registro` VALUES (1,12,'Export',NULL,NULL,'Envió consolidado a 1 destinatario(s)',NULL,NULL,1,'2026-02-12 19:03:17','2026-02-13 00:03:17'),(2,12,'Export',NULL,NULL,'Envió boletin a 1 destinatario(s)',NULL,NULL,1,'2026-02-12 19:50:09','2026-02-13 00:50:09'),(3,12,'Export',NULL,NULL,'Envió boletin a 1 destinatario(s)',NULL,NULL,1,'2026-02-12 19:52:16','2026-02-13 00:52:16'),(4,12,'Export',NULL,NULL,'Envió consolidado a 2 destinatario(s)',NULL,NULL,1,'2026-02-12 20:06:47','2026-02-13 01:06:47'),(5,12,'Export',NULL,NULL,'Envió boletin a 1 destinatario(s)',NULL,NULL,1,'2026-02-12 20:08:28','2026-02-13 01:08:28'),(6,12,'Export',NULL,NULL,'Envió consolidado a 2 destinatario(s)',NULL,NULL,1,'2026-02-12 20:08:51','2026-02-13 01:08:51'),(7,12,'Export',NULL,NULL,'Envió boletin a 1 destinatario(s)',NULL,NULL,1,'2026-02-12 20:11:22','2026-02-13 01:11:22'),(8,12,'Export',NULL,NULL,'Envió asistencia_diaria a 2 destinatario(s)',NULL,NULL,1,'2026-02-12 20:28:54','2026-02-13 01:28:54'),(9,12,'DELETE',NULL,NULL,'Usuario con ID 28 eliminado permanentemente.',NULL,NULL,1,'2026-03-01 21:07:11','2026-03-02 02:07:11'),(10,12,'Export',NULL,NULL,'Envió boletin a 1 destinatario(s)',NULL,NULL,1,'2026-04-07 23:55:47','2026-04-08 04:55:47'),(11,14,'Export',NULL,NULL,'Envió boletines a 3 destinatario(s)',NULL,NULL,1,'2026-04-08 08:03:17','2026-04-08 13:03:17'),(12,14,'Export',NULL,NULL,'Envió boletines a 2 destinatario(s)',NULL,NULL,1,'2026-04-08 08:03:45','2026-04-08 13:03:45'),(13,14,'Export',NULL,NULL,'Envió boletines a 2 destinatario(s)',NULL,NULL,1,'2026-04-08 08:03:58','2026-04-08 13:03:58'),(14,14,'Export',NULL,NULL,'Envió boletines a 2 destinatario(s)',NULL,NULL,1,'2026-04-08 08:04:12','2026-04-08 13:04:12'),(15,14,'Export',NULL,NULL,'Envió boletines a 2 destinatario(s)',NULL,NULL,1,'2026-04-08 08:04:23','2026-04-08 13:04:23'),(16,14,'Export',NULL,NULL,'Envió boletines a 3 destinatario(s)',NULL,NULL,1,'2026-04-08 08:04:36','2026-04-08 13:04:36'),(17,14,'Export',NULL,NULL,'Envió boletines a 4 destinatario(s)',NULL,NULL,1,'2026-04-08 08:05:53','2026-04-08 13:05:53'),(18,12,'Export','calificaciones',NULL,'Sincronizacion planillas. Nuevos=0 Actualizados=284 SinCambios=0','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36',1,'2026-04-08 17:43:39','2026-04-08 22:43:39'),(19,12,'Export','horarios',NULL,'Descarga PDF horario (6vo - 6-Aa)','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36',1,'2026-04-08 18:05:41','2026-04-08 23:05:41'),(20,12,'CREATE','horarios',162,'Horario creado (grupo=17, dia=Martes, 09:00-10:00)','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36',1,'2026-04-08 18:06:45','2026-04-08 23:06:45'),(21,12,'CREATE','horarios',163,'Horario creado (grupo=17, dia=Martes, 10:00-11:00)','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36',1,'2026-04-08 18:07:17','2026-04-08 23:07:17'),(22,12,'Export','calificaciones',NULL,'Sincronizacion planillas. Nuevos=4 Actualizados=284 SinCambios=0','127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36',1,'2026-04-09 10:12:33','2026-04-09 15:12:33');
/*!40000 ALTER TABLE `log_registro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materias`
--

DROP TABLE IF EXISTS `materias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materias`
--

LOCK TABLES `materias` WRITE;
/*!40000 ALTER TABLE `materias` DISABLE KEYS */;
INSERT INTO `materias` VALUES (7,'Inglés','ING-001',3,'Idioma extranjero',NULL,NULL),(8,'Informática','INF-001',3,'Computación y tecnología',NULL,NULL),(12,'Química','QUI-001',4,'Reacciones y elementos químicos',NULL,NULL),(13,'Biología','BIO-001',4,'Organismos vivos y ecosistemas',NULL,'2026-03-02 02:42:04'),(16,'Estadística','EST-001',3,'Análisis de datos',NULL,NULL),(21,'Matemáticas','MAT-001',5,'Matemáticas básicas y avanzadas','2026-01-12 01:14:36','2026-01-12 01:14:36'),(22,'Lengua Castellana','LEN-001',5,'Español y comunicación','2026-01-12 01:14:36','2026-01-12 01:14:36'),(23,'Ciencias Naturales','NAT-001',7,'Ciencias de la naturaleza','2026-01-12 01:14:36','2026-03-02 02:43:16'),(24,'Ciencias Sociales','SOC-001',4,'Historia, geografía y civismo','2026-01-12 01:14:36','2026-01-12 01:14:36'),(26,'Geometría','GEO-001',3,'Geometría y trigonometría','2026-01-12 01:14:36','2026-01-12 01:14:36'),(27,'Álgebra','ALG-001',6,'Álgebra y funcione','2026-01-12 01:14:36','2026-03-08 03:35:19'),(34,'Educación Artística','ART-001',8,'sxoo','2026-03-03 02:07:41','2026-03-08 02:42:30');
/*!40000 ALTER TABLE `materias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `niveles`
--

DROP TABLE IF EXISTS `niveles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `niveles` (
  `id_nivel` int NOT NULL AUTO_INCREMENT,
  `nombre_nivel` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_nivel`),
  UNIQUE KEY `uk_nombre_nivel` (`nombre_nivel`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `niveles`
--

LOCK TABLES `niveles` WRITE;
/*!40000 ALTER TABLE `niveles` DISABLE KEYS */;
INSERT INTO `niveles` VALUES (1,'Primaria','Grados 1-5',NULL,NULL),(2,'Secundaria','Grados 6-9',NULL,NULL),(3,'Bachillerato','Grados 10-11',NULL,NULL);
/*!40000 ALTER TABLE `niveles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notas`
--

DROP TABLE IF EXISTS `notas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notas` (
  `id_nota` int NOT NULL AUTO_INCREMENT,
  `id_estudiante` int NOT NULL,
  `id_actividad` int NOT NULL,
  `id_materia` int NOT NULL,
  `id_periodo` int NOT NULL,
  `puntaje_obtenido` decimal(5,2) DEFAULT NULL,
  `porcentaje` decimal(5,2) DEFAULT NULL,
  `calificacion` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=318 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notas`
--

LOCK TABLES `notas` WRITE;
/*!40000 ALTER TABLE `notas` DISABLE KEYS */;
INSERT INTO `notas` VALUES (228,119,17,23,1,5.00,NULL,NULL,'2026-04-03 17:03:43','2026-04-03 00:37:41','2026-04-03 22:03:43'),(229,118,17,23,1,2.00,NULL,NULL,'2026-04-03 17:03:43','2026-04-03 00:37:51','2026-04-03 22:03:43'),(230,117,17,23,1,2.00,NULL,NULL,'2026-04-03 17:03:44','2026-04-03 00:37:52','2026-04-03 22:03:44'),(231,205,17,23,1,2.00,NULL,NULL,'2026-04-03 17:03:44','2026-04-03 00:37:55','2026-04-03 22:03:44'),(232,196,17,23,1,2.00,NULL,NULL,'2026-04-03 17:03:44','2026-04-03 00:37:58','2026-04-03 22:03:44'),(233,202,17,23,1,2.00,NULL,NULL,'2026-04-03 17:03:44','2026-04-03 00:37:59','2026-04-03 22:03:44'),(240,119,32,27,1,1.00,NULL,NULL,'2026-04-06 21:37:40','2026-04-03 01:04:18','2026-04-07 02:37:40'),(241,119,33,27,1,5.00,NULL,NULL,'2026-04-06 21:37:40','2026-04-03 01:04:18','2026-04-07 02:37:40'),(242,119,34,27,1,4.80,NULL,NULL,'2026-04-06 21:37:40','2026-04-03 01:04:18','2026-04-07 02:37:40'),(243,119,35,27,1,5.00,NULL,NULL,'2026-04-06 21:37:40','2026-04-03 01:04:18','2026-04-07 02:37:40'),(244,119,36,27,1,5.00,NULL,NULL,'2026-04-06 21:37:40','2026-04-03 01:04:18','2026-04-07 02:37:40'),(245,119,37,27,1,5.00,NULL,NULL,'2026-04-06 21:37:40','2026-04-03 01:04:18','2026-04-07 02:37:40'),(247,118,32,27,1,1.00,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(248,118,33,27,1,4.50,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(249,118,34,27,1,5.00,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(250,118,35,27,1,4.50,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(251,118,36,27,1,4.20,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(252,118,37,27,1,4.50,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(254,117,32,27,1,1.00,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(255,117,33,27,1,4.10,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(256,117,34,27,1,4.30,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(257,117,35,27,1,5.00,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(258,117,36,27,1,4.00,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(259,117,37,27,1,4.00,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(261,205,32,27,1,1.00,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(262,205,33,27,1,3.70,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(263,205,34,27,1,4.50,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(264,205,35,27,1,4.50,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(265,205,36,27,1,3.50,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(266,205,37,27,1,3.80,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(268,196,32,27,1,1.00,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(269,196,33,27,1,3.90,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(270,196,34,27,1,4.50,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(271,196,35,27,1,4.00,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(272,196,36,27,1,4.20,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(273,196,37,27,1,5.00,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(275,202,32,27,1,1.00,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(276,202,33,27,1,4.00,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(277,202,34,27,1,4.00,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(278,202,35,27,1,4.00,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(279,202,36,27,1,3.50,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(280,202,37,27,1,4.50,NULL,NULL,'2026-04-06 21:37:41','2026-04-03 01:04:18','2026-04-07 02:37:41'),(282,119,40,27,2,1.00,NULL,NULL,'2026-04-03 23:08:29','2026-04-04 04:07:18','2026-04-04 04:08:29'),(283,118,40,27,2,5.00,NULL,NULL,'2026-04-03 23:08:29','2026-04-04 04:07:20','2026-04-04 04:08:29'),(284,117,40,27,2,2.00,NULL,NULL,'2026-04-03 23:08:29','2026-04-04 04:07:21','2026-04-04 04:08:29'),(285,205,40,27,2,3.00,NULL,NULL,'2026-04-03 23:08:29','2026-04-04 04:07:22','2026-04-04 04:08:29'),(286,196,40,27,2,4.00,NULL,NULL,'2026-04-03 23:08:29','2026-04-04 04:07:23','2026-04-04 04:08:29'),(287,202,40,27,2,5.00,NULL,NULL,'2026-04-03 23:08:29','2026-04-04 04:07:24','2026-04-04 04:08:29'),(288,119,41,16,1,5.00,NULL,NULL,'2026-04-04 01:48:29','2026-04-04 06:09:53','2026-04-04 06:48:29'),(289,118,41,16,1,5.00,NULL,NULL,'2026-04-04 01:48:28','2026-04-04 06:09:54','2026-04-04 06:48:28'),(290,117,41,16,1,5.00,NULL,NULL,'2026-04-04 01:44:00','2026-04-04 06:09:55','2026-04-04 06:44:00'),(291,205,41,16,1,5.00,NULL,NULL,'2026-04-04 01:48:30','2026-04-04 06:09:56','2026-04-04 06:48:30'),(292,196,41,16,1,5.00,NULL,NULL,'2026-04-04 01:48:30','2026-04-04 06:09:57','2026-04-04 06:48:30'),(293,202,41,16,1,5.00,NULL,NULL,'2026-04-04 01:48:31','2026-04-04 06:09:59','2026-04-04 06:48:31'),(316,287,36,27,1,1.00,NULL,NULL,'2026-04-08 17:49:54','2026-04-08 22:49:54','2026-04-08 22:49:54'),(317,287,33,27,1,1.00,NULL,NULL,'2026-04-08 17:59:20','2026-04-08 22:59:20','2026-04-08 22:59:20');
/*!40000 ALTER TABLE `notas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `observador`
--

DROP TABLE IF EXISTS `observador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `observador` (
  `id_observacion` int NOT NULL AUTO_INCREMENT,
  `id_estudiante` int NOT NULL,
  `id_materia` int DEFAULT NULL,
  `id_usuario` int NOT NULL,
  `tipo_observacion` enum('Positiva','Negativa','Neutra') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Neutra',
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_observacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_observacion`),
  KEY `idx_id_estudiante` (`id_estudiante`),
  KEY `idx_id_usuario` (`id_usuario`),
  KEY `fk_observador_materia` (`id_materia`),
  CONSTRAINT `fk_observador_estudiante` FOREIGN KEY (`id_estudiante`) REFERENCES `estudiantes` (`id_estudiante`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_observador_materia` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_observador_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `observador`
--

LOCK TABLES `observador` WRITE;
/*!40000 ALTER TABLE `observador` DISABLE KEYS */;
INSERT INTO `observador` VALUES (9,239,13,14,'Positiva','12312321','2026-04-06 22:38:00','2026-04-07 03:43:26','2026-04-07 03:43:26');
/*!40000 ALTER TABLE `observador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `periodos`
--

DROP TABLE IF EXISTS `periodos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `periodos` (
  `id_periodo` int NOT NULL AUTO_INCREMENT,
  `numero_periodo` int NOT NULL,
  `nombre_periodo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `estado` enum('Abierto','Cerrado','Cancelado') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Abierto',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_periodo`),
  UNIQUE KEY `uk_numero_periodo` (`numero_periodo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `periodos`
--

LOCK TABLES `periodos` WRITE;
/*!40000 ALTER TABLE `periodos` DISABLE KEYS */;
INSERT INTO `periodos` VALUES (1,1,'Período 1','2025-01-20','2025-03-31','Abierto',NULL,'2026-04-07 02:31:36'),(2,2,'Período 2','2025-04-01','2025-06-30','Cerrado',NULL,'2026-04-07 02:29:58'),(3,3,'Período 3','2025-07-01','2025-09-30','Cerrado',NULL,'2026-04-07 02:30:02'),(4,4,'Período 4','2025-10-01','2025-11-30','Cerrado',NULL,'2026-04-07 02:31:36');
/*!40000 ALTER TABLE `periodos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permisos`
--

DROP TABLE IF EXISTS `permisos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permisos`
--

LOCK TABLES `permisos` WRITE;
/*!40000 ALTER TABLE `permisos` DISABLE KEYS */;
INSERT INTO `permisos` VALUES (1,1,'gestionar_usuarios','Crear, editar, eliminar usuarios','usuarios','CRUD',1,'2026-01-07 18:40:12','2026-01-07 18:40:12'),(2,1,'gestionar_roles','Gestionar roles y asignaciones','roles','CRUD',1,'2026-01-07 18:40:12','2026-01-07 18:40:12'),(3,1,'gestionar_permisos','Configurar permisos por rol','permisos','CRUD',1,'2026-01-07 18:40:12','2026-01-07 18:40:12'),(4,1,'ver_reportes','Acceder a reportes del sistema','reportes','READ',1,'2026-01-07 18:40:12','2026-01-07 18:40:12'),(5,1,'exportar_datos','Exportar datos de la base de datos','datos','EXPORT',1,'2026-01-07 18:40:12','2026-01-07 18:40:12'),(6,1,'auditoría','Ver logs de auditoría','auditoria','READ',1,'2026-01-07 18:40:12','2026-01-07 18:40:12'),(7,2,'ver_estudiantes','Ver información de estudiantes','estudiantes','READ',1,'2026-01-07 18:40:12','2026-01-07 18:40:12'),(8,2,'ver_calificaciones','Ver calificaciones y notas','notas','READ',1,'2026-01-07 18:40:12','2026-01-07 18:40:12'),(9,2,'gestionar_periodos','Crear y gestionar períodos académicos','periodos','CRUD',1,'2026-01-07 18:40:12','2026-01-07 18:40:12'),(10,2,'ver_reportes','Acceder a reportes académicos','reportes','READ',1,'2026-01-07 18:40:12','2026-01-07 18:40:12'),(11,2,'comunicados','Enviar comunicados','comunicados','CREATE',1,'2026-01-07 18:40:12','2026-01-07 18:40:12'),(16,4,'crear_actividades','Crear tareas y actividades','actividades','CREATE',1,'2026-01-07 18:40:12','2026-01-07 18:40:12'),(17,4,'calificar','Calificar actividades','notas','CREATE',1,'2026-01-07 18:40:12','2026-01-07 18:40:12'),(18,4,'ver_asistencia','Ver registro de asistencia','asistencia','READ',1,'2026-01-07 18:40:12','2026-01-07 18:40:12'),(19,4,'registrar_asistencia','Registrar asistencia','asistencia','CREATE',1,'2026-01-07 18:40:12','2026-01-07 18:40:12'),(20,4,'crear_observaciones','Crear observaciones de estudiantes','observador','CREATE',1,'2026-01-07 18:40:12','2026-01-07 18:40:12'),(30,6,'crear_planilla','Crear nuevas planillas de calificación','planillas','crear',1,'2026-01-08 01:54:53','2026-01-08 01:54:53'),(31,6,'editar_planilla','Editar planillas de calificación existentes','planillas','editar',1,'2026-01-08 01:54:53','2026-01-08 01:54:53'),(32,6,'borrar_planilla','Eliminar planillas de calificación','planillas','borrar',1,'2026-01-08 01:54:53','2026-01-08 01:54:53'),(33,1,'crear_planilla','Crear nuevas planillas de calificación','planillas','crear',1,'2026-01-08 01:55:05','2026-01-08 01:55:05'),(34,2,'crear_planilla','Crear nuevas planillas de calificación','planillas','crear',1,'2026-01-08 01:55:05','2026-01-08 01:55:05'),(35,4,'crear_planilla','Crear nuevas planillas de calificación','planillas','crear',1,'2026-01-08 01:55:05','2026-01-08 01:55:05'),(36,1,'editar_planilla','Editar planillas de calificación existentes','planillas','editar',1,'2026-01-08 01:55:05','2026-01-08 01:55:05'),(37,2,'editar_planilla','Editar planillas de calificación existentes','planillas','editar',1,'2026-01-08 01:55:05','2026-01-08 01:55:05'),(38,4,'editar_planilla','Editar planillas de calificación existentes','planillas','editar',1,'2026-01-08 01:55:05','2026-01-08 01:55:05'),(39,1,'borrar_planilla','Eliminar planillas de calificación','planillas','borrar',1,'2026-01-08 01:55:05','2026-01-08 01:55:05'),(40,2,'borrar_planilla','Eliminar planillas de calificación','planillas','borrar',1,'2026-01-08 01:55:05','2026-01-08 01:55:05');
/*!40000 ALTER TABLE `permisos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plantillas_asistencias`
--

DROP TABLE IF EXISTS `plantillas_asistencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plantillas_asistencias` (
  `id_plantilla` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `nombre_plantilla` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `id_materia` int NOT NULL,
  `id_periodo` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_plantilla`),
  UNIQUE KEY `uk_plantilla_usuario_materia_periodo` (`id_usuario`,`id_materia`,`id_periodo`),
  KEY `idx_plantilla_usuario` (`id_usuario`),
  KEY `idx_plantilla_materia` (`id_materia`),
  KEY `idx_plantilla_periodo` (`id_periodo`),
  CONSTRAINT `fk_plantillas_asistencias_materia` FOREIGN KEY (`id_materia`) REFERENCES `materias` (`id_materia`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_plantillas_asistencias_periodo` FOREIGN KEY (`id_periodo`) REFERENCES `periodos` (`id_periodo`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_plantillas_asistencias_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plantillas_asistencias`
--

LOCK TABLES `plantillas_asistencias` WRITE;
/*!40000 ALTER TABLE `plantillas_asistencias` DISABLE KEYS */;
INSERT INTO `plantillas_asistencias` VALUES (1,12,'Asistencia Álgebra','Control de asistencia - Álgebra',27,1,'2026-04-07 01:14:19','2026-04-07 01:14:19'),(2,12,'Asistencia Biología','Control de asistencia - Biología',13,1,'2026-04-07 01:17:11','2026-04-07 01:17:11');
/*!40000 ALTER TABLE `plantillas_asistencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reportes_inasistencias`
--

DROP TABLE IF EXISTS `reportes_inasistencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
  `estado_reporte` enum('abierto','en_atencion','resuelto','cerrado') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'abierto',
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Reportes de inasistencias críticas para seguimiento';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reportes_inasistencias`
--

LOCK TABLES `reportes_inasistencias` WRITE;
/*!40000 ALTER TABLE `reportes_inasistencias` DISABLE KEYS */;
INSERT INTO `reportes_inasistencias` VALUES (1,119,27,1,1,1,0,33.33,1,'abierto',NULL,'2026-04-07 01:15:21','2026-04-09 15:14:11'),(2,118,27,1,1,1,0,100.00,1,'abierto',NULL,'2026-04-07 01:15:21','2026-04-07 01:15:21'),(3,117,27,1,1,1,0,33.33,1,'abierto',NULL,'2026-04-07 01:15:21','2026-04-09 15:14:11'),(4,205,27,1,1,1,0,33.33,1,'abierto',NULL,'2026-04-07 01:15:21','2026-04-09 15:14:11'),(5,196,27,1,1,1,0,33.33,1,'abierto',NULL,'2026-04-07 01:15:21','2026-04-09 15:14:11'),(6,202,27,1,1,1,0,33.33,1,'abierto',NULL,'2026-04-07 01:15:21','2026-04-09 15:14:11'),(7,119,13,1,1,1,0,100.00,1,'abierto',NULL,'2026-04-07 01:17:12','2026-04-07 01:17:12'),(8,117,13,1,1,1,0,100.00,1,'abierto',NULL,'2026-04-07 01:17:12','2026-04-07 01:17:12'),(9,196,13,1,1,1,0,100.00,1,'abierto',NULL,'2026-04-07 01:17:12','2026-04-07 01:17:12'),(10,287,27,1,1,1,0,50.00,1,'abierto',NULL,'2026-04-08 22:49:33','2026-04-09 15:15:47');
/*!40000 ALTER TABLE `reportes_inasistencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'Rector','Administrador de la institución educativa','{\"auditoría\": true, \"documentos\": true, \"comunicados\": true, \"ver_reportes\": true, \"exportar_datos\": true, \"gestionar_datos\": true, \"gestionar_roles\": true, \"gestionar_usuarios\": true}','2025-10-31 03:42:38','2025-10-31 03:42:38'),(2,'Coordinador','Coordinador académico de grados/áreas','{\"comunicados\": true, \"asignaciones\": true, \"ver_reportes\": true, \"ver_estudiantes\": true, \"gestionar_periodos\": true, \"ver_calificaciones\": true}','2025-10-31 03:42:38','2025-10-31 03:42:38'),(4,'Profesor','Docente que imparte asignaturas','{\"calificar\": true, \"crear_notas\": true, \"observaciones\": true, \"ver_asistencia\": true, \"crear_actividades\": true, \"ver_estudiantes_asignados\": true}','2025-10-31 03:42:38','2025-10-31 03:42:38'),(6,'server_admin','Administrador del Sistema',NULL,'2026-01-07 19:13:25','2026-01-07 19:13:25');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (12,'121221221','larry','janpierr','larryjanpier@gmail.com','$2b$12$oHWUU.3GBkcMMPjVFfzRZOI4XiETeTBDVlmDIpnOwFFmojYJiJx5S',6,1,NULL,'2026-01-07 21:10:58','2026-03-03 03:49:42'),(13,'12312313','Larry Jan Pierr','Murcia Lozano','langostamutante@gmail.com','$2b$12$tq9ehKMT0p2.eRrR1CGux.l6aViLsD1eJu1TZBD3gEUqvcqlApq4C',1,1,NULL,'2026-01-07 23:28:37','2026-03-03 03:51:11'),(14,'123123123','larry','aaaaaa','jakyovonkiroskavi@gmail.com','$2b$12$SyJg0ywruC44dS5i/MpkgugWondMZYw2qp7byPoSJ4SGxkl/jTOxu',4,1,NULL,'2026-01-07 23:41:53','2026-03-03 03:50:54'),(15,'1111','Larry','murcia','larryjanpierr@gmail.com','$2b$12$v5kWZSzjJ851E1BvKwGtIeIeWjr6BnRqCqcyly0/HOiYje6TtmcxK',2,1,NULL,'2026-01-08 00:01:59','2026-03-03 03:50:27'),(22,'a','a','a','d@gmail.com','$2b$12$wroFkElpMfX//wFCyZR7WutJ3.ptS0ikM0uiaMjR1A1US32m8jeIi',4,1,NULL,'2026-01-12 03:16:12','2026-03-03 03:50:14'),(27,'111111','l','a','la@gmail.com','$2b$12$VqhO14QYSshEHHEo/q7FZexWPMzqSuftelfnPtMP1pOgld/ITd69a',4,1,NULL,'2026-01-22 21:05:44','2026-03-03 03:50:38'),(29,'1131231','avse','asds','de@gmail.com','$2b$12$mvNvQw2pGMAmU30j/sMTnOdwJCuONjRWpWXnkADKZB3vgKZgFBNMO',4,1,NULL,'2026-03-04 01:14:40','2026-03-04 01:14:40');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'anexo_de_datos'
--

--
-- Dumping routines for database 'anexo_de_datos'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-04-15  8:46:58
