CREATE DATABASE  IF NOT EXISTS `salud` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `salud`;
-- MySQL dump 10.13  Distrib 5.5.16, for Win32 (x86)
--
-- Host: localhost    Database: salud
-- ------------------------------------------------------
-- Server version	5.5.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `permiso`
--

DROP TABLE IF EXISTS `permiso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permiso` (
  `idpermiso` int(10) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(255) NOT NULL,
  `idcategoria_permiso` int(10) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idpermiso`),
  KEY `FKpermiso30573` (`idcategoria_permiso`),
  CONSTRAINT `FKpermiso30573` FOREIGN KEY (`idcategoria_permiso`) REFERENCES `categoria_permiso` (`idcategoria_permiso`)
) ENGINE=InnoDB AUTO_INCREMENT=249 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permiso`
--

LOCK TABLES `permiso` WRITE;
/*!40000 ALTER TABLE `permiso` DISABLE KEYS */;
INSERT INTO `permiso` VALUES (221,'Mostar Contenido',1),(222,'Crear Contenido',1),(223,'Eliminar Contenido',1),(224,'Nuevo Contenido',1),(225,'Mostrar Noticias',1),(226,'Crear  Noticias',1),(227,'Eliminar noticias',1),(228,'Mostar Actividades',1),(229,'Crear Actividades',1),(230,'Eliminar Actividades',1),(231,'Mostrar Areas',1),(232,'Modificar Areas',1),(233,'Mostrar Usuarios',2),(234,'Crear Usuarios',2),(235,'Mostrar Permisos',2),(236,'Asignar Permisos',2),(237,'Reportes',5),(238,'Dashboard',5),(239,'Manipular Estado Civil',3),(240,'Manipular Tipo Sangre',3),(241,'Manipular Parentesco',3),(242,'Manipular Titulo Secundaria',3),(243,'Manipular Carreras',3),(244,'Manipular Centro Universitario',3),(245,'Manipular Facultad',3),(246,'Modificar Configuracion',2),(247,'Mostrar  Archivos sin Usar',2),(248,'Eliminar Archivos sin Usar',2);
/*!40000 ALTER TABLE `permiso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario_permisos`
--

DROP TABLE IF EXISTS `usuario_permisos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario_permisos` (
  `usuarioidusuario` int(10) NOT NULL,
  `permisosidpermiso` int(10) NOT NULL,
  PRIMARY KEY (`usuarioidusuario`,`permisosidpermiso`),
  KEY `FKusuario_pe657117` (`usuarioidusuario`),
  KEY `FKusuario_pe436420` (`permisosidpermiso`),
  CONSTRAINT `FKusuario_pe436420` FOREIGN KEY (`permisosidpermiso`) REFERENCES `permiso` (`idpermiso`),
  CONSTRAINT `FKusuario_pe657117` FOREIGN KEY (`usuarioidusuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_permisos`
--

LOCK TABLES `usuario_permisos` WRITE;
/*!40000 ALTER TABLE `usuario_permisos` DISABLE KEYS */;
INSERT INTO `usuario_permisos` VALUES (1,221),(1,222),(1,223),(1,224),(1,225),(1,226),(1,227),(1,228),(1,229),(1,230),(1,231),(1,232),(1,233),(1,234),(1,235),(1,236),(1,237),(1,238),(1,239),(1,240),(1,241),(1,242),(1,243),(1,244),(1,245),(2,221),(2,222),(2,223),(2,224),(2,225),(2,226),(2,227),(2,228),(2,229),(2,230),(2,231),(2,232),(4,221),(4,222),(4,223),(4,224),(4,225),(4,226),(4,227),(4,228),(4,229),(4,230),(4,231),(4,232),(4,233),(4,234),(4,235),(4,236),(4,237),(20,221),(20,222);
/*!40000 ALTER TABLE `usuario_permisos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departamento`
--

DROP TABLE IF EXISTS `departamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departamento` (
  `iddepartamento` int(10) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`iddepartamento`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departamento`
--

LOCK TABLES `departamento` WRITE;
/*!40000 ALTER TABLE `departamento` DISABLE KEYS */;
INSERT INTO `departamento` VALUES (1,'Alta Verapaz'),(2,'Baja Verapaz'),(3,'Chimaltenango'),(4,'Chiquimula'),(5,'Petén'),(6,'El Progreso'),(7,'Quiché'),(8,'Escuintla'),(9,'Guatemala'),(10,'Huehuetenango'),(11,'Izabal'),(12,'Jalapa'),(13,'Jutiapa'),(14,'Quetzaltenango'),(15,'Retalhuleu'),(16,'Sacatepéquez'),(17,'San Marcos'),(18,'Santa Rosa'),(19,'Sololá'),(20,'Suchitepéquez'),(21,'Totonicapán'),(22,'Zacapa');
/*!40000 ALTER TABLE `departamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edificio`
--

DROP TABLE IF EXISTS `edificio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `edificio` (
  `idedificio` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `direccion` varchar(250) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idedificio`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edificio`
--

LOCK TABLES `edificio` WRITE;
/*!40000 ALTER TABLE `edificio` DISABLE KEYS */;
INSERT INTO `edificio` VALUES (1,'Bienestar Estudiantil','Comunidad Universitaria, zona 12','42144987'),(2,'T3 - Ingenieria USAC','Ciudad Universitaria, zona 12','42144987'),(3,'T4 - Ingenieria Usac','Ciudad Universitaria Zona 12','323232232'),(4,'M5 - Odontologia','Ciudad Universitaria zona 12','343222321'),(5,'M4 - Odontología','Ciudad Universitaria zona 12','323323223'),(7,'Prueba 6','prueba 6','44343443'),(8,'M4 - Odontolog&iacute;a','Ciudad Universitaria zona 12','323323223'),(9,'M4 - Odontolog&iacute;a','Ciudad Universitaria zona 12','323323223'),(10,'prueba 1','prueba 1','232323'),(11,'CUM','Zona 11','35344343'),(12,'otro lugar','en guatemala','33333');
/*!40000 ALTER TABLE `edificio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `responsable_actividad`
--

DROP TABLE IF EXISTS `responsable_actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `responsable_actividad` (
  `responsableidresponsable` int(11) NOT NULL,
  `actividadidactividad` int(11) NOT NULL,
  PRIMARY KEY (`responsableidresponsable`,`actividadidactividad`),
  KEY `FKresponsabl971119` (`responsableidresponsable`),
  KEY `FKresponsabl144858` (`actividadidactividad`),
  CONSTRAINT `FKresponsabl144858` FOREIGN KEY (`actividadidactividad`) REFERENCES `actividad` (`idactividad`),
  CONSTRAINT `FKresponsabl971119` FOREIGN KEY (`responsableidresponsable`) REFERENCES `responsable` (`idresponsable`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `responsable_actividad`
--

LOCK TABLES `responsable_actividad` WRITE;
/*!40000 ALTER TABLE `responsable_actividad` DISABLE KEYS */;
INSERT INTO `responsable_actividad` VALUES (3,1),(3,7),(3,22),(4,7),(4,22),(5,2),(5,3),(8,7),(8,13),(11,1),(11,2),(11,3),(11,22),(15,1),(15,22);
/*!40000 ALTER TABLE `responsable_actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuracion`
--

DROP TABLE IF EXISTS `configuracion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configuracion` (
  `idconfiguracion` int(10) NOT NULL AUTO_INCREMENT,
  `telefono` varchar(50) DEFAULT NULL,
  `correo_electronico` varchar(100) DEFAULT NULL,
  `fax` varchar(50) DEFAULT NULL,
  `direccion_imagen` varchar(100) NOT NULL,
  `direccion_pdf` varchar(100) NOT NULL,
  `tamanio_sub` int(10) NOT NULL,
  `dir_rel_imagen` varchar(100) NOT NULL,
  `dir_rel_pdf` varchar(100) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idconfiguracion`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuracion`
--

LOCK TABLES `configuracion` WRITE;
/*!40000 ALTER TABLE `configuracion` DISABLE KEYS */;
INSERT INTO `configuracion` VALUES (1,'24189622','saludusac@gmail.com','24189633','C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\websalud\\images\\upload\\imagen\\','C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\websalud\\images\\upload\\pdf\\',2,'images/upload/imagen/','images/upload/pdf/','Edificio Bienestar Estudiantil 3er Nivel, Ciudad Universitaria Zona 12, Guatemala C.A');
/*!40000 ALTER TABLE `configuracion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contenido`
--

DROP TABLE IF EXISTS `contenido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contenido` (
  `menuidmenu` int(11) NOT NULL,
  `idcontenido` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` text NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `multimediaidmultimedia` int(11) NOT NULL,
  PRIMARY KEY (`idcontenido`),
  KEY `FKcontenido417686` (`multimediaidmultimedia`),
  CONSTRAINT `FKcontenido417686` FOREIGN KEY (`multimediaidmultimedia`) REFERENCES `multimedia` (`idmultimedia`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contenido`
--

LOCK TABLES `contenido` WRITE;
/*!40000 ALTER TABLE `contenido` DISABLE KEYS */;
INSERT INTO `contenido` VALUES (1,1,'MUESTRA DE FOTO','FOTO 1',288);
/*!40000 ALTER TABLE `contenido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `area`
--

DROP TABLE IF EXISTS `area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `area` (
  `idarea` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(60) NOT NULL,
  `areaidarea` int(11) DEFAULT NULL,
  `descripcion` text,
  `size` int(11) NOT NULL DEFAULT '0',
  `multimediaidmultimedia` int(11) DEFAULT NULL,
  PRIMARY KEY (`idarea`),
  KEY `FKarea432514` (`multimediaidmultimedia`),
  CONSTRAINT `FKarea432514` FOREIGN KEY (`multimediaidmultimedia`) REFERENCES `multimedia` (`idmultimedia`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `area`
--

LOCK TABLES `area` WRITE;
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
INSERT INTO `area` VALUES (1,'Unidad de Salud',NULL,'1',1,NULL),(2,'Odontologia',NULL,'1',0,NULL),(3,'Laboratorio Clinico',NULL,'<div style=\'font-size: 10pt; font-weight: normal; \'><br></div><div style=\'font-size: 10pt; font-weight: normal; \'><br></div><div style=\'font-size: 10pt; font-weight: normal; \'><br></div><b><div style=\'text-align: center; \'><b><font size=\'5\'>AREA DE LABORATORIO ES LA MEJOR</font></b></div></b><div style=\'font-size: 10pt; text-align: center; font-weight: normal; \'><br></div>',1,NULL),(4,'Psicologia',NULL,'1',0,NULL),(5,'Medicina',NULL,'1',3,NULL),(6,'PPIVS',5,'1',2,NULL),(7,'Nutricion',5,'1',0,NULL),(8,'Actividad Fisica',5,'1',1,NULL),(9,'Consulta Externa',5,'1',1,NULL);
/*!40000 ALTER TABLE `area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encabezado`
--

DROP TABLE IF EXISTS `encabezado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encabezado` (
  `areaidarea` int(11) NOT NULL,
  `multimediaidmultimedia` int(11) NOT NULL,
  PRIMARY KEY (`areaidarea`,`multimediaidmultimedia`),
  KEY `FKencabezado458445` (`areaidarea`),
  KEY `FKencabezado219439` (`multimediaidmultimedia`),
  CONSTRAINT `FKencabezado219439` FOREIGN KEY (`multimediaidmultimedia`) REFERENCES `multimedia` (`idmultimedia`),
  CONSTRAINT `FKencabezado458445` FOREIGN KEY (`areaidarea`) REFERENCES `area` (`idarea`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encabezado`
--

LOCK TABLES `encabezado` WRITE;
/*!40000 ALTER TABLE `encabezado` DISABLE KEYS */;
/*!40000 ALTER TABLE `encabezado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu` (
  `idmenu` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  `areaidarea` int(11) NOT NULL,
  `contenido` text,
  `idmenu_rec` int(11) DEFAULT NULL,
  `size` int(11) NOT NULL DEFAULT '4',
  PRIMARY KEY (`idmenu`),
  KEY `FKmenu590668` (`areaidarea`),
  KEY `FKmenu855382` (`idmenu_rec`),
  CONSTRAINT `FKmenu590668` FOREIGN KEY (`areaidarea`) REFERENCES `area` (`idarea`),
  CONSTRAINT `FKmenu855382` FOREIGN KEY (`idmenu_rec`) REFERENCES `menu` (`idmenu`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'Quienes Somos',1,'1',NULL,3),(2,'Administraci&oacute;n',1,'1',NULL,3),(3,'Misi&oacute;n',1,'1',NULL,1),(4,'Visi&oacute;n',1,'1',NULL,1),(5,'Antecedentes',1,'1',NULL,3),(6,'Investigaci&oacute;n y Docenc&iacute;a',1,'1',NULL,1),(7,'Quienes Somos',2,'1',NULL,3),(8,'Docencia',2,'1',NULL,3),(9,'Investigaci&oacute;n',2,'1',NULL,3),(11,'Extensi&oacute;n',2,'1',NULL,3),(12,'Quienes Somos',3,'<br><div style=\'font-size: 10pt; font-weight: normal; \'><br></div><div style=\'text-align: center; \'><b><font size=\'5\' color=\'#990000\'>ESTE ES UN EJEMPLO DE UN CUADRO</font></b></div><div style=\'font-size: 10pt; font-weight: normal; text-align: center; \'><br></div><div style=\'font-size: 10pt; font-weight: normal; text-align: center; \'>MUCHO TEXTO</div><div style=\'font-size: 10pt; font-weight: normal; text-align: center; \'><br></div><div style=\'font-size: 10pt; font-weight: normal; text-align: center; \'>MUCHO TEXTO</div><div style=\'font-size: 10pt; font-weight: normal; text-align: center; \'><br></div><div style=\'font-size: 10pt; font-weight: normal; text-align: center; \'>MUCHO TEXTO</div>',NULL,2),(13,'Docencia',3,'1',NULL,3),(14,'Investigaci&oacute;n',3,'<div style=\'font-size: 10pt; \'><br></div><div style=\'text-align: center; \'><font size=\'5\'><b>INVESTIGACI&Oacute;N</b></font></div><div style=\'font-size: 10pt; \'>&nbsp;</div>',NULL,1),(16,'Extensi&oacute;n',3,'1',NULL,3),(17,'Quienes Somos',4,'1',NULL,1),(18,'Docencia',4,'1',NULL,3),(19,'Investigaci&oacute;n',4,'1',NULL,3),(21,'Extensi&oacute;n',4,'1',NULL,3),(22,'Quienes Somos',5,'1',NULL,3),(23,'Docencia',5,'1',NULL,3),(24,'Investigaci&oacute;n',5,'1',NULL,1),(26,'Extensi&oacute;n',5,'1',NULL,1),(38,'Organigrama',1,'1',2,0),(39,'Quienes Somos',6,'1',NULL,1),(40,'Docencia',6,'1',NULL,2),(41,'Investigaci&oacute;n',6,'1',NULL,2),(42,'Extensi&oacute;n',6,'1',NULL,2),(43,'Quienes Somos',7,'1',NULL,2),(44,'Docencia',7,'1',NULL,2),(45,'Investigaci&oacute;n',7,'1',NULL,2),(46,'Extensi&oacute;n',7,'1',NULL,2),(47,'Quienes Somos',8,'1',NULL,2),(48,'Docencia',8,'1',NULL,2),(49,'Investigaci&oacute;n',8,'1',NULL,2),(50,'Extensi&oacute;n',8,'1',NULL,2),(51,'Quienes Somos',9,'1',NULL,1),(52,'Docencia',9,'1',NULL,2),(53,'Investigaci&oacute;n',9,'1',NULL,2),(54,'Extensi&oacute;n',9,'1',NULL,2),(55,'Unete a PPIVS',6,'1',39,1),(56,'Problemas dentales',2,'<br>',11,0),(58,'prueba de quienes somos',9,'1',51,1),(59,'prueba',8,'1',47,1),(60,'prueba',2,'1',7,3),(62,'Programa del docente integrado',1,'1',6,3),(63,'Investigaci&oacute;n Multidiciplinaria',1,'1',6,0),(66,'Consulta Externa',5,'1',26,3),(67,'Feria de la Salud',5,'1',26,0),(68,'trifoliar',1,'1',1,0),(69,'PRUEBAS DE VIH',3,'',16,0),(70,'AAAA',1,'',1,3),(71,'prueba 1',1,'prueba',4,3);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `multimedia`
--

DROP TABLE IF EXISTS `multimedia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `multimedia` (
  `idmultimedia` int(11) NOT NULL AUTO_INCREMENT,
  `direccion` varchar(255) NOT NULL,
  `direccion_relativa` varchar(255) NOT NULL,
  `tamanio` int(10) NOT NULL,
  `usuarioidusuario` int(10) NOT NULL,
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tipo` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idmultimedia`),
  KEY `FKimagen646018` (`usuarioidusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=322 DEFAULT CHARSET=utf8 COMMENT='1 IMAGEN, 2 PDF';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `multimedia`
--

LOCK TABLES `multimedia` WRITE;
/*!40000 ALTER TABLE `multimedia` DISABLE KEYS */;
INSERT INTO `multimedia` VALUES (288,'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\websalud\\images\\upload\\imagen\\70snapshot_20120327_2.jpg','images/upload/imagen/70snapshot_20120327_2.jpg',61464,1,'2012-03-29 11:09:37',1),(294,'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\websalud\\images\\upload\\imagen\\76200412855cartaasesoradeeps.jpg','images/upload/imagen/76200412855cartaasesoradeeps.jpg',102625,1,'2012-03-29 13:53:11',1),(296,'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\websalud\\images\\upload\\pdf\\78calendarioentregaeps_1er_sem2012(1).pdf','images/upload/pdf/78calendarioentregaeps_1er_sem2012(1).pdf',37490,1,'2012-03-29 14:02:09',2),(297,'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\websalud\\images\\upload\\imagen\\79afichefinaltabaco.jpg','images/upload/imagen/79afichefinaltabaco.jpg',125319,1,'2012-03-29 14:38:04',1);
/*!40000 ALTER TABLE `multimedia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria_permiso`
--

DROP TABLE IF EXISTS `categoria_permiso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoria_permiso` (
  `idcategoria_permiso` int(10) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  PRIMARY KEY (`idcategoria_permiso`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria_permiso`
--

LOCK TABLES `categoria_permiso` WRITE;
/*!40000 ALTER TABLE `categoria_permiso` DISABLE KEYS */;
INSERT INTO `categoria_permiso` VALUES (1,'Administrar Contenido'),(2,'Administrar'),(3,'Configurar Examen'),(4,'Estudiantes'),(5,'Reportes');
/*!40000 ALTER TABLE `categoria_permiso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `actividad`
--

DROP TABLE IF EXISTS `actividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actividad` (
  `idactividad` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) NOT NULL,
  `areaidarea` int(11) NOT NULL,
  `descripcion` text,
  `Edificioidedificio` int(11) NOT NULL,
  `salon` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idactividad`),
  KEY `FKactividad858803` (`areaidarea`),
  KEY `FKactividad380266` (`Edificioidedificio`),
  CONSTRAINT `FKactividad380266` FOREIGN KEY (`Edificioidedificio`) REFERENCES `edificio` (`idedificio`),
  CONSTRAINT `FKactividad858803` FOREIGN KEY (`areaidarea`) REFERENCES `area` (`idarea`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividad`
--

LOCK TABLES `actividad` WRITE;
/*!40000 ALTER TABLE `actividad` DISABLE KEYS */;
INSERT INTO `actividad` VALUES (1,'Prueba de actividad',2,'ESto es una prueba<div id=\'wrc-float-icon\' style=\'position: fixed; z-index: 2147483646; left: 15px; top: 15px; width: 42px; height: 42px; background-image: url(safari-extension://com.avast.wrc-6H4HRTU5E3/71965acc/images/float/grey-0.png); display: none; \'></div>',11,'101'),(2,'Taller de manipuladores',3,'<div><span style=\'font-size: 10pt; \'>Esta dirigida para manufactura de alimentos.</span></div>',1,'302'),(3,'actividad 1',1,'nueva actividad',1,'320'),(4,'actividad 2',1,'actividad 2',1,''),(5,'actividad 3',2,'<div><br></div><div>actividad 2<br></div>',1,''),(6,'actividad 5',1,'actividad 5',11,''),(7,'actividad 4',1,'<div><br></div><div>actividad 4</div>',1,''),(8,'actividad 6',1,'actividad 6',1,''),(9,'actividad 9',1,'actividad 9',1,''),(10,'actividad 10',1,'actividad 10',1,''),(11,'actividad 11',1,'actividad 11',1,''),(12,'actividad 12',1,'<div><br></div><div>actividad 12</div>',1,''),(13,'actividad 13',1,'actividad 13',1,''),(14,'actividad 14',1,'actividad 14',1,''),(15,'actividad 15',1,'actividad 15',1,''),(16,'actividad 16',1,'actividad 16',1,''),(17,'actividad 17',1,'actividad 17',1,''),(18,'actividad 18',1,'actividad 18',1,''),(19,'actividad 19',1,'actividad 19',1,''),(20,'actividad 20',1,'actividad 20',1,''),(21,'actividad 21',4,'actividad 21',1,''),(22,'actividad 22',1,'actividad 22',1,''),(23,'podokfl',1,'siofklsdklds',1,''),(24,'zzzzzz',4,'zzzzzzzzzzzz',1,'');
/*!40000 ALTER TABLE `actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `responsable`
--

DROP TABLE IF EXISTS `responsable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `responsable` (
  `idresponsable` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `apellido` varchar(150) NOT NULL,
  `usuarioidusuario` int(10) DEFAULT NULL,
  `areaidarea` int(11) NOT NULL,
  PRIMARY KEY (`idresponsable`),
  KEY `FKresponsabl927589` (`usuarioidusuario`),
  KEY `FKresponsabl680991` (`areaidarea`),
  CONSTRAINT `FKresponsabl680991` FOREIGN KEY (`areaidarea`) REFERENCES `area` (`idarea`),
  CONSTRAINT `FKresponsabl927589` FOREIGN KEY (`usuarioidusuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `responsable`
--

LOCK TABLES `responsable` WRITE;
/*!40000 ALTER TABLE `responsable` DISABLE KEYS */;
INSERT INTO `responsable` VALUES (2,'Karen Alejandra','Sontay',3,1),(3,'Aura Luz','Cifuentes Reyes',2,2),(4,'Maria Antonieta','Flores',NULL,2),(5,'Jennifer','Bonilla',NULL,3),(7,'Maria','Magdalena',NULL,1),(8,'josue','reyes',NULL,2),(9,'jose','perez',NULL,2),(10,'Aura','Reyes',NULL,4),(11,'Josue','Pablo',NULL,3),(13,'Josue','Gom&eacute;z',NULL,1),(14,'prueba 1','prueba 2',NULL,1),(15,'Danilo','Morales',17,5),(16,'Jorge','Ramirez',NULL,4),(17,'Dora Rene','Guerra',NULL,4);
/*!40000 ALTER TABLE `responsable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalleactividad`
--

DROP TABLE IF EXISTS `detalleactividad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalleactividad` (
  `iddetalleactividad` int(20) NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL,
  `horainicio` datetime NOT NULL,
  `horafin` datetime NOT NULL,
  `actividadidactividad` int(11) NOT NULL,
  PRIMARY KEY (`iddetalleactividad`),
  KEY `FKdetalleact662754` (`actividadidactividad`),
  CONSTRAINT `FKdetalleact662754` FOREIGN KEY (`actividadidactividad`) REFERENCES `actividad` (`idactividad`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalleactividad`
--

LOCK TABLES `detalleactividad` WRITE;
/*!40000 ALTER TABLE `detalleactividad` DISABLE KEYS */;
INSERT INTO `detalleactividad` VALUES (3,'2012-03-28 00:00:00','1970-01-01 09:00:00','1970-01-01 22:00:00',1),(4,'2012-03-29 00:00:00','1970-01-01 09:00:00','1970-01-01 22:00:00',1),(5,'2012-03-30 00:00:00','1970-01-01 09:00:00','1970-01-01 22:00:00',1),(6,'2012-03-29 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',2),(7,'2012-03-30 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',2),(8,'2012-04-05 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',2),(9,'2012-04-06 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',2),(10,'2012-04-12 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',2),(11,'2012-04-13 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',2),(12,'2012-03-30 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(13,'2012-03-22 00:00:00','1970-01-01 09:00:00','1970-01-01 11:00:00',1);
/*!40000 ALTER TABLE `detalleactividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `idusuario` int(10) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `apellido` varchar(150) NOT NULL,
  `nick` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `createtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` int(11) NOT NULL DEFAULT '1' COMMENT '1-> activo, 2-> desactivado',
  `updateusuario` int(11) NOT NULL,
  `no_personal` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE KEY `nick_UNIQUE` (`nick`),
  KEY `FKusuario800841` (`updateusuario`),
  CONSTRAINT `FKusuario800841` FOREIGN KEY (`updateusuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'admin','admin','admin','a123456','42144987','lucita287@gmail.com',NULL,1,1,'423322'),(2,'Aura Luz','Cifuentes Reyes','lucita287','24328221','24328221','lucita287@gmail.com',NULL,1,2,NULL),(3,'Karen','Sontay','k2010','24328221','42144987','lucita287@gmail.com','2012-03-06 12:17:12',1,1,NULL),(4,'Darwin','Hernández','darn1986','darn','42144987','lucita287@gmail.com','2012-03-06 12:17:12',1,1,NULL),(5,'Jennifer','Bonilla','jennifer','jennifer','42144987','lucita287@gmail.com','2012-03-06 12:17:12',1,1,NULL),(6,'Marí­a','Cifuentes','maria','maria','42144987','lucita287@gmail.com','2012-03-06 12:17:12',1,1,NULL),(7,'Jose','Salazar','jose','jose','42144987','lucita287@gmail.com','2012-03-06 12:17:12',1,1,NULL),(8,'Marco','Reyes','maco','maco','42144987','lucita287@gmail.com','2012-03-06 12:17:12',1,1,NULL),(9,'Alejandra','Sontay','ale','ale','42144987','lucita287@gmail.com','2012-03-06 12:17:12',1,1,NULL),(10,'Sofia','Rodriguez','sofi','sofi','42144987','lucita287@gmail.com','2012-03-06 12:17:12',1,1,NULL),(11,'Esperanza','Hernandez','espe','espe','42144987','lucita287@gmail.com','2012-03-06 12:17:12',1,1,NULL),(12,'Zoila','Galan','zoila','zoila','42144987','lucita287@gmail.com','2012-03-06 12:17:12',1,1,NULL),(13,'Leo','Lara','leo','leo','42144987','lucita287@gmail.com','2012-03-06 12:17:12',1,1,NULL),(14,'Juan','Cifuentes','juan','juan','42144987','lucita287@gmail.com','2012-03-06 12:17:12',1,1,NULL),(15,'Jessica','Orozco','jess','jess','42144987','lucita287@gmail.com','2012-03-06 12:17:12',1,1,NULL),(16,'Manuel','Mutzus','elmutzus','elmutzus','24328221','elmutzus@gmail.com','2012-03-06 12:37:44',1,1,NULL),(17,'Elder','Arevalo','manuel','mauel','42323324','elmutzus@gmail.com','2012-03-06 12:37:44',1,1,NULL),(18,'aura','luz','klucita','a123456','24328221','lucita287@gmail.com','2012-03-06 21:58:04',2,1,NULL),(19,'a','a','aura','auraluz','22222222','','2012-03-06 21:59:32',1,1,NULL),(20,'Maria','Sontay','maria2','a123456','24328221','lucita287@gmail.com','2012-03-09 17:40:17',1,1,NULL),(21,'Maria Elena','Galan','maelen','a123456','42144987','lucita287@gmail.com','2012-03-13 02:57:38',1,2,NULL),(22,'Maria','Magdalena','mariita','a123456','42144987','lucita287@gmail.com','2012-03-29 02:23:14',1,1,'3232322');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `area_usuario`
--

DROP TABLE IF EXISTS `area_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `area_usuario` (
  `areaidarea` int(11) NOT NULL,
  `usuarioidusuario` int(10) NOT NULL,
  PRIMARY KEY (`areaidarea`,`usuarioidusuario`),
  KEY `FKarea_usuar302492` (`areaidarea`),
  KEY `FKarea_usuar665501` (`usuarioidusuario`),
  CONSTRAINT `FKarea_usuar302492` FOREIGN KEY (`areaidarea`) REFERENCES `area` (`idarea`),
  CONSTRAINT `FKarea_usuar665501` FOREIGN KEY (`usuarioidusuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `area_usuario`
--

LOCK TABLES `area_usuario` WRITE;
/*!40000 ALTER TABLE `area_usuario` DISABLE KEYS */;
INSERT INTO `area_usuario` VALUES (2,1),(8,1);
/*!40000 ALTER TABLE `area_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `noticia`
--

DROP TABLE IF EXISTS `noticia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `noticia` (
  `idnoticia` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `descripcion` text NOT NULL,
  `areaidarea` int(11) NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL,
  `prioridad` int(11) NOT NULL DEFAULT '1',
  `multimediaidmultimedia` int(11) DEFAULT NULL,
  `descripcion_corta` varchar(100) DEFAULT NULL,
  `estado` int(11) DEFAULT '1',
  `createtime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `multimediaidmultimedia_pdf` int(11) DEFAULT NULL,
  PRIMARY KEY (`idnoticia`),
  KEY `FKnoticia914947` (`multimediaidmultimedia`),
  KEY `FKnoticia378758` (`areaidarea`),
  CONSTRAINT `FKnoticia378758` FOREIGN KEY (`areaidarea`) REFERENCES `area` (`idarea`),
  CONSTRAINT `FKnoticia914947` FOREIGN KEY (`multimediaidmultimedia`) REFERENCES `multimedia` (`idmultimedia`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `noticia`
--

LOCK TABLES `noticia` WRITE;
/*!40000 ALTER TABLE `noticia` DISABLE KEYS */;
INSERT INTO `noticia` VALUES (1,'PRUEBA 1','<div style=\'text-align: center; \'><b><font size=\'4\'>holaaaaa</font></b></div><br><div style=\'font-size: 10pt; text-align: justify; \'><span style=\'font-size: 10pt; \'>Esto es una prueba</span></div><div style=\'font-size: 10pt; text-align: justify; \'><br></div><div style=\'font-size: 10pt; text-align: justify; \'>El deporte es toda aquella actividad f&iacute;sica que involucra una serie de reglas o normas a desempe&ntilde;ar dentro de un espacio o &aacute;rea determinada (campo de juego, cancha, tablero, mesa, entre otros) a menudo asociada a la competitividad deportiva. Por lo general debe estar institucionalizado (federaciones, clubes), requiere competici&oacute;n con uno mismo o con los dem&aacute;s. Como t&eacute;rmino solitario, el deporte se refiere normalmente a actividades en las cuales la capacidad f&iacute;sica pulmonar del competidor son la forma primordial para determinar el resultado (ganar o perder); sin embargo, tambi&eacute;n se usa para incluir actividades donde otras capacidades externas o no directamente ligadas al f&iacute;sico del deportista son factores decisivos, como la agudeza mental o el equipamiento. Tal es el caso de, por ejemplo, los deportes mentales o los deportes de motor. Los deportes son un entretenimiento tanto para quien lo realiza como para quien observa su pr&aacute;ctica.</div>',6,'2012-03-26 00:00:00','2012-04-05 00:00:00',1,294,'PRUEBA 1 :D',1,'2012-03-29 12:29:16',296),(2,'prueba 2','prueba 2',4,'2012-03-25 00:00:00','2012-04-30 00:00:00',1,297,'prueba 2',1,'2012-03-29 14:38:19',NULL),(3,'prueba 3','prueba 3',2,'2012-03-25 00:00:00','2012-04-08 00:00:00',1,NULL,'prueba 3',1,'2012-03-29 14:38:54',NULL);
/*!40000 ALTER TABLE `noticia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'salud'
--

--
-- Dumping routines for database 'salud'
--
/*!50003 DROP FUNCTION IF EXISTS `EliminarActividad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `EliminarActividad`(pidactividad int ) RETURNS int(11)
    DETERMINISTIC
BEGIN
    DECLARE done BOOLEAN DEFAULT FALSE;
    declare viddetalleact int;
    declare vidresponsable int;
    declare cant int;
    DECLARE c0 CURSOR FOR select iddetalleactividad from detalleactividad where actividadidactividad=pidactividad;
    DECLARE c1 CURSOR FOR select responsableidresponsable from responsable_actividad where actividadidactividad=pidactividad;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = TRUE;
    set cant=0;
            open c0;
            c0_loop: LOOP
            fetch c0 into viddetalleact;
                    IF `done` THEN LEAVE c0_loop; END IF;
                    DELETE FROM detalleactividad WHERE iddetalleactividad = viddetalleact; 
                    set cant=cant+1;
            END LOOP c0_loop;
            CLOSE c0;
            SET done = FALSE;
            open c1;
            c1_loop: LOOP
            fetch c1 into vidresponsable;
                    IF `done` THEN LEAVE c1_loop; END IF;
                    DELETE FROM responsable_actividad WHERE responsableidresponsable = vidresponsable; 
                    set cant=cant+1;
            END LOOP c1_loop;
            CLOSE c1;
            
            
             DELETE FROM actividad WHERE idactividad = pidactividad;    
    RETURN 1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `EliminarContenido` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `EliminarContenido`(pidcontenido int ) RETURNS int(11)
    DETERMINISTIC
BEGIN
        DELETE FROM contenido WHERE idcontenido=pidcontenido ;
    
    RETURN 1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `EliminarDetalleActividad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `EliminarDetalleActividad`(pidactividad int ) RETURNS int(11)
    DETERMINISTIC
BEGIN
    DECLARE done BOOLEAN DEFAULT FALSE;
    declare viddetalleact int;
    declare cant int;
    DECLARE c0 CURSOR FOR select iddetalleactividad from detalleactividad where actividadidactividad=pidactividad;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = TRUE;
    set cant=0;
            open c0;
            c0_loop: LOOP
            fetch c0 into viddetalleact;
                    IF `done` THEN LEAVE c0_loop; END IF;
                    DELETE FROM detalleactividad WHERE iddetalleactividad = viddetalleact; 
                    set cant=cant+1;
            END LOOP c0_loop;
            CLOSE c0;
                
    RETURN cant;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `EliminarEncabezado` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `EliminarEncabezado`(pidarea int,pidmultimedia int ) RETURNS int(11)
    DETERMINISTIC
BEGIN
        DELETE FROM encabezado WHERE areaidarea=pidarea and multimediaidmultimedia=pidmultimedia ;
    
    RETURN 1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `EliminarMenu` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `EliminarMenu`(pidmenu int ) RETURNS int(11)
    DETERMINISTIC
BEGIN
    DECLARE done BOOLEAN DEFAULT FALSE;
    declare eliminar int;
    declare vidcontenido int;
    declare cmenu int;
    DECLARE c0 CURSOR FOR select idcontenido from contenido where menuidmenu=pidmenu;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = TRUE;
   SELECT count(idmenu) INTO cmenu FROM menu where idmenu_rec is not null and idmenu=pidmenu;
    
    
    if(cmenu>0) then
            open c0;
            c0_loop: LOOP
            fetch c0 into vidcontenido;
                    IF `done` THEN LEAVE c0_loop; END IF;
                    DELETE FROM contenido WHERE idcontenido=vidcontenido ;
            END LOOP c0_loop;
            CLOSE c0;
                      
            DELETE FROM Menu WHERE idmenu=pidmenu;
            set eliminar=1;
    else
            set eliminar=0;
    end if;
    
    RETURN eliminar;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `EliminarNoticia` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `EliminarNoticia`(pidnoticia int ) RETURNS int(11)
    DETERMINISTIC
BEGIN
    
        DELETE FROM noticia WHERE idnoticia=pidnoticia;
    
    RETURN 1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `InsertarActividadFecha` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `InsertarActividadFecha`(pidactividad int,pfecha datetime,phorainicio datetime, phorafin datetime ) RETURNS int(11)
    DETERMINISTIC
BEGIN
   DECLARE idday int DEFAULT 0;
   select ifnull(max(iddetalleactividad),0) into idday from detalleactividad where fecha=pfecha and horainicio=phorainicio and horafin=phorafin and actividadidactividad=pidactividad;

if idday=0 then
    INSERT INTO detalleactividad
      (fecha, 
      horainicio, 
      horafin, 
      actividadidactividad) 
    VALUES 
      (pfecha, 
      phorainicio, 
      phorafin, 
      pidactividad);
end if;
    RETURN 1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `Rango_fechas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `Rango_fechas`(idactividad int,fecha_inicio DATETIME,fecha_fin DATETIME,hora_inicio DATETIME,hora_fin DATETIME, lunes INT,martes INT,miercoles INT,jueves INT, viernes INT, sabado INT,domingo INT) RETURNS int(11)
    DETERMINISTIC
BEGIN
    DECLARE mydate DATETIME;
    DECLARE mday int;
    SET mday=0;
    SET mydate = fecha_inicio;
    IF fecha_inicio<=fecha_fin and hora_inicio<hora_fin then
        WHILE mydate < fecha_fin DO
            
            if (lunes=1 and DAYOFWEEK(mydate)=2) then
                SET mday=mday+InsertarActividadFecha(idactividad,mydate,hora_inicio, hora_fin );
            end if;
            if (martes=1 and DAYOFWEEK(mydate)=3) then
                SET mday=mday+InsertarActividadFecha(idactividad,mydate,hora_inicio, hora_fin );
            end if;
            if (miercoles=1 and DAYOFWEEK(mydate)=4) then
                SET mday=mday+InsertarActividadFecha(idactividad,mydate,hora_inicio, hora_fin );
            end if;
            if (jueves=1 and DAYOFWEEK(mydate)=5) then
                SET mday=mday+InsertarActividadFecha(idactividad,mydate,hora_inicio, hora_fin );
            end if;
            if (viernes=1 and DAYOFWEEK(mydate)=6) then
                SET mday=mday+InsertarActividadFecha(idactividad,mydate,hora_inicio, hora_fin );
            end if;
            if (sabado=1 and DAYOFWEEK(mydate)=7) then
                SET mday=mday+InsertarActividadFecha(idactividad,mydate,hora_inicio, hora_fin );
            end if;
            if (domingo=1 and DAYOFWEEK(mydate)=1) then
                SET mday=mday+InsertarActividadFecha(idactividad,mydate,hora_inicio, hora_fin );
            end if;
            SET mydate = date_add(mydate, INTERVAL 1 DAY);
        END WHILE;
    end if;
       
    RETURN mday;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-03-30 20:08:15
