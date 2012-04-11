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
-- Table structure for table `tipo_sangre`
--

DROP TABLE IF EXISTS `tipo_sangre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_sangre` (
  `idtipo_sangre` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`idtipo_sangre`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_sangre`
--

LOCK TABLES `tipo_sangre` WRITE;
/*!40000 ALTER TABLE `tipo_sangre` DISABLE KEYS */;
INSERT INTO `tipo_sangre` VALUES (1,'A'),(3,'B'),(4,'AB'),(5,'O POSITIVO');
/*!40000 ALTER TABLE `tipo_sangre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoria` (
  `idcategoria` int(10) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) NOT NULL,
  `orden` int(11) NOT NULL,
  `autoevaluacion` int(10) NOT NULL,
  `multifasico` int(10) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idcategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'ojos',1,1,0,0);
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paciente`
--

DROP TABLE IF EXISTS `paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paciente` (
  `idpaciente` int(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(300) NOT NULL,
  `fecha_nac` datetime NOT NULL,
  `carne` int(11) DEFAULT NULL,
  `direccion` varchar(300) NOT NULL,
  `telefono` varchar(50) NOT NULL,
  `movil` varchar(50) NOT NULL,
  `email` varchar(80) NOT NULL,
  `emer_nombre` varchar(200) DEFAULT NULL,
  `idemer_parentesco` int(11) DEFAULT NULL,
  `emer_telefono` varchar(50) DEFAULT NULL,
  `emer_movil` varchar(50) DEFAULT NULL,
  `carreraidcarrera` int(11) DEFAULT NULL,
  `tipo_sangreidtipo_sangre` int(11) DEFAULT NULL,
  `estado_civilidestado_civil` int(11) DEFAULT NULL,
  `centro_regionalidcentro_regional` int(11) DEFAULT NULL,
  `unidad_academicaidunidad_academica` int(11) DEFAULT NULL,
  `titulo_secundariaidtitulo_secundaria` int(11) DEFAULT NULL,
  `dependenciaiddependencia` int(11) DEFAULT NULL,
  `nombre_carrera` varchar(80) DEFAULT NULL,
  `nombre_centro` varchar(80) DEFAULT NULL,
  `nombre_dependencia` varchar(80) DEFAULT NULL,
  `nombre_unidad_academica` varchar(80) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `usuario` varchar(20) NOT NULL,
  PRIMARY KEY (`idpaciente`),
  UNIQUE KEY `username_UNIQUE` (`usuario`),
  UNIQUE KEY `carne` (`carne`),
  KEY `FKpaciente34221` (`titulo_secundariaidtitulo_secundaria`),
  KEY `FKpaciente702060` (`dependenciaiddependencia`),
  KEY `FKpaciente761424` (`idemer_parentesco`),
  KEY `FKpaciente156346` (`carreraidcarrera`),
  KEY `FKpaciente497631` (`tipo_sangreidtipo_sangre`),
  KEY `FKpaciente544904` (`estado_civilidestado_civil`),
  KEY `FKpaciente1089` (`centro_regionalidcentro_regional`),
  KEY `FKpaciente178128` (`unidad_academicaidunidad_academica`),
  CONSTRAINT `FKpaciente1089` FOREIGN KEY (`centro_regionalidcentro_regional`) REFERENCES `centro_regional` (`idcentro_regional`),
  CONSTRAINT `FKpaciente156346` FOREIGN KEY (`carreraidcarrera`) REFERENCES `carrera` (`idcarrera`),
  CONSTRAINT `FKpaciente178128` FOREIGN KEY (`unidad_academicaidunidad_academica`) REFERENCES `unidad_academica` (`idunidad_academica`),
  CONSTRAINT `FKpaciente34221` FOREIGN KEY (`titulo_secundariaidtitulo_secundaria`) REFERENCES `titulo_secundaria` (`idtitulo_secundaria`),
  CONSTRAINT `FKpaciente497631` FOREIGN KEY (`tipo_sangreidtipo_sangre`) REFERENCES `tipo_sangre` (`idtipo_sangre`),
  CONSTRAINT `FKpaciente544904` FOREIGN KEY (`estado_civilidestado_civil`) REFERENCES `estado_civil` (`idestado_civil`),
  CONSTRAINT `FKpaciente702060` FOREIGN KEY (`dependenciaiddependencia`) REFERENCES `dependencia` (`iddependencia`),
  CONSTRAINT `FKpaciente761424` FOREIGN KEY (`idemer_parentesco`) REFERENCES `parentesco` (`idparentesco`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paciente`
--

LOCK TABLES `paciente` WRITE;
/*!40000 ALTER TABLE `paciente` DISABLE KEYS */;
/*!40000 ALTER TABLE `paciente` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=252 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permiso`
--

LOCK TABLES `permiso` WRITE;
/*!40000 ALTER TABLE `permiso` DISABLE KEYS */;
INSERT INTO `permiso` VALUES (221,'Mostar Contenido',1),(222,'Crear Contenido',1),(223,'Eliminar Contenido',1),(224,'Nuevo Contenido',1),(225,'Mostrar Noticias',1),(226,'Crear  Noticias',1),(227,'Eliminar noticias',1),(228,'Mostar Actividades',1),(229,'Crear Actividades',1),(230,'Eliminar Actividades',1),(231,'Mostrar Areas',1),(232,'Modificar Areas',1),(233,'Mostrar Usuarios',2),(234,'Crear Usuarios',2),(235,'Mostrar Permisos',2),(236,'Asignar Permisos',2),(237,'Reportes',5),(238,'Dashboard',5),(239,'Manipular Estado Civil',3),(240,'Manipular Tipo Sangre',3),(241,'Manipular Parentesco',3),(242,'Manipular Titulo Secundaria',3),(243,'Manipular Carreras',3),(244,'Manipular Centro Universitario',3),(245,'Manipular Facultad',3),(246,'Modificar Configuracion',2),(247,'Mostrar  Archivos sin Usar',2),(248,'Eliminar Archivos sin Usar',2),(249,'Manipular Dependencia',3),(250,'Manipular Categoria',3),(251,'Manipular Categoria Ponderación',3);
/*!40000 ALTER TABLE `permiso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categoria_interpretacion`
--

DROP TABLE IF EXISTS `categoria_interpretacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categoria_interpretacion` (
  `idcategoria_interpretacion` int(10) NOT NULL AUTO_INCREMENT,
  `ponderacion_max` int(10) NOT NULL,
  `ponderacion_min` int(10) NOT NULL,
  `interpretacion` text,
  `idcategoria` int(10) NOT NULL,
  PRIMARY KEY (`idcategoria_interpretacion`),
  KEY `FKcategoria_569059` (`idcategoria`),
  CONSTRAINT `FKcategoria_569059` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria_interpretacion`
--

LOCK TABLES `categoria_interpretacion` WRITE;
/*!40000 ALTER TABLE `categoria_interpretacion` DISABLE KEYS */;
INSERT INTO `categoria_interpretacion` VALUES (1,20,10,'hola',1);
/*!40000 ALTER TABLE `categoria_interpretacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pregunta_titulo_respuesta`
--

DROP TABLE IF EXISTS `pregunta_titulo_respuesta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pregunta_titulo_respuesta` (
  `idtitulo_respuesta` int(11) NOT NULL,
  `idpregunta` int(10) NOT NULL,
  `ponderacion` int(10) DEFAULT NULL,
  PRIMARY KEY (`idtitulo_respuesta`,`idpregunta`),
  KEY `FKpregunta_t278188` (`idtitulo_respuesta`),
  KEY `FKpregunta_t722293` (`idpregunta`),
  CONSTRAINT `FKpregunta_t278188` FOREIGN KEY (`idtitulo_respuesta`) REFERENCES `titulo_respuesta` (`idtitulo_respuesta`),
  CONSTRAINT `FKpregunta_t722293` FOREIGN KEY (`idpregunta`) REFERENCES `pregunta` (`idpregunta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pregunta_titulo_respuesta`
--

LOCK TABLES `pregunta_titulo_respuesta` WRITE;
/*!40000 ALTER TABLE `pregunta_titulo_respuesta` DISABLE KEYS */;
INSERT INTO `pregunta_titulo_respuesta` VALUES (6,7,1),(7,4,1),(8,4,1),(9,4,1),(10,4,1),(21,3,2),(22,3,32);
/*!40000 ALTER TABLE `pregunta_titulo_respuesta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo_titulo_respuesta`
--

DROP TABLE IF EXISTS `grupo_titulo_respuesta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupo_titulo_respuesta` (
  `idgrupo` int(11) NOT NULL,
  `idtitulo_respuesta` int(11) NOT NULL,
  `orden` int(11) NOT NULL,
  PRIMARY KEY (`idgrupo`,`idtitulo_respuesta`),
  KEY `FKgrupo_titu883601` (`idtitulo_respuesta`),
  CONSTRAINT `FKgrupo_titu883601` FOREIGN KEY (`idtitulo_respuesta`) REFERENCES `titulo_respuesta` (`idtitulo_respuesta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo_titulo_respuesta`
--

LOCK TABLES `grupo_titulo_respuesta` WRITE;
/*!40000 ALTER TABLE `grupo_titulo_respuesta` DISABLE KEYS */;
INSERT INTO `grupo_titulo_respuesta` VALUES (1,1,1),(1,2,2),(1,3,3),(1,4,4),(2,3,3),(2,4,4),(2,5,1),(2,6,2),(3,7,1),(3,8,2),(3,9,3),(3,10,4),(4,4,2),(4,11,1),(5,12,1),(5,13,2),(5,14,3),(5,15,4),(5,16,5),(6,1,1),(6,17,2),(6,18,3);
/*!40000 ALTER TABLE `grupo_titulo_respuesta` ENABLE KEYS */;
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
INSERT INTO `area` VALUES (1,'Unidad de Salud',NULL,'1',1,NULL),(2,'Odontologia',NULL,'1',0,NULL),(3,'Laboratorio Clinico',NULL,'<div style=\'font-size: 10pt; font-weight: normal; \'><br></div><div style=\'font-size: 10pt; font-weight: normal; \'><br></div><div style=\'font-size: 10pt; font-weight: normal; \'><br></div><b><div style=\'text-align: center; \'><b><font size=\'5\'>AREA DE LABORATORIO ES LA MEJOR</font></b></div></b><div style=\'font-size: 10pt; text-align: center; font-weight: normal; \'><br></div>',1,NULL),(4,'Psicologia',NULL,'1',0,NULL),(5,'Medicina',NULL,'<br><div style=\'font-size: 10pt; font-family: Arial, Verdana; \'><br></div><div style=\'text-align: center; \'><font face=\'\'Arial Black\'\' size=\'5\'>AREA DE MEDICINA</font></div><div style=\'font-size: 10pt; font-family: Arial, Verdana; \'><br></div><div style=\'font-size: 10pt; font-family: Arial, Verdana; \'>Bienvenido</div>',2,329),(6,'PPIVS',5,'1',2,NULL),(7,'Nutricion',5,'1',0,NULL),(8,'Actividad Fisica',5,'1',1,NULL),(9,'Consulta Externa',5,'1',1,NULL);
/*!40000 ALTER TABLE `area` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividad`
--

LOCK TABLES `actividad` WRITE;
/*!40000 ALTER TABLE `actividad` DISABLE KEYS */;
INSERT INTO `actividad` VALUES (1,'Prueba de actividad',2,'ESto es una prueba<div id=\'wrc-float-icon\' style=\'position: fixed; z-index: 2147483646; left: 15px; top: 15px; width: 42px; height: 42px; background-image: url(safari-extension://com.avast.wrc-6H4HRTU5E3/71965acc/images/float/grey-0.png); display: none; \'></div>',11,'101'),(2,'Taller de manipuladores',3,'<div><span style=\'font-size: 10pt; \'>Esta dirigida para manufactura de alimentos.</span></div>',1,'302'),(3,'actividad 1',1,'nueva actividad',1,'320'),(4,'actividad 2',1,'actividad 2',1,''),(5,'actividad 3',2,'<div><br></div><div>actividad 2<br></div>',1,''),(6,'actividad 5',1,'actividad 5',11,''),(7,'actividad 4',1,'<div><br></div><div>actividad 4</div>',1,''),(8,'actividad 6',1,'actividad 6',1,''),(9,'actividad 9',1,'actividad 9',1,''),(10,'actividad 10',1,'actividad 10',1,''),(11,'actividad 11',1,'actividad 11',1,''),(12,'actividad 12',1,'<div><br></div><div>actividad 12</div>',1,''),(13,'actividad 13',1,'actividad 13',1,''),(14,'actividad 14',1,'actividad 14',1,''),(15,'actividad 15',1,'actividad 15',1,''),(16,'actividad 16',1,'actividad 16',1,''),(17,'actividad 17',1,'actividad 17',1,''),(18,'actividad 18',1,'actividad 18',1,''),(19,'actividad 19',1,'actividad 19',1,''),(20,'actividad 20',1,'actividad 20',1,''),(21,'actividad 21',4,'actividad 21',1,''),(22,'actividad 22',1,'actividad 22',1,''),(23,'podokfl',1,'siofklsdklds',1,''),(24,'zzzzzz',4,'zzzzzzzzzzzz',1,''),(25,'ACTIVIDAD DE MEDICINA',5,'ACTIVIDAD DE MEDICINA',3,'332323');
/*!40000 ALTER TABLE `actividad` ENABLE KEYS */;
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
INSERT INTO `menu` VALUES (1,'Quienes Somos',1,'<div><b><font size=\'5\'><br></font></b></div><b><font size=\'5\'>AREA DE QUIENES SOMOS</font></b><div style=\'font-size: 10pt; font-weight: normal; \'><br></div><div style=\'font-size: 10pt; font-weight: normal; \'><br></div><div style=\'font-size: 10pt; font-weight: normal; \'>PRIMERA PARTE DE QUIENES SOMO&nbsp;</div>',NULL,1),(2,'Administraci&oacute;n',1,'1',NULL,3),(3,'Misi&oacute;n',1,'1',NULL,1),(4,'Visi&oacute;n',1,'1',NULL,1),(5,'Antecedentes',1,'1',NULL,3),(6,'Investigaci&oacute;n y Docenc&iacute;a',1,'1',NULL,1),(7,'Quienes Somos',2,'1',NULL,3),(8,'Docencia',2,'1',NULL,3),(9,'Investigaci&oacute;n',2,'1',NULL,3),(11,'Extensi&oacute;n',2,'1',NULL,3),(12,'Quienes Somos',3,'<br><div style=\'font-size: 10pt; font-weight: normal; \'><br></div><div style=\'text-align: center; \'><b><font size=\'5\' color=\'#990000\'>ESTE ES UN EJEMPLO DE UN CUADRO</font></b></div><div style=\'font-size: 10pt; font-weight: normal; text-align: center; \'><br></div><div style=\'font-size: 10pt; font-weight: normal; text-align: center; \'>MUCHO TEXTO</div><div style=\'font-size: 10pt; font-weight: normal; text-align: center; \'><br></div><div style=\'font-size: 10pt; font-weight: normal; text-align: center; \'>MUCHO TEXTO</div><div style=\'font-size: 10pt; font-weight: normal; text-align: center; \'><br></div><div style=\'font-size: 10pt; font-weight: normal; text-align: center; \'>MUCHO TEXTO</div>',NULL,2),(13,'Docencia',3,'1',NULL,3),(14,'Investigaci&oacute;n',3,'<div style=\'font-size: 10pt; \'><br></div><div style=\'text-align: center; \'><font size=\'5\'><b>INVESTIGACI&Oacute;N</b></font></div><div style=\'font-size: 10pt; \'>&nbsp;</div>',NULL,1),(16,'Extensi&oacute;n',3,'1',NULL,3),(17,'Quienes Somos',4,'1',NULL,1),(18,'Docencia',4,'1',NULL,3),(19,'Investigaci&oacute;n',4,'1',NULL,3),(21,'Extensi&oacute;n',4,'1',NULL,3),(22,'Quienes Somos',5,'1',NULL,3),(23,'Docencia',5,'1',NULL,3),(24,'Investigaci&oacute;n',5,'1',NULL,1),(26,'Extensi&oacute;n',5,'1',NULL,1),(38,'Organigrama',1,'1',2,0),(39,'Quienes Somos',6,'1',NULL,1),(40,'Docencia',6,'1',NULL,2),(41,'Investigaci&oacute;n',6,'1',NULL,2),(42,'Extensi&oacute;n',6,'1',NULL,2),(43,'Quienes Somos',7,'1',NULL,2),(44,'Docencia',7,'1',NULL,2),(45,'Investigaci&oacute;n',7,'1',NULL,2),(46,'Extensi&oacute;n',7,'1',NULL,2),(47,'Quienes Somos',8,'1',NULL,2),(48,'Docencia',8,'1',NULL,2),(49,'Investigaci&oacute;n',8,'1',NULL,2),(50,'Extensi&oacute;n',8,'1',NULL,2),(51,'Quienes Somos',9,'1',NULL,1),(52,'Docencia',9,'1',NULL,2),(53,'Investigaci&oacute;n',9,'1',NULL,2),(54,'Extensi&oacute;n',9,'1',NULL,2),(55,'Unete a PPIVS',6,'1',39,1),(56,'Problemas dentales',2,'<br>',11,0),(58,'prueba de quienes somos',9,'1',51,1),(59,'prueba',8,'1',47,1),(60,'prueba',2,'1',7,3),(62,'Programa del docente integrado',1,'1',6,3),(63,'Investigaci&oacute;n Multidiciplinaria',1,'1',6,0),(66,'Consulta Externa',5,'1',26,3),(67,'Feria de la Salud',5,'1',26,0),(68,'trifoliar',1,'1',1,0),(69,'PRUEBAS DE VIH',3,'',16,0),(70,'AAAA',1,'',1,3),(71,'prueba 1',1,'prueba',4,3);
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
) ENGINE=InnoDB AUTO_INCREMENT=334 DEFAULT CHARSET=utf8 COMMENT='1 IMAGEN, 2 PDF';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `multimedia`
--

LOCK TABLES `multimedia` WRITE;
/*!40000 ALTER TABLE `multimedia` DISABLE KEYS */;
INSERT INTO `multimedia` VALUES (288,'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\websalud\\images\\upload\\imagen\\70snapshot_20120327_2.jpg','images/upload/imagen/70snapshot_20120327_2.jpg',61464,1,'2012-03-29 11:09:37',1),(294,'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\websalud\\images\\upload\\imagen\\76200412855cartaasesoradeeps.jpg','images/upload/imagen/76200412855cartaasesoradeeps.jpg',102625,1,'2012-03-29 13:53:11',1),(296,'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\websalud\\images\\upload\\pdf\\78calendarioentregaeps_1er_sem2012(1).pdf','images/upload/pdf/78calendarioentregaeps_1er_sem2012(1).pdf',37490,1,'2012-03-29 14:02:09',2),(297,'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\websalud\\images\\upload\\imagen\\79afichefinaltabaco.jpg','images/upload/imagen/79afichefinaltabaco.jpg',125319,1,'2012-03-29 14:38:04',1),(322,'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\websalud\\images\\upload\\imagen\\4snapshot_20120327_2.jpg','images/upload/imagen/4snapshot_20120327_2.jpg',61464,1,'2012-03-31 03:26:00',1),(323,'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\websalud\\images\\upload\\imagen\\5snapshot_20120328.jpg','images/upload/imagen/5snapshot_20120328.jpg',52301,1,'2012-03-31 03:26:08',1),(324,'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\websalud\\images\\upload\\imagen\\6snapshot_20120321.jpg','images/upload/imagen/6snapshot_20120321.jpg',46217,1,'2012-03-31 03:26:15',1),(325,'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\websalud\\images\\upload\\imagen\\7snapshot_20120314_1.jpg','images/upload/imagen/7snapshot_20120314_1.jpg',59466,1,'2012-03-31 03:26:22',1),(326,'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\websalud\\images\\upload\\imagen\\8koala.jpg','images/upload/imagen/8koala.jpg',780831,1,'2012-03-31 03:30:09',1),(327,'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\websalud\\images\\upload\\imagen\\9penguins.jpg','images/upload/imagen/9penguins.jpg',777835,1,'2012-03-31 03:30:16',1),(328,'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\websalud\\images\\upload\\imagen\\10hydrangeas.jpg','images/upload/imagen/10hydrangeas.jpg',595284,1,'2012-03-31 03:30:23',1),(329,'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\websalud\\images\\upload\\imagen\\11snapshot_20120328.jpg','images/upload/imagen/11snapshot_20120328.jpg',52301,1,'2012-03-31 03:31:38',1),(331,'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\websalud\\images\\upload\\imagen\\13snapshot_20120314_1.jpg','images/upload/imagen/13snapshot_20120314_1.jpg',59466,1,'2012-03-31 03:33:07',1),(333,'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\websalud\\images\\upload\\imagen\\15snapshot_20110707_1.jpg','images/upload/imagen/15snapshot_20110707_1.jpg',57702,1,'2012-04-09 16:43:34',1);
/*!40000 ALTER TABLE `multimedia` ENABLE KEYS */;
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
-- Table structure for table `carrera`
--

DROP TABLE IF EXISTS `carrera`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carrera` (
  `idcarrera` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(250) NOT NULL,
  PRIMARY KEY (`idcarrera`)
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carrera`
--

LOCK TABLES `carrera` WRITE;
/*!40000 ALTER TABLE `carrera` DISABLE KEYS */;
INSERT INTO `carrera` VALUES (1,'LICENCIATURA EN TRABAJO SOCIAL'),(2,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN PEDAGOGIA Y PROMOTOR DE DERECHOS HUMANOS Y CULTURA DE PAZ'),(3,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN PEDAGOGIA Y TECNICO EN ADMINISTRACION EDUCATIVA'),(4,'MEDICO Y CIRUJANO'),(5,'pem en pedagia y promotor de derechos humanos'),(6,'lic. Dise&Ntilde;o grafico'),(7,'Lic. En dise&Ntilde;o grafico'),(8,'Abogado y Notario'),(9,'arquitectura'),(10,'BIOLOGO'),(11,'licenciatura de dise&Ntilde;o grafico'),(12,'licenciatura en dise&Ntilde;o grafico'),(13,'dise&Ntilde;o grafico'),(15,'ingenieria en alimentos cunsuroc'),(16,'liceciatura en dise&Ntilde;o grafico'),(17,'ing.agro. En recursos naturales'),(18,'TECNICO UNICERSITARIO EN AGRIMENSURA'),(20,'licda. Trabajo social'),(21,'pem pedagogia y tenico en administacion educativa'),(22,'Licenciado en ciencias juridcas y sociales  abogado y notario'),(24,'pedagogia'),(26,'administracion de empresas'),(27,'MEDICO VENETINARIO'),(28,'psicologo'),(29,'LICENCIADO EN TRABAJO SOCIAL'),(30,'PEM EN LEGUA Y LITERATURA'),(31,'Escuela de Formaci'),(32,'PUBLICIDAD PROFESIONAL'),(33,'abogado y notario     cunsuroc'),(34,'ADMINISTRACION'),(35,'ORIENTACION VOCACIONAL Y LABORAL'),(36,'CIRUJANO DENTISTA'),(37,'CONTADURIA PUBLICA Y AUDITORIA'),(39,'\"LICENCIATURA EN CIENCIAS JUR'),(40,'INGENIERIA AGRONOMICA EN SISTEMAS DE PRODUCCION AGRICOLA'),(41,'INGENIERIA EN GESTION AMBIENTAL LOCAL'),(42,'MEDICINA VETERINARIA '),(43,'INGENIERIA EN INDUSTRIAS AGROPECUARIAS Y FORESTALES'),(44,'INGENIERIA AGRONOMICA EN RECURSOS NATURALES RENOVABLES'),(45,'TECNICO EN TRADUCCION Y CORRESPONDENCIA INTERNACIONAL'),(46,'ZOOTECNIA'),(47,'LICENCIATURA EN RELACIONES INTERNACIONALES'),(48,'LOCUCION PROFESIONAL'),(49,'LICENCIATURA EN TURISMO'),(50,'TECNICO EN ENFERMERIA'),(51,'QUIMICA FARMACEUTICA'),(52,'QUIMICA BIOLOGICA'),(53,'LICENCIATURA EN DANZA CONTEMPORANEA Y COREOGRAFIA'),(54,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN HISTORIA Y CIENCIAS SOCIALES'),(55,'LICENCIATURA EN CIENCIA POLITICA'),(56,'NUTRICION'),(57,'LICENCIATURA EN ARQUEOLOGIA'),(58,'LICENCIATURA EN ARTE DRAMATICO CON ESPECIALIZACION EN ACTUACION'),(59,'LICENCIATURA EN SOCIOLOGIA'),(60,'LICENCIATURA EN ARTES VISUALES CON ESPECIALIZACION EN PINTURA'),(61,'INGENIERIA AMBIENTAL'),(62,'QUIMICA'),(63,'TECNICO UNIVERSITARIO EN ARCHIVOS'),(64,'LICENCIATURA EN HISTORIA'),(65,'LICENCIATURA EN ANTROPOLOGIA'),(66,'LICENCIATURA EN MUSICA'),(67,'BIOLOGIA'),(68,'INGENIERIA CIVIL'),(69,'INGENIERIA EN CIENCIAS Y SISTEMAS'),(70,'INGENIERIA INDUSTRIAL'),(71,'INGENIERIA ELECTRICA'),(72,'INGENIERIA ELECTRONICA'),(73,'INGENIERIA QUIMICA'),(74,'INGENIERIA MECANICA INDUSTRIAL'),(75,'INGENIERIA MECANICA'),(76,'INGENIERIA MECANICA ELECTRICA'),(77,'LICENCIATURA EN MATEMATICA APLICADA'),(78,'LICENCIATURA EN FISICA APLICADA'),(79,'INGENIERO ELECTRONICO'),(81,'PERIODISMO PROFESIONAL'),(82,'TERAPIA OCUPACIONAL Y RECREATIVA'),(83,'LICENCIATURA EN PSICOLOGIA'),(84,'PROFESORADO DE EDUCACION ESPECIAL'),(85,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN CIENCIAS ESPECIALIZADO EN MATEMATICA Y FISICA'),(86,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN CIENCIAS ECONOMICO CONTABLES'),(87,'T'),(88,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN LENGUA Y LITERATURA'),(89,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN CIENCIAS ESPECIALIZADO EN QUIMICA Y BIOLOGIA'),(90,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN COMPUTACION E INFORMATICA'),(91,'TERAPIA DEL LENGUAJE'),(92,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN EDUCACI'),(93,'PROFESORADO DE ENSE�ANZA MEDIA EN PSICOLOGIA'),(94,'PROFESORADO EN ENSE&Ntilde;ANZA MEDIA EN EDUCACION PARA CONTEXTOS MULTICULTURALES'),(95,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN PEDAGOGIA Y TECNICO EN INVESTIGACION EDUCATIVA'),(96,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN PEDAGOGIA Y CIENCIAS NATURALES CON ORIENTACION AMBIENTAL'),(97,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN EDUCACION MUSICAL'),(98,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN ARTES PLASTICAS E HISTORIA DEL ARTE'),(99,'LICENCIATURA EN LETRAS'),(100,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN PEDAGOGIA Y EDUCACION INTERCULTURAL'),(101,'LICENCIATURA EN FILOSOFIA'),(102,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN IDIOMA INGLES'),(103,'LICENCIATURA EN ARTE'),(104,'TECNICO EN RESTAURACION DE BIENES MUEBLES'),(105,'\"LICENCIATURA EN CIENCIAS JURIDICAS Y SOCIALES'),(106,'BIBLIOTECARIO GENERAL'),(107,'TECNICO EN PROCESAMIENTO DE ALIMENTOS'),(108,'TECNICO EN PRODUCCION AGRICOLA'),(109,'PEM EN PEDAGOGIA Y TENICO ADMINISTRATIVO ED.'),(110,'LICENCIATURA EN ENFERMERIA'),(111,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN FILOSOFIA'),(113,'licenciatura  en pedagogia'),(114,'pem en pedagogia y ciencias naturales con orientaci'),(115,'pem en pedagogia y ciencias naturales con roeintacion'),(116,'pem en pedagogia y ciencias naturales con orientacion'),(117,'pem pedagogia y ciencias naturales con orientaci'),(119,'pem pedagogia y ciencias naturales con orientacion'),(120,'PROFESORADO'),(121,'profesorado en ense&Ntilde;anza media'),(122,'pem en pedagogia y ciencias naturales con orie'),(123,'pem en pedagogia y ciencias natuarles con orientacion'),(124,'Profesorado en Ense&Ntilde;anza Media   taxisco'),(125,'PROFESORADO EN ENSE&Ntilde;ANZA MEDIA EN PEDAGOGIA Y T'),(126,'profesor de ense&Ntilde;anza media en pedagogia y'),(127,'pem sabatino'),(128,'ING. AGRONOMO EN SISTEMAS DE PRODUCCION'),(129,'tecnico en ling'),(130,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN PEDAGOGIA Y TECNICO EN FORMULACION DE PROYECTOS EDUCATIVOS'),(131,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN MATEMATICA Y FISICA'),(132,'TRABAJADOR SOCIAL RURAL'),(133,'TECNICO EN AGRIMENSURA'),(134,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN PEDAGOG'),(135,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN PEDAGOGIA Y TECNICO EN ADMINISTRACION EDUCATIVA CON ORIENTACION EN MEDIO AMBIENTE'),(136,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN PEDAGOG'),(137,'TECNICO EN TURISMO'),(138,'TRABAJADOR SOCIAL'),(139,'INGENIERIA FORESTAL'),(140,'AUDITOR TECNICO'),(141,'INGENIERO AGRONOMO EN SISTEMAS DE PRODUCCION'),(142,'ADMINISTRACION DE EMPRESAS'),(143,'TECNICO EN ADMINISTRACION DE EMPRESAS'),(144,'TECNICO UNIVERSITARIO EN AGRIMENSURA'),(145,'TECNICO EN PROCESOS AGROINDUSTRIALES'),(146,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN CIENCIAS NATURALES CON ORIENTACION AMBIENTAL'),(147,'TECNICO EN ADMINISTRACION DE EMPRESAS'),(148,'PERIODISMO PROFESIONAL'),(149,'LICENCIATURA EN ADMINISTRACION DE EMPRESAS'),(150,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN PEDAGOGIA Y CIENCIAS DE LA EDUCACION'),(151,'TECNICO EN PRODUCCION FRUTICOLA'),(152,'AGRONOMIA'),(153,'PROFESORADO EN PSICOPEDAGOGIA'),(154,'T'),(155,'TECNICO EN GEOLOGIA'),(156,'LICENCIATURA EN ZOOTECNIA'),(157,'LICENCIATURA EN ZOOTECNIA CON ENFASIS EN SISTEMAS DE PRODUCCION  AGROPECUARIA'),(158,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN PEDAGOGIA CON ORIENTACION EN MEDIO AMBIENTE'),(159,'TECNICO EN ADMINISTRACION EDUCATIVA'),(160,'INGENIERO AGRONOMO EN SISTEMAS DE PRODUCCION AGROPECUARIA'),(161,'licenciatura en ciencias de la comunicaci'),(162,'LICENCIATURA EN ADMINISTRACION DE RECURSOS TURISTICOS'),(163,'PROFESORADO EN ENSE&Ntilde;ANZA MEDIA CON ESPECIALIZACION EN MATEMATICAS Y FISICA'),(164,'TECNICO EN PRODUCCION PECUARIA'),(165,'LICENCIATURA EN CIENCIAS JURIDICAS Y SOCIALES'),(166,'licda. En adms. De recursos turisticos'),(167,'TECNICO EN ARQUEOLOGIA'),(168,'pem en pedagogia  y promotor de derechos humanos'),(169,'PROFESORADO DE ENSE&Ntilde;ANZA MEDIA EN PEDAGOG'),(170,'INGENIERIA EN INDUSTRIA ALIMENTARIA'),(171,'lci. Adm. Recursos turisticos'),(172,'TECNICO UNIVERSITARIO EN ELECTRONICA'),(173,'TECNICO UNIVERSITARIO EN METAL Y MECANICA'),(174,'TECNICO UNIVERSITARIO EN REFRIGERACION Y AIRE ACONDICIONADO'),(175,'LOCUCION PROFESIONAL'),(176,'INGENIERO AGRONOMO EN SISTEMAS DE PRODUCCION AGRICOLA'),(177,'PERIODISTA PROFESIONAL'),(178,'tecnico en electricidad'),(179,'tecnico en electronica');
/*!40000 ALTER TABLE `carrera` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `noticia`
--

LOCK TABLES `noticia` WRITE;
/*!40000 ALTER TABLE `noticia` DISABLE KEYS */;
INSERT INTO `noticia` VALUES (1,'PRUEBA 1','<div style=\'text-align: center; \'><b><font size=\'4\'>holaaaaa</font></b></div><br><div style=\'font-size: 10pt; text-align: justify; \'><span style=\'font-size: 10pt; \'>Esto es una prueba</span></div><div style=\'font-size: 10pt; text-align: justify; \'><br></div><div style=\'font-size: 10pt; text-align: justify; \'>El deporte es toda aquella actividad f&iacute;sica que involucra una serie de reglas o normas a desempe&ntilde;ar dentro de un espacio o &aacute;rea determinada (campo de juego, cancha, tablero, mesa, entre otros) a menudo asociada a la competitividad deportiva. Por lo general debe estar institucionalizado (federaciones, clubes), requiere competici&oacute;n con uno mismo o con los dem&aacute;s. Como t&eacute;rmino solitario, el deporte se refiere normalmente a actividades en las cuales la capacidad f&iacute;sica pulmonar del competidor son la forma primordial para determinar el resultado (ganar o perder); sin embargo, tambi&eacute;n se usa para incluir actividades donde otras capacidades externas o no directamente ligadas al f&iacute;sico del deportista son factores decisivos, como la agudeza mental o el equipamiento. Tal es el caso de, por ejemplo, los deportes mentales o los deportes de motor. Los deportes son un entretenimiento tanto para quien lo realiza como para quien observa su pr&aacute;ctica.</div>',6,'2012-03-26 00:00:00','2012-04-05 00:00:00',1,294,'PRUEBA 1 :D',1,'2012-03-29 12:29:16',296),(2,'prueba 2','prueba 2',4,'2012-03-25 00:00:00','2012-04-30 00:00:00',1,297,'prueba 2',1,'2012-03-29 14:38:19',NULL),(3,'prueba 3','prueba 3',2,'2012-03-25 00:00:00','2012-04-08 00:00:00',1,NULL,'prueba 3',1,'2012-03-29 14:38:54',NULL),(4,'NUEVA NOTICIA','<div><br></div><div>NUEVA NOTICIA</div>',1,'2012-03-25 00:00:00','2012-04-18 00:00:00',3,NULL,'una noticia nueva',1,'2012-03-31 03:35:29',NULL);
/*!40000 ALTER TABLE `noticia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parentesco`
--

DROP TABLE IF EXISTS `parentesco`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parentesco` (
  `idparentesco` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `grupo_familiar` int(11) NOT NULL,
  `antecedentes_familiares` int(10) NOT NULL,
  `emergencia` int(10) NOT NULL,
  PRIMARY KEY (`idparentesco`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parentesco`
--

LOCK TABLES `parentesco` WRITE;
/*!40000 ALTER TABLE `parentesco` DISABLE KEYS */;
INSERT INTO `parentesco` VALUES (1,'Padre',1,1,1),(2,'Madre',1,1,1),(3,'Hermano(a)',1,1,1);
/*!40000 ALTER TABLE `parentesco` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_pregunta`
--

DROP TABLE IF EXISTS `tipo_pregunta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_pregunta` (
  `idtipo_pregunta` int(10) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) NOT NULL,
  `idgrupo` int(11) DEFAULT NULL,
  PRIMARY KEY (`idtipo_pregunta`),
  UNIQUE KEY `idgrupo` (`idgrupo`),
  KEY `FKtipo_pregu253906` (`idgrupo`),
  CONSTRAINT `FKtipo_pregu253906` FOREIGN KEY (`idgrupo`) REFERENCES `grupo` (`idgrupo`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_pregunta`
--

LOCK TABLES `tipo_pregunta` WRITE;
/*!40000 ALTER TABLE `tipo_pregunta` DISABLE KEYS */;
INSERT INTO `tipo_pregunta` VALUES (1,'Campo Numerico',NULL),(2,'Campo Cadena',NULL),(3,'Opcion Diferentes',NULL),(4,'Siempre, Frecuentemente, Ocasionalmente, No',1),(5,'A diario, 1 a 3 Veces/Semana, Ocasionalmente, No',2),(6,'Muy pasado(a) de peso, Pasado(a) de peso, Bien de peso, Bajo(a) de peso',3),(7,'SI, NO',4),(8,'Grupo Familiar',5),(9,'Siempre, A veces, Nunca',6);
/*!40000 ALTER TABLE `tipo_pregunta` ENABLE KEYS */;
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
-- Table structure for table `pregunta`
--

DROP TABLE IF EXISTS `pregunta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pregunta` (
  `idpregunta` int(10) NOT NULL AUTO_INCREMENT,
  `orden` int(11) NOT NULL,
  `requerida` int(10) NOT NULL DEFAULT '0',
  `pregunta` varchar(255) DEFAULT NULL,
  `categoriaidcategoria` int(10) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `idtipo_pregunta` int(10) NOT NULL,
  `auto_evaluacion` int(10) NOT NULL,
  `multifasico` int(11) NOT NULL,
  `largo` int(10) DEFAULT NULL COMMENT '1->pequeño,2->mediano,3->Grande',
  `multiple` int(11) DEFAULT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idpregunta`),
  KEY `FKpregunta916024` (`categoriaidcategoria`),
  KEY `FKpregunta179647` (`idtipo_pregunta`),
  CONSTRAINT `FKpregunta179647` FOREIGN KEY (`idtipo_pregunta`) REFERENCES `tipo_pregunta` (`idtipo_pregunta`),
  CONSTRAINT `FKpregunta916024` FOREIGN KEY (`categoriaidcategoria`) REFERENCES `categoria` (`idcategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pregunta`
--

LOCK TABLES `pregunta` WRITE;
/*!40000 ALTER TABLE `pregunta` DISABLE KEYS */;
INSERT INTO `pregunta` VALUES (1,1,1,'a',1,'a',1,1,0,0,0,0),(2,1,1,'a',1,'a',2,1,0,1,0,0),(3,1,1,'a',1,'a',3,1,0,0,0,0),(4,2,1,'hola hola hola hola',1,'',6,1,0,0,1,0),(5,12,0,'ESTO ES UNA PRUEBA',1,'HOLA',2,1,1,1,0,0),(6,111,0,'HOLAAAAAAAAA',1,'',1,1,0,0,0,0),(7,1,0,'HOLA',1,'',3,1,0,0,0,0),(8,12,1,'prueba prueba',1,'a',1,1,0,0,0,0);
/*!40000 ALTER TABLE `pregunta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `centro_regional`
--

DROP TABLE IF EXISTS `centro_regional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `centro_regional` (
  `idcentro_regional` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `departamentoiddepartamento` int(11) DEFAULT NULL,
  PRIMARY KEY (`idcentro_regional`),
  KEY `FKcentro_reg197935` (`departamentoiddepartamento`),
  CONSTRAINT `FKcentro_reg197935` FOREIGN KEY (`departamentoiddepartamento`) REFERENCES `departamento` (`iddepartamento`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centro_regional`
--

LOCK TABLES `centro_regional` WRITE;
/*!40000 ALTER TABLE `centro_regional` DISABLE KEYS */;
INSERT INTO `centro_regional` VALUES (1,'Campus Central',2),(7,'CUM',9);
/*!40000 ALTER TABLE `centro_regional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo`
--

DROP TABLE IF EXISTS `grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupo` (
  `idgrupo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idgrupo`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo`
--

LOCK TABLES `grupo` WRITE;
/*!40000 ALTER TABLE `grupo` DISABLE KEYS */;
INSERT INTO `grupo` VALUES (1,'Siempre, Frecuentemente, Ocasionalmente, No'),(2,'A diario, 1 a 3 Veces/Semana, Ocasionalmente, No'),(3,'Muy pasado(a) de peso, Pasado(a) de peso, Bien de peso, Bajo(a) de peso'),(4,'SI, NO'),(5,'Grupo Familiar'),(6,'Siempre, A veces, Nunca');
/*!40000 ALTER TABLE `grupo` ENABLE KEYS */;
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
-- Table structure for table `unidad_academica`
--

DROP TABLE IF EXISTS `unidad_academica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unidad_academica` (
  `idunidad_academica` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`idunidad_academica`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidad_academica`
--

LOCK TABLES `unidad_academica` WRITE;
/*!40000 ALTER TABLE `unidad_academica` DISABLE KEYS */;
INSERT INTO `unidad_academica` VALUES (1,'TRABAJO SOCIAL'),(2,'HUMANIDADES'),(3,'CIENCIAS MEDICAS'),(4,'ARQUITECTURA'),(5,'CIENCIAS JURIDICAS Y SOCIALES'),(6,'CIENCIAS QUIMICAS Y FARMACIA'),(7,'INGENIERIA'),(8,'AGRONOMIA'),(9,'CUNSUROC'),(10,'EFPEM'),(11,'CIENCIAS ECONOMICAS'),(12,'MEDICINA VETERINARIA Y ZOOTECNIA'),(13,'CIENCIAS PSICOLOGICAS'),(14,'CIENCIAS DE LA COMUNICACI'),(15,'ECONOMICAS'),(16,'ODONTOLOGIA'),(17,'CIENCIA LINGUISTICA'),(18,'CIENCIA POLITICA'),(19,'CIENCIAS DE LA COMUNICACION'),(20,'ESCUELA DE ARTE'),(21,'HISTORIA'),(22,'ESCUELA DE CIENCIA LING'),(23,'ESCUELA DE CIENCIAS LINGUISTICAS');
/*!40000 ALTER TABLE `unidad_academica` ENABLE KEYS */;
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
INSERT INTO `encabezado` VALUES (1,322),(1,323),(1,324),(1,325),(3,333),(5,326),(5,327),(5,328);
/*!40000 ALTER TABLE `encabezado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `titulo_respuesta`
--

DROP TABLE IF EXISTS `titulo_respuesta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `titulo_respuesta` (
  `idtitulo_respuesta` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`idtitulo_respuesta`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `titulo_respuesta`
--

LOCK TABLES `titulo_respuesta` WRITE;
/*!40000 ALTER TABLE `titulo_respuesta` DISABLE KEYS */;
INSERT INTO `titulo_respuesta` VALUES (1,'Siempre'),(2,'Frecuentemente'),(3,'Ocasionalmente'),(4,'No'),(5,'A diario'),(6,'1 a 3 Veces/Semana'),(7,'Muy pasado(a) de peso'),(8,'Pasado(a) de peso'),(9,'Bien de peso'),(10,'Bajo(a) de peso'),(11,'Si'),(12,'Madre'),(13,'Padre'),(14,'Abuelos'),(15,'Abuelas'),(16,'Yo'),(17,'A Veces'),(18,'Nunca'),(19,'hola'),(20,'hola2'),(21,'Recientemente'),(22,'Posteriormente');
/*!40000 ALTER TABLE `titulo_respuesta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dependencia`
--

DROP TABLE IF EXISTS `dependencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dependencia` (
  `iddependencia` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`iddependencia`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dependencia`
--

LOCK TABLES `dependencia` WRITE;
/*!40000 ALTER TABLE `dependencia` DISABLE KEYS */;
INSERT INTO `dependencia` VALUES (1,'Rectoría'),(2,'Facultad de Agronom&iacute;a'),(3,'Facultad de Arquitectura'),(4,'Facultad de Ciencias Jur&iacute;dicas y Sociales'),(5,'Facultad de Ciencias Economicas'),(6,'Facultad de Ciencias Qu&iacute;micas y Farmacia'),(7,'Facultad de Humanidades'),(8,'Facultad de Ingenier&iacute;a'),(9,'Facultad de Ciencias M&eacute;dicas'),(10,'Facultad de Odontolog&iacute;a'),(11,'Facultad de Medicina Veterinaria y Zootecnia'),(12,'Centro Universitario de occidente'),(13,'Escuela de Historia'),(14,'Escuela de Ciencias Psicol&oacute;gicas'),(15,'Centro universitario del Norte'),(16,'Centro de Estudios urbanos y Regionales'),(17,'Escuela de Ciencias de la Comunicaci&oacute;n'),(18,'Divisi&oacute;n de Bienestar Estudiantil Unviersitario'),(19,'inst. de investigacines econ&oacute;micas y sociales'),(20,'Centro Universitario de Oriente'),(21,'Centro Universitario de Noroccidente'),(22,'Centro de Estudios del Mar y Acuicultura'),(23,'Finca Bulbuxya'),(24,'Finca Sabana Grande'),(25,'Finca San Julian'),(26,'Departamento de Registro y Estad&iacute;stica'),(27,'Direcci&oacute;n General Financiera'),(28,'Direcci&oacute;n General de Extensi&oacute;n'),(29,'Centro Universitario del Sur'),(30,'Centro Universitario de Sur oriente'),(31,'Departamento de Auditoria Interna'),(32,'Finca Medio Monte'),(33,'Secretaria General'),(34,'Biblioteca Central'),(35,'Divisi&oacute;n Servicios Generales'),(36,'Centro universitario de Suroccidente'),(37,'Farmacia Universitaria'),(38,'Direcci&oacute;n General de Investigaci&oacute;n'),(39,'Direcci&oacute;n General de Administraci&oacute;n'),(40,'Centro universitario de San Marcos'),(41,'Centro Universitario del Peten'),(42,'Escuela de Trabajo Social'),(43,'Plan de Prestaciones'),(44,'Escuela de Ciencia Pol&iacute;tica'),(45,'EFPEM Central'),(46,'Direcci&oacute;n General de Docencia'),(47,'Centro Universitario Metropolitano'),(48,'Centro universitario de Izabal'),(49,'Centro de Estudios Conservacionistas'),(50,'Escuela de Ciencias Ling&uuml;isticas'),(51,'Granja Experimental Veterinaria'),(52,'Plan de Prestaciones'),(53,'Centro Universitario de Santa rosa'),(54,'Escuela Superior de Arte'),(55,'unidad ejecutora Programa USAC/BCIE'),(56,'Centro Universitario de Chimaltenango'),(57,'Centro Universitario de Jutiapa'),(58,'Sistema de Estudios de Postgrado'),(59,'direcci&oacute;n de Asuntos Jur&iacute;dicos'),(60,'Instituto T&eacute;cnologico Universitario Guatemala'),(61,'Centro Universitario de el Quiche'),(62,'Centro Universitario de el Progreso'),(63,'Centro Universitario de Baja Verapaz'),(64,'Centro Universitario de Totonicapan');
/*!40000 ALTER TABLE `dependencia` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contenido`
--

LOCK TABLES `contenido` WRITE;
/*!40000 ALTER TABLE `contenido` DISABLE KEYS */;
INSERT INTO `contenido` VALUES (1,1,'MUESTRA DE FOTO','FOTO 1',288),(1,2,'','FOTO 2',331);
/*!40000 ALTER TABLE `contenido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado_civil`
--

DROP TABLE IF EXISTS `estado_civil`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estado_civil` (
  `idestado_civil` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`idestado_civil`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado_civil`
--

LOCK TABLES `estado_civil` WRITE;
/*!40000 ALTER TABLE `estado_civil` DISABLE KEYS */;
INSERT INTO `estado_civil` VALUES (1,'Soltero'),(2,'Casado'),(4,'Viudo'),(5,'Divorciado');
/*!40000 ALTER TABLE `estado_civil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `titulo_secundaria`
--

DROP TABLE IF EXISTS `titulo_secundaria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `titulo_secundaria` (
  `idtitulo_secundaria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  PRIMARY KEY (`idtitulo_secundaria`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `titulo_secundaria`
--

LOCK TABLES `titulo_secundaria` WRITE;
/*!40000 ALTER TABLE `titulo_secundaria` DISABLE KEYS */;
INSERT INTO `titulo_secundaria` VALUES (1,'Maestro'),(2,'Bachiller en Computación'),(4,'Bachiller en Ciencias y Letras');
/*!40000 ALTER TABLE `titulo_secundaria` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalleactividad`
--

LOCK TABLES `detalleactividad` WRITE;
/*!40000 ALTER TABLE `detalleactividad` DISABLE KEYS */;
INSERT INTO `detalleactividad` VALUES (3,'2012-03-28 00:00:00','1970-01-01 09:00:00','1970-01-01 22:00:00',1),(4,'2012-03-29 00:00:00','1970-01-01 09:00:00','1970-01-01 22:00:00',1),(5,'2012-03-30 00:00:00','1970-01-01 09:00:00','1970-01-01 22:00:00',1),(6,'2012-03-29 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',2),(7,'2012-03-30 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',2),(8,'2012-04-05 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',2),(9,'2012-04-06 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',2),(10,'2012-04-12 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',2),(11,'2012-04-13 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',2),(12,'2012-03-30 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(13,'2012-03-22 00:00:00','1970-01-01 09:00:00','1970-01-01 11:00:00',1),(14,'2012-04-02 00:00:00','1970-01-01 14:00:00','1970-01-01 15:00:00',25),(15,'2012-04-06 00:00:00','1970-01-01 14:00:00','1970-01-01 15:00:00',25),(16,'2012-04-09 00:00:00','1970-01-01 14:00:00','1970-01-01 15:00:00',25),(17,'2012-04-13 00:00:00','1970-01-01 14:00:00','1970-01-01 15:00:00',25),(18,'2012-04-16 00:00:00','1970-01-01 14:00:00','1970-01-01 15:00:00',25),(19,'2012-04-20 00:00:00','1970-01-01 14:00:00','1970-01-01 15:00:00',25),(20,'2012-04-23 00:00:00','1970-01-01 14:00:00','1970-01-01 15:00:00',25),(21,'2012-04-27 00:00:00','1970-01-01 14:00:00','1970-01-01 15:00:00',25);
/*!40000 ALTER TABLE `detalleactividad` ENABLE KEYS */;
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
INSERT INTO `responsable_actividad` VALUES (3,1),(3,7),(3,22),(4,7),(4,22),(5,2),(5,3),(8,7),(8,13),(11,1),(11,2),(11,3),(11,22),(11,25),(15,1),(15,22),(15,25);
/*!40000 ALTER TABLE `responsable_actividad` ENABLE KEYS */;
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

-- Dump completed on 2012-04-11  6:48:51
