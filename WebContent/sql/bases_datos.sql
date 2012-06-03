CREATE DATABASE  IF NOT EXISTS `websalud` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `websalud`;
-- MySQL dump 10.13  Distrib 5.5.16, for Win32 (x86)
--
-- Host: localhost    Database: websalud
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_sangre`
--

LOCK TABLES `tipo_sangre` WRITE;
/*!40000 ALTER TABLE `tipo_sangre` DISABLE KEYS */;
INSERT INTO `tipo_sangre` VALUES (1,'O POSITIVO'),(2,'O NEGATIVO'),(3,'B POSITIVO'),(4,'B NEGATIVO'),(5,'A NEGATIVO'),(6,'A POSITIVO'),(7,'AB POSITIVO'),(8,'AB NEGATIVO'),(9,'NOSE');
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
  `idmenu_categoria` int(11) NOT NULL,
  PRIMARY KEY (`idcategoria`),
  KEY `FKcategoria500537` (`idmenu_categoria`),
  CONSTRAINT `FKcategoria500537` FOREIGN KEY (`idmenu_categoria`) REFERENCES `menu_categoria` (`idmenu_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (23,'TRABAJO',2,1,1,1,17),(24,'ALERGIAS',3,1,1,1,18),(25,'HOSPITALIZACIÓN',10,1,1,1,19),(26,'ANTECENTES PERSONALES',9,1,1,1,20),(27,'ANTECEDENTES FAMILIARES',10,1,1,1,20),(29,'MEDICAMENTOS',7,0,1,1,22),(30,'NUTRICION',8,0,1,1,24),(31,'HABITOS DE VIDA',7,1,1,1,25),(32,'OCIO',3,0,1,1,32),(33,'TRAUMAS, ACCIDENTES Y SITUACIONES PELIGROSAS',3,1,1,1,26),(34,'CABEZA',1,1,1,1,27),(35,'OJO',2,1,1,1,27),(36,'OÍDOS, NARIZ y GARGANTA',3,1,1,1,27),(37,'GENITOURINARIO',4,1,1,1,28),(38,'GASTROINSTESTINAL',5,1,1,1,29),(39,'MÚSCULOS Y HUESOS',6,1,1,1,30),(40,'SENTIMIENTOS',18,0,1,1,31),(41,'OTROS PROBLEMAS',19,0,1,1,31),(42,'AMBIENTE FAMILIAR',1,1,1,1,1),(43,'COMIDA',11,1,1,1,33),(44,'SALUD ORAL',1,1,0,1,34),(45,'SALUD MENTAL',1,1,0,1,35),(46,'HÁBITOS HIGIÉNICOS',1,1,0,1,36);
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
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
  `pregunta` varchar(255) NOT NULL,
  `categoriaidcategoria` int(10) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `idtipo_pregunta` int(10) NOT NULL,
  `auto_evaluacion` int(10) NOT NULL,
  `multifasico` int(11) NOT NULL,
  `largo` int(10) DEFAULT NULL COMMENT '1->pequeño,2->mediano,3->Grande',
  `multiple` int(11) DEFAULT NULL,
  `estado` int(11) NOT NULL DEFAULT '1' COMMENT '0-> NO EN DASH , 1 EN DASH',
  `genero` int(10) NOT NULL DEFAULT '0' COMMENT '0->ambos,1->hombres,2->mujeres',
  PRIMARY KEY (`idpregunta`),
  KEY `FKpregunta916024` (`categoriaidcategoria`),
  KEY `FKpregunta179647` (`idtipo_pregunta`),
  CONSTRAINT `FKpregunta179647` FOREIGN KEY (`idtipo_pregunta`) REFERENCES `tipo_pregunta` (`idtipo_pregunta`),
  CONSTRAINT `FKpregunta916024` FOREIGN KEY (`categoriaidcategoria`) REFERENCES `categoria` (`idcategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=347 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pregunta`
--

LOCK TABLES `pregunta` WRITE;
/*!40000 ALTER TABLE `pregunta` DISABLE KEYS */;
INSERT INTO `pregunta` VALUES (128,5,1,'Situación actual de la familia del estudiante',23,'',3,0,1,0,0,1,0),(129,4,1,'Quién sostiene su hogar',23,'',3,0,1,0,1,1,0),(130,3,1,'VIVIENDA DEL ESTUDIANTE: Ud. vive en:',23,'',3,0,1,0,0,1,0),(136,87,1,'Ha estado usted hospitalizado',25,'',7,0,1,0,0,1,0),(137,88,0,'Enfermedad común (veces)',25,'',1,0,1,0,0,1,0),(138,89,0,'Traúmas y golpes (veces)',25,'',1,0,1,0,0,1,0),(139,90,0,'Transtornos mentales (veces)',25,'',1,0,1,0,0,1,0),(140,91,0,'Operaciones (veces)',25,'',1,0,1,0,0,1,0),(151,81,0,'Diabetes Mellitus',27,'Selecciona si tú, ó alguno de tus PADRES O ABUELOS (vivos o fallecidos) tienen o tuvieron o varias de las siguientes enfermedades.',8,1,1,0,1,0,0),(152,82,0,'Presión alta',27,'',8,1,1,0,1,0,0),(153,83,0,'Derrame Cerebral',27,'',8,1,1,0,1,0,0),(154,84,0,'Infarto cardiaco',27,'',8,1,1,0,1,0,0),(155,85,0,'Cancer',27,'',8,1,1,0,1,0,0),(157,86,0,'Vih/sida',27,'',8,1,1,0,1,0,0),(160,21,0,'Si usted marcó SI, señale qué medicamentos consume',29,'',3,0,1,0,1,1,0),(161,22,0,'Consume usted, algún tranquilizante?',29,'',3,0,1,0,1,1,0),(162,20,1,'Consume usted, frecuentemente, algún medicamento',29,'',7,0,1,0,0,1,0),(163,44,1,'Tomo 1 ó mas gaseosa y/o jugos enlatados',30,'',5,1,1,0,0,0,0),(164,45,1,'Como frutas',30,'',5,1,1,0,0,0,0),(165,46,1,'Como verduras',30,'',5,1,1,0,0,0,0),(167,47,1,'Tomo leche entera',30,'',5,1,1,0,0,0,0),(169,48,1,'Consumo comida rápida (shucos, hamburguesa, pizza, papas fritas, tacos, dobladas, etc)',30,'',5,1,1,0,0,0,0),(170,49,1,'Bebo 8 más vasos de agua al día',30,'',5,1,1,0,0,0,0),(171,50,1,'Mi mejor tiempo de comida es la cena',30,'',5,1,1,0,0,0,0),(175,51,1,'Como más de un huevo',30,'',5,1,1,0,0,0,0),(176,52,1,'En relación a mi peso, creo que estoy',30,'',6,1,1,0,0,0,0),(183,31,1,'Fumo ó fume cigarrillos',31,'',5,1,1,0,0,0,0),(185,32,1,'Fumo de 1 a 5 cigarrillos',31,'SI NUNCA HAS FUMADO MARCA \'NO\' HASTA LA PREGUNTA 35',5,1,1,0,0,0,0),(186,33,1,'Fumo principalmente en las mañanas, al momento de levantarme',31,'',5,1,1,0,0,0,0),(187,34,1,'Fumo más de 5 cigarrillos',31,'',5,1,1,0,0,0,0),(188,35,1,'Soy fumador(a) pasivo(a)',31,'',5,1,1,0,0,0,0),(189,36,1,'Consumo bebidas alcohólicas (cervezas, ron, vino, etc)',31,'',5,1,1,0,0,0,0),(190,37,1,'Con que frecuencia bebes 6 o más bebidas en una ocasión',31,'SI NO LO HACES, MARCA \'NO\' HASTA LA PREGUNTA 38, SI NO BEBES DESDE HACE 3 MESES Ó MAS, MARCA \'LA FRECUENCIA DE CONSUMO\' Y PASA A LA PREGUNTA 38',5,1,1,0,0,0,0),(191,38,1,'Con que frecuencia has dejado de hacer tus actividades, debido al consumo de licor (clases, tareas, trabajo)',31,'',5,1,1,0,0,0,0),(193,39,1,'Practico ejercicio 30 minutos ó mas (Correr, Gimnasio, Pesas, Pilates, Bicicletas, etc)',31,'',5,1,1,0,0,0,0),(194,40,1,'Consume drogas (marihuana, cocaína, etc)',31,'',5,1,1,0,0,0,0),(195,41,1,'Mi vida sexual es',31,'SI NO TIENES VIDA SEXUAL ACTIVA, MARCA \'NO\' HASTA LA PREGUNTA PREGUNTA NO. 43',5,1,1,0,0,0,0),(196,42,1,'Mi práctica sexual es con más de una parejta',31,'',5,1,1,0,0,0,0),(197,16,1,'Tiene tiempo libre semanalmente',32,'',7,0,1,0,0,1,0),(198,17,1,'Si usted disfruta de tiempo libre por semana, señale:',32,'',3,0,1,0,0,1,0),(199,18,0,'Si tiene tiempo libre es empleado preferentemente en: (Puede marcar varias proposiciones).',32,'',3,0,1,0,1,1,0),(200,19,0,'Otra actividad no señalada. ¿Cual?',32,'',2,0,1,2,0,1,0),(210,1,1,'Sufro dolores de cabeza',34,'',4,1,1,0,0,0,0),(211,2,1,'Me duele la cabeza cuando estoy tens@',34,'',4,1,1,0,0,0,0),(212,3,1,'Me duele la cabeza sin motivo alguno',34,'',4,1,1,0,0,0,0),(213,4,1,'Uso lentes (anteojos ó de contacto)',35,'',4,1,1,0,0,0,0),(214,5,1,'Se me cansa la vista (al leer, ver tv, etc)',35,'',4,1,1,0,0,0,0),(215,6,1,'Tengo la vista borrosa al leer o identificar personas u objetos lejanos (carteles, pizarra, amigos, etc)',35,'',4,1,1,0,0,0,0),(216,7,1,'Tengo dificultad para escuchar con uno o ambos oídos',36,'',4,1,1,0,0,0,0),(217,8,1,'Padezco de infecciones de garganta',36,'',4,1,1,0,0,0,0),(218,9,1,'Acumulo cerumen',36,'',4,1,1,0,0,0,0),(219,10,1,'Mantengo secreción nasal (moquera)',36,'',4,1,1,0,0,0,0),(220,17,1,'Siento ardor al orinar',37,'',4,1,1,0,0,0,0),(221,18,1,'Siento dolor al orinar',37,'',4,1,1,0,0,0,0),(222,19,1,'Padezco de calculos en los riñones',37,'',4,1,1,0,0,0,0),(223,20,1,'Tengo problemas en mis testículos',37,'SOLO HOMBRES',4,1,1,0,0,0,1),(224,21,1,'Mis ciclos menstruales son regulares',37,'SOLO MUJERES',4,1,1,0,0,0,2),(225,22,1,'Tengo flujo vaginal blanquecino o amarillento',37,'',4,1,1,0,0,0,2),(226,23,1,'Tengo dolores menstruales intensos',37,'',4,1,1,0,0,0,2),(227,29,1,'Tengo dolores de espalda',39,'',4,1,1,0,0,0,0),(228,30,1,'Tengo dolores de cuello',39,'',4,1,1,0,0,0,0),(229,24,1,'Se me embota el estomago',38,'',4,1,1,0,0,0,0),(230,25,1,'Sufro de agruras reflujo',38,'',4,1,1,0,0,0,0),(231,26,1,'Sufro de diarrea',38,'',4,1,1,0,0,0,0),(232,27,1,'Sufro de estreñimiento',38,'',4,1,1,0,0,0,0),(233,28,1,'Me lavo las manos antes de comer',38,'',4,1,1,0,0,0,0),(234,24,1,'¿Se siente solo?',40,'',9,0,1,0,0,1,0),(235,25,1,'¿Llora sin razón aparente?',40,'',9,0,1,0,0,1,0),(236,26,1,'¿Ha tenido alguna vez intento de suicidarse?',40,'',9,0,1,0,0,1,0),(237,27,1,'¿Tiene problemas de concentración?',40,'',9,0,1,0,0,1,0),(238,28,1,'Al despertarse ¿no puede o le cuesta volverse a dormir?',40,'',9,0,1,0,0,1,0),(239,29,1,'¿Se siente tenso y ansioso?',40,'',9,0,1,0,0,1,0),(240,30,1,'¿Teme contagiarse con facilidad?',40,'',9,0,1,0,0,1,0),(241,31,1,'Generalmente ¿Se preocupa demasiado por las cosas?',40,'',9,0,1,0,0,1,0),(242,32,1,'¿Tiene problemas para dormise?',40,'',9,0,1,0,0,1,0),(243,33,1,'Constantemente ¿Le vienen a la cabeza pensamientos que le causan temor?',40,'',9,0,1,0,0,1,0),(244,34,1,'Tiene temores exagerados',40,'',9,0,1,0,0,1,0),(245,35,1,'¿Sufre de agotamiento nervioso?',40,'',9,0,1,0,0,1,0),(246,36,1,'¿Se enoja fácilmente, muy irritable?',40,'',9,0,1,0,0,1,0),(247,40,1,'Se molesta cuando las cosas no están ordenadas y exactas',40,'',9,0,1,0,0,1,0),(248,41,1,'Hace la mayoría de las cosas violentamente',40,'',9,0,1,0,0,1,0),(249,42,1,'Se considera tímido',40,'',9,0,1,0,0,1,0),(250,43,1,'Es usted es demasiado susceptible',40,'',9,0,1,0,0,1,0),(251,44,1,'Se molesta ante la critica',40,'',9,0,1,0,0,1,0),(252,45,1,'Tiembla o se siente acobardado siempre que alguien le grita',40,'',9,0,1,0,0,1,0),(253,46,1,'Se siente triste, deprimido',40,'',9,0,1,0,0,1,0),(254,47,1,'Se confunde todo si tiene que hacer las cosas rápidamente',40,'',9,0,1,0,0,1,0),(255,48,1,'Generalmente desea tener a alguien que lo aconseje',40,'',9,0,1,0,0,1,0),(256,49,1,'Se considera muy dependiente',40,'',9,0,1,0,0,1,0),(257,50,1,'Tiene problemas económicos',40,'',9,0,1,0,0,1,0),(258,51,1,'Tiene problemas matrimoniales o con su pareja',40,'',9,0,1,0,0,1,0),(259,52,1,'Tiene problemas familiares',40,'',9,0,1,0,0,1,0),(260,53,1,'Le preocupan las cuestiones sexuales',40,'',9,0,1,0,0,1,0),(261,54,1,'Siente que alguien controla su mente',40,'',9,0,1,0,0,1,0),(262,55,1,'Considera usted su rendimiento académico satisfactorio',40,'',9,0,1,0,0,1,0),(263,56,1,'¿Le cuesta tomar decisiones?',40,'',9,0,1,0,0,1,0),(264,57,1,'Le cuesta mostrar sus emociones?',40,'',9,0,1,0,0,1,0),(265,56,1,'Se le dificulta hablar en público',40,'',9,0,1,0,0,1,0),(266,59,1,'Tiene dificultad para relacionarse con otras personas',40,'',9,0,1,0,0,1,0),(267,23,0,'Otro medicamento no señalado. ¿Cual?',29,'',2,0,1,2,0,1,0),(268,37,0,'Tiene usted algún problema que no ha sido investigado en este cuestionario y le gustaría consultarlo',41,'',2,0,1,3,0,1,0),(269,37,1,'Sufre al no ejercer dominio constante sobre si mismo',40,'',9,0,1,0,0,1,0),(270,38,1,'Se molesta cuando le dicen lo que tiene que hacer',40,'',9,0,1,0,0,1,0),(271,39,1,'Cree que su mente no esta bien',40,'',9,0,1,0,0,1,0),(272,58,1,'Se le dificulta hablar en público',40,'',9,0,1,0,0,1,0),(273,11,1,'El polvo me provoca alergia',24,'',4,1,1,0,0,0,0),(274,12,1,'Comer mariscos me provoca alergia',24,'',4,1,1,0,0,0,0),(275,13,1,'El clima frío me provoca alergia',24,'',4,1,1,0,0,0,0),(276,14,1,'Comer cerdo me provoca alergia',24,'',4,1,1,0,0,0,0),(277,15,1,'Soy alérgico a la penicilina ó aspirina',24,'',4,1,1,0,0,0,0),(278,16,1,'El sol me provoca alergia',24,'',4,1,1,0,0,0,0),(279,43,1,'Mi práctica sexual es con más de una pareja',31,'',5,1,1,0,0,0,0),(280,53,1,'Asma Bronquial',26,'',7,1,1,0,0,0,0),(281,54,1,'Rinitis Alérgica',26,'',7,1,1,0,0,0,0),(282,55,1,'Migraña',26,'',7,1,1,0,0,0,0),(283,56,1,'Discapacidad (Sordera, ceguera, brazos, piernas, etc).',26,'',7,1,1,0,0,0,0),(284,57,1,'Convulsiones',26,'',7,1,1,0,0,0,0),(285,58,1,'Gonorrea',26,'',7,1,1,0,0,0,0),(286,59,1,'Sifilis',26,'',7,1,1,0,0,0,0),(287,60,1,'Hepatitis B',26,'',7,1,1,0,0,0,0),(288,61,1,'Virus del Papiloma Humano',26,'',7,1,1,0,0,0,0),(289,62,1,'Úlcera gástrica o duodenal (diagnosticado por especialista)',26,'',7,1,1,0,0,0,0),(290,63,1,'Reflujo Gastroesofágico (diagnosticado por especialista)',26,'',7,1,1,0,0,0,0),(291,64,1,'Sobrepeso/obesidad',26,'',7,1,1,0,0,0,0),(292,65,1,'Me operaron del apéndice',26,'',7,1,1,0,0,0,0),(293,66,1,'Me operaron de la vesícular biliar',26,'',7,1,1,0,1,0,0),(294,67,1,'Estoy operado de al menos un testículo',26,'',7,1,1,0,0,0,1),(295,68,1,'Estoy operado del prepucio (circuncisión)',26,'',7,1,1,0,0,0,1),(296,69,1,'Estoy utilizando anticonceptivos',26,'',7,1,1,0,0,0,2),(297,70,1,'Estoy embarazada',26,'',7,1,1,0,0,0,2),(298,71,1,'He estado embarazada',26,'',7,1,1,0,0,0,2),(299,72,1,'Estoy operada de los ovarios',26,'',7,1,1,0,0,0,2),(301,74,1,'Tengo masas en mis mamas',26,'',7,1,1,0,0,0,2),(302,73,1,'Tengo quistes en mis ovarios',26,'',7,1,1,0,0,0,2),(303,75,1,'Acné',26,'',7,1,1,0,0,0,0),(304,76,1,'Miopía',26,'',7,1,1,0,0,0,0),(305,77,1,'Astigmatismo',26,'',7,1,1,0,0,0,0),(306,78,1,'Daltonismo',26,'',7,1,1,0,0,0,0),(307,79,1,'Ceguera total o parcial',26,'',7,1,1,0,0,0,0),(308,80,1,'Sordera parcial o total',26,'',7,1,1,0,0,0,0),(309,1,1,'Come en exceso*: leche, crema, huevos, cerdo, mantequilla, recados, mayonesa, embutidos.',43,'',7,0,1,0,0,1,0),(310,2,1,'Come en exceso*: Azúcar, pasteles, pastas, dulces, pan, helados.',43,'',7,0,1,0,0,1,0),(311,3,1,'Bebe 5 ó mas tazas de café al día',43,'',7,0,1,0,0,1,0),(312,4,1,'Bebe 3 ó mas Gaseosas al día.',43,'',7,0,1,0,0,1,0),(313,5,0,'Tiene tendencia a tener sobrepeso',43,'',7,0,1,0,0,1,0),(314,6,1,'Come frutas diariamente',43,'',7,0,1,0,0,1,0),(315,7,0,'Come ensaladas y verduras diariamente',43,'',7,1,1,0,0,1,0),(316,6,1,'Conduce bicicleta en lugares transitados',33,'',3,0,1,0,0,1,0),(317,7,1,'Conduce motocicleta sin casco, chumpa de cuero, botas y/o guates de cuero.',33,'',3,0,1,0,0,1,0),(318,8,1,'Tiende a exceder las velocidades permitidas',33,'',3,0,1,0,0,1,0),(319,9,1,'Maneja después de beber alcohol o ingerir alguna droga.',33,'',3,0,1,0,0,1,0),(321,10,1,'Camina de noche por calles desconocidas por usted',33,'',3,0,1,0,0,1,0),(322,11,1,'Da o pide jalón en vehículos.',33,'',3,0,1,0,0,1,0),(323,12,1,'Se expone a ruidos fuertes',33,'',3,0,1,0,0,1,0),(324,13,1,'Se expone a insecticidas o químicos de peligro.',33,'',3,0,1,0,0,1,0),(325,14,1,'Sabe usted nadar',33,'',3,0,1,0,0,1,0),(326,15,1,'Utiliza cinturones de seguridad cuando maneja o acompaña al conductor de un automóvil',33,'',3,0,1,0,0,1,0),(327,1,1,'Al cepillarme los dientes me sangran las encías',44,'',4,1,0,0,0,0,0),(328,2,1,'Utilizo hilo dental todos los días',44,'',4,1,0,0,0,0,0),(329,3,1,'Durante el último mes he padecido dolor dental',44,'',4,1,0,0,0,0,0),(330,4,1,'Como frutas y verduras diariamente',44,'',4,1,0,0,0,0,0),(331,5,1,'Visito al odontólogo por lo menos una vez al año',44,'',4,1,0,0,0,0,0),(332,1,1,'Tengo problemas con mi rendimiento académico',45,'',4,1,0,0,0,0,0),(333,2,1,'Tengo una adecuada relación con mis padres',45,'',4,1,0,0,0,0,0),(334,3,1,'Me es fácil iniciar y/o mantener adecuadas relaciones de pareja o noviazgo',45,'',4,1,0,0,0,0,0),(335,4,1,'Se me dificulta relacionarme con otras personas',45,'',4,1,0,0,0,0,0),(336,5,1,'Tengo problemas laborales (si no trabaja, Seleccione NO)',45,'',4,1,0,0,0,0,0),(337,6,1,'Tengo una adecuada relación con mis hermanos',45,'',4,1,0,0,0,0,0),(338,7,1,'Considero que mi situación económica permite satisfacer mis principales necesidades',45,'',4,1,0,0,0,0,0),(339,8,1,'Sufro de malestares físicos (dolor de cabeza, dolor de espalda o nuca, dolores musculares, diarrea, gastritis, caspa, acné u otros). Cuando tengo presiones problemas de estrés',45,'',4,1,0,0,0,0,0),(341,9,1,'Me encuentro satisfecho(a) en cuanto aspectos teóricos y/o prácticos de sexualidad',45,'',4,1,0,0,0,0,0),(342,10,1,'Participo en actividades grupales (iglesia, organizaciones comunitarias, etc.) o entrenamientos que disfruto',45,'',4,1,0,0,0,0,0),(343,1,1,'Me lavo las manos con agua y jabón',46,'',4,1,0,0,0,0,0),(344,2,1,'Me lavo las manos después de ir al baño',46,'',4,1,0,0,0,0,0),(345,3,1,'Consumo alimentos que se venden en cafeterías y/o casetas de la ciudad universitaria',46,'',4,1,0,0,0,0,0),(346,4,1,'Cuando consumo alimentos fuera de casa veo la limpieza del lugar, de la persona que despacha y me fijo como los prepara',46,'',4,1,0,0,0,0,0);
/*!40000 ALTER TABLE `pregunta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paciente`
--

DROP TABLE IF EXISTS `paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paciente` (
  `idpaciente` int(20) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) DEFAULT NULL,
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
  `tipo_sangreidtipo_sangre` int(11) DEFAULT NULL,
  `estado_civilidestado_civil` int(11) DEFAULT NULL,
  `usuario` varchar(20) DEFAULT NULL,
  `sexo` int(11) NOT NULL DEFAULT '1',
  `titulo_secundaria` varchar(150) DEFAULT NULL,
  `crecio_en` varchar(100) DEFAULT NULL,
  `estado` int(11) NOT NULL DEFAULT '1',
  `iddepartamento` int(11) DEFAULT NULL,
  `idnacionalidad` int(11) DEFAULT NULL,
  `examen_linea` int(11) NOT NULL DEFAULT '0',
  `idunidad_academica` int(11) DEFAULT NULL,
  PRIMARY KEY (`idpaciente`),
  UNIQUE KEY `carne` (`carne`),
  KEY `FKpaciente761424` (`idemer_parentesco`),
  KEY `FKpaciente497631` (`tipo_sangreidtipo_sangre`),
  KEY `FKpaciente544904` (`estado_civilidestado_civil`),
  KEY `Index12` (`carne`),
  KEY `Index13` (`usuario`),
  KEY `FKpaciente283056` (`idunidad_academica`),
  CONSTRAINT `FKpaciente283056` FOREIGN KEY (`idunidad_academica`) REFERENCES `unidad_academica` (`idunidad_academica`),
  CONSTRAINT `FKpaciente497631` FOREIGN KEY (`tipo_sangreidtipo_sangre`) REFERENCES `tipo_sangre` (`idtipo_sangre`),
  CONSTRAINT `FKpaciente544904` FOREIGN KEY (`estado_civilidestado_civil`) REFERENCES `estado_civil` (`idestado_civil`),
  CONSTRAINT `FKpaciente761424` FOREIGN KEY (`idemer_parentesco`) REFERENCES `parentesco` (`idparentesco`)
) ENGINE=InnoDB AUTO_INCREMENT=119 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paciente`
--

LOCK TABLES `paciente` WRITE;
/*!40000 ALTER TABLE `paciente` DISABLE KEYS */;
INSERT INTO `paciente` VALUES (101,'AURA LUZ','CIFUENTES REYES','1987-12-01 00:00:00',200614790,'31 AVE C 14-33 SAN MARTIN, Ciudad de Guatemala','24328221','42144987',' lucita287@gmail.com  ','Aura Reyes',1,'3232232','3232323',2,1,'200614790',2,'BACHILLERATO EN COMPUTACION CON ORIENTACION CIENTIFICA','Guatemala',1,NULL,NULL,0,NULL),(102,'DARWIN DANIEL','HERNANDEZ GALAN','1986-04-26 00:00:00',200511916,'6 CALLE 11-70 ZONA 7 QUINTA SAMAYOA, Ciudad de Guatemala','24840667','54734043','darn1986@gmail.com','Edgar',2,'23545454','53124364',2,1,'200511916',1,'BACH CON ORIENT.TECNICA OCUP. EN ELECTRICIDAD Y SOLDADURA','Guatemala',1,NULL,NULL,0,NULL),(103,'MICHAEL ALEXIS','GARNICA GOMEZ','1993-09-08 00:00:00',201224244,'1 CALLE 8-75 SECTOR A-1 COL DE SAN CRISTOBAL III CASA 12 ZONA 8, Mixco','24352289','50199529','michael.gago@hotmail.es','Aura Reyes',1,'42201711','41221011',5,2,'201224244',1,'BACHILLERATO EN COMPUTACION CON ORIENTACION CIENTIFICA','Guatemala',1,NULL,NULL,0,NULL),(104,'FERDY ALEXANDER','MORALES MENDEZ','1990-03-18 00:00:00',200843454,'ZONA 1 BARRIO LAS PALMERAS, Ciudad de Guatemala','79440564','49176397','ferdyam_17@hotmail.com  ','Aura reyes',1,'3323232','3232323',3,2,'200843454',1,'Bachillerato en computacion','Guatemala',1,NULL,NULL,0,NULL),(105,'JOSE BENJAMIN','CANCINOS FLORES','1992-04-01 00:00:00',201212806,'L 4 MANZ C SEC 1 COL SANTO DOMINGO ZONA 6, Santa Catarina Pinula','66327071','42143108','benjamin.cancinos@hotmail.com',NULL,NULL,NULL,NULL,NULL,NULL,'201212806',1,NULL,NULL,1,NULL,NULL,0,NULL),(106,'JERRY BRIAN','OSORIO ALVARADO','1989-08-05 00:00:00',200714575,'13 AVENIDA B 15-76 ZONA 7  COLONIA SAN IGNACI, Mixco','24361102','42815919','jb_2_2007@yahoo.es','asasd',1,'asdasd','asdasd',2,1,'200714575',1,'','aaaaaaaaaaa',1,NULL,NULL,0,NULL),(107,'JOSE FELICIANO','FELIPE LEON','1970-04-09 00:00:00',8816479,'9 AVENIDA 26-75 ZONA 7 FUENTES DEL VALLE 1, San Miguel Petapa','66354291','53084705','joseffelipe@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,'8816479',1,NULL,NULL,1,NULL,NULL,0,NULL),(108,'JAIRO ALBERTO','CIFUENTES FUENTES','1987-08-24 00:00:00',200614994,'5-26 FRACCION 4 ZONA 7 DE MIXCO, Villa Nueva','53769057','53769057',' j777jairo@gmail.com',NULL,NULL,NULL,NULL,NULL,NULL,'200614994',1,NULL,NULL,1,NULL,NULL,0,NULL),(109,'DAVID ANTONIO','TERCERO MEJIA','1989-01-06 00:00:00',200614942,'LOTE 16 SEC A Z 18 COL PRADOS DEL NORTE, Ciudad de Guatemala','22554589','53413717','triler_1441@yahoo.com ',NULL,NULL,NULL,NULL,NULL,NULL,'200614942',1,NULL,NULL,1,NULL,NULL,0,NULL),(110,'JUAN CARLOS','REYES CANAHUI','1987-05-12 00:00:00',200614848,'35 AV 15-42 ZONA 7 SAN MIGUEL PETAPA GUATEMALA, San Miguel Petapa','24481329','50830995',' canahui777@yahoo.es  ',NULL,NULL,NULL,NULL,NULL,NULL,'200614848',1,NULL,NULL,1,2,NULL,0,1),(111,'CHRISTIAN JOSUE','MALDONADO ARROYO','1988-01-03 00:00:00',200614863,'14 AVENIDA 20-69 ZONA 12 COL REFORMITA, Ciudad de Guatemala','24730399','50170992','christyan_pollito@hotmail.com   ',NULL,NULL,NULL,NULL,NULL,NULL,'200614863',1,NULL,NULL,1,2,3,0,1),(112,'MARIO ROBERTO','MORALES SITAVI','1988-05-03 00:00:00',200614833,'30 CALLE B 2-20 ZONA 8, Ciudad de Guatemala','24712348','50190375','mario858@hotmail.com   ',NULL,NULL,NULL,NULL,NULL,NULL,'200614833',1,NULL,NULL,1,2,3,0,1),(113,' ',' ','1975-05-30 00:00:00',9516964,'11 CALLE 5 AVENIDA 3-43 ZONA 7 MIXCO, Ciudad de Guatemala','24407825','52749381','pablo.b.francoc@gmail.com      ',NULL,NULL,NULL,NULL,NULL,NULL,'9516964',1,NULL,NULL,1,2,3,0,1),(114,'JOEL EDMUNDO','JIMENEZ ARRECIS','1986-04-05 00:00:00',200413135,'5 AVE 1-09 Z 10 SANTA TERESITA 2 SAN MIGUEL PETAPA, Villa Nueva','55591567','55591567',' maxl31@hotmail.com     ',NULL,NULL,NULL,NULL,NULL,NULL,'200413135',1,NULL,NULL,1,2,3,0,1),(115,'EDUARDO JAVIER','PEREZ LOPEZ','1982-03-05 00:00:00',200413047,'5TA CALLE 31-94 Z11 UTATLAN II, Ciudad de Guatemala','24394102','54746127',' eduard0javier@hotmail.com  ',NULL,NULL,NULL,NULL,NULL,NULL,'200413047',1,NULL,NULL,1,2,3,0,1),(116,'EMANUEL SERGIO','OROZCO MENDEZ','1986-06-22 00:00:00',200413032,'13 AVE C 9-67 Z 7 EL CEDRO LA BRIGADA MIXCO, Mixco','24375238','58652759',' esvom7@gmail.com    ',NULL,NULL,NULL,NULL,NULL,NULL,'200413032',1,NULL,NULL,1,2,3,0,1),(117,'JULIO ROBERTO','CHICAS POLANCO','1985-11-11 00:00:00',200412987,'6 CALLE A 20-45 ZONA 11 COLONIA MIRADOR I, Ciudad de Guatemala','24736759','55108674','titojrcp@hotmail.com  ',NULL,NULL,NULL,NULL,NULL,NULL,'200412987',1,NULL,NULL,1,2,3,0,1),(118,'JENIFER PAMELA','PALACIOS SALES','1993-04-26 00:00:00',201222673,'17 C 2-73 Z 3, Ciudad de Guatemala','22538762','50715586','cutecancan@hotmail.com','Darwin Daniel Hernandez',1,'322332','32323232',2,2,'201222673',2,'BACHILLER INDUST.Y PERITO EN CONSTRUCC Y DIBUJO COMPUTARIZA','Guatemala',1,2,3,0,1);
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
  `idcategoria_permiso` int(10) NOT NULL,
  PRIMARY KEY (`idpermiso`),
  KEY `FKpermiso30573` (`idcategoria_permiso`),
  CONSTRAINT `FKpermiso30573` FOREIGN KEY (`idcategoria_permiso`) REFERENCES `categoria_permiso` (`idcategoria_permiso`)
) ENGINE=InnoDB AUTO_INCREMENT=261 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permiso`
--

LOCK TABLES `permiso` WRITE;
/*!40000 ALTER TABLE `permiso` DISABLE KEYS */;
INSERT INTO `permiso` VALUES (221,'Mostar Contenido',1),(222,'Crear Contenido',1),(223,'Eliminar Contenido',1),(224,'Nuevo Contenido',1),(225,'Mostrar Noticias',1),(226,'Crear  Noticias',1),(227,'Eliminar noticias',1),(228,'Mostar Actividades',1),(229,'Crear Actividades',1),(230,'Eliminar Actividades',1),(231,'Mostrar Areas',1),(232,'Modificar Areas',1),(233,'Mostrar Usuarios',2),(234,'Crear Usuarios',2),(235,'Mostrar Permisos',2),(236,'Asignar Permisos',2),(238,'Dashboard',5),(239,'Manipular Estado Civil',3),(240,'Manipular Tipo Sangre',3),(241,'Manipular Parentesco',3),(242,'Manipular Titulo Secundaria',3),(246,'Modificar Configuracion',2),(247,'Mostrar  Archivos sin Usar',2),(248,'Eliminar Archivos sin Usar',2),(250,'Manipular Categoria',3),(252,'Manipular Menu Categoria',3),(253,'Sistema de Secretarias',3),(254,'Menu de Anuncios',3),(255,'Seleccionar tipo de examen',3),(256,'Resultados',3),(257,'Gestion de Resultados',3),(259,'Gestion de Resultados',3),(260,'Estudiantes',3);
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
  `titulo` varchar(100) NOT NULL,
  `size` int(10) DEFAULT '1' COMMENT '1-> pequeño, 2 -> mediano, 3-> grande',
  PRIMARY KEY (`idcategoria_interpretacion`),
  KEY `FKcategoria_569059` (`idcategoria`),
  CONSTRAINT `FKcategoria_569059` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria_interpretacion`
--

LOCK TABLES `categoria_interpretacion` WRITE;
/*!40000 ALTER TABLE `categoria_interpretacion` DISABLE KEYS */;
INSERT INTO `categoria_interpretacion` VALUES (1,7,5,'FELICITACIONES!!! Tus respuestas demuestran que tienes una excelente salud oral. Recuerda que mientras mantengas tus adecuados hábitos de higiene bucal y de alimentos, estarás evitando problemas como gingivitis, periodontitis y caries dental.\\n\\nDETERIORO DE MI SALUD ORAL\\n\\nLa gingivitis es la inflamación de las encías. Es causada principalmente por una mala higiene, o sea, cepillarse los dientes menos de 3 veces por día, mala técnica de cepillado, falta en la utilización del hilo dental como parte rutinaria del cuidado de los dientes, consumo frecuente de dulces, pasteles, hábitos de fumar, etc. Este problema de continuar, daña y ocasiona pérdida gradual de huesos que sostiene los dientes, llamándose entonces periodontitis; hasta aquí si modificas tus hábitos alimenticios e higiénicos y decides consultar con tu odontólogo tienes grandes probabilidades de recuperar tu salud. La fase final se presenta cuando, debido a la falta de una base que sostenga los dientes, estos se caen.\\n\\nLa caries \ndental es una lesión ocasionada por bacterias que se alimentan del azúcar de tu dieta y se desarrolla paralelamente a los que mencionamos anteriormente, osea que toda persona que tiene malos hábitos alimenticios e higiénicos invariablemente va a presentar, caries las cuales tarde o temprano te darán dolor en las piezas dentales dañadas.\\n\\nFinalmente te mencionaremos un problema frecuentemente observado, el cual se denomina Alteraciones de articulación témporo-mandibular, el cual se caracteriza por el tronido de la mandíbula en el momento de comer o al abrir la boca (por ejemplo con el bostezo), es causado por varios factores, uno de los más importantes es el estrés que se manifiesta por el rechinido de los dientes durante el sueño. Si te truena la mandíbula al comer o abrir la boca es importante que sepas que existen métodos odontológicos para mejorar este tipo de problema.',44,'SALUD ORAL',3),(2,12,8,'Tu salud oral esta DETERIORÁNDOSE!!, probablemente tengas que mejorar o reforzar algunas de tus practicas ya que podrías presentar algún problema en tus encías o dientes, consulta a tu odontólogo.\\n\\nDETERIORO DE MI SALUD ORAL\\n\\nLa gingivitis es la inflamación de las encías. Es causada principalmente por una mala higiene, o sea, cepillarse los dientes menos de 3 veces por día, mala técnica de cepillado, falta en la utilización del hilo dental como parte rutinaria del cuidado de los dientes, consumo frecuente de dulces, pasteles, hábitos de fumar, etc. Este problema de continuar, daña y ocasiona pérdida gradual de huesos que sostiene los dientes, llamándose entonces periodontitis; hasta aquí si modificas tus hábitos alimenticios e higiénicos y decides consultar con tu odontólogo tienes grandes probabilidades de recuperar tu salud. La fase final se presenta cuando, debido a la falta de una base que sostenga los dientes, estos se caen.\\n\\nLa caries dental es una lesión ocasionada por \nbacterias que se alimentan del azúcar de tu dieta y se desarrolla paralelamente a los que mencionamos anteriormente, osea que toda persona que tiene malos hábitos alimenticios e higiénicos invariablemente va a presentar, caries las cuales tarde o temprano te darán dolor en las piezas dentales dañadas.\\n\\nFinalmente te mencionaremos un problema frecuentemente observado, el cual se denomina Alteraciones de articulación témporo-mandibular, el cual se caracteriza por el tronido de la mandíbula en el momento de comer o al abrir la boca (por ejemplo con el bostezo), es causado por varios factores, uno de los más importantes es el estrés que se manifiesta por el rechinido de los dientes durante el sueño. Si te truena la mandíbula al comer o abrir la boca es importante que sepas que existen métodos odontológicos para mejorar este tipo de problema.',44,'SALUD ORAL',3),(3,16,13,'Estas en RIESGO!!!... Tus respuestas indican que no le estás dando la importancia debida a tu higiene bucal y alimenticia, probablemente tengas lesiones que podrían en futuro cercano ocasionar pérdidas de tus piezas dentales. Si deseas mayor información consulta al área odontológica.\\n\\nDETERIORO DE MI SALUD ORAL\\n\\nLa gingivitis es la inflamación de las encías. Es causada principalmente por una mala higiene, o sea, cepillarse los dientes menos de 3 veces por día, mala técnica de cepillado, falta en la utilización del hilo dental como parte rutinaria del cuidado de los dientes, consumo frecuente de dulces, pasteles, hábitos de fumar, etc. Este problema de continuar, daña y ocasiona pérdida gradual de huesos que sostiene los dientes, llamándose entonces periodontitis; hasta aquí si modificas tus hábitos alimenticios e higiénicos y decides consultar con tu odontólogo tienes grandes probabilidades de recuperar tu salud. La fase final se presenta cuando, debido a la falta de una base que \nsostenga los dientes, estos se caen.\\n\\nLa caries dental es una lesión ocasionada por bacterias que se alimentan del azúcar de tu dieta y se desarrolla paralelamente a los que mencionamos anteriormente, osea que toda persona que tiene malos hábitos alimenticios e higiénicos invariablemente va a presentar, caries las cuales tarde o temprano te darán dolor en las piezas dentales dañadas.\\n\\nFinalmente te mencionaremos un problema frecuentemente observado, el cual se denomina Alteraciones de articulación témporo-mandibular, el cual se caracteriza por el tronido de la mandíbula en el momento de comer o al abrir la boca (por ejemplo con el bostezo), es causado por varios factores, uno de los más importantes es el estrés que se manifiesta por el rechinido de los dientes durante el sueño. Si te truena la mandíbula al comer o abrir la boca es importante que sepas que existen métodos odontológicos para mejorar este tipo de problema.',44,'SALUD ORAL',3),(4,20,17,'CUIDADO!! Presentas deterioro oral marcado... Es importante que consultes a un odontólogo para realizarte un diagnostico e iniciar tratamiento inmediato para evitar problemas más serios.\\n\\nDETERIORO DE MI SALUD ORAL\\n\\nLa gingivitis es la inflamación de las encías. Es causada principalmente por una mala higiene, o sea, cepillarse los dientes menos de 3 veces por día, mala técnica de cepillado, falta en la utilización del hilo dental como parte rutinaria del cuidado de los dientes, consumo frecuente de dulces, pasteles, hábitos de fumar, etc. Este problema de continuar, daña y ocasiona pérdida gradual de huesos que sostiene los dientes, llamándose entonces periodontitis; hasta aquí si modificas tus hábitos alimenticios e higiénicos y decides consultar con tu odontólogo tienes grandes probabilidades de recuperar tu salud. La fase final se presenta cuando, debido a la falta de una base que sostenga los dientes, estos se caen.\\n\\nLa caries dental es una lesión ocasionada por bacterias que se \nalimentan del azúcar de tu dieta y se desarrolla paralelamente a los que mencionamos anteriormente, osea que toda persona que tiene malos hábitos alimenticios e higiénicos invariablemente va a presentar, caries las cuales tarde o temprano te darán dolor en las piezas dentales dañadas.\\n\\nFinalmente te mencionaremos un problema frecuentemente observado, el cual se denomina Alteraciones de articulación témporo-mandibular, el cual se caracteriza por el tronido de la mandíbula en el momento de comer o al abrir la boca (por ejemplo con el bostezo), es causado por varios factores, uno de los más importantes es el estrés que se manifiesta por el rechinido de los dientes durante el sueño. Si te truena la mandíbula al comer o abrir la boca es importante que sepas que existen métodos odontológicos para mejorar este tipo de problema.',44,'SALUD ORAL',3),(5,6,4,'SIN RIESGO... Muy bien, sabes donde consumir tus alimentos y practicas hábitos higiénicos con los que evitas contaminarte con parásitos o padecer de intoxicación alimenticia.\\n\\nAlgunas vez has padecido de nauseas, vómitos y diarrea puede que te hayas intoxicado al ingerir un alimento mal preparado ... si tus resultados mostraron algún grado de riesgo, Urge!! Que cambies de hábitos por el bien de tu SALUD.',46,'HÁBITOS HIGIÉNICOS',1),(6,10,7,'BAJO RIESGO... Tienes que cuidar donde comes, debes ser más observador y exigente en los lugares donde consumes tus alimentos ya que puedes enfermarte.',46,'HÁBITOS HIGIÉNICOS',1),(7,13,11,'RIESGO MODERADO.   Cuidado!!! Estás siendo descuidado en algunas cosas sencillas, como lavarte las manos en forma correcta antes de comer tus alimentos, no te acostumbres a comer alimentos de cualquier lugar, no te dejes llevar por los olores, piensa en el riesgo que corres al ingerirlo.\\n\\nAlgunas vez has padecido de nauseas, vómitos y diarrea puede que te hayas intoxicado al ingerir un alimento mal preparado ... si tus resultados mostraron algún grado de riesgo, Urge!! Que cambies de hábitos por el bien de tu SALUD.',46,'HÁBITOS HIGIÉNICOS',2),(8,16,14,'ALTO RIESGO.  Es importante que pienses en tu salud, todo lo que estas haciendo te pone en peligro de adquirir parásitos como amebas y lombrices, que solo pueden ser detectados por un examen de heces; te recomendamos que te lo hagas lo antes posible y dependiendo de los resultados recibas el tratamiento adecuado por tu médico o silo prefieres por los médicos de Unidad de Salud.\\n\\nAlgunas vez has padecido de nauseas, vómitos y diarrea puede que te hayas intoxicado al ingerir un alimento mal preparado ... si tus resultados mostraron algún grado de riesgo, Urge!! Que cambies de hábitos por el bien de tu SALUD.',46,'HÁBITOS HIGIÉNICOS',2),(9,15,10,'Posees un excelente nivel de Salud Mental. NO lo descuides, posees recursos internos y externos en los que puede apoyarte para mantenerlo y por qué no? mejorarlo. Dentro de tus posibilidades busca mantener el equilibrio en todas tus áreas de vida, prestandoles atención y cuidado a cada una de ellas. A partir de ahora cuentas con el apoyo del Área de Psicología.',45,'SALUD MENTAL',1),(10,22,16,'Tu nivel de Salud Mental, está Muy Bien. Puedes Mejorarlo así estarás previniendo la aparición de otras situaciones que podrían llegar a afectar tu desempeño general. Busca apoyo de personas de tu confianza, busca ayuda profesional para poder trabajar los aspectos que pueden estar afectándote, participa en actividades de crecimiento y desarrollo personal como las que se llevan a cabo en el Área de Psicología.',45,'SALUD MENTAL',2),(11,30,23,'Tu nivel de Salud Mental está Regular, no lo descuides, necesitas apoyo profesional psicológico ya que tus respuestas indican que carias áreas en tu vida están siendo afectadas y que a mediano plazo puede dar como resultado situaciones muy serias de crisis emocional e inclusive física. Muy probablemente necesitas realizar algunos cambios en tu vida. Busca ayuda profesional, cunetas con el Área de Psicología y sus actividades de apoyo como lo son Psicoterapia (individual, de pareja, familiar) y los Talleres de Crecimiento y Desarrollo Personal, que orientan a reforzar áreas como lo social, académica, emocional, autoestima, hablar en público y otras.',45,'SALUD MENTAL',1),(12,40,31,'ESTE NIVEL INDICA UN MARCADO SUFRIMIENTO EMOCIONAL que limita tu desempeño general. Definitivamente necesitas apoyo profesional Psicológico. Muy probablemente estás disfuncionando en la mayoría de áreas de tu vida y como consecuencia estás muy afectado(a) desempeñandote por debajo de tu capacidad personal, algunos de los malestares físicos que quizás experimentes (dolor de cabeza, de nuca, gastritis, caspas, etc.) tienen relación estrecha con la tensión que ejercen tus problemas sobre ti. Urge que busques ayuda, la cual puedes encontrar en el Área de Psicología de la Unidad de Salud, que puede apoyarte por medio de Psicoterapia individual, de Pareja y Familiar, también puedes participar de los Talleres de Crecimiento y Desarrollo Personal.',45,'SALUD MENTAL',2);
/*!40000 ALTER TABLE `categoria_interpretacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `area_examen`
--

DROP TABLE IF EXISTS `area_examen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `area_examen` (
  `idarea_examen` int(10) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`idarea_examen`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `area_examen`
--

LOCK TABLES `area_examen` WRITE;
/*!40000 ALTER TABLE `area_examen` DISABLE KEYS */;
INSERT INTO `area_examen` VALUES (1,'Medicina'),(2,'Psicología'),(3,'Odontología'),(4,'Laboratorio');
/*!40000 ALTER TABLE `area_examen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resultado_examen`
--

DROP TABLE IF EXISTS `resultado_examen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resultado_examen` (
  `idresultado_examen` int(10) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(100) NOT NULL,
  `interpretacion` text NOT NULL,
  `idtipo_interpretacion` int(10) NOT NULL,
  `size` int(10) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idresultado_examen`),
  KEY `FKresultado_488218` (`idtipo_interpretacion`),
  CONSTRAINT `FKresultado_488218` FOREIGN KEY (`idtipo_interpretacion`) REFERENCES `tipo_interpretacion` (`idtipo_interpretacion`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resultado_examen`
--

LOCK TABLES `resultado_examen` WRITE;
/*!40000 ALTER TABLE `resultado_examen` DISABLE KEYS */;
INSERT INTO `resultado_examen` VALUES (3,'1.CEFALEA','Dolor de cabeza, esto indica tu estado actual. debes mejorar',3,2),(4,'2.NO CEFALEA','Sin dolor de cabeza',3,3),(5,'2.MIGRANA','',4,1),(6,'3.OTRA CEFALEA','',4,1),(7,'4.NO TIENE','',4,1),(10,'6.DISMINUIDA SIN LENTES','',5,1),(11,'2.CORREGIDA CON LENTES','',5,1),(12,'5.DISMINUIDA CON LENTES','',5,1),(13,'3.VISTA LIMITROFE SIN LENTES','',5,1),(14,'1.VISTA NORMAL','',5,1),(16,'4.VISTA LIMITROFE CON LENTES','',5,1),(17,'1.CEFALEA TENSIONAL','',4,1),(18,'MIOPIA-ASTIGMATISMO','',6,1),(19,'MIOPIA','',6,1),(20,'ASTIGMATISMO','',6,1),(21,'SIN DX','',6,1),(22,'1.AUDICION NORMAL','',7,1),(23,'2.HIPOACUSIA','',7,1),(24,'3.SORDERA','',7,1),(25,'1.PROBABLE TAPON','',8,1),(26,'2.NO PROBABLE','',8,1),(27,'1.SI TIENE','',9,1),(28,'2.NO TIENE','',9,1),(29,'1.SI TIENE','',10,1),(30,'2.NO TIENE','',10,1),(31,'1.SI TIENE','',11,1),(32,'2.NO TIENE','',11,1),(33,'1.SI TIENE','',12,1),(34,'2.NO TIENE','',12,1),(37,'1.SI TIENE','',13,1),(38,'2.NO TIENE','',13,1),(39,'1.SI TIENE','',14,1),(40,'2.NO TIENE','',14,1),(42,'1.SI TENGO','',15,1),(43,'2.NO TENGO','',15,1),(44,'2.PROBABLE INFECCION','',16,1),(45,'1.NO INFECCION','',16,1),(46,'3.CALCULOS DEL RIÑON','',16,1),(47,'4.PROBLEMA DE TESTICULO','',17,1),(48,'1.FLUJO VAGINAL','',18,1),(49,'2.MENSTRUACION IRREGULAR','',18,1),(50,'3.DOLOR MENSTRUAL','',18,1),(51,'4.QUISTES DE OVARIO','',18,1),(52,'5.SIN PROBLEMA','',18,1),(53,'2 PROBABLE ENF. PEPTICA','',19,1),(54,'1 ENF. PEPTICA','',19,1),(55,'3.NO ENF.PEPTICA','',19,1),(56,'1.DIARREA CRONICA','',19,1),(57,'2.CONSTIPACION','',19,1),(58,'3.ULCERA GASTRICA','',19,1),(59,'4.REFLUJO','',19,1),(60,'1. DOLOR MUSCULAR MODERADO','',20,1),(61,'2. DOLOR MUSCULAR LEVE','',20,1),(62,'3. NO DOLOR MUSCULAR','',20,1),(63,'1. FUMADOR','',21,1),(64,'2. EX FUMADOR','',21,1),(65,'3. NO FUMADOR','',21,1),(66,'1. CONSUMO DE ALTO RIESGO','',22,1),(67,'2. CONSUMO DE RIESGO','',22,1),(68,'3. CONSUMO SOCIAL','',22,1),(69,'4. NO BEBEDOR(A)','',22,1),(70,'1. EJERCICIO ADECUADO','',23,1),(71,'2. EJERCICIO INADECUADO','',23,1),(72,'3. EJERCICIO DEFICIENTE','',23,1),(73,'1. SI CONSUME','',24,1),(74,'2. NO CONSUME','',24,1),(75,'1. CONDUCTA SEGURA','',25,1),(76,'2. CONDUCTA DE RIESGO','',25,1),(77,'3. CONDUCTA DE ALTO RIESGO','',25,1),(78,'4. NO VIDA SEXUAL','',25,1),(79,'1.APENDICECTOMIA','',28,1),(80,'2.COLECISTECTOMIA','',28,1),(81,'3.CIRUGIA DE TESTICULO','',28,1),(82,'4.POSTATECTOMIA','',28,1),(83,'5.CIRUGIA DE OVARIO','',28,1),(84,'6.SIN CIRUGIA','',28,1);
/*!40000 ALTER TABLE `resultado_examen` ENABLE KEYS */;
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
  CONSTRAINT `pregunta_titulo_respuesta_ibfk_1` FOREIGN KEY (`idpregunta`) REFERENCES `pregunta` (`idpregunta`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pregunta_titulo_respuesta`
--

LOCK TABLES `pregunta_titulo_respuesta` WRITE;
/*!40000 ALTER TABLE `pregunta_titulo_respuesta` DISABLE KEYS */;
INSERT INTO `pregunta_titulo_respuesta` VALUES (1,210,1),(1,211,1),(1,212,1),(1,213,1),(1,214,1),(1,215,1),(1,216,4),(1,217,4),(1,218,4),(1,219,4),(1,220,1),(1,221,1),(1,222,1),(1,223,1),(1,224,1),(1,225,1),(1,226,1),(1,227,1),(1,228,1),(1,229,1),(1,230,1),(1,231,1),(1,232,1),(1,233,1),(1,234,0),(1,235,0),(1,236,0),(1,237,0),(1,238,0),(1,239,0),(1,240,0),(1,241,0),(1,242,0),(1,243,0),(1,244,0),(1,245,0),(1,246,0),(1,247,0),(1,248,0),(1,249,0),(1,250,0),(1,251,0),(1,252,0),(1,253,0),(1,254,0),(1,255,0),(1,256,0),(1,257,0),(1,258,0),(1,259,0),(1,260,0),(1,261,0),(1,262,0),(1,263,0),(1,264,0),(1,265,0),(1,266,0),(1,269,0),(1,270,0),(1,271,0),(1,272,0),(1,273,1),(1,274,1),(1,275,1),(1,276,1),(1,277,1),(1,278,1),(1,327,4),(1,328,4),(1,329,1),(1,330,1),(1,331,1),(1,332,4),(1,333,1),(1,334,1),(1,335,4),(1,336,4),(1,337,1),(1,338,1),(1,339,4),(1,341,1),(1,342,1),(1,343,1),(1,344,1),(1,345,1),(1,346,1),(2,210,2),(2,211,2),(2,212,2),(2,213,2),(2,214,2),(2,215,2),(2,216,3),(2,217,3),(2,218,3),(2,219,3),(2,220,2),(2,221,2),(2,222,2),(2,223,2),(2,224,2),(2,225,2),(2,226,2),(2,227,2),(2,228,2),(2,229,2),(2,230,2),(2,231,2),(2,232,2),(2,233,2),(2,273,2),(2,274,2),(2,275,2),(2,276,2),(2,277,2),(2,278,2),(2,327,3),(2,328,3),(2,329,2),(2,330,2),(2,331,2),(2,332,3),(2,333,2),(2,334,2),(2,335,3),(2,336,3),(2,337,2),(2,338,2),(2,339,3),(2,341,2),(2,342,2),(2,343,2),(2,344,2),(2,345,2),(2,346,2),(3,163,3),(3,164,3),(3,165,3),(3,167,3),(3,169,3),(3,170,3),(3,171,3),(3,175,3),(3,183,3),(3,185,3),(3,186,3),(3,187,3),(3,188,3),(3,189,3),(3,190,3),(3,191,3),(3,193,3),(3,194,3),(3,195,3),(3,196,3),(3,210,3),(3,211,3),(3,212,3),(3,213,3),(3,214,3),(3,215,3),(3,216,2),(3,217,2),(3,218,2),(3,219,2),(3,220,3),(3,221,3),(3,222,3),(3,223,3),(3,224,3),(3,225,3),(3,226,3),(3,227,3),(3,228,3),(3,229,3),(3,230,3),(3,231,3),(3,232,3),(3,233,3),(3,273,3),(3,274,3),(3,275,3),(3,276,3),(3,277,3),(3,278,3),(3,279,3),(3,327,2),(3,328,2),(3,329,3),(3,330,3),(3,331,3),(3,332,2),(3,333,3),(3,334,3),(3,335,2),(3,336,2),(3,337,3),(3,338,3),(3,339,2),(3,341,3),(3,342,3),(3,343,3),(3,344,3),(3,345,3),(3,346,3),(4,136,0),(4,162,0),(4,163,4),(4,164,4),(4,165,4),(4,167,4),(4,169,4),(4,170,4),(4,171,4),(4,175,4),(4,183,4),(4,185,4),(4,186,4),(4,187,4),(4,188,4),(4,189,4),(4,190,4),(4,191,4),(4,193,4),(4,194,4),(4,195,4),(4,196,4),(4,197,0),(4,210,4),(4,211,4),(4,212,4),(4,213,4),(4,214,4),(4,215,4),(4,216,1),(4,217,1),(4,218,1),(4,219,1),(4,220,4),(4,221,4),(4,222,4),(4,223,4),(4,224,4),(4,225,4),(4,226,4),(4,227,4),(4,228,4),(4,229,4),(4,230,4),(4,231,4),(4,232,4),(4,233,4),(4,273,4),(4,274,4),(4,275,4),(4,276,4),(4,277,4),(4,278,4),(4,279,4),(4,280,2),(4,281,2),(4,282,2),(4,283,2),(4,284,2),(4,285,2),(4,286,2),(4,287,2),(4,288,2),(4,289,2),(4,290,2),(4,291,2),(4,292,2),(4,293,2),(4,294,2),(4,295,2),(4,296,2),(4,297,2),(4,298,2),(4,299,2),(4,301,2),(4,302,2),(4,303,2),(4,304,2),(4,305,2),(4,306,2),(4,307,2),(4,308,2),(4,309,0),(4,310,0),(4,311,0),(4,312,0),(4,313,0),(4,314,0),(4,315,0),(4,316,0),(4,317,0),(4,318,0),(4,319,0),(4,321,0),(4,322,0),(4,323,0),(4,324,0),(4,325,0),(4,326,0),(4,327,1),(4,328,1),(4,329,4),(4,330,4),(4,331,4),(4,332,1),(4,333,4),(4,334,4),(4,335,1),(4,336,1),(4,337,4),(4,338,4),(4,339,1),(4,341,4),(4,342,4),(4,343,4),(4,344,4),(4,345,4),(4,346,4),(5,163,1),(5,164,1),(5,165,1),(5,167,1),(5,169,1),(5,170,1),(5,171,1),(5,175,1),(5,183,1),(5,185,1),(5,186,1),(5,187,1),(5,188,1),(5,189,1),(5,190,1),(5,191,1),(5,193,1),(5,194,1),(5,195,1),(5,196,1),(5,279,1),(6,163,2),(6,164,2),(6,165,2),(6,167,2),(6,169,2),(6,170,2),(6,171,2),(6,175,2),(6,183,2),(6,185,2),(6,186,2),(6,187,2),(6,188,2),(6,189,2),(6,190,2),(6,191,2),(6,193,2),(6,194,2),(6,195,2),(6,196,2),(6,279,2),(7,176,1),(8,176,2),(9,176,3),(10,176,4),(11,136,0),(11,162,0),(11,197,0),(11,280,1),(11,281,1),(11,282,1),(11,283,1),(11,284,1),(11,285,1),(11,286,1),(11,287,1),(11,288,1),(11,289,1),(11,290,1),(11,291,1),(11,292,1),(11,293,1),(11,294,1),(11,295,1),(11,296,1),(11,297,1),(11,298,1),(11,299,1),(11,301,1),(11,302,1),(11,303,1),(11,304,1),(11,305,1),(11,306,1),(11,307,1),(11,308,1),(11,309,0),(11,310,0),(11,311,0),(11,312,0),(11,313,0),(11,314,0),(11,315,0),(11,316,0),(11,317,0),(11,318,0),(11,319,0),(11,321,0),(11,322,0),(11,323,0),(11,324,0),(11,325,0),(11,326,0),(12,129,0),(12,151,1),(12,152,1),(12,153,1),(12,154,1),(12,155,1),(12,157,1),(13,129,0),(13,151,2),(13,152,2),(13,153,2),(13,154,2),(13,155,2),(13,157,2),(14,151,3),(14,152,3),(14,153,3),(14,154,3),(14,155,3),(14,157,3),(15,151,4),(15,152,4),(15,153,4),(15,154,4),(15,155,4),(15,157,4),(16,151,5),(16,152,5),(16,153,5),(16,154,5),(16,155,5),(16,157,5),(17,234,0),(17,235,0),(17,236,0),(17,237,0),(17,238,0),(17,239,0),(17,240,0),(17,241,0),(17,242,0),(17,243,0),(17,244,0),(17,245,0),(17,246,0),(17,247,0),(17,248,0),(17,249,0),(17,250,0),(17,251,0),(17,252,0),(17,253,0),(17,254,0),(17,255,0),(17,256,0),(17,257,0),(17,258,0),(17,259,0),(17,260,0),(17,261,0),(17,262,0),(17,263,0),(17,264,0),(17,265,0),(17,266,0),(17,269,0),(17,270,0),(17,271,0),(17,272,0),(18,234,0),(18,235,0),(18,236,0),(18,237,0),(18,238,0),(18,239,0),(18,240,0),(18,241,0),(18,242,0),(18,243,0),(18,244,0),(18,245,0),(18,246,0),(18,247,0),(18,248,0),(18,249,0),(18,250,0),(18,251,0),(18,252,0),(18,253,0),(18,254,0),(18,255,0),(18,256,0),(18,257,0),(18,258,0),(18,259,0),(18,260,0),(18,261,0),(18,262,0),(18,263,0),(18,264,0),(18,265,0),(18,266,0),(18,269,0),(18,270,0),(18,271,0),(18,272,0),(36,128,0),(37,128,0),(38,128,0),(39,128,0),(40,128,0),(41,128,0),(42,128,0),(43,128,0),(44,128,0),(45,129,0),(46,129,0),(47,129,0),(48,129,0),(49,129,0),(50,129,0),(51,130,0),(52,130,0),(53,130,0),(54,130,0),(55,130,0),(56,130,0),(76,160,0),(77,160,0),(78,160,0),(79,160,0),(80,160,0),(81,160,0),(82,160,0),(83,161,0),(84,161,0),(85,161,0),(86,161,0),(87,161,0),(88,161,0),(89,198,0),(90,198,0),(91,198,0),(92,199,0),(93,199,0),(94,199,0),(95,199,0),(96,199,0),(97,199,0),(98,199,0),(99,199,0),(100,199,0),(101,316,0),(101,317,0),(101,318,0),(101,319,0),(101,321,0),(101,322,0),(101,323,0),(101,324,0),(101,325,0),(101,326,0);
/*!40000 ALTER TABLE `pregunta_titulo_respuesta` ENABLE KEYS */;
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
  KEY `FKcontenido303639` (`menuidmenu`),
  KEY `FKcontenido417686` (`multimediaidmultimedia`),
  CONSTRAINT `FKcontenido303639` FOREIGN KEY (`menuidmenu`) REFERENCES `menu` (`idmenu`),
  CONSTRAINT `FKcontenido417686` FOREIGN KEY (`multimediaidmultimedia`) REFERENCES `multimedia` (`idmultimedia`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contenido`
--

LOCK TABLES `contenido` WRITE;
/*!40000 ALTER TABLE `contenido` DISABLE KEYS */;
INSERT INTO `contenido` VALUES (39,1,'','Organigrama',48),(21,2,'En estudiantes de la Universidad de San Carlos de Guatemala en el año 2002','Prevalencia y características de tabaquismo',49),(21,3,'Estudiantes de primer ingreso de la Universidad de San Carlos de Guatemala 2004','Fiabilidad de la prueba de Harvard modificada para la evaluación de la Condición Física',50),(21,4,'Durante el Examen de Salud. Efectuado a estudiantes de Primer Ingreso a la Universidad de San Carlos de Guatemala. Unidad de Salud. 2006.','Fiabilidad de la Grada de Harvard 35-40 para la determinación de la condición física',51),(21,5,'En la Universidad de San Carlos de Guatemala','Efectos del Acuerdo de Rectoría 469-2003 en el Tabaquismo',52),(21,6,'Universidad de San Carlos de Guatemala. Unidad de Salud, 2007','Calidad de vida del estudiante obeso de primer ingreso',53),(21,7,'En la Universidad de San Carlos de Guatemala','Acuerdo de Rectoría para la prohibición de la venta y consumo de tabaco',54),(24,8,'','docencia',55),(42,9,'En estudiantes de la Universidad de San Carlos de Guatemala. Unidad de Salud, 2001.','GLICEMIA PRE-PRANDIAL Y FACTORES DE RIESGO PARA DIABETES TIPO 2',58),(42,10,'Universidad de San Carlos de Guatemala. Unidad de Salud, 2004','CALIDAD DE VIDA DEL ESTUDIANTE DE PRIMER INGRESO',59),(42,11,'Universidad de San Carlos de Guatemala. Unidad de Salud, 2006.','IMPACTO DEL EXAMEN DE AUTOEVALUACIÓN DE ESTUDIANTES DE INGRESO',60),(42,12,'Universidad de San Carlos de Guatemala, División de Bienestar Estudiantil, Unidad de Salud, 2007','VARIABILIDAD DE VALORES SEROLÓGICOS DE LA GLUCOSA Y PERFIL LIPÍDICO CON Y SIN AYUNO',61),(18,13,'','Aprende a hablar en público',62),(18,14,'','Desarrollo de la Autoestima',63),(18,15,'','Desarrollo de la habilidad social',64),(18,16,'','Manejo de las emociones',65),(18,17,'','Relaciones humanas',66),(18,18,'','Técnicas de estudio',67),(18,19,'','Toma de decisiones',68),(18,20,'','Trabajo en equipo',69),(18,21,'','Técnicas de relajación',70),(23,22,'','Equipo PPIVS',81),(17,23,'EJEPLO','EJEMPLO PDF',92),(17,24,'','imagen prueba',94),(44,30,'Ven a pedír una cita','Solicitando examen de salud',116),(44,31,'3er Nivel de Bienestar Estudiantil, Campus Central. Zona 12','Entrada de la Unidad de Salud',159),(44,32,'Esperando para odontología','Examen multifásico / Odontología',160),(44,33,'Revisión general','Examen multifásico / Odontología',161),(44,34,'Entrevista personal','Examen multifásico / Psicología',162),(44,35,'','Examen multifásico / Medicina',163),(44,36,'Medidas Corporales','Examen multifásico',164),(45,37,'','Trifoliar Parte 1',158),(45,38,'','Trifoliar Parte 2',157),(46,40,'','foto de aerobico',167),(19,41,'','GRADA',172),(19,42,'','ejemplo pdf',173);
/*!40000 ALTER TABLE `contenido` ENABLE KEYS */;
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
  `size` int(11) NOT NULL DEFAULT '3' COMMENT '0-> sin texto, 1 -> pequeño , 2 -> mediano, 3 -> Grande',
  `multimediaidmultimedia` int(11) DEFAULT NULL,
  `html_adicional` text,
  PRIMARY KEY (`idarea`),
  KEY `FKarea245370` (`areaidarea`),
  KEY `FKarea432514` (`multimediaidmultimedia`),
  CONSTRAINT `FKarea245370` FOREIGN KEY (`areaidarea`) REFERENCES `area` (`idarea`),
  CONSTRAINT `FKarea432514` FOREIGN KEY (`multimediaidmultimedia`) REFERENCES `multimedia` (`idmultimedia`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `area`
--

LOCK TABLES `area` WRITE;
/*!40000 ALTER TABLE `area` DISABLE KEYS */;
INSERT INTO `area` VALUES (1,'Unidad de Salud',NULL,'<div align=\'center\' style=\'text-align: right; \'><font size=\'2\'>Universidad de San Carlos de Guatemala</font></div><div align=\'center\' style=\'font-size: 10pt; \'><font><font size=\'5\'><br></font></font></div><div align=\'center\'><font><font><font size=\'5\'>Unidad de Salud</font><br><font size=\'2\'>Bienestar Estudiantil<br>Direcci&oacute;n General de&nbsp;</font><font face=\'Arial, Verdana\' size=\'2\'>Docencia</font><br></font><br></font><br></div><div align=\'center\'><br></div><div align=\'center\'><br></div><div align=\'center\'><br></div><div align=\'center\' style=\'font-size: 10pt; \'><font size=\'4\'>Directores y Jefes de Unidad de Salud del a&ntilde;o 1972 al a&ntilde;o 2007</font><br></div>',2,57,NULL),(2,'Odontología',NULL,'<div style=\'text-align: justify;\'><span style=\'font-size: large; \'>Forma parte de la Unidad de Salud prestando servicios a la comunidad universitaria a precios econ&oacute;micos.</span></div><font size=\'4\'><br><b>SERVICIOS:</b><br></font><div><ul><li style=\'text-align: justify;\'><span style=\'font-size: large; \'>Atenci&oacute;n de urgencias</span></li><li style=\'text-align: justify;\'><span style=\'font-size: large; \'>Limpieza dental</span></li><li style=\'text-align: justify;\'><span style=\'font-size: large; \'>Aplicaci&oacute;n de fl&uacute;or</span></li><li style=\'text-align: justify;\'><span style=\'font-size: large; \'>Obturaciones de amalgama (rellenos met&aacute;licos en molares)</span></li><li style=\'text-align: justify;\'><span style=\'font-size: large; \'>Obturaciones de resina (rellenos blancos solo en dientes anteriores)</span></li><li style=\'text-align: justify;\'><span style=\'font-size: large; \'>Tratamiento pulpares (dientes anteriores &uacute;\nnicamente)</span></li><li style=\'text-align: justify;\'><span style=\'font-size: large; \'>Extracci&oacute;n dentales (no cordales)</span></li></ul><font size=\'4\'><br><b>ACTIVIDADES:<br></b><br></font><div><ul><li style=\'text-align: justify;\'><span style=\'font-size: large; \'>Dar consulta externa.</span></li><li style=\'text-align: justify;\'><span style=\'font-size: large; \'>Llevar registro y control de pacientes y casos.</span></li><li style=\'text-align: justify;\'><span style=\'font-size: large; \'>Impartir talleres informativos de su especialidad a estudiantes universitarios</span></li></ul></div></div>',4,NULL,NULL),(3,'Laboratorio Clínico',NULL,'<div align=\'justify\'><font size=\'4\'>Desde su fundaci&oacute;n la Unidad de salud cuenta entre sus \'&Aacute;reas\' de trabajo con el Laboratorio cl&iacute;nico, el que actualmente est&aacute; atendiendo por dos Qu&iacute;micas Bi&oacute;logas, una en calidad de Jefe y la otra como Profesora Auxiliar. Ambas profesionales forman parte del personal docente de dicha Unidad.<br><br>Se desempe&ntilde;a tambi&eacute;n en este laboratorio, estudiantes de Qu&iacute;mica Biol&oacute;gica de la Facultad de Ciencias Qu&iacute;micas y Farmacias, quienes durante un per&iacute;odo de doce semanas desarrollan actividades catalogadas como experiencias docentes la comunidad EDC.<br><br>El programa de estudios y pr&aacute;cticas de dichos estudiantes fue aprobado en 1981, por una comisi&oacute;n bipartita adoc, integrada por representantes de la Facultad de Ciencias Qu&iacute;micas y Farmacia y de la Unidad de Salud, y cada a&ntilde;o se adecua a las necesidades del momento.<br><br>Este \nlaboratorio coadyuva al diagn&oacute;stico cl&iacute;nico de las personas que se atienden en la Unidad de Salud, mediante el examen mutif&aacute;sico, as&iacute; como tambi&eacute;n de quienes son referidas de la consulta externa por el m&eacute;dico de guardia.<br><br>Los datos obtenidos de los ex&aacute;menes de laboratorio realizados, se registran ordenadamente y un an&aacute;lisis retrospectivo de los mismos permite efectuar una caracterizaci&oacute;n de la poblaci&oacute;n atendida cada a&ntilde;o, as&iacute; como establecer cada uno de los \'Parametros\' que son de utilidad para proponer nuevos objetivos en el futuro.<br><br>CONTENIDO:</font><br><font size=\'4\'><br>1.&nbsp; Examen multif&aacute;sico</font><blockquote><ul><li><font size=\'4\'>Rutina de comproparasitolog&iacute;a</font></li></ul></blockquote><blockquote><blockquote><blockquote><font size=\'4\'>- Examen macrosc&oacute;pico de heces fecales</font><br></blockquote></blockquote></blockquote><blockquote><blockquote><blockquote><font size=\'4>- Examen microsc&oacute;pico de heces fecales</font><br></blockquote></blockquote></blockquote><blockquote><ul><li><font size=\'4\'>Rutina de Urian&aacute;lisis</font></li></ul></blockquote><blockquote><blockquote><blockquote><font size=\'4\'>- Examen macrosc&oacute;pico de orina</font><br></blockquote></blockquote></blockquote><blockquote><blockquote><blockquote><font size=\'4\'>- Examen microsc&oacute;pico de sedimento urinario</font><font size=\'4\'><br></font></blockquote></blockquote><ul><li><font size=\'4\'>Examen rutinario de hematolog&iacute;a</font></li></ul></blockquote><blockquote><blockquote><blockquote><font size=\'4\'>- Recuento leucocitario</font><br></blockquote></blockquote></blockquote><blockquote><blockquote><blockquote><font size=\'4\'>- F&oacute;rmula leucocitaria</font><br></blockquote></blockquote></blockquote><blockquote><blockquote><blockquote><font size=\'4\'>- Velocidad de eritrosedimentaci&oacute;n</font><br></blockquote></blockquote></blockquote><blockquote><ul><li><font size=\'\n4\'>VDRL</font></li></ul></blockquote><font size=\'4\'>2.&nbsp; Consulta Externa</font><br><ul><li><font size=\'4\'>Rutina de Coproparasitolog&iacute;a</font></li></ul><ul><li><font size=\'4\'>Rutina de Urian&aacute;lisis</font></li></ul><ul><li><font size=\'4\'>Examen rutinario de hematolog&iacute;a</font></li></ul><ul><li><font size=\'4\'>VDRL</font></li></ul><ul><li><font size=\'4\'>Hematocrito y Hemoglobina</font></li></ul><ul><li><font size=\'4\'>Tiempo de Coagulaci&oacute;n y Sangr&iacute;a</font></li></ul><ul><li><font size=\'4\'>Gota gruesa</font></li></ul><ul><li><font size=\'4\'>Frotis perif&eacute;rico</font></li></ul><ul><li><font size=\'4\'>Campo oscuro</font></li></ul><ul><li><font size=\'4\'>Prueba de Gram</font></li></ul><ul><li><font size=\'4\'>Prueba de Graham</font></li></ul><ul><li><font size=\'4\'>Investigaci&oacute;n directa de hongos</font></li></ul><ul><li><font size=\'4\'>Investigaci&oacute;n en fresco de tricomonas</font></li></ul><ul><li><font size=\'4\'>Pruebas bioqu&iacute;micas (\ncolesterol, &aacute;cido &uacute;rico, glucosa, creatinina, otras)</font></li></ul></div>',4,NULL,NULL),(4,'Psicología',NULL,'<div align=\'justify\'><font size=\'4\'><br>El &aacute;rea de psicolog&iacute;a de la Unidad de Salud, es una de las cuatro &aacute;reas que conforman la Unidad de Salud de la Divisi&oacute;n de Bienestar Estudiantil Universitario.</font><br><font size=\'4\'><br><b>La Filosof&iacute;a de trabajo bajo la cual funciona es la siguiente:</b></font><b><br></b><font size=\'4\'><br>\'Cumplir con los prop&oacute;sitos de creaci&oacute;n de la Divisi&oacute;n de Bienestar Estudiantil Universitario y espec&iacute;ficamente de la Unidad de Salud, basados en los siguientes valores: Calidad, Eficiencia, Lealtad y Respeto\'</font><br><font size=\'4\'><br><b>Habi&eacute;ndose establecido como Visi&oacute;n:</b></font><b><br></b><font size=\'4\'><br>\'Ser el &Aacute;rea que busca promover la salud mental del estudiante universitario, a trav&eacute;s de la educaci&oacute;n, promoci&oacute;n y prevenci&oacute;n, en alianza con otras disciplinas afines y d&aacute;ndole cumplimiento a los objetivos y \nprop&oacute;sitos, misi&oacute;n y visi&oacute;n de la Unidad de Salud con flexibilidad a cambios positivos\'</font><br><font size=\'4\'><br><b>Misi&oacute;n:</b></font><b><br></b><font size=\'4\'><br>\'Participar en la promoci&oacute;n de la salud integral del estudiante universitario y formaci&oacute;n de estudiantes practicantes por medio de la docencia, investigaci&oacute;n, extensi&oacute;n y administraci&oacute;n con programas cient&iacute;ficos, &eacute;ticos, pragm&aacute;ticos y human&iacute;sticos\'</font><br><br></div><br>',4,NULL,NULL),(5,'Medicina',NULL,'<div align=\'justify\'><font size=\'4\'>El &aacute;rea de medicina forma parte de un equipo multiprofesional de la salud que tiene como objetivos preservar la salud de los estudiantes y promover estilos de vida saludable, especialmente en aquellos j&oacute;venes con mayores probabilidad de desarrollar enfermedades cr&oacute;nico degenerativas, especialmente diabetes tipo 2, hipertensi&oacute;n arterial y secundariamente problemas micro o macro circulatorios.</font><br><br><font size=\'4\'>El primer acercamiento con los estudiantes es a trav&eacute;s del examen de salud, el cual por mandato del Consejo Superior Universitario, todos los estudiantes que ingresan a nuestra Universidad deben realizarlo como requisito para reinscribirse el siguiente a&ntilde;o.</font><br><font size=\'4\'>Al 20% de todos los estudiantes se les efect&uacute;a un examen cl&iacute;nico, realizando nuestra &aacute;rea, las siguientes evaluaciones:</font><br><br><font size=\'4\'>Presi&oacute;n Arterial, pulso: \nUtilizando un esfigmoman&oacute;metro el&eacute;ctrico calibrado.</font><br><br><font size=\'4\'>Agudeza Visual, por medio de un visor para determinar la agudeza visual lejana y cercana.</font><br><br><font size=\'4\'>Evaluaciones antropom&eacute;tricas: Peso, Talla, IMC, cintura abdominal, pliegues cut&aacute;neos, calculando riesgos en funci&oacute;n de los criterios para desarrollar diabetes y problemas cardiovasculares, establecidos por OMS y la Federaci&oacute;n Internacional de Diabetes.</font><br><font size=\'4\'>Determinaci&oacute;n de la condici&oacute;n f&iacute;sica utilizando la Grada de Harvard modificada, en donde se utilizan dos escalones, uno de 35 cent&iacute;metros para las mujeres y el otro de 40 cent&iacute;metros para los hombres. Ambos deben subir y bajar el escal&oacute;n durante 4 minutos a un ritmo establecido por un metr&oacute;nomo digital calibrado a 120 subidas y bajadas por minuto. Al finalizar el tiempo, se mide el pulso por 30 segundos al minuto de reposo, luego a los dos \nminutos y finalmente a los 3 minutos.</font><br><br><font size=\'4\'>Se realiza la sumatoria se multiplica por 2. Por &uacute;ltimo se divide el tiempo en segundos (240 segundos si el estudiante completo los 4 minutos) entre la sumatoria de los pulsos por dos. Todo estudiante acondicionado tendr&aacute; un &iacute;ndice de 80 o m&aacute;s.</font><br><font size=\'4\'>Se eval&uacute;an los conductos auditivos, debido al hallazgo frecuente de tapones ceruminosos.</font></div>',4,NULL,NULL),(6,'PPIVS',5,'<div style=\'text-align: center;font-family: Arial, Verdana; font-style: normal; font-variant: normal; font-weight: normal; line-height: normal; \'><font size=\'5\' color=\'#000099\'>Programa Preventivo y de</font></div><div style=\'text-align: center;font-family: Arial, Verdana; font-style: normal; font-variant: normal; font-weight: normal; line-height: normal; \'><font size=\'5\' color=\'#000099\'>Intervenci&oacute;n en Vida Saludable</font></div><div style=\'text-align: justify;\'><font face=\'Arial, Verdana\'><br></font></div><font face=\'Arial, Verdana\'><div style=\'text-align: justify;\'>Es el programa de la Unidad de Salud, que se dedica a promover en los estudiantes universitarios y en la comunidad san carlista un estilo de vida saludable, facilitando el acceso a la informaci&oacute;n y fomentando su pr&aacute;ctica de manera integral.</div></font><div style=\'text-align: justify;\'><br></div><font face=\'Arial, Verdana\'><div style=\'text-align: justify;\'><font color=\'#000099\' \nsize=\'5\'>Misi&oacute;n:</font></div></font><div style=\'text-align: justify;\'><br></div><font face=\'Arial, Verdana\'><div style=\'text-align: justify;\'>Contribuir a la promoci&oacute;n de la salud del estudiante de la Universidad de San Carlos de Guatemala, como un programa integral productivo, confiable, efectivo y motivador.</div></font><div style=\'text-align: justify;\'><br></div><div style=\'text-align: justify;\'><br></div><font face=\'Arial, Verdana\'><div style=\'text-align: justify;\'><font size=\'5\' color=\'#000099\'>Visi&oacute;n:</font></div></font><div style=\'text-align: justify;\'><br></div><font face=\'Arial, Verdana\'><div style=\'text-align: justify;\'>Ser un programa de excelencia a nivel universitario internacional por su experiencia profesional y confiable que genere educaci&oacute;n y promoci&oacute;n de la salud integral en los estudiantes de la Universidad de San Carlos de Guatemala, principalmente a trav&eacute;s de acciones de prevenci&oacute;n.</div></font>',4,NULL,'<div \nclass=\"prezi-player\"><style type=\"text/css\" media=\"screen\">.prezi-player { width: 550px; } .prezi-player-links { text-align: center; }</style><object id=\"prezi_uwyqlwiivg7v\" name=\"prezi_uwyqlwiivg7v\" classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" width=\"550\" height=\"400\"><param name=\"movie\" value=\"http://prezi.com/bin/preziloader.swf\"/><param name=\"allowfullscreen\" value=\"true\"/><param name=\"allowscriptaccess\" value=\"always\"/><param name=\"bgcolor\" value=\"#ffffff\"/><param name=\"flashvars\" value=\"prezi_id=uwyqlwiivg7v&amp;lock_to_path=0&amp;color=ffffff&amp;autoplay=no&amp;autohide_ctrls=0\"/><embed id=\"preziEmbed_uwyqlwiivg7v\" name=\"preziEmbed_uwyqlwiivg7v\" src=\"http://prezi.com/bin/preziloader.swf\" type=\"application/x-shockwave-flash\" allowfullscreen=\"true\" allowscriptaccess=\"always\" width=\"550\" height=\"400\" bgcolor=\"#ffffff\" flashvars=\"prezi_id=uwyqlwiivg7v&amp;lock_to_path=0&amp;color=ffffff&amp;autoplay=no&amp;autohide_ctrls=0\"></embed></object><div class=\"prezi-player-links\"><p><a title=\"\nPresentación del PIVS\" href=\"http://prezi.com/uwyqlwiivg7v/presentacion-del-pivs/\">Presentación del PIVS</a> on <a href=\"http://prezi.com\">Prezi</a></p></div></div>'),(7,'Nutrición',5,'<div align=\'center\'><div style=\'text-align: justify;\'><b><br></b></div><div style=\'text-align: justify;\'><b>Atenci&oacute;n Nutricional  en el &aacute;rea de diet&eacute;tica a estudiantes, personal administrativo y de servicio de la USAC y en algunos casos  cortes&iacute;as, aprobados &uacute;nicamente por el jefe de &aacute;rea medica, Dr. Roderico Guerra. Consulta externa a estudiantes y  personal de la USAC de Lunes a Viernes de 10:00 a las 15:30 hrs. Apoyo en el examen multif&aacute;sico que se lleva a cabo los d&iacute;as lunes, martes y jueves de 8:00 a 10:30 hrs.</b></div><div style=\'text-align: justify;\'><b><br></b></div><div style=\'text-align: justify;\'><b>Apoyo multidiciplinario al area de medicina preventiva.</b></div></div><div align=\'center\'><b><font><br><font size=\'5\'>&nbsp;CONSULTA EXTERNA NUTRICI&Oacute;NAL<br>&nbsp;&Aacute;REA M&Eacute;DICA</font></font><br><font style=\'font-size: 10pt; \' size=\'4\'><font size=\'5\'>(ESTUDIANTES Y TRABAJADORES DE USAC)</\nfont></font><br></b></div><font style=\'font-size: 10pt; \' size=\'4\'><b><br><br>Horario de atenci&oacute;n<br>Lunes a viernes: 10:00 a 15:00 hrs.<br><br>Servicios<br>&#183;        Talleres de Nutrici&oacute;n adecuada y recuperaci&oacute;n del bajo peso.<br><br>Para Consulta externa realizar los siguientes pasos:<br>1)     Asistir a la cl&iacute;nica No. 25 de la Unidad de Salud a solicitar su cita.<br>2)     Asistir el d&iacute;a y hora programada.<br><br><br>Requisitos<br>&#183;        Estudiantes: carn&eacute; vigente<br>&#183;        Trabajadores: n&uacute;mero de registro </b><br></font>',4,NULL,NULL),(8,'Actividad Fisica',5,'<div align=\'justify\'><font size=\'4\'>Nuestro compromiso con &eacute;l estudiante es brindarle un programa especializado dependiendo de sus cualidades f&iacute;sicas actuales proponiendol&eacute; llevarl&eacute; a un estado de vida saludable.<br><br>Nuestro programa cuenta con actividades deportivas (Voleibol, Atletismo, F&uacute;tbol y Tenis de mesa), actividades de tipo f&iacute;sica (A&eacute;robicos y Caminatas) y tenemos asesoria t&eacute;cnica y m&eacute;todologica para la orientaci&oacute;n de los estudiantes que deseen hacer una rutina de ejercicio propia.</font></div>',2,NULL,NULL),(9,'Consulta Externa',5,'<div style=\'text-align: center; \'><font size=\'4\'><b>HORARIO ATENCI&Oacute;N</b></font></div><div style=\'font-weight: normal; text-align: justify; \'><font size=\'4\'><br></font></div><div style=\'font-weight: normal; text-align: justify; \'><font size=\'4\'>El &aacute;rea m&eacute;dica de Unidad de Salud proporciona a la comunidad universitaria: Estudiantes y Trabajadores atenci&oacute;n m&eacute;dica atrav&eacute;z de la consulta externa, la cual funciona de lunes a viernes en horario de 7:30 a 19:00 horas y d&iacute;as s&aacute;bados de 8:00 a 13:00 horas.</font></div><div style=\'font-weight: normal; text-align: justify; \'><font face=\'Arial, Verdana\' size=\'4\'><br></font></div><font face=\'Arial, Verdana\' size=\'4\' style=\'font-weight: normal; \'><div style=\'text-align: justify;\'>Los pacientes ser&aacute;n evaluados previamente por el personal de enfermer&iacute;a, quienes le asignar&aacute;n una cita, en un&nbsp;periodo&nbsp;no mayor de 24 horas, s&iacute; el caso \nlo amerita, ser&aacute; evaluado por el personal m&eacute;dico como emergencia.</div></font><div style=\'font-weight: normal; text-align: justify; \'><font size=\'4\'><br></font></div><font face=\'Arial, Verdana\' size=\'4\' style=\'font-weight: normal; \'><div style=\'text-align: justify;\'>Se dispone de atenci&oacute;n m&eacute;dica general, medicina interna, cirug&iacute;a menor, ginecolog&iacute;a y control prenatal.</div></font><div style=\'font-weight: normal; text-align: justify; \'><font size=\'4\'><br></font></div><font face=\'Arial, Verdana\' size=\'4\' style=\'font-weight: normal; \'><div style=\'text-align: justify;\'>Se han asignado&nbsp;d&iacute;as&nbsp;espec&iacute;ficos para procedimientos frecuentes entre estudiantes y trabajadores:</div></font><div style=\'font-weight: normal; text-align: justify; \'><font size=\'4\'><br></font></div><font face=\'Arial, Verdana\' size=\'4\' style=\'font-weight: normal; \'><div style=\'text-align: justify;\'>D&iacute;as viernes de 7:30 a 8:00 \nElectrocardiogramas (previa evaluaci&oacute;n del medico(a) )</div></font><div style=\'font-weight: normal; text-align: justify; \'><font size=\'4\'><br></font></div><font face=\'Arial, Verdana\' size=\'4\' style=\'font-weight: normal; \'><div style=\'text-align: justify; \'>de 8:00 a 9:00 Lavado de o&iacute;dos.</div></font>',4,43,NULL);
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
  `edificioidedificio` int(11) NOT NULL,
  `salon` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idactividad`),
  KEY `FKactividad858803` (`areaidarea`),
  KEY `FKactividad401066` (`edificioidedificio`),
  CONSTRAINT `FKactividad401066` FOREIGN KEY (`edificioidedificio`) REFERENCES `edificio` (`idedificio`),
  CONSTRAINT `FKactividad858803` FOREIGN KEY (`areaidarea`) REFERENCES `area` (`idarea`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actividad`
--

LOCK TABLES `actividad` WRITE;
/*!40000 ALTER TABLE `actividad` DISABLE KEYS */;
INSERT INTO `actividad` VALUES (1,'Tenis de Mesa',8,'Inscribete y ven a aprender como jugar y los tipos de agarre.<div><br></div><div>TAMBIEN PUEDES UTILIZAR NUESTRA MESA EN TUS TIEMPOS LIBRES</div>',1,'19'),(2,'Atletismo',8,'Atletismo. Diviertete corriendo.',2,''),(3,'Voleibol',8,'Entrenamiento fisico, t&eacute;cnico y t&aacute;ctico para las personas que estan inscritas en nuestro programa.<div><br></div><div>D&iacute;as martes y jueves de 11:00 a 13:00 horas</div><div>Requisitos: Pantaloneta y agua.</div>',1,''),(4,'Futbol',8,'<font face=\'Arial, Verdana\' size=\'2\'>El entrenamiento de&nbsp;F&uacute;tbol&nbsp;Sala se a implementado&nbsp;&uacute;nicamente&nbsp;el femenino y puedes inscribirte en la secci&oacute;n de deportes o enviar tus dudas a&nbsp;</font><div><font face=\'Arial, Verdana\' size=\'2\'>us-deportes@hotmail.com</font></div>',1,''),(5,'Taller Deja de Fumar y Gana',6,'Inici&oacute; el jueves 26 de abril de 2012',1,'302'),(6,'Cita de examen de salud y Consulta Externa',1,'<b>Cita del Examen de Salud:</b><div style=\'font-weight: normal; \'>Requisito obligatorio para el segundo a&ntilde;o de estudios, ven ped&iacute;r tu cita.</div><div style=\'font-weight: normal; \'><br></div><div><b>Consulta Externa:</b></div><div style=\'font-weight: normal; \'>Si necesitas consulta med&iacute;ca puedes acudir a la clinica de consulta externa.</div>',1,'Clinica de Consulta Externa'),(7,'TALLER: &#34;HABLAR EN P&Uacute;BLICO&#34;',4,'<font size=\'3\'>Te ense&ntilde;amos una forma de estructurar una conferencia y a perder un poco esos temores con din&aacute;micas y ejercicios.</font>',1,'302'),(8,'TALLER: &#34;DESARROLLO DE LA AUTOESTIMA&#34;',4,'La persona m&aacute;s valiosa eres t&uacute;, Aprende a valorarte, respetarte y amarte positivamente.',1,'302'),(9,'TALLER: &#34;RELACIONES HUMANAS&#34;',4,'<font size=\'3\'>Yo te comprendo y t&uacute; me comprendes, esa es la magia de las relaciones interpersonales saludables</font>',1,'302'),(10,'TALLER. &#34;T&Eacute;CNICAS DE ESTUDIO&#34;',4,'<font size=\'3\'>Superando fallas y obteniendo mejores resultados en tus estudios.</font>',1,'302'),(11,'TALLER. &#34;T&Eacute;CNICAS DE ESTUDIO&#34;',4,'<font size=\'3\'>Superando fallas y obteniendo mejores resultados en tus estudios.</font>',1,'302'),(12,'Psicoterapia',4,'Es un proceso de conocimiento y crecimiento.<br>',4,'Clinicas 9, 11, 12, 13, 14 y 15'),(13,'AEROBICOS',8,'Modalidades: Aer&oacute;bicos coreogr&aacute;fico, tae-bo, step, pesas, colchonetas, baile latino y ??mucho m&aacute;s!',4,'Frento a clinica 23'),(14,'Horario de atenci&oacute;n de odontolog&iacute;a',2,'Tus Dientes se ven m&aacute;s brillantes y se mantienen sanos si te cepillas despu&eacute;s de cada comida. <br><br>Sonr&iacute;e Feliz si te cepillas correctamente usa hilo dental todos los d&iacute;as y visita al dentista cada 6 meses.',4,'');
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
  `areaidarea` int(11) NOT NULL COMMENT '1 HABILITADO, 0 DESHABILITADO',
  `contenido` text,
  `idmenu_rec` int(11) DEFAULT NULL,
  `size` int(11) NOT NULL DEFAULT '4',
  `estado` int(11) NOT NULL,
  PRIMARY KEY (`idmenu`),
  KEY `FKmenu590668` (`areaidarea`),
  KEY `FKmenu855382` (`idmenu_rec`),
  CONSTRAINT `FKmenu590668` FOREIGN KEY (`areaidarea`) REFERENCES `area` (`idarea`),
  CONSTRAINT `FKmenu855382` FOREIGN KEY (`idmenu_rec`) REFERENCES `menu` (`idmenu`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

LOCK TABLES `menu` WRITE;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'Quienes Somos',1,'<div align=\\\'justify\\\'><font size=\\\'3\\\'>La Unidad de Salud secci&oacute;n de la Divisi&oacute;n de Bienestar Estudiantil Universitario, es una dependencia de la Universidad de San Carlos de Guatemala, creada para velar por la salud del estudiante, realiza sus actividades en funci&oacute;n de la Docencia, Investigaci&oacute;n y Servicio enfocandose en la prevenci&oacute;n de la salud.</font><br><br><font size=\\\'3\\\'>Dentro de las actividades de servicio, se encuentra la realizaci&oacute;n del examen obligatorio de salud a todos los estudiantes que ingresan a nuestra Universidad, a&ntilde;o con a&ntilde;o. Debido al incremento de esta poblaci&oacute;n, se realizan dos modalidades de examen para cubrir al 100% de los j&oacute;venes.</font><br><br><font size=\\\'3\\\'>Para nuestro control epidemiol&oacute;gico, se efect&uacute;a en el 20% de estudiantes de ingreso un examen multidisciplinario de Salud (evaluaciones m&eacute;dicas, odontol&oacute;gicas, Psicol&oacute;gicas y ex&aacute;menes de Laboratorio Cl&iacute;nico), el cual hemos denominado \'MULTIF&Aacute;SICO\'</font><br><br><font size=\\\'3\\\'>El estudiante deber&aacute; completar un cuestionario de salud y luego se le asigna una fecha para las evaluaciones medicas, las cuales incluyen: ex&aacute;men de la vista, presi&oacute;n arterial y pulso, medidas antropom&eacute;tricas, prueba de condici&oacute;n f&iacute;sica. Se les practica tambi&eacute;n una entrevista psicol&oacute;gica, una evaluaci&oacute;n odontol&oacute;gica y ex&aacute;menes de laboratorio: Hematrocr&iacute;to, tipo de sangre, heces y orina..</font><br><br><font size=\\\'3\\\'>Al 80% restante de los estudiantes se les efect&uacute;a un Cuestionario Autoadministrado de Salud, combinandolo con charlas educativas con temas de cada especialidad de salud.</font><br><br><font size=\\\'3\\\'>Tambi&eacute;n se examinan estudiantes de nivel intermedio y estudiantes de egreso, cuando la unidad acad&eacute;mica lo requiera.</font><br><br><font size=\\\'3\\\'>La actividad docente se efectua de manera pr&aacute;ctica y te&oacute;rica a estudiantes de Quimica Biol&oacute;gica, Nutrici&oacute;n, Humanidades, Ingenieria, Psicolog&iacute;a y Publicidad (Estudiantes de cuarto, quinto a&ntilde;o de las difentes carreras y estudiantes de EPS), proporcionandoles multidisciplinariamente un Programa Docente Integrado, el cual incluye temas de prevenci&oacute;n de la salud con el prop&oacute;sito de ampliar el conocimiento de los practicantes.</font><br><br><font size=\\\'3\\\'>La investigaci&oacute;n es otra de las actividades realizadas por los docentes, tanto dentro como fuera de nuestra dependencia, incluyendo tesis de grado &oacute; post grado.</font><br><br><font size=\\\'3\\\'>El &aacute;rea medica cuenta con 4 profesores m&eacute;dicos, 3 m&eacute;dicos fuera de carrera docente, 3 enfermeras, 2 tecnicos deportivos</font><br><font size=\\\'3\\\'>El &aacute;rea Psicol&oacute;gica cuenta con 4 profesores psic&oacute;logos, 1 psic&oacute;loga fuera de carrera docente.</font><br><font size=\\\'3\\\'>El &aacute;rea Odontol&oacute;gica cuenta con 1 profesor odont&oacute;logo, 2 odont&oacute;logos fuera de carrera docente, 2 asistentes.</font><br><font size=\\\'3\\\'>El Laboratorio Cl&iacute;nico cuenta con 3 profesoras Qu&iacute;micas Bi&oacute;logas, 2 Qu&iacute;micas Bi&oacute;logas fuera de carrera docente.</font><br></div>',NULL,4,1),(2,'Administraci&oacute;n',1,'<div align=\'center\'><font size=\'4\'><b>Jefatura</b><br>Licenciada MAR&Iacute;A SANDRA ARMAS DE VARGAS <br><br><b>Secretar&iacute;a</b><br><br>ROSA ELIZABETH GIR&Oacute;N DE BRAN <br>Secretaria Jefatura <br><br>IRMA YOLANDA CHANAX SARMIENTO <br>Secretaria de Recepci&oacute;n Jornada Matutina <br><br>ANNA GABRIELA MONTERROSO CABRERA <br>Secretaria de Recepci&oacute;n Jornada Vespertina <br><br>ROSA ALCIRA TRIJILIO DE FIGUEROA <br>Secretaria Archivo <br><br><b>C&oacute;mputo</b><br>Helen Lopez<br>Operadora Informatica<br><br><b>Servicios</b><br>VIRGILIO J. JOL&Oacute;N ALVIZ&Uacute;RES <br>HERLINDO V&Eacute;LIZ CATAL&Aacute;N <br>MARIO FUENTES</font></div>',NULL,4,1),(3,'Misi&oacute;n',1,'<div align=\'justify\'><font size=\'4\'><br>Detectar y contribuir a la recuperaci&oacute;n de la salud del estudiante universitario, cumpliendo a la responsabilidad de preservar y mantener sana a la poblaci&oacute;n estudiantil, basado en la creaci&oacute;n y coordinaci&oacute;n de programas confiables y efectivos que contribuyan a la prevenci&oacute;n y promoci&oacute;n de la salud integral del estudiante.</font></div>',NULL,1,1),(4,'Visi&oacute;n',1,'<div align=\'justify\'><font size=\'4\'><br>Ser la dependencia l&iacute;der, experta, confiable multiprofesional e interdisciplinaria de la Universidad de San Carlos de Guatemala, de la cual emanen las directrices en cuanto a la educaci&oacute;n, promoci&oacute;n y prevenci&oacute;n de la salud integral del estudiante universitario, que le hagan participe de las responsabilidad de adquirir conocimientos necesarios para llevar un estilo de vida sano que se traduzca en un mejor rendimiento acad&eacute;mico y cuyos programas se realicen bajo una supervisi&oacute;n directa que permita la calidad y cubran las necesidades de salud.&nbsp;</font></div>',NULL,2,1),(5,'Antecedentes',1,'<div align=\'justify\'><font size=\'4\'><br></font></div><div align=\'justify\'><font size=\'4\'><br></font></div><div align=\'justify\'><font size=\'4\'>El 10 de Octubre de 1959, el Consejo Superior Universitario, seg&uacute;n punto DECIMO CUARTO, del Acta 703, cre&oacute; el Departamento de Bienestar Estudiantil, Secci&oacute;n de Orientaci&oacute;n y Selecci&oacute;n Profesional. El 30 de julio de 1975 en el Punto CUARTO, inciso 4.4.7 del Acta 16-7 del mismo Organismo, fue aprobado el Reglamento de dicho Departamento.&nbsp;</font></div><div align=\'justify\'><font size=\'4\'><br>El 10 de noviembre de 1971, por Acuerdo de Rector&iacute;a No. 7,735 fue creada la Unidad de Salud como parte del Departamento de Bienestar Estudiantil, autorizada por el Consejo Superior Universitario en el Punto TERCERO, inciso 3.1 del Acta N&uacute;mero 1130 de fecha 13 de noviembre de 1,971.&nbsp;</font></div><div align=\'justify\'><font size=\'4\'><br>El 25 de agosto de 1981, por Acuerdo de Rector&\niacute;a No. 699-81, se le da a &eacute;ste Departamento la categor&iacute;a <br>de Divisi&oacute;nde Bienestar Estudiantil Universitario, conformada por la Secci&oacute;n<br><br></font></div><div align=\'justify\'><font size=\'4\'>Socioecon&oacute;mica, Secci&oacute;n de Orientaci&oacute;n Vocacional y Unidad de Salud. <br>El 7 de julio de 1999, se integra la Divisi&oacute;n de Bienestar Estudiantil Universitario a la estructura org&aacute;nica de la Direcci&oacute;n General de Docencia, seg&uacute;n Punto SEGUNDO del Acta No. 21-99 del Consejo Superior Universitario.&nbsp;</font></div>',NULL,4,1),(6,'Investigaci&oacute;n Docencia',1,'<div align=\'center\'><br><div align=\'center\'><font size=\'4\'>Investigaciones Multidisciplinarias de la Unidad de Salud<br><br>Programa Docente Integrado ( PDI )</font></div></div>',NULL,1,1),(7,'Quienes Somos',2,'<div style=\'font-family: Arial, Verdana; font-style: normal; font-variant: normal; line-height: normal; text-align: center; \'><b><font size=\'4\'>Cl&iacute;nica de Odontolog&iacute;a</font></b></div><div style=\'font-family: Arial, Verdana; font-style: normal; font-variant: normal; line-height: normal; text-align: center; font-weight: normal; \'><font size=\'4\'><br></font></div><div style=\'font-family: Arial, Verdana; font-style: normal; font-variant: normal; line-height: normal; text-align: center; font-weight: normal; \'><font size=\'4\'>Tus Dientes se ven m&aacute;s brillantes y se mantienen sanos si te cepillas despu&eacute;s de cada comida.&nbsp;</font></div><div style=\'font-family: Arial, Verdana; font-style: normal; font-variant: normal; line-height: normal; text-align: center; font-weight: normal; \'><font size=\'4\'><br></font></div><div style=\'font-family: Arial, Verdana; font-style: normal; font-variant: normal; line-height: normal; text-align: center; font-weight: \nnormal; \'><font size=\'4\'>Sonr&iacute;e Feliz si te cepillas correctamente usa hilo dental todos los d&iacute;as y visita al dentista cada 6 meses.</font></div><div style=\'font-family: Arial, Verdana; font-style: normal; font-variant: normal; line-height: normal; text-align: center; font-weight: normal; \'><font size=\'4\'><br></font></div><div style=\'font-family: Arial, Verdana; font-style: normal; font-variant: normal; line-height: normal; text-align: center; \'><b><font size=\'4\'>Horarios de Atenci&oacute;n</font></b></div><div style=\'font-family: Arial, Verdana; font-style: normal; font-variant: normal; line-height: normal; text-align: center; font-weight: normal; \'><font size=\'4\'>Lunes a Viernes</font></div><div style=\'font-family: Arial, Verdana; font-style: normal; font-variant: normal; line-height: normal; text-align: center; font-weight: normal; \'><font size=\'4\'>De 12:00 a 19:00 Hrs.</font></div><div style=\'text-align: center; \'><font face=\'Arial, Verdana\' size=\'4\'>S&aacute;bado</\nfont></div><div style=\'font-family: Arial, Verdana; font-style: normal; font-variant: normal; line-height: normal; text-align: center; font-weight: normal; \'><font size=\'4\'>De 8:00 a 13:00 Hrs.</font></div>',NULL,3,1),(8,'Docencia',2,'proximamente ...',NULL,1,1),(9,'Investigaci&oacute;n',2,'proximamente ....',NULL,1,1),(10,'Extensi&oacute;n',2,'proximamente ...',NULL,1,1),(11,'Quienes Somos',3,'<div align=\'justify\'><font size=\'4\'>Desde su fundaci&oacute;n la Unidad de salud cuenta entre sus \'&Aacute;reas\' de trabajo con el Laboratorio cl&iacute;nico, el que actualmente est&aacute; atendiendo por dos Qu&iacute;micas Bi&oacute;logas, una en calidad de Jefe y la otra como Profesora Auxiliar. Ambas profesionales forman parte del personal docente de dicha Unidad.<br><br></font><br></div>',NULL,2,1),(12,'Docencia',3,'<font size=\'4\'><b><font size=\'5\'>Examen Multif&aacute;sico<br></font></b><br></font><ol><li><font size=\'4\'>30% del total de estudiantes de primer ingreso de la Universidad de San Carlos, escogidos seg&uacute;n n&uacute;mero de carnet.</font></li><li><font size=\'4\'>Egresados de 6 Unidades Acad&eacute;micas de la USAC:</font></li><ol><li><font size=\'4\'>Estudiantes asignados a EPS de Ciencias Econ&oacute;micas.</font></li><li><font size=\'4\'>Estudiantes asignados a EPS de Arquitectura.</font></li><li><font size=\'4\'>Estudiantes asignados a EPS de Agronom&iacute;a</font></li><li><font size=\'4\'>Estudiantes asignados a EPS de Trabajo Social.</font></li><li><font size=\'4\'>Estudiantes que solicitan Examen P&uacute;blico de Ciencias M&eacute;dicas</font></li><li><font size=\'4\'>Estudiantes que solicitan Examen privado de Ingenier&iacute;a</font></li></ol><li><font size=\'4\'>Otros</font></li><ol><li><font size=\'4\'>Estudiantes de otros niveles acad&eacute;micos y personal que \nsolicitan el examen expresamente.</font></li></ol></ol><p><b><font size=\'5\'>Consulta Externa</font></b></p><ol><li><font size=\'4\'>Estudiantes de la USAC de cualquier nivel acad&eacute;mico</font></li><li><font size=\'4\'>Personal administrativo y docente de la USAC.</font></li><li><font size=\'4\'>Parientes de estudiantes y personal atendido por cortes&iacute;a</font></li></ol><p><br></p>',NULL,4,1),(13,'Investigaci&oacute;n',3,'<div align=\'justify\'><font size=\'5\'>Programa<br></font><br><font size=\'4\'>El programa de la Unidad de Salud constituye las experiencias docentes con la comunidad -EDC- que los estudiantes de la carrera Qu&iacute;mica Biol&oacute;gica realizan en el medio universitario y tienen como prop&oacute;sito, como una derivaci&oacute;n del proceso de ense&ntilde;anza-aprendizaje, brindar servicios de diagnostico de laboratorio cl&iacute;nico especialmente al sector estudiantil de primer ingreso a la Universidad y realizar trabajos de investigaci&oacute;n en relaci&oacute;n con la tecnolog&iacute;a del laboratorio cl&iacute;nico y los problemas de salud de la poblaci&oacute;n atendida. Su sede es la Unidad de Salud de la Universidad y se realizan en cooperaci&oacute;n con estudiantes de otras profesiones.<br></font><br><font size=\'5\'>Justificaciones<br></font><br><font size=\'4\'>Al crearse la Unidad de Salud en 1972, se establecieron como justificaciones para la participaci&\noacute;n de profesionales y estudiantes de Qu&iacute;mica Biol&oacute;gica han realizando su actividad intramuros efectuando elaboraci&oacute;n te&oacute;rica y pr&aacute;ticas \'con muestras\' de pacientes a los cuales raras vez se les conoc&iacute;a como personas o colectividades con caracter&iacute;sticas que no pueden aprenderse al investigar especimes biol&oacute;gicos que solo las identifican en una forma muy parcial y fragmentada.<br>Tales justificaciones, v&aacute;lidas en aquella &eacute;poca y que en la actualidad han sido ampliamente superadas con una diversidad de Programas de EDC incluyendo EPS, ponen de manifiesto las motivaciones esenciales docentes que originaron la participaci&oacute;n de estudiantes de Qu&iacute;mica Biol&oacute;gicas en el Laboratorio Cl&iacute;nico de la Unidad de Salud, para satisfacer intereses acad&eacute;micos de la Facultad.<br></font><br></div>',NULL,4,1),(14,'Extensi&oacute;n',3,'Proximamente...',NULL,1,1),(15,'Quienes Somos',4,'<div align=\'center\' style=\'font-size: 10pt; \'><div align=\'justify\'><font size=\'4\'>El <b>&Aacute;rea de Psicolog&iacute;a</b> de Unidad de Salud, esta comprometida en fomentar la Salud Mental del estudiante de la Universidad de San Carlos, enfoc&aacute;ndose en actividades de promoci&oacute;n de la salud.</font><br></div><font size=\'4\' style=\'font-weight: normal; \'><br><b>PROFESIONALES DEL &Aacute;REA DE PSICOLOG&Iacute;A</b><br>Licda. Ana Guadalupe P&eacute;rez Batres, M.A. <br>Psic&oacute;loga Cl&iacute;nica con Maestr&iacute;a en Educaci&oacute;n Superior. Profesora Titular X<br><br>Lic. Jorge Concepci&oacute;n Ram&iacute;rez &Aacute;lvarez, M.A.<br>Psic&oacute;logo Cl&iacute;nico e Industrial con Maestr&iacute;a en Consejer&iacute;a Cl&iacute;nica e Intervenci&oacute;n Psico-Social en Salud Mental. <br>Profesor Titular IV<br><br>Lic. V&iacute;ctor Rodolfo Comparini Estrada, M.A.<br>Psic&oacute;logo Cl&iacute;nico con Maestr&iacute;a en Psicolog&iacute;a Cl&iacute;nica \ny Salud Mental<br>Profesor Titular VI <br><br>Licda. Dora Ren&eacute; Guerra, M.A.<br>Psic&oacute;loga Cl&iacute;nica con Maestr&iacute;a en Psicolog&iacute;a Cl&iacute;nica y Salud Mental<br>Profesor Titular III<br><br>Licda. Ana Luisa Palomo Valiente<br>Psic&oacute;loga Cl&iacute;nica<br></font></div><div align=\'center\' style=\'font-weight: normal; \'><font size=\'4\'><br></font></div>',NULL,4,1),(16,'Docencia',4,'<div align=\'justify\'><font size=\'4\'>El &Aacute;rea de Psicolog&iacute;a, participa en tres programas distintos de Docencia:<br><br><b>a) Programa Docente Integrado<br></b><br>Consiste en la Docencia Presencial que a lo largo del ciclo acad&eacute;mico cada uno de los docentes del &Aacute;rea de psicolog&iacute;a ofrece al grupo de alumnos practicantes y a estudiantes que hacen el EPS en la Unidad de Salud, de acuerdo a calendarizaci&oacute;n previamente establecida por la Coordinaci&oacute;n de Docencia de la Unidad de Salud, los temas correspondientes al &aacute;rea de Psicolog&iacute;a son: Salud Mental, Patolog&iacute;as m&aacute;s frecuentes en Psicolog&iacute;a, Autoestima.<br><b><br>b) Programa Docente para los alumnos de la Escuela de Ciencias Psicol&oacute;gicas de la Universidad de San Carlos de Guatemala.<br></b><br>Siendo el &Aacute;rea de Psicolog&iacute;a de la Unidad de Salud un centro de pr&aacute;ctica para los alumnos de tercero, cuarto y quinto a&ntilde;o de la \ncarrera de Licenciatura en Psicolog&iacute;a, como apoyo a la formaci&oacute;n de dichos estudiantes y para la optimizaci&oacute;n de la atenci&oacute;n se ofrecen los siguientes programas docentes:<br><br></font><div align=\'left\'><ul><li><font size=\'4\'>    Entrevista Cl&iacute;nica<br></font></li><li><font size=\'4\'>    Psicoterapia</font></li><li><font size=\'4\'>    Psicopatolog&iacute;a</font></li><li><font size=\'4\'>    DSM IV</font></li><li><font size=\'4\'>    MMPI</font></li></ul></div><font size=\'4\'><br><b>Talleres de crecimiento y desarrollo personal<br></b></font><div align=\'justify\'><font size=\'4\'><br>Asesor&iacute;a individual para los casos de Consulta Externa que atienden los alumnos practicantes.</font><br></div><font size=\'4\'><br><b>C)Docencia General:<br></b><br>Es la docencia que reciben los profesores de la Unidad de Salud como parte de la programaci&oacute;n de las actividades de docencia de la instituci&oacute;n y consiste en participar como oyente o como disertante de \nconferencias relacionadas con un tema central seleccionado por el pleno de docentes. </font><br></div>',NULL,4,1),(17,'Investigaci&oacute;n',4,'AREA DE PSICOLOG&Iacute;A<div><br></div><div>&nbsp;</div>',NULL,3,0),(18,'Extensi&oacute;n',4,'<div align=\'justify\'><font size=\'4\'>Son todas aquellas actividades de proyecci&oacute;n a la comunidad universitaria en especial, que el &Aacute;rea de psicolog&iacute;a lleva a cabo siendo estas: Consulta Externa (Psicoterapia individual, Familiar, Pareja y Grupal) charlas de la especialidad, dentro y fuera de la Ciudad Universitaria, Evaluaciones para extender constancias a estudiantes universitarios que as&iacute; lo soliciten (previa evaluaci&oacute;n del caso).</font><br><font size=\'4\'>Atenci&oacute;n a emergencias dentro del Campus Central.</font><br><br><font size=\'4\'>Talleres de Crecimiento y Desarrollo Personal dentro y fuera del Campus Universitario.</font><br><font size=\'4\'>Las actividades que a continuaci&oacute;n se indican no tienen ning&uacute;n costo econ&oacute;mico para los miembros de la comunidad universitaria; en el caso de que personas no universitarias que expresen inter&eacute;s por recibir apoyo del &aacute;rea por medio de estas actividades, \ndeben acercarse a las oficinas y hacer la consulta respectiva con el personal ya que existe la posibilidad de recibir atenci&oacute;n por medio del concepto Cortes&iacute;a.</font></div>',NULL,3,1),(19,'Quienes Somos',5,'<div align=\'center\'><div align=\'justify\'><font size=\'4\'><br>El &aacute;rea de Medicina de Unidad de Salud, esta comprometida en velar por la salud del estudiante de la Universidad de San Carlos, enfocandose en actividades de promoci&oacute;n de la salud y prevenci&oacute;n de la enfermedad. <br><br></font></div><br><font size=\'4\'>PROFESIONALES DEL &Aacute;REA DE MEDICINA<br>Dr. M.A., MsC. RODERICO RAM&Oacute;N GUERRA OBANDO <br>Medicina Interna, Profesor titular XI<br>rguerra@usac.edu.gt<br><br>Dr. M.A. CARLOS ENRIQUE CATAL&Aacute;N G&Oacute;MEZ <br>Profesor titular X<br>carlosen@usac.edu.gt<br><br>Dr. SA&Uacute;L ERNESTO ROJAS CASTILLO <br>Profesor titular VIII<br>srojas@usac.edu.gt<br><br>Dr. MsC. DANILO OLIVERIO MORALES ANDRADE <br>Medicina Interna , Profesor titular VII <br>dmorales@usac.edu.gt<br><br>Dra. LIGIA ESTER AR&Eacute;VALO VERAS<br>Consulta Externa Jornada Matutina<br><br>Dra. RITA MARIA FIGUEROA FIGUEROA<br>Consulta Externa Jornada Vespertina<br><br>Enfermera \nMAGNOLIA ELIZABETH GUZM&Aacute;N CASTA&Ntilde;EDA<br>Consulta Externa Jornada Matutina<br><br>Enfermera AURA YOLANDA QUIROA RAM&Iacute;REZ<br>Consulta Externa Jornada Matutina<br><br>Enfermera BEATRIZ DE JESUS BACA L&Oacute;PEZ<br>Consulta Externa Jornada Vespertina<br></font><br></div>',NULL,4,1),(20,'Docencia',5,'<br><b><font size=\'5\'>DOCENCIA<br></font></b><br><div align=\'justify\'><font size=\'4\'>El &aacute;rea m&eacute;dica de Unidad de Salud realiza actividades docentes, enfoc&aacute;ndose en temas de medicina preventiva, dirigidos a estudiantes practicantes y a estudiantes que ingresan a nuestra Universidad, cre&aacute;ndose programas especificos, los cuales se detallan a continuaci&oacute;n.</font><br></div><br><b><font size=\'5\'>PROGRAMA DOCENTE INTEGRADO<br></font></b><br><div align=\'justify\'><font size=\'4\'>Este programa fue creado con el objetivo de proporcionar a los estudiantes practicantes que rotan por nuestra dependencia, conocimiento integral sobre temas de salud, enfoc&aacute;ndonos en temas preventivos y temas relacionados con estilos de vida que puedan afectar &oacute; favorecer nuestra salud. La clases magistrales son programadas de acuerdo a la rotaci&oacute;n de los estudiantes, imparti&eacute;ndose en coordinaci&oacute;n con las otras &aacute;reas profesionales, 13 \ntemas.<br></font><br><font size=\'4\'>Los temas que imparte el &aacute;rea medica son:<br>Tabaco y Salud<br>Estilos de Vida Saludable<br>Medicina Preventiva<br><br><b><font size=\'5\'>DOCENCIA A PRACTICANTES DE NUTRICI&Oacute;N<br></font></b><br>El &aacute;rea m&eacute;dica, ha contado con estudiantes practicantes de diferentes unidades acad&eacute;micas desde su creaci&oacute;n. Actualmente cuenta con estudiantes de la Escuela de Nutrici&oacute;n de la Facultad de Ciencias Qu&iacute;micas y Farmacia. Contamos con una estudiante de Ejercicio Profesional Supervisado (EPS), por un periodo de 6 meses y 3 estudiantes de EDC, por un periodo de 3 meses. Desarrollan actividdes de docencia servicio e investigaci&oacute;n.<br>Se ha desarrollado un programa de clases magistrales con temas m&eacute;dicos y nutricionales como parte del proceso de ense&ntilde;anza aprendizaje que nuestra &aacute;rea ofrece. Las clases se desarrollan durante el periodo de practica, incluyendo: Presentaci&oacute;n de casos interesantes, \npresentaci&oacute;n, discuci&oacute;n y an&aacute;lisis de articulos de revisi&oacute;n. Finalmente se imparten en el periodo, 6 clases magistrales con los siguientes temas:<br></font><ul><li><font size=\'4\'>Metabolismo de los Carbohidratos</font></li><li><font size=\'4\'>Metabolismo de las Grasas</font></li><li><font size=\'4\'>Metabolismo de las Prote&iacute;nas</font></li><li><font size=\'4\'>Obesidad</font></li><li><font size=\'4\'>Desnutrici&oacute;n</font></li><li><font size=\'4\'>Hipertesi&oacute;n Arterial y nutrici&oacute;n</font></li><li><font size=\'4\'>Diabetes, nutrici&oacute;n y aterosclerosis </font></li></ul></div>',NULL,4,1),(21,'Investigaci&oacute;n',5,'<div align=\'justify\'><font size=\'4\'><br>Es funci&oacute;n del &aacute;rea de medicina investigar los problema de salud que afectan a los estudiantes de la Universidad de San Carlos, aportar y transferir conocimiento y proponer intervenciones de salud, para solucionarlos a corto mediano &oacute; largo plazo. Se presentan estudios realizados enfocados en temas prevalentes y que consideramos importantes.&nbsp;</font></div>',NULL,1,1),(22,'Extensi&oacute;n',5,'<br><div align=\'center\'><font size=\'4\'>Ferias de Salud<br><br></font><font size=\'4\'>Jornadas Contra el tabaco</font></div> <br><div align=\'center\'><font size=\'4\'>Ferias de Salud<br><br></font><font size=\'4\'>Jornadas Contra el tabaco</font></div>',NULL,1,1),(23,'Quienes Somos',6,'<div align=\'center\' style=\'font-size: 10pt; \'><div align=\'justify\'>El &aacute;rea de Medicina de Unidad de Salud, esta comprometida en velar por la salud del estudiante de la Universidad de San Carlos, enfoc&aacute;ndose en actividades de promoci&oacute;n de la salud y prevenci&oacute;n de la enfermedad.<br></div><br><br><font size=\'4\'>Dr. Efra&iacute;n Medina, Coordinador</font></div><div align=\'center\' style=\'font-size: 10pt; \'><font size=\'4\'>Licda. Gretel Samayoa, Alianzas Estrat&eacute;gicas</font></div><div align=\'center\'><font size=\'4\'>Licda. Loida Ram&iacute;rez, Material Educativo</font></div><div align=\'center\'><font size=\'4\'>Licda. Karla de Jim&eacute;nez, Estrategia de Comunicaci&oacute;n</font></div><div align=\'center\'><font size=\'4\'>Lic. Mario Rojo, Voluntariado</font></div><div align=\'center\' style=\'font-size: 10pt; \'><font size=\'4\'><br></font></div><br>',NULL,3,1),(24,'Docencia',6,'1',NULL,0,1),(25,'Investigaci&oacute;n',6,'Proximamente ...',NULL,1,1),(26,'Extensi&oacute;n',6,'<div align=\'center\'><font size=\'5\'><br><font color=\'#000099\'><b>L&iacute;neas Estrat&eacute;gicas</b></font><br></font></div><div align=\'center\'><font size=\'4\'><br>Informaci&oacute;n y sensibilizaci&oacute;n<br>Voluntariado<br>Alianzas estrat&eacute;gicas</font></div>',NULL,1,0),(27,'Quienes Somos',7,'<div style=\'text-align: justify;\'><font size=\'4\'><br></font></div><div style=\'text-align: justify;\'><font size=\'4\'><br></font></div><div style=\'text-align: justify;\'><font size=\'4\'>El departamento de Nutrici&oacute;n es dependiente del &Aacute;rea M&eacute;dica de la Unidad de Salud, conjuntajuntamente trabaja  con la medicina preventiva, cl&iacute;nica y t&eacute;cnica deportiva. No existe  Nutricionista contratada, &uacute;nicamente se cuenta con una estudiante de EPS de la Escuela de Nutrici&oacute;n en horario convenido de 8:00 a 16:00 horas, de lunes a viernes.</font></div><div style=\'text-align: justify;\'><br></div>',NULL,2,1),(28,'Docencia',7,'<ol><li><font size=\'4\'>Talleres de Nutrici&oacute;n de Evaluaci&oacute;n del Estado Nutricional  a estudiantes, deportistas y personal que asistan a la Unidad de Salud.</font></li><li><font size=\'4\'>Actualizaci&oacute;n de la cartelera de Nutrici&oacute;n, atravez del area de docencia presentando  temas relacionados con alimentaci&oacute;n, nutrici&oacute;n y estilos de vida saludable.</font></li><li><font size=\'4\'><font face=\'Arial, Verdana\'>Apoyo&nbsp;multidisciplinario&nbsp;al area de medicina preventiva.</font></font></li><li><font size=\'4\'><font face=\'Arial, Verdana\'>Elaboraci&oacute;n de&nbsp;Investigaciones&nbsp;sobre determinados temas relacionados con salud-nutrici&oacute;n&nbsp;</font></font></li></ol><font face=\'Arial, Verdana\'>&nbsp;</font>',NULL,2,1),(29,'Investigaci&oacute;n',7,'Proximamente...',NULL,1,1),(30,'Extensi&oacute;n',7,'<div style=\'font-family: Arial, Verdana; font-style: normal; font-variant: normal; font-weight: normal; line-height: normal; font-size: 10pt; \'><font size=\'4\'><br></font></div><font size=\'4\' style=\'font-family: Arial, Verdana; font-style: normal; font-variant: normal; font-weight: normal; line-height: normal; \'><div style=\'text-align: justify; \'>&#8226; Participaci&oacute;n en  las Ferias de Salud que organiza la  Instituci&oacute;n, para as&iacute; brindar consejer&iacute;a nutricional promoviendo la cl&iacute;nica de nutrici&oacute;n a pacientes con bajo peso, sobrepeso, obesidad y otras&nbsp;patolog&iacute;as.</div></font><div><div style=\'text-align: justify;\'><font face=\'Arial, Verdana\' size=\'4\'><br></font></div><font size=\'4\' style=\'font-family: Arial, Verdana; font-style: normal; font-variant: normal; font-weight: normal; line-height: normal; \'><div style=\'text-align: justify; \'>&#8226; Coordinar con deportes una peque&ntilde;a participaci&oacute;n \ndentro de la elaboraci&oacute;n del taller de primera consulta de nutrici&oacute;n.</div><div style=\'font-size: 10pt; text-align: justify; \'><span style=\'font-size: 10pt; \'>&nbsp;</span></div></font></div>',NULL,2,1),(31,'Quienes Somos',8,'<br><br><div align=\'justify\'><font size=\'4\'>Somos un equipo especializado en la materia de la cultura fisica y el deporte, capacitados para estructurar, elaborar y trabajar distintos programas de actividad y ejercicio fisico as&iacute; tambi&eacute;n como deportivos.  Enfocados en una sola menta <br><br>VEN A LA UNIDAD DE SALUD<br><br><font size=\'3\'><b>\'MEJORAR LA SALUD Y ELIMINAR EL SEDENTARISMO EN EL ESTUDIANTE UNIVERSITARIO\'<br></b></font><b><br></b></font><div align=\'center\'><font size=\'4\'><b>David Vel&aacute;squez</b><br>T&eacute;cnico Deportivo<br>&Aacute;rea M&eacute;dica<br>USAC - BEU</font></div><br></div>',NULL,3,1),(32,'Docencia',8,'proximamente ...<br>',NULL,1,1),(33,'Investigaci&oacute;n',8,'proximamente ...&nbsp;',NULL,1,0),(34,'Extensi&oacute;n',8,'proximamente',NULL,1,1),(35,'Quienes Somos',9,'',NULL,0,0),(36,'Docencia',9,'1&nbsp;',NULL,0,1),(37,'Investigaci&oacute;n',9,'1&nbsp;',NULL,1,0),(38,'Extensi&oacute;n',9,'1',NULL,1,1),(39,'Organigrama',1,'',2,0,1),(40,'Antecedentes',6,'<div align=\'center\'><font size=\'4\'><font size=\'5\'>ANTECEDENTES:<br></font><br></font><div align=\'justify\'><ul><li><font size=\'4\'>    2004 Se cre&oacute; el Programa para la Prevenci&oacute;n de ITS, VIH y SIDA &#8211;PPIVS&#8211; en alianza la Universidad de San Carlos de Guatemala con M&eacute;dicos del Mundo.</font></li><li><font size=\'4\'>    2006 Se asign&oacute; un espacio f&iacute;sico al Programa dentro de la Unidad de Salud.</font></li><li><font size=\'4\'>    2010 Se asume la administraci&oacute;n del Programa desde la Unidad de Salud.</font></li><li><font size=\'4\'>    2011 Se incluyen nuevas tem&aacute;ticas en el Programa.</font></li></ul></div></div>',23,2,1),(41,'Programa Docente Integrado',1,'<div align=\'justify\'><font size=\'4\'>El Programa Docente Integrado fue creado y estructurado por los profesores de la Unidad de Salud para ser desarrollado con los estudiantes practicantes durante el tiempo que los asignen las unidades acad&eacute;micas a esta Unidad. <br><br><b>DESCRIPCI&Oacute;N: <br></b>El PDI engloba conocimientos te&oacute;ricos-pr&aacute;cticos sobre prevenci&oacute;n en salud que los estudiantes practicantes de la Unidad de Salud, han de adquirir como parte de su formaci&oacute;n cient&iacute;fica. <br><br>Dentro de este proceso de ense&ntilde;anza-aprendizaje el estudiante conocer&aacute; aspectos generales de promoci&oacute;n de la salud y prevenci&oacute;n de la enfermedad, adquirir&aacute; habilidades diagn&oacute;sticas de detecci&oacute;n temprana, con una visi&oacute;n multidisciplinaria del ser humano. Se refrescar&aacute;n aspectos b&aacute;sicos sobre investigaci&oacute;n relacionados a circunstancias de salud-enfermedad de nuestra \npoblaci&oacute;n. <br>Las actividades se desarrollan una vez por semana en horario de 8:15 a 9:00 horas. <br><br><b>FINALIDAD: <br></b>Su finalidad, adem&aacute;s de la docencia espec&iacute;fica requerida seg&uacute;n los programas elaborados conjuntamente con las unidades acad&eacute;micas, impartida por cada una de las &aacute;reas, el estudiante adquiera conocimientos de disciplinas afines. <br>Al mismo tiempo que lograr&aacute; que las diferentes &aacute;reas trabajen en conjunto y se realicen actividades de prevenci&oacute;n y atenci&oacute;n en salud en forma integral. <br><br><b>OBJETIVOS: <br></b>1) Fomentar en el estudiante practicante una visi&oacute;n integral y multidisciplinaria de la salud del ser humano. <br>2) Generar en el estudiante actitudes y acciones permanentes de promoci&oacute;n y prevenci&oacute;n en salud.<br>3) Propiciar una mejora continua en la calidad de vida del estudiante universitario y su entorno.</font></div>',6,4,1),(42,'Investigaciones de multidisciplinarias de la UDS',1,'<br>',6,0,1),(44,'Examen de Salud',1,'<font size=\'4\' style=\'font-size: 10pt; \'><b><br><br>PASOS PARA GENERAR BOLETA DE PAGO DE EXAMEN DE SALUD:<br></b></font><br><ul><li style=\'font-size: 10pt; \'><font size=\'4\'>Ingresa a la PAGINA <a href=\'http://estudiante.usac.edu.gt/pagousac/faces/menu/sgi_inicio.jsp\'>GESTOR DE PAGOS</a></font></li><li style=\'font-size: 10pt; \'><font size=\'4\'>Ingresa su USUARIO (No. de Carn&eacute;) Y PASSWORD (No sabe su pin recup&eacute;relo En <a href=\'http://www.registro.usac.edu.gt/\'>click aqu&iacute;</a>,&nbsp;reingreso, anotar no.carn&eacute; y fecha de nacimiento.</font></li><li style=\'font-size: 10pt; \'><font size=\'4\'>Siguiente</font></li><li style=\'font-size: 10pt; \'><font size=\'4\'>Seleccione examen de salud 2012</font></li><li style=\'font-size: 10pt; \'><font size=\'4\'>Agregar pago</font></li><li style=\'font-size: 10pt; \'><font size=\'4\'>Generar orden de pago</font></li><li style=\'font-size: 10pt; \'><font size=\'4\'>Cancelar en G&amp;T o Banrural</font></\nli><li style=\'font-size: 10pt; \'><span style=\'font-size: large; \'>Ven a la Unidad de a pedir tu cita</span></li></ul><p align=\'justify\' style=\'font-size: 10pt; \'><font size=\'4\'><br></font></p><p align=\'justify\' style=\'font-size: 10pt; \'><font size=\'4\'>NOTA: Se le extender&aacute; una tarjeta que debe presentarla para su reinscripci&oacute;n y cada vez que solicite consulta m&eacute;dica, psicol&oacute;gica y odontol&oacute;gica. <br></font></p><p align=\'justify\' style=\'font-size: 10pt; \'><font size=\'4\'>Por favor informar a sus compa&ntilde;eros de primer a&ntilde;o sobre esta evaluaci&oacute;n en salud, para que esten efect&uacute;en el examen.</font></p><p style=\'font-size: 10pt; \'><br></p>',NULL,4,1),(45,'Trifoliar Informativo',1,'',1,0,1),(46,'Clases de aerobicos',8,'<div style=\'text-align: center;\'><span style=\'font-size: large; \'>VEN A LA UNIDAD DE SALUD A RECIBIR TUS CLASES</span></div><div style=\'font-size: 10pt; \'><br></div>',31,1,1),(47,'jornada contra el tabaco',5,'hola como estas',22,1,1);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pregunta_paciente`
--

DROP TABLE IF EXISTS `pregunta_paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pregunta_paciente` (
  `idpregunta` int(10) NOT NULL,
  `idpaciente` int(20) NOT NULL,
  `respuesta` varchar(150) DEFAULT NULL,
  `cantidad` int(10) DEFAULT NULL,
  PRIMARY KEY (`idpregunta`,`idpaciente`),
  KEY `FKpregunta_p614670` (`idpregunta`),
  KEY `FKpregunta_p675932` (`idpaciente`),
  CONSTRAINT `FKpregunta_p675932` FOREIGN KEY (`idpaciente`) REFERENCES `paciente` (`idpaciente`),
  CONSTRAINT `pregunta_paciente_ibfk_1` FOREIGN KEY (`idpregunta`) REFERENCES `pregunta` (`idpregunta`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pregunta_paciente`
--

LOCK TABLES `pregunta_paciente` WRITE;
/*!40000 ALTER TABLE `pregunta_paciente` DISABLE KEYS */;
INSERT INTO `pregunta_paciente` VALUES (128,101,NULL,NULL),(128,102,NULL,NULL),(128,103,NULL,NULL),(128,104,NULL,NULL),(129,101,NULL,NULL),(129,102,NULL,NULL),(129,103,NULL,NULL),(129,104,NULL,NULL),(130,101,NULL,NULL),(130,102,NULL,NULL),(130,103,NULL,NULL),(130,104,NULL,NULL),(136,101,NULL,NULL),(136,103,NULL,NULL),(137,101,NULL,0),(137,103,NULL,0),(138,101,NULL,0),(138,103,NULL,0),(139,101,NULL,0),(139,103,NULL,0),(140,101,NULL,0),(140,103,NULL,0),(151,101,NULL,NULL),(151,103,NULL,NULL),(152,101,NULL,NULL),(152,103,NULL,NULL),(153,101,NULL,NULL),(153,103,NULL,NULL),(154,101,NULL,NULL),(154,103,NULL,NULL),(155,101,NULL,NULL),(155,103,NULL,NULL),(157,101,NULL,NULL),(157,103,NULL,NULL),(160,101,NULL,NULL),(160,103,NULL,NULL),(160,104,NULL,NULL),(161,101,NULL,NULL),(161,103,NULL,NULL),(161,104,NULL,NULL),(162,101,NULL,NULL),(162,102,NULL,NULL),(162,103,NULL,NULL),(162,104,NULL,NULL),(163,101,NULL,NULL),(163,103,NULL,NULL),(164,101,NULL,NULL),(164,103,NULL,NULL),(165,101,NULL,NULL),(165,103,NULL,NULL),(167,101,NULL,NULL),(167,103,NULL,NULL),(169,101,NULL,NULL),(169,103,NULL,NULL),(170,101,NULL,NULL),(170,103,NULL,NULL),(171,101,NULL,NULL),(171,103,NULL,NULL),(175,101,NULL,NULL),(175,103,NULL,NULL),(176,101,NULL,NULL),(176,103,NULL,NULL),(183,101,NULL,NULL),(183,103,NULL,NULL),(185,101,NULL,NULL),(185,103,NULL,NULL),(186,101,NULL,NULL),(186,103,NULL,NULL),(187,101,NULL,NULL),(187,103,NULL,NULL),(188,101,NULL,NULL),(188,103,NULL,NULL),(189,101,NULL,NULL),(189,103,NULL,NULL),(190,101,NULL,NULL),(190,103,NULL,NULL),(191,101,NULL,NULL),(191,103,NULL,NULL),(193,101,NULL,NULL),(193,103,NULL,NULL),(194,101,NULL,NULL),(194,103,NULL,NULL),(195,101,NULL,NULL),(195,103,NULL,NULL),(196,101,NULL,NULL),(196,103,NULL,NULL),(197,101,NULL,NULL),(197,102,NULL,NULL),(197,103,NULL,NULL),(197,104,NULL,NULL),(198,101,NULL,NULL),(198,102,NULL,NULL),(198,103,NULL,NULL),(198,104,NULL,NULL),(199,101,NULL,NULL),(199,102,NULL,NULL),(199,103,NULL,NULL),(199,104,NULL,NULL),(200,101,'',NULL),(200,102,'Conduccion Sinfónica',NULL),(200,103,'otra',NULL),(200,104,'',NULL),(210,101,NULL,NULL),(210,103,NULL,NULL),(210,104,NULL,NULL),(211,101,NULL,NULL),(211,103,NULL,NULL),(211,104,NULL,NULL),(212,101,NULL,NULL),(212,103,NULL,NULL),(212,104,NULL,NULL),(213,101,NULL,NULL),(213,103,NULL,NULL),(213,104,NULL,NULL),(214,101,NULL,NULL),(214,103,NULL,NULL),(214,104,NULL,NULL),(215,101,NULL,NULL),(215,103,NULL,NULL),(215,104,NULL,NULL),(216,101,NULL,NULL),(216,103,NULL,NULL),(216,104,NULL,NULL),(217,101,NULL,NULL),(217,103,NULL,NULL),(217,104,NULL,NULL),(218,101,NULL,NULL),(218,103,NULL,NULL),(218,104,NULL,NULL),(219,101,NULL,NULL),(219,103,NULL,NULL),(219,104,NULL,NULL),(220,101,NULL,NULL),(220,103,NULL,NULL),(221,101,NULL,NULL),(221,103,NULL,NULL),(222,101,NULL,NULL),(222,103,NULL,NULL),(223,103,NULL,NULL),(224,101,NULL,NULL),(225,101,NULL,NULL),(226,101,NULL,NULL),(227,101,NULL,NULL),(227,103,NULL,NULL),(228,101,NULL,NULL),(228,103,NULL,NULL),(229,101,NULL,NULL),(229,103,NULL,NULL),(230,101,NULL,NULL),(230,103,NULL,NULL),(231,101,NULL,NULL),(231,103,NULL,NULL),(232,101,NULL,NULL),(232,103,NULL,NULL),(233,101,NULL,NULL),(233,103,NULL,NULL),(234,101,NULL,NULL),(234,102,NULL,NULL),(234,103,NULL,NULL),(234,104,NULL,NULL),(235,101,NULL,NULL),(235,102,NULL,NULL),(235,103,NULL,NULL),(235,104,NULL,NULL),(236,101,NULL,NULL),(236,102,NULL,NULL),(236,103,NULL,NULL),(236,104,NULL,NULL),(237,101,NULL,NULL),(237,102,NULL,NULL),(237,103,NULL,NULL),(237,104,NULL,NULL),(238,101,NULL,NULL),(238,102,NULL,NULL),(238,103,NULL,NULL),(238,104,NULL,NULL),(239,101,NULL,NULL),(239,102,NULL,NULL),(239,103,NULL,NULL),(239,104,NULL,NULL),(240,101,NULL,NULL),(240,102,NULL,NULL),(240,103,NULL,NULL),(240,104,NULL,NULL),(241,101,NULL,NULL),(241,102,NULL,NULL),(241,103,NULL,NULL),(241,104,NULL,NULL),(242,101,NULL,NULL),(242,102,NULL,NULL),(242,103,NULL,NULL),(242,104,NULL,NULL),(243,101,NULL,NULL),(243,102,NULL,NULL),(243,103,NULL,NULL),(243,104,NULL,NULL),(244,101,NULL,NULL),(244,102,NULL,NULL),(244,103,NULL,NULL),(244,104,NULL,NULL),(245,101,NULL,NULL),(245,102,NULL,NULL),(245,103,NULL,NULL),(245,104,NULL,NULL),(246,101,NULL,NULL),(246,102,NULL,NULL),(246,103,NULL,NULL),(246,104,NULL,NULL),(247,101,NULL,NULL),(247,102,NULL,NULL),(247,103,NULL,NULL),(247,104,NULL,NULL),(248,101,NULL,NULL),(248,102,NULL,NULL),(248,103,NULL,NULL),(248,104,NULL,NULL),(249,101,NULL,NULL),(249,102,NULL,NULL),(249,103,NULL,NULL),(249,104,NULL,NULL),(250,101,NULL,NULL),(250,102,NULL,NULL),(250,103,NULL,NULL),(250,104,NULL,NULL),(251,101,NULL,NULL),(251,102,NULL,NULL),(251,103,NULL,NULL),(251,104,NULL,NULL),(252,101,NULL,NULL),(252,102,NULL,NULL),(252,103,NULL,NULL),(252,104,NULL,NULL),(253,101,NULL,NULL),(253,102,NULL,NULL),(253,103,NULL,NULL),(253,104,NULL,NULL),(254,101,NULL,NULL),(254,102,NULL,NULL),(254,103,NULL,NULL),(254,104,NULL,NULL),(255,101,NULL,NULL),(255,102,NULL,NULL),(255,103,NULL,NULL),(255,104,NULL,NULL),(256,101,NULL,NULL),(256,102,NULL,NULL),(256,103,NULL,NULL),(256,104,NULL,NULL),(257,101,NULL,NULL),(257,102,NULL,NULL),(257,103,NULL,NULL),(257,104,NULL,NULL),(258,101,NULL,NULL),(258,102,NULL,NULL),(258,103,NULL,NULL),(258,104,NULL,NULL),(259,101,NULL,NULL),(259,102,NULL,NULL),(259,103,NULL,NULL),(259,104,NULL,NULL),(260,101,NULL,NULL),(260,102,NULL,NULL),(260,103,NULL,NULL),(260,104,NULL,NULL),(261,101,NULL,NULL),(261,102,NULL,NULL),(261,103,NULL,NULL),(261,104,NULL,NULL),(262,101,NULL,NULL),(262,102,NULL,NULL),(262,103,NULL,NULL),(262,104,NULL,NULL),(263,101,NULL,NULL),(263,102,NULL,NULL),(263,103,NULL,NULL),(263,104,NULL,NULL),(264,101,NULL,NULL),(264,102,NULL,NULL),(264,103,NULL,NULL),(264,104,NULL,NULL),(265,101,NULL,NULL),(265,102,NULL,NULL),(265,103,NULL,NULL),(265,104,NULL,NULL),(266,101,NULL,NULL),(266,102,NULL,NULL),(266,103,NULL,NULL),(266,104,NULL,NULL),(267,101,'',NULL),(267,102,'Epival',NULL),(267,103,'',NULL),(267,104,'',NULL),(268,101,'',NULL),(268,102,'',NULL),(268,103,'soy feliz',NULL),(268,104,'',NULL),(269,101,NULL,NULL),(269,102,NULL,NULL),(269,103,NULL,NULL),(269,104,NULL,NULL),(270,101,NULL,NULL),(270,102,NULL,NULL),(270,103,NULL,NULL),(270,104,NULL,NULL),(271,101,NULL,NULL),(271,102,NULL,NULL),(271,103,NULL,NULL),(271,104,NULL,NULL),(272,101,NULL,NULL),(272,102,NULL,NULL),(272,103,NULL,NULL),(272,104,NULL,NULL),(273,101,NULL,NULL),(273,103,NULL,NULL),(273,104,NULL,NULL),(274,101,NULL,NULL),(274,103,NULL,NULL),(274,104,NULL,NULL),(275,101,NULL,NULL),(275,103,NULL,NULL),(275,104,NULL,NULL),(276,101,NULL,NULL),(276,103,NULL,NULL),(276,104,NULL,NULL),(277,101,NULL,NULL),(277,103,NULL,NULL),(277,104,NULL,NULL),(278,101,NULL,NULL),(278,103,NULL,NULL),(278,104,NULL,NULL),(279,101,NULL,NULL),(279,103,NULL,NULL),(280,101,NULL,NULL),(280,103,NULL,NULL),(281,101,NULL,NULL),(281,103,NULL,NULL),(282,101,NULL,NULL),(282,103,NULL,NULL),(283,101,NULL,NULL),(283,103,NULL,NULL),(284,101,NULL,NULL),(284,103,NULL,NULL),(285,101,NULL,NULL),(285,103,NULL,NULL),(286,101,NULL,NULL),(286,103,NULL,NULL),(287,101,NULL,NULL),(287,103,NULL,NULL),(288,101,NULL,NULL),(288,103,NULL,NULL),(289,101,NULL,NULL),(289,103,NULL,NULL),(290,101,NULL,NULL),(290,103,NULL,NULL),(291,101,NULL,NULL),(291,103,NULL,NULL),(292,101,NULL,NULL),(292,103,NULL,NULL),(293,101,NULL,NULL),(293,103,NULL,NULL),(294,103,NULL,NULL),(295,103,NULL,NULL),(296,101,NULL,NULL),(297,101,NULL,NULL),(298,101,NULL,NULL),(299,101,NULL,NULL),(301,101,NULL,NULL),(302,101,NULL,NULL),(303,101,NULL,NULL),(303,103,NULL,NULL),(304,101,NULL,NULL),(304,103,NULL,NULL),(305,101,NULL,NULL),(305,103,NULL,NULL),(306,101,NULL,NULL),(306,103,NULL,NULL),(307,101,NULL,NULL),(307,103,NULL,NULL),(308,101,NULL,NULL),(308,103,NULL,NULL),(309,101,NULL,NULL),(309,102,NULL,NULL),(309,103,NULL,NULL),(310,101,NULL,NULL),(310,102,NULL,NULL),(310,103,NULL,NULL),(311,101,NULL,NULL),(311,102,NULL,NULL),(311,103,NULL,NULL),(312,101,NULL,NULL),(312,102,NULL,NULL),(312,103,NULL,NULL),(313,102,NULL,NULL),(313,103,NULL,NULL),(314,101,NULL,NULL),(314,102,NULL,NULL),(314,103,NULL,NULL),(315,101,NULL,NULL),(315,102,NULL,NULL),(315,103,NULL,NULL),(316,101,NULL,NULL),(316,102,NULL,NULL),(316,103,NULL,NULL),(316,104,NULL,NULL),(317,101,NULL,NULL),(317,102,NULL,NULL),(317,103,NULL,NULL),(317,104,NULL,NULL),(318,101,NULL,NULL),(318,102,NULL,NULL),(318,103,NULL,NULL),(318,104,NULL,NULL),(319,101,NULL,NULL),(319,102,NULL,NULL),(319,103,NULL,NULL),(319,104,NULL,NULL),(321,101,NULL,NULL),(321,102,NULL,NULL),(321,103,NULL,NULL),(321,104,NULL,NULL),(322,101,NULL,NULL),(322,102,NULL,NULL),(322,103,NULL,NULL),(322,104,NULL,NULL),(323,101,NULL,NULL),(323,102,NULL,NULL),(323,103,NULL,NULL),(323,104,NULL,NULL),(324,101,NULL,NULL),(324,102,NULL,NULL),(324,103,NULL,NULL),(324,104,NULL,NULL),(325,101,NULL,NULL),(325,102,NULL,NULL),(325,103,NULL,NULL),(325,104,NULL,NULL),(326,101,NULL,NULL),(326,102,NULL,NULL),(326,103,NULL,NULL),(326,104,NULL,NULL);
/*!40000 ALTER TABLE `pregunta_paciente` ENABLE KEYS */;
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
  `tamanio` longtext NOT NULL,
  `usuarioidusuario` int(10) NOT NULL,
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tipo` int(11) NOT NULL DEFAULT '1' COMMENT '1-> imagen 2-> pdf',
  PRIMARY KEY (`idmultimedia`),
  KEY `FKmultimedia696932` (`usuarioidusuario`),
  CONSTRAINT `FKmultimedia696932` FOREIGN KEY (`usuarioidusuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `multimedia`
--

LOCK TABLES `multimedia` WRITE;
/*!40000 ALTER TABLE `multimedia` DISABLE KEYS */;
INSERT INTO `multimedia` VALUES (14,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/8dsc02695.jpg','images/upload/imagen/8dsc02695.jpg','27599',1,'2012-04-26 21:26:36',1),(15,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/9dsc02696.jpg','images/upload/imagen/9dsc02696.jpg','28349',1,'2012-04-26 21:26:46',1),(16,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/10dsc02702.jpg','images/upload/imagen/10dsc02702.jpg','28587',1,'2012-04-26 21:26:55',1),(17,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/11dscn3713.jpg','images/upload/imagen/11dscn3713.jpg','24704',1,'2012-04-26 21:27:17',1),(18,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/12dscn1298.jpg','images/upload/imagen/12dscn1298.jpg','27174',1,'2012-04-26 21:27:26',1),(19,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/13dsc02712.jpg','images/upload/imagen/13dsc02712.jpg','29148',1,'2012-04-26 21:27:33',1),(20,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/14dsc02710.jpg','images/upload/imagen/14dsc02710.jpg','28695',1,'2012-04-26 21:27:45',1),(21,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/15dsc02708.jpg','images/upload/imagen/15dsc02708.jpg','29030',1,'2012-04-26 21:27:56',1),(22,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/16dsc02700.jpg','images/upload/imagen/16dsc02700.jpg','27619',1,'2012-04-26 21:35:15',1),(23,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/17dsc02702.jpg','images/upload/imagen/17dsc02702.jpg','28587',1,'2012-04-26 21:35:22',1),(24,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/18dsc02703.jpg','images/upload/imagen/18dsc02703.jpg','29265',1,'2012-04-26 21:35:30',1),(25,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/19dsc02704.jpg','images/upload/imagen/19dsc02704.jpg','29381',1,'2012-04-26 21:35:37',1),(40,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/34dsc02691.jpg','images/upload/imagen/34dsc02691.jpg','137415',1,'2012-04-26 21:54:50',1),(41,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/35dsc02695.jpg','images/upload/imagen/35dsc02695.jpg','141470',1,'2012-04-26 21:55:06',1),(42,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/36dsc02706.jpg','images/upload/imagen/36dsc02706.jpg','143809',1,'2012-04-26 21:55:15',1),(43,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/37dscn1836.jpg','images/upload/imagen/37dscn1836.jpg','30617',1,'2012-04-26 21:56:13',1),(44,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/38dscn1836.jpg','images/upload/imagen/38dscn1836.jpg','30617',1,'2012-04-26 21:56:38',1),(45,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/39dscn2452.jpg','images/upload/imagen/39dscn2452.jpg','30042',1,'2012-04-26 21:56:48',1),(46,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/40dscn3713.jpg','images/upload/imagen/40dscn3713.jpg','24704',1,'2012-04-26 21:56:56',1),(47,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/41dsc02696.jpg','images/upload/imagen/41dsc02696.jpg','28349',1,'2012-04-26 21:57:31',1),(48,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/42organigrama.png','images/upload/imagen/42organigrama.png','98765',1,'2012-04-26 22:56:17',1),(49,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/4328tabaquismo.pdf','images/upload/pdf/4328tabaquismo.pdf','45557',1,'2012-04-27 02:04:48',2),(50,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/4429prueba_harvard.pdf','images/upload/pdf/4429prueba_harvard.pdf','276609',1,'2012-04-27 02:05:50',2),(51,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/4530gradadeharvard2006.pdf','images/upload/pdf/4530gradadeharvard2006.pdf','85001',1,'2012-04-27 02:07:04',2),(52,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/4631acuerdo_tabaquismo.pdf','images/upload/pdf/4631acuerdo_tabaquismo.pdf','36188',1,'2012-04-27 02:07:59',2),(53,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/4732calidad_vida.pdf','images/upload/pdf/4732calidad_vida.pdf','194262',1,'2012-04-27 02:09:16',2),(54,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/4833acuerdo_de_rectoria.pdf','images/upload/pdf/4833acuerdo_de_rectoria.pdf','589846',1,'2012-04-27 02:10:12',2),(55,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/49docencia.png','images/upload/imagen/49docencia.png','477054',1,'2012-04-27 03:07:52',1),(56,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/50afichemayo2012.pdf','images/upload/pdf/50afichemayo2012.pdf','207459',1,'2012-04-27 04:59:24',2),(57,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/51jefes_uds.jpg','images/upload/imagen/51jefes_uds.jpg','50590',1,'2012-04-27 05:12:43',1),(58,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/5224glicemia.pdf','images/upload/pdf/5224glicemia.pdf','112713',1,'2012-04-27 05:26:45',2),(59,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/5325calidad2.pdf','images/upload/pdf/5325calidad2.pdf','413556',1,'2012-04-27 05:27:39',2),(60,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/5426autoevaluacion.pdf','images/upload/pdf/5426autoevaluacion.pdf','538956',1,'2012-04-27 05:28:55',2),(61,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/5527ayuno_14horas.pdf','images/upload/pdf/5527ayuno_14horas.pdf','87090',1,'2012-04-27 05:29:44',2),(62,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/4035p1.pdf','images/upload/pdf/4035p1.pdf','45247',1,'2012-04-27 06:39:45',2),(63,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/4137p2.pdf','images/upload/pdf/4137p2.pdf','45010',1,'2012-04-27 06:40:35',2),(64,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/4238p3.pdf','images/upload/pdf/4238p3.pdf','45104',1,'2012-04-27 06:41:10',2),(65,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/4339p4.pdf','images/upload/pdf/4339p4.pdf','45121',1,'2012-04-27 06:41:50',2),(66,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/4440p5.pdf','images/upload/pdf/4440p5.pdf','45294',1,'2012-04-27 06:42:27',2),(67,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/4541p6.pdf','images/upload/pdf/4541p6.pdf','45502',1,'2012-04-27 06:43:22',2),(68,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/4645p8.pdf','images/upload/pdf/4645p8.pdf','45007',1,'2012-04-27 06:48:19',2),(69,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/4744p9.pdf','images/upload/pdf/4744p9.pdf','44946',1,'2012-04-27 06:49:08',2),(70,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/4846p7.pdf','images/upload/pdf/4846p7.pdf','45058',1,'2012-04-27 06:49:54',2),(71,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/49dsc02710.jpg','images/upload/imagen/49dsc02710.jpg','28695',2,'2012-04-27 12:40:08',1),(72,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/50dscn0131.jpg','images/upload/imagen/50dscn0131.jpg','71511',3,'2012-04-27 14:45:27',1),(73,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/51dscn0141.jpg','images/upload/imagen/51dscn0141.jpg','76978',3,'2012-04-27 14:46:33',1),(74,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/52dscn1149.jpg','images/upload/imagen/52dscn1149.jpg','29346',3,'2012-04-27 14:46:43',1),(75,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/53dscn1191.jpg','images/upload/imagen/53dscn1191.jpg','27806',3,'2012-04-27 14:46:57',1),(76,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/54dscn1207.jpg','images/upload/imagen/54dscn1207.jpg','28458',3,'2012-04-27 14:47:04',1),(77,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/55dscn1265.jpg','images/upload/imagen/55dscn1265.jpg','27514',3,'2012-04-27 14:47:13',1),(78,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/56dscn2382.jpg','images/upload/imagen/56dscn2382.jpg','22111',3,'2012-04-27 14:47:21',1),(79,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/57dscn3669.jpg','images/upload/imagen/57dscn3669.jpg','20966',3,'2012-04-27 14:47:34',1),(81,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/59dscn1921-copy.jpg','images/upload/imagen/59dscn1921-copy.jpg','152427',3,'2012-04-27 15:07:50',1),(91,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/54mypdf.pdf','images/upload/pdf/54mypdf.pdf','960305',1,'2012-04-30 15:39:59',2),(92,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/55mypdf.pdf','images/upload/pdf/55mypdf.pdf','92711',4,'2012-05-02 15:24:56',2),(94,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/57myimagen.jpg','images/upload/imagen/57myimagen.jpg','97103',4,'2012-05-02 15:26:43',1),(116,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/66myimagen.jpg','images/upload/imagen/66myimagen.jpg','145127',1,'2012-05-04 20:19:36',1),(127,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/69myimagen.jpg','images/upload/imagen/69myimagen.jpg','24704',1,'2012-05-07 13:46:42',1),(152,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/72usalud1336404478917.jpg','images/upload/imagen/72usalud1336404478917.jpg','33747',1,'2012-05-07 15:27:58',1),(153,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/73usalud1336404486753.jpg','images/upload/imagen/73usalud1336404486753.jpg','27360',1,'2012-05-07 15:28:06',1),(154,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/74usalud1336404495478.jpg','images/upload/imagen/74usalud1336404495478.jpg','32688',1,'2012-05-07 15:28:15',1),(155,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/75usalud1336404503128.jpg','images/upload/imagen/75usalud1336404503128.jpg','34148',1,'2012-05-07 15:28:23',1),(157,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/77usalud1336404597864.jpg','images/upload/imagen/77usalud1336404597864.jpg','186094',1,'2012-05-07 15:29:57',1),(158,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/78usalud1336404612299.jpg','images/upload/imagen/78usalud1336404612299.jpg','175883',1,'2012-05-07 15:30:12',1),(159,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/79usalud1336404694432.jpg','images/upload/imagen/79usalud1336404694432.jpg','139880',1,'2012-05-07 15:31:34',1),(160,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/80usalud1336404710894.jpg','images/upload/imagen/80usalud1336404710894.jpg','147111',1,'2012-05-07 15:31:50',1),(161,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/81usalud1336404723689.jpg','images/upload/imagen/81usalud1336404723689.jpg','135934',1,'2012-05-07 15:32:03',1),(162,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/82usalud1336404736207.jpg','images/upload/imagen/82usalud1336404736207.jpg','133383',1,'2012-05-07 15:32:16',1),(163,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/83usalud1336404753225.jpg','images/upload/imagen/83usalud1336404753225.jpg','141470',1,'2012-05-07 15:32:33',1),(164,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/84usalud1336404784739.jpg','images/upload/imagen/84usalud1336404784739.jpg','142732',1,'2012-05-07 15:33:04',1),(165,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/85usalud1336404864139.jpg','images/upload/imagen/85usalud1336404864139.jpg','30151',1,'2012-05-07 15:34:24',1),(167,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/76usalud1336417820432.jpg','images/upload/imagen/76usalud1336417820432.jpg','138394',1,'2012-05-07 19:10:20',1),(169,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/78usalud1336483882426.jpg','images/upload/imagen/78usalud1336483882426.jpg','13124',1,'2012-05-08 13:31:22',1),(170,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/79usalud1336483891099.jpg','images/upload/imagen/79usalud1336483891099.jpg','16077',1,'2012-05-08 13:31:31',1),(171,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/80usalud1336484150716.jpg','images/upload/imagen/80usalud1336484150716.jpg','29262',1,'2012-05-08 13:35:50',1),(172,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/76usalud1336581445124.jpg','images/upload/imagen/76usalud1336581445124.jpg','82925',8,'2012-05-09 16:37:25',1),(173,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/77usalud1336581592696.pdf','images/upload/pdf/77usalud1336581592696.pdf','82515',8,'2012-05-09 16:39:52',2),(174,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/78usalud1336583122695.pdf','images/upload/pdf/78usalud1336583122695.pdf','2389052',8,'2012-05-09 17:05:22',2),(175,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/79usalud1337185846887.jpg','images/upload/imagen/79usalud1337185846887.jpg','59459',5,'2012-05-16 16:30:46',1),(176,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/80usalud1337185964036.jpg','images/upload/imagen/80usalud1337185964036.jpg','59459',5,'2012-05-16 16:32:44',1),(177,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/81usalud1337186051585.jpg','images/upload/imagen/81usalud1337186051585.jpg','59459',5,'2012-05-16 16:34:11',1),(178,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/82usalud1337186147646.jpg','images/upload/imagen/82usalud1337186147646.jpg','50624',5,'2012-05-16 16:35:47',1),(179,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/83usalud1337186347700.jpg','images/upload/imagen/83usalud1337186347700.jpg','59459',5,'2012-05-16 16:39:07',1),(180,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/84usalud1337186389393.jpg','images/upload/imagen/84usalud1337186389393.jpg','50624',5,'2012-05-16 16:39:49',1),(181,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/85usalud1337285638920.jpg','images/upload/imagen/85usalud1337285638920.jpg','60998',9,'2012-05-17 20:13:58',1),(182,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/86usalud1337285811786.jpg','images/upload/imagen/86usalud1337285811786.jpg','62409',9,'2012-05-17 20:16:51',1),(183,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/87usalud1337285828145.jpg','images/upload/imagen/87usalud1337285828145.jpg','59455',9,'2012-05-17 20:17:08',1),(184,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/88usalud1337285898362.pdf','images/upload/pdf/88usalud1337285898362.pdf','97675',9,'2012-05-17 20:18:18',2),(185,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/89usalud1337285994909.pdf','images/upload/pdf/89usalud1337285994909.pdf','24818',9,'2012-05-17 20:19:54',2),(186,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/imagen/90usalud1337286095545.jpg','images/upload/imagen/90usalud1337286095545.jpg','152475',9,'2012-05-17 20:21:35',1),(187,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/91usalud1337883364750.pdf','images/upload/pdf/91usalud1337883364750.pdf','208142',1,'2012-05-24 18:16:04',2),(188,'/usr/share/apache-tomcat-7.0.27/webapps/websalud/images/upload/pdf/92usalud1337893754658.pdf','images/upload/pdf/92usalud1337893754658.pdf','893099',10,'2012-05-24 21:09:14',2),(189,'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\ROOT\\images/upload/imagen/93usalud1338750147550.png','images/upload/imagen/93usalud1338750147550.png','301454',1,'2012-06-03 19:02:27',1),(190,'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\ROOT\\images/upload/pdf/94usalud1338750299496.pdf','images/upload/pdf/94usalud1338750299496.pdf','12195',1,'2012-06-03 19:04:59',2),(191,'C:\\Program Files\\Apache Software Foundation\\Tomcat 7.0\\webapps\\ROOT\\images/upload/pdf/95usalud1338750613864.pdf','images/upload/pdf/95usalud1338750613864.pdf','109147',1,'2012-06-03 19:10:13',2);
/*!40000 ALTER TABLE `multimedia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paciente_menu_categoria`
--

DROP TABLE IF EXISTS `paciente_menu_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paciente_menu_categoria` (
  `idpaciente` int(20) NOT NULL,
  `idmenu_categoria` int(11) NOT NULL,
  `auto_evaluacion` int(11) DEFAULT NULL,
  `multifasico` int(11) DEFAULT NULL,
  PRIMARY KEY (`idpaciente`,`idmenu_categoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paciente_menu_categoria`
--

LOCK TABLES `paciente_menu_categoria` WRITE;
/*!40000 ALTER TABLE `paciente_menu_categoria` DISABLE KEYS */;
INSERT INTO `paciente_menu_categoria` VALUES (17,1,0,1),(17,17,0,1),(17,18,0,1),(17,19,0,1),(17,20,0,1),(17,21,0,1),(17,22,0,1),(17,24,0,1),(17,25,0,1),(17,26,0,1),(17,27,0,1),(17,28,0,1),(17,29,0,1),(17,30,0,1),(17,31,0,1),(17,32,0,1),(17,33,0,1),(20,17,0,1),(20,18,0,1),(20,19,0,1),(20,20,0,1),(20,21,0,1),(20,22,0,1),(20,24,0,1),(20,25,0,1),(20,26,0,1),(20,27,0,1),(20,28,0,1),(20,29,0,1),(20,30,0,1),(20,31,0,1),(85,17,0,1),(85,18,0,1),(85,19,0,1),(85,20,0,1),(85,21,0,1),(85,22,0,1),(85,24,0,1),(85,25,0,1),(85,26,0,1),(85,27,0,1),(85,28,0,1),(85,29,0,1),(85,30,0,1),(85,31,0,1),(90,17,0,1),(90,18,0,1),(90,19,0,1),(90,20,0,1),(90,21,0,1),(90,22,0,1),(90,24,0,1),(90,25,0,1),(90,26,0,1),(90,27,0,1),(90,28,0,1),(90,29,0,1),(90,30,0,1),(90,31,0,1),(91,17,0,1),(91,18,0,1),(91,19,0,1),(91,20,0,1),(91,21,0,1),(91,22,0,1),(91,24,0,1),(91,25,0,1),(91,26,0,1),(91,27,0,1),(91,28,0,1),(91,29,0,1),(91,30,0,1),(91,31,0,1),(92,17,0,1),(92,18,0,1),(92,19,0,1),(92,20,0,1),(92,22,0,1),(94,17,0,1),(94,18,0,1),(94,19,0,1),(95,17,0,1),(95,18,0,1),(95,19,0,1),(95,20,0,1),(95,21,0,1),(95,22,0,1),(95,24,0,1),(95,25,0,1),(95,26,0,1),(95,27,0,1),(95,28,0,1),(95,29,0,1),(95,30,0,1),(95,31,0,1),(96,1,0,1),(96,17,0,1),(96,18,0,1),(96,19,0,1),(96,20,0,1),(96,22,0,1),(96,24,0,1),(96,25,0,1),(96,27,0,1),(96,28,0,1),(96,29,0,1),(96,30,0,1),(96,32,0,1),(97,1,0,1),(97,17,0,1),(97,18,0,1),(97,19,0,1),(97,20,0,1),(97,22,0,1),(97,24,0,1),(97,25,0,1),(97,26,0,1),(97,27,0,1),(97,28,0,1),(97,29,0,1),(97,30,0,1),(97,31,0,1),(97,32,0,1),(97,33,0,1),(100,1,0,1),(100,17,0,1),(100,18,0,1),(100,19,0,1),(100,20,0,1),(100,22,0,1),(100,24,0,1),(100,25,0,1),(100,26,0,1),(100,27,0,1),(100,28,0,1),(100,29,0,1),(100,30,0,1),(100,31,0,1),(100,32,0,1),(100,33,0,1),(101,1,0,1),(101,17,0,1),(101,18,1,1),(101,19,0,1),(101,20,0,1),(101,22,0,1),(101,24,0,1),(101,25,1,1),(101,26,0,1),(101,27,1,1),(101,28,1,1),(101,29,1,1),(101,30,1,1),(101,31,0,1),(101,32,0,1),(101,33,0,1),(102,1,0,1),(102,17,0,1),(102,22,0,1),(102,26,0,1),(102,31,0,1),(102,32,0,1),(102,33,0,1),(103,1,0,1),(103,17,0,1),(103,18,0,1),(103,19,0,1),(103,20,0,1),(103,22,0,1),(103,24,0,1),(103,25,0,1),(103,26,0,1),(103,27,0,1),(103,28,0,1),(103,29,0,1),(103,30,0,1),(103,31,0,1),(103,32,0,1),(103,33,0,1),(104,1,0,1),(104,17,0,1),(104,18,0,1),(104,22,0,1),(104,26,0,1),(104,27,0,1),(104,31,0,1),(104,32,0,1);
/*!40000 ALTER TABLE `paciente_menu_categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resultado_condicion`
--

DROP TABLE IF EXISTS `resultado_condicion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resultado_condicion` (
  `idresultado_examen` int(10) NOT NULL,
  `idencabezado_condicion` int(10) NOT NULL,
  PRIMARY KEY (`idresultado_examen`,`idencabezado_condicion`),
  KEY `FKresultado_447375` (`idresultado_examen`),
  KEY `FKresultado_493241` (`idencabezado_condicion`),
  CONSTRAINT `FKresultado_447375` FOREIGN KEY (`idresultado_examen`) REFERENCES `resultado_examen` (`idresultado_examen`),
  CONSTRAINT `FKresultado_493241` FOREIGN KEY (`idencabezado_condicion`) REFERENCES `encabezado_condicion` (`idencabezado_condicion`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resultado_condicion`
--

LOCK TABLES `resultado_condicion` WRITE;
/*!40000 ALTER TABLE `resultado_condicion` DISABLE KEYS */;
INSERT INTO `resultado_condicion` VALUES (3,26),(3,27),(4,28),(5,31),(6,32),(7,33),(10,34),(10,36),(11,37),(12,38),(13,39),(13,41),(14,40),(16,35),(16,42),(17,30),(18,43),(19,44),(20,45),(21,46),(22,50),(23,48),(23,49),(24,47),(25,52),(26,53),(27,54),(28,55),(29,56),(30,57),(31,59),(32,60),(33,61),(34,62),(37,63),(38,64),(39,65),(40,66),(42,67),(44,69),(45,70),(46,71),(47,72),(48,74),(48,76),(48,79),(48,80),(48,81),(49,75),(49,76),(49,81),(50,77),(50,80),(50,81),(51,78),(51,79),(52,82),(52,83),(53,85),(53,89),(54,86),(54,87),(54,88),(54,91),(55,90),(56,92),(57,93),(58,94),(59,95),(60,96),(61,97),(62,98),(63,99),(64,100),(65,101),(66,103),(67,104),(68,105),(69,106),(70,107),(71,108),(72,109),(73,111),(74,112),(75,113),(76,114),(76,115),(76,116),(76,117),(77,118),(78,119),(79,120),(80,121),(81,122),(82,123),(83,124);
/*!40000 ALTER TABLE `resultado_condicion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ambiente_familiar`
--

DROP TABLE IF EXISTS `ambiente_familiar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ambiente_familiar` (
  `idpaciente` int(20) NOT NULL,
  `descripcion` varchar(300) NOT NULL,
  PRIMARY KEY (`idpaciente`),
  KEY `FKambiente_f549692` (`idpaciente`),
  CONSTRAINT `FKambiente_f549692` FOREIGN KEY (`idpaciente`) REFERENCES `paciente` (`idpaciente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ambiente_familiar`
--

LOCK TABLES `ambiente_familiar` WRITE;
/*!40000 ALTER TABLE `ambiente_familiar` DISABLE KEYS */;
INSERT INTO `ambiente_familiar` VALUES (101,'hola'),(102,'Todo funciona fabuloso en mi familia'),(103,'hola hola'),(104,'hoa');
/*!40000 ALTER TABLE `ambiente_familiar` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `responsable`
--

LOCK TABLES `responsable` WRITE;
/*!40000 ALTER TABLE `responsable` DISABLE KEYS */;
INSERT INTO `responsable` VALUES (1,'David','Velásquez',NULL,8),(2,'Dr. Efraín','Medina',NULL,6),(3,'Lic. Jorge Concepción','Ramírez Álvarez',NULL,4),(4,'Licda. Dora Rene','Guerra',NULL,4),(5,'Lic. Víctor Rodolfo','Comparini Estrada',NULL,4),(6,'Licda. Ana Guadalupe','Pérez Batres',NULL,4),(7,'Licda. Ana Luisa','Palomo Valiente',NULL,4),(8,'Corina','Arriaga',NULL,8),(9,'Rita','Figueroa',NULL,9);
/*!40000 ALTER TABLE `responsable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cita`
--

DROP TABLE IF EXISTS `cita`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cita` (
  `idcita` int(20) NOT NULL AUTO_INCREMENT,
  `estado` int(10) NOT NULL,
  `tipo_examen` int(10) NOT NULL,
  `cupo` int(10) NOT NULL,
  `fecha` datetime NOT NULL,
  `hora_inicio` datetime NOT NULL,
  `hora_fin` datetime NOT NULL,
  PRIMARY KEY (`idcita`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cita`
--

LOCK TABLES `cita` WRITE;
/*!40000 ALTER TABLE `cita` DISABLE KEYS */;
INSERT INTO `cita` VALUES (89,1,1,20,'2012-05-02 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(90,1,1,20,'2012-05-04 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(91,1,1,20,'2012-05-07 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(92,1,1,20,'2012-05-09 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(93,1,1,20,'2012-05-11 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(94,1,1,20,'2012-05-14 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(95,1,1,20,'2012-05-16 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(96,1,1,20,'2012-05-18 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(97,1,1,20,'2012-05-21 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(98,1,1,20,'2012-05-23 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(99,1,1,20,'2012-05-25 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(100,1,1,20,'2012-05-28 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(101,1,1,20,'2012-05-30 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(102,1,2,20,'2012-06-01 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(103,1,2,20,'2012-06-04 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(104,1,2,20,'2012-06-06 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(105,1,2,20,'2012-06-08 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(106,1,2,20,'2012-06-11 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(107,1,2,20,'2012-06-13 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(108,1,2,20,'2012-06-15 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(109,1,2,20,'2012-06-18 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(110,1,2,20,'2012-06-20 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(111,1,2,20,'2012-06-22 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(112,1,2,20,'2012-06-25 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(113,1,2,20,'2012-06-27 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(114,1,2,20,'2012-06-29 00:00:00','1970-01-01 07:00:00','1970-01-01 10:00:00'),(115,2,1,150,'2012-06-01 00:00:00','1970-01-01 16:00:00','1970-01-01 18:00:00'),(116,2,1,150,'2012-06-04 00:00:00','1970-01-01 16:00:00','1970-01-01 18:00:00'),(117,2,1,150,'2012-06-06 00:00:00','1970-01-01 16:00:00','1970-01-01 18:00:00'),(118,2,1,150,'2012-06-08 00:00:00','1970-01-01 16:00:00','1970-01-01 18:00:00'),(119,2,1,150,'2012-06-11 00:00:00','1970-01-01 16:00:00','1970-01-01 18:00:00'),(120,2,1,150,'2012-06-13 00:00:00','1970-01-01 16:00:00','1970-01-01 18:00:00'),(121,2,1,150,'2012-06-15 00:00:00','1970-01-01 16:00:00','1970-01-01 18:00:00'),(122,2,1,150,'2012-06-18 00:00:00','1970-01-01 16:00:00','1970-01-01 18:00:00'),(123,2,1,150,'2012-06-20 00:00:00','1970-01-01 16:00:00','1970-01-01 18:00:00'),(124,2,1,150,'2012-06-22 00:00:00','1970-01-01 16:00:00','1970-01-01 18:00:00'),(125,2,1,150,'2012-06-25 00:00:00','1970-01-01 16:00:00','1970-01-01 18:00:00'),(126,2,1,150,'2012-06-27 00:00:00','1970-01-01 16:00:00','1970-01-01 18:00:00'),(127,2,1,150,'2012-06-29 00:00:00','1970-01-01 16:00:00','1970-01-01 18:00:00');
/*!40000 ALTER TABLE `cita` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuracion_examen`
--

DROP TABLE IF EXISTS `configuracion_examen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configuracion_examen` (
  `idconfiguracion_examen` int(10) NOT NULL AUTO_INCREMENT,
  `terminacion` int(10) NOT NULL,
  `tipo_examen` int(10) NOT NULL,
  PRIMARY KEY (`idconfiguracion_examen`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuracion_examen`
--

LOCK TABLES `configuracion_examen` WRITE;
/*!40000 ALTER TABLE `configuracion_examen` DISABLE KEYS */;
INSERT INTO `configuracion_examen` VALUES (1,0,2),(2,1,2),(3,1,2),(4,1,1),(5,1,1),(6,1,1),(7,1,1),(8,1,1),(9,1,1),(10,1,1);
/*!40000 ALTER TABLE `configuracion_examen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nacionalidad`
--

DROP TABLE IF EXISTS `nacionalidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nacionalidad` (
  `idnacionalidad` int(10) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `codigo` int(11) NOT NULL,
  PRIMARY KEY (`idnacionalidad`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nacionalidad`
--

LOCK TABLES `nacionalidad` WRITE;
/*!40000 ALTER TABLE `nacionalidad` DISABLE KEYS */;
INSERT INTO `nacionalidad` VALUES (3,'guatemalteca',30),(4,'INGLESA',55);
/*!40000 ALTER TABLE `nacionalidad` ENABLE KEYS */;
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
  `estado` int(10) DEFAULT '1' COMMENT '1-> activo, 0 -> inactivo',
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `multimediaidmultimedia_pdf` int(11) DEFAULT NULL,
  PRIMARY KEY (`idnoticia`),
  KEY `FKnoticia378758` (`areaidarea`),
  KEY `FKnoticia914947` (`multimediaidmultimedia`),
  KEY `FKnoticia744912` (`multimediaidmultimedia_pdf`),
  CONSTRAINT `FKnoticia378758` FOREIGN KEY (`areaidarea`) REFERENCES `area` (`idarea`),
  CONSTRAINT `FKnoticia744912` FOREIGN KEY (`multimediaidmultimedia_pdf`) REFERENCES `multimedia` (`idmultimedia`),
  CONSTRAINT `FKnoticia914947` FOREIGN KEY (`multimediaidmultimedia`) REFERENCES `multimedia` (`idmultimedia`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `noticia`
--

LOCK TABLES `noticia` WRITE;
/*!40000 ALTER TABLE `noticia` DISABLE KEYS */;
INSERT INTO `noticia` VALUES (1,'TALLERES DE  CRECIMIENTO Y DESARROLLO PERSONAL','<div align=\'center\'><b>DIRECCI&Oacute;N GENERAL DE DOCENCIA<br>BIENESTAR ESTUDIANTIL UNIVERSITARIO<br>  UNIDAD DE SALUD, &Aacute;REA DE PSICOLOG&Iacute;A<br></b><br>TALLERES DE  CRECIMIENTO Y DESARROLLO PERSONAL<br><br>SESIONES DE DOS HORAS CADA UNA<br>DIPLOMA DE PARTICIPACI&Oacute;N. <br>INFORMACI&Oacute;N &Aacute;REA DE PSICOLOG&Iacute;A  TEL.  24439633,   EXT. 1183.     <br><br><br>TE ESPERAMOS!<br></div>',4,'2012-04-26 00:00:00','2012-05-31 00:00:00',1,NULL,'SESIONES DE DOS HORAS CADA UNA DIPLOMA DE PARTICIPACI&Oacute;N.',1,'2012-04-27 05:00:05',56),(2,'Bolet&iacute;n No. 2','<div style=\'font-weight: normal; text-align: center; \'><b><u><font color=\'#cc9933\' size=\'4\'>Bolet&iacute;n Informativo Marzo 2012</font></u></b></div><div style=\'text-align: center; \'><font color=\'#cc9933\' size=\'4\'><b><u>PPIVS</u></b></font></div>',6,'2012-04-27 00:00:00','2012-04-30 00:00:00',1,NULL,'Bolet&iacute;n Informativo Marzo 2012',1,'2012-04-27 15:26:49',91),(4,'CLASES DE AER&Oacute;BICOS','<div style=\'font-family: Arial, Verdana; font-size: 10pt; text-align: center; \'><span style=\'font-size: 10pt; \'>CLASES DE AER&Oacute;BICOS EN UNIDAD DE SALUD</span></div><div style=\'font-family: Arial, Verdana; font-size: 10pt; text-align: center; \'>3er Nivel, Edificio de Bienestar Estudiantil</div><div style=\'font-family: Arial, Verdana; font-size: 10pt; text-align: center; \'><br></div><div style=\'font-family: Arial, Verdana; font-size: 10pt; text-align: center; \'>D&iacute;as: lunes, mi&eacute;rcoles y viernes</div><div style=\'font-family: Arial, Verdana; font-size: 10pt; text-align: center; \'>Horarios:</div><div style=\'font-family: Arial, Verdana; font-size: 10pt; text-align: center; \'>12:10 a 12:50 hrs</div><div style=\'font-family: Arial, Verdana; font-size: 10pt; text-align: center; \'>13:00 a 13:45 hrs</div><div style=\'font-family: Arial, Verdana; font-size: 10pt; text-align: center; \'>15:00 a 15:50 hrs</div><div style=\'font-family: Arial, Verdana; \nfont-size: 10pt; text-align: center; \'>15:50 a 16:30 hrs</div><div style=\'font-family: Arial, Verdana; font-size: 10pt; text-align: center; \'><br></div><div style=\'font-family: Arial, Verdana; font-size: 10pt; text-align: center; \'>Modalidades: Aer&oacute;bicos coreogr&aacute;fico, tae-bo, step, pesas, colchonetas, baile latino y mucho m&aacute;s!</div><div style=\'font-family: Arial, Verdana; font-size: 10pt; text-align: center; \'><br></div><div style=\'text-align: center; \'><font face=\'Arial, Verdana\' size=\'2\'>PROGRAMA&nbsp;COMPLETAMENTE&nbsp;GRATUITO DE ENERO A NOVIEMBRE</font></div><div style=\'font-family: Arial, Verdana; font-size: 10pt; text-align: center; \'><br></div><div style=\'font-family: Arial, Verdana; font-size: 10pt; text-align: center; \'>Te invitamos a nuestra S&uacute;per Clase este 29 de mayo de 15:00 a 17:00 hrs. Ven y ap&uacute;ntate ya!</div>',8,'2012-05-01 00:00:00','2012-05-31 00:00:00',1,NULL,'Programa completamente gratuito de ENERO a NOVIEMBRE!',1,'2012-05-07 13:25:24',NULL),(5,'Examen de Salud','<font size=\'4\'><b>PASOS PARA GENERAR BOLETA DE PAGO DE EXAMEN DE SALUD 2012:</b></font><br><br><ul><li>Ingresa a la PAGINA <a href=\'http://estudiante.usac.edu.gt/pagousac/faces/menu/sgi_inicio.jsp\'>GESTOR DE PAGOS</a></li><li>Ingresa su USUARIO (No. de Carn&eacute;) Y PASSWORD (No sabe su pin recup&eacute;relo En <a href=\'http://rye.usac.edu.gt/\'>click aqu&iacute;</a>)</li><li>Siguiente</li><li>Seleccione examen de salud 2012</li><li>Agregar pago</li><li>Generar orden de pago</li><li>PAGAR EN BANRURAL O G&amp;T&nbsp;</li><li>Ven a la Unidad de a pedir tu cita</li></ul><br><br>NOTA: Se le extender&aacute; una tarjeta que debe presentarla para su reinscripci&oacute;n y cada vez que solicite consulta m&eacute;dica, psicol&oacute;gica y odontol&oacute;gica. <br><br>Por favor informar a sus compa&ntilde;eros de primer a&ntilde;o sobre esta evaluaci&oacute;n en salud, para que esten efect&uacute;en el examen.<br>',1,'2012-05-01 00:00:00','2012-12-31 00:00:00',3,NULL,'La tarjeta \nde salud que debe presentarla para su reinscripci&oacute;n de su segundo a&ntilde;o.',1,'2012-05-07 13:38:39',NULL),(6,'XV Jornada Deportiva y Cultural Contra el Tabaco','<div style=\'font-family: Arial, Verdana; font-style: normal; font-variant: normal; line-height: normal; text-align: center; \'><font size=\'4\'>Esta actividad esta dirigida a estudiantes docentes y administrativo de los de la USAC, para motivarlos a la lucha contra <b>el nocivo humo de tabaco</b> en nuestras vidas tanto como el que fuma como el que esta cerca de un fumador</font></div><div style=\'font-family: Arial, Verdana; font-style: normal; font-variant: normal; line-height: normal; text-align: center; \'><font size=\'4\'><br></font></div><div style=\'text-align: center; \'><font face=\'Arial, Verdana\' size=\'4\'>Inscribirte</font><font size=\'4\' style=\'font-family: Arial, Verdana; font-style: normal; font-variant: normal; line-height: normal; \'>&nbsp;ya en la Unidad de salud</font></div><div style=\'text-align: center; \'><font size=\'4\'><font face=\'Arial, Verdana\'>ultima fecha de&nbsp;inscripci&oacute;n&nbsp;el 22 mayo&nbsp;</font></\nfont></div>',5,'2012-05-09 00:00:00','2012-05-31 00:00:00',3,NULL,'participa dejando de fumar',1,'2012-05-09 16:59:29',174),(7,'TALLERES DE CRECIMIENTO PERSONAL','TALLERES DE DESARROLLO Y CRECIMIENTO PERSONAL<br>PSICOLOGIA AFICHE JUNIO 2012<br>',1,'2012-05-21 00:00:00','2012-05-31 00:00:00',3,NULL,'TALLERES DE CRECIMIENTO PERSONAL JUNIO',1,'2012-05-24 18:19:52',187);
/*!40000 ALTER TABLE `noticia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_categoria`
--

DROP TABLE IF EXISTS `menu_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_categoria` (
  `idmenu_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) NOT NULL,
  `instruccion` text,
  `idarea_examen` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idmenu_categoria`),
  KEY `FKmenu_categ91506` (`idarea_examen`),
  CONSTRAINT `FKmenu_categ91506` FOREIGN KEY (`idarea_examen`) REFERENCES `area_examen` (`idarea_examen`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_categoria`
--

LOCK TABLES `menu_categoria` WRITE;
/*!40000 ALTER TABLE `menu_categoria` DISABLE KEYS */;
INSERT INTO `menu_categoria` VALUES (1,'AMBIENTE FAMILIAR','<br>',2),(17,'TRABAJO',' ',2),(18,'ALERGIAS','<font size=\'4\'><b>INSTRUCCIONES</b></font><br><br>La informaci&oacute;n de este documento es <font color=\'#ff0000\'>CONFIDENCIAL  Y DE USO INTERNO</font>,  se utilizar&aacute; como evaluaci&oacute;n  del estado de salud de los estudiantes que ingresan a la Universidad de San Carlos de Guatemala. No se revelar&aacute;n datos personales a ninguna persona. Cualquier duda puedes consultarla al personal de Unidad de Salud.<br><br>A continuaci&oacute;n encontrar&aacute;s preguntas a las que debes <u><font color=\'#ff0000\'>RESPONDER DE ACUERDO A TU ESTADO DE SALUD Y H&Aacute;BITOS DE VIDA,  LOS &Uacute;LTIMOS 3 MESES</font></u>, tendr&aacute;s diferentes opciones, marca con una &#34;X&#34; la opci&oacute;n que m&aacute;s se identifique contigo.  <br>',1),(19,'HOSPITALIZACION','<font size=\'4\'><b>INSTRUCCIONES</b></font><br><br>La informaci&oacute;n de este documento es <font color=\'#ff0000\'>CONFIDENCIAL  Y DE USO INTERNO</font>,  se utilizar&aacute; como evaluaci&oacute;n  del estado de salud de los estudiantes que ingresan a la Universidad de San Carlos de Guatemala. No se revelar&aacute;n datos personales a ninguna persona. Cualquier duda puedes consultarla al personal de Unidad de Salud.<br><br>A continuaci&oacute;n encontrar&aacute;s preguntas a las que debes <u><font color=\'#ff0000\'>RESPONDER DE ACUERDO A TU ESTADO DE SALUD Y H&Aacute;BITOS DE VIDA,  LOS &Uacute;LTIMOS 3 MESES</font></u>, tendr&aacute;s diferentes opciones, marca con una &#34;X&#34; la opci&oacute;n que m&aacute;s se identifique contigo.  <br>',1),(20,'ANTECEDENTES','<font size=\'4\'><b>INSTRUCCIONES</b></font><br><br>La informaci&oacute;n de este documento es <font color=\'#ff0000\'>CONFIDENCIAL  Y DE USO INTERNO</font>,  se utilizar&aacute; como evaluaci&oacute;n  del estado de salud de los estudiantes que ingresan a la Universidad de San Carlos de Guatemala. No se revelar&aacute;n datos personales a ninguna persona. Cualquier duda puedes consultarla al personal de Unidad de Salud.<br><br>A continuaci&oacute;n encontrar&aacute;s preguntas a las que debes <u><font color=\'#ff0000\'>RESPONDER DE ACUERDO A TU ESTADO DE SALUD Y H&Aacute;BITOS DE VIDA,  LOS &Uacute;LTIMOS 3 MESES</font></u>, tendr&aacute;s diferentes opciones, marca con una &#34;X&#34; la opci&oacute;n que m&aacute;s se identifique contigo.  <br>',1),(22,'MEDICAMENTOS',' ',2),(24,'NUTRICION','<font size=\'4\'><b>INSTRUCCIONES</b></font><br><br>La informaci&oacute;n de este documento es <font color=\'#ff0000\'>CONFIDENCIAL  Y DE USO INTERNO</font>,  se utilizar&aacute; como evaluaci&oacute;n  del estado de salud de los estudiantes que ingresan a la Universidad de San Carlos de Guatemala. No se revelar&aacute;n datos personales a ninguna persona. Cualquier duda puedes consultarla al personal de Unidad de Salud.<br><br>A continuaci&oacute;n encontrar&aacute;s preguntas a las que debes <u><font color=\'#ff0000\'>RESPONDER DE ACUERDO A TU ESTADO DE SALUD Y H&Aacute;BITOS DE VIDA,  LOS &Uacute;LTIMOS 3 MESES</font></u>, tendr&aacute;s diferentes opciones, marca con una &#34;X&#34; la opci&oacute;n que m&aacute;s se identifique contigo.  <br>',1),(25,'HABITOS DE VIDA','<font size=\'4\'><b>INSTRUCCIONES</b></font><br><br>La informaci&oacute;n de este documento es <font color=\'#ff0000\'>CONFIDENCIAL  Y DE USO INTERNO</font>,  se utilizar&aacute; como evaluaci&oacute;n  del estado de salud de los estudiantes que ingresan a la Universidad de San Carlos de Guatemala. No se revelar&aacute;n datos personales a ninguna persona. Cualquier duda puedes consultarla al personal de Unidad de Salud.<br><br>A continuaci&oacute;n encontrar&aacute;s preguntas a las que debes <u><font color=\'#ff0000\'>RESPONDER DE ACUERDO A TU ESTADO DE SALUD Y H&Aacute;BITOS DE VIDA,  LOS &Uacute;LTIMOS 3 MESES</font></u>, tendr&aacute;s diferentes opciones, marca con una &#34;X&#34; la opci&oacute;n que m&aacute;s se identifique contigo.  <br>',1),(26,'SITUACIONES DE PELIGRO','',2),(27,'CABEZA','<font size=\'4\'><b>INSTRUCCIONES</b></font><br><br>La informaci&oacute;n de este documento es <font color=\'#ff0000\'>CONFIDENCIAL  Y DE USO INTERNO</font>,  se utilizar&aacute; como evaluaci&oacute;n  del estado de salud de los estudiantes que ingresan a la Universidad de San Carlos de Guatemala. No se revelar&aacute;n datos personales a ninguna persona. Cualquier duda puedes consultarla al personal de Unidad de Salud.<br><br>A continuaci&oacute;n encontrar&aacute;s preguntas a las que debes <u><font color=\'#ff0000\'>RESPONDER DE ACUERDO A TU ESTADO DE SALUD Y H&Aacute;BITOS DE VIDA,  LOS &Uacute;LTIMOS 3 MESES</font></u>, tendr&aacute;s diferentes opciones, marca con una \'X\' la opci&oacute;n que m&aacute;s se identifique contigo. &nbsp;<br>',1),(28,'GENITOURINARIO','<font size=\'4\'><b>INSTRUCCIONES</b></font><br><br>La informaci&oacute;n de este documento es <font color=\'#ff0000\'>CONFIDENCIAL  Y DE USO INTERNO</font>,  se utilizar&aacute; como evaluaci&oacute;n  del estado de salud de los estudiantes que ingresan a la Universidad de San Carlos de Guatemala. No se revelar&aacute;n datos personales a ninguna persona. Cualquier duda puedes consultarla al personal de Unidad de Salud.<br><br>A continuaci&oacute;n encontrar&aacute;s preguntas a las que debes <u><font color=\'#ff0000\'>RESPONDER DE ACUERDO A TU ESTADO DE SALUD Y H&Aacute;BITOS DE VIDA,  LOS &Uacute;LTIMOS 3 MESES</font></u>, tendr&aacute;s diferentes opciones, marca con una &#34;X&#34; la opci&oacute;n que m&aacute;s se identifique contigo.  <br>',1),(29,'GASTROINTESTINAL','<font size=\'4\'><b>INSTRUCCIONES</b></font><br><br>La informaci&oacute;n de este documento es <font color=\'#ff0000\'>CONFIDENCIAL  Y DE USO INTERNO</font>,  se utilizar&aacute; como evaluaci&oacute;n  del estado de salud de los estudiantes que ingresan a la Universidad de San Carlos de Guatemala. No se revelar&aacute;n datos personales a ninguna persona. Cualquier duda puedes consultarla al personal de Unidad de Salud.<br><br>A continuaci&oacute;n encontrar&aacute;s preguntas a las que debes <u><font color=\'#ff0000\'>RESPONDER DE ACUERDO A TU ESTADO DE SALUD Y H&Aacute;BITOS DE VIDA,  LOS &Uacute;LTIMOS 3 MESES</font></u>, tendr&aacute;s diferentes opciones, marca con una &#34;X&#34; la opci&oacute;n que m&aacute;s se identifique contigo.  <br>',1),(30,'MUSCULOS Y HUESOS','<font size=\'4\'><b>INSTRUCCIONES</b></font><br><br>La informaci&oacute;n de este documento es <font color=\'#ff0000\'>CONFIDENCIAL  Y DE USO INTERNO</font>,  se utilizar&aacute; como evaluaci&oacute;n  del estado de salud de los estudiantes que ingresan a la Universidad de San Carlos de Guatemala. No se revelar&aacute;n datos personales a ninguna persona. Cualquier duda puedes consultarla al personal de Unidad de Salud.<br><br>A continuaci&oacute;n encontrar&aacute;s preguntas a las que debes <u><font color=\'#ff0000\'>RESPONDER DE ACUERDO A TU ESTADO DE SALUD Y H&Aacute;BITOS DE VIDA,  LOS &Uacute;LTIMOS 3 MESES</font></u>, tendr&aacute;s diferentes opciones, marca con una &#34;X&#34; la opci&oacute;n que m&aacute;s se identifique contigo.  <br>',1),(31,'SENTIMIENTOS',' ',2),(32,'OCIO','<br>',2),(33,'COMIDA','',3),(34,'SALUD ORAL','',3),(35,'SALUD MENTAL','',2),(36,'H&Aacute;BITOS HIGI&Eacute;NICOS','',4);
/*!40000 ALTER TABLE `menu_categoria` ENABLE KEYS */;
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
  PRIMARY KEY (`idparentesco`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parentesco`
--

LOCK TABLES `parentesco` WRITE;
/*!40000 ALTER TABLE `parentesco` DISABLE KEYS */;
INSERT INTO `parentesco` VALUES (1,'Madre'),(2,'Padre'),(3,'Esposo(a)'),(4,'Hermano(a)'),(5,'Abuelo(a)'),(6,'Otro');
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
  KEY `FKusuario_pe639680` (`permisosidpermiso`),
  CONSTRAINT `FKusuario_pe639680` FOREIGN KEY (`permisosidpermiso`) REFERENCES `permiso` (`idpermiso`),
  CONSTRAINT `FKusuario_pe657117` FOREIGN KEY (`usuarioidusuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario_permisos`
--

LOCK TABLES `usuario_permisos` WRITE;
/*!40000 ALTER TABLE `usuario_permisos` DISABLE KEYS */;
INSERT INTO `usuario_permisos` VALUES (2,221),(2,222),(2,223),(2,224),(2,225),(2,226),(2,227),(2,228),(2,229),(2,230),(2,231),(2,232),(3,221),(3,222),(3,223),(3,224),(3,225),(3,226),(3,227),(3,228),(3,229),(3,230),(3,231),(3,232),(4,221),(4,222),(4,223),(4,224),(4,225),(4,226),(4,227),(4,228),(4,229),(4,230),(4,231),(4,232),(5,221),(5,222),(5,223),(5,224),(5,225),(5,226),(5,227),(5,228),(5,229),(5,230),(5,231),(5,232),(6,221),(6,222),(6,223),(6,224),(6,225),(6,226),(6,227),(6,228),(6,229),(6,230),(6,231),(6,232),(7,221),(7,222),(7,223),(7,224),(7,225),(7,226),(7,227),(7,228),(7,229),(7,230),(7,231),(7,232),(8,221),(8,222),(8,223),(8,224),(8,225),(8,226),(8,227),(8,228),(8,229),(8,230),(8,231),(8,232),(9,221),(9,222),(9,223),(9,224),(9,225),(9,226),(9,227),(9,228),(9,229),(9,230),(9,231),(9,232),(10,221),(10,222),(10,223),(10,224),(10,225),(10,226),(10,227),(10,228),(10,229),(10,230),(10,231),(10,232);
/*!40000 ALTER TABLE `usuario_permisos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo_familiar`
--

DROP TABLE IF EXISTS `grupo_familiar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupo_familiar` (
  `idpaciente` int(20) NOT NULL,
  `idgrupo_familiar` int(20) NOT NULL AUTO_INCREMENT,
  `idparentesco` int(11) NOT NULL,
  `genero` int(10) NOT NULL,
  `ocupacion` varchar(30) DEFAULT NULL,
  `ingreso` double DEFAULT NULL,
  `salud` int(10) NOT NULL,
  `lugar` varchar(50) NOT NULL,
  `edad` int(10) DEFAULT '0',
  PRIMARY KEY (`idgrupo_familiar`),
  KEY `FKgrupo_fami983612` (`idpaciente`),
  KEY `FKgrupo_fami391739` (`idparentesco`),
  CONSTRAINT `FKgrupo_fami391739` FOREIGN KEY (`idparentesco`) REFERENCES `parentesco` (`idparentesco`),
  CONSTRAINT `FKgrupo_fami983612` FOREIGN KEY (`idpaciente`) REFERENCES `paciente` (`idpaciente`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo_familiar`
--

LOCK TABLES `grupo_familiar` WRITE;
/*!40000 ALTER TABLE `grupo_familiar` DISABLE KEYS */;
INSERT INTO `grupo_familiar` VALUES (102,14,2,0,'Medico',500000,1,'Ciudad',70),(102,15,1,1,'Medico',0,1,'Ciudad',65),(102,16,4,0,'Administrador',30000,1,'Ciudad',40),(102,17,4,1,'Terapista Ocupacional',25000,1,'Ciudad',38),(103,18,1,1,'profesor',3333,1,'Guatemala',23),(103,19,2,0,'Maestro',34332,1,'Guatemala',23),(101,20,1,1,'',0,1,'',21);
/*!40000 ALTER TABLE `grupo_familiar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departamento`
--

DROP TABLE IF EXISTS `departamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departamento` (
  `iddepartamento` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `codigo` int(10) NOT NULL,
  PRIMARY KEY (`iddepartamento`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departamento`
--

LOCK TABLES `departamento` WRITE;
/*!40000 ALTER TABLE `departamento` DISABLE KEYS */;
INSERT INTO `departamento` VALUES (2,'Guatemala',1),(3,'Sacatepequez',3),(4,'Izabal',18),(5,'Jalapa',21);
/*!40000 ALTER TABLE `departamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `anuncio`
--

DROP TABLE IF EXISTS `anuncio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `anuncio` (
  `idanuncio` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(200) NOT NULL,
  `descripcion` varchar(300) NOT NULL,
  `contenido` text NOT NULL,
  PRIMARY KEY (`idanuncio`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anuncio`
--

LOCK TABLES `anuncio` WRITE;
/*!40000 ALTER TABLE `anuncio` DISABLE KEYS */;
INSERT INTO `anuncio` VALUES (1,'Instrucciones del Examen de salud','Al iniciar sessión los estudiantes veran esta información','<div style=\'text-align: justify;\'><font face=\'Arial, Verdana\' size=\'4\'>La tarjeta </font><font face=\'Arial, Verdana\' size=\'4\'>de salud </font><font face=\'Arial, Verdana\' size=\'4\'>que se le extender&aacute;, debera &nbsp;presentarla para su primera reinscripci&oacute;n y cada vez que solicite consulta m&eacute;dica, psicol&oacute;gica y odontol&oacute;gica.&nbsp;</font></div><div><span style=\'font-family: Arial, Verdana; font-size: large; text-align: justify; \'><br></span></div><div><span style=\'font-family: Arial, Verdana; font-size: large; text-align: justify; \'>Este examen posee una parte&nbsp;</span><span style=\'font-family: Arial, Verdana; font-size: large; text-align: justify; \'>electr&oacute;nica y otra parte presencial en la Unidad de Salud.</span><br><ul><li style=\'text-align: justify;\'><font color=\'#000099\' face=\'Arial, Verdana\' size=\'4\'>Paso 1</font></li><ul><li style=\'\ntext-align: justify;\'><font face=\'Arial, Verdana\' size=\'4\'>Complete sus datos generales</font></li></ul><li style=\'text-align: justify;\'><span style=\'font-family: Arial, Verdana; \'><font color=\'#000099\' size=\'4\'>Paso 2</font></span></li><ul><li style=\'text-align: justify;\'><span style=\'font-family: Arial, Verdana; \'><font size=\'4\'>Llene el formulario del examen, este es un examen extenso y debe poseer tiempo suficiente para finalizar el examen, o puede continuarlo en otro momento.</font></span></li></ul><li style=\'text-align: justify;\'><span style=\'font-family: Arial, Verdana; \'><font color=\'#000099\' size=\'4\'>Paso 3</font></span></li><ul><li style=\'text-align: justify;\'><font face=\'Arial, Verdana\' size=\'4\'>&nbsp;<font color=\'#ff0000\'>Es necesario imprimir sus resultados, si usted no puede imprimirlo por favor ir a la Unidad de Salud, para llenar el formulario&nbsp;f&iacute;sico.</font></font></li><li style=\'text-align: justify;\'><font face=\'Arial, Verdana\' size=\'4\'\n>Escoja una citas de las disponibles, en caso de no encontrar una cita que satisfaga sus necesidades ir a la Unidad de Salud a solicitar una cita.</font></li></ul></ul></div><div style=\'text-align: justify;\'><font size=\'4\'><font face=\'Arial, Verdana\'>Por favor informar a sus compa&ntilde;eros universitarios de primer a&ntilde;o sobre esta evaluaci&oacute;n en salud, para que se efect&uacute;en el examen.</font><span style=\'font-family: Arial, Verdana; font-style: normal; font-variant: normal; font-weight: normal; line-height: normal; \'>&nbsp;</span></font></div>'),(2,'Instrucciones Autoevaluacion','Al tocarle autoevaluación los estudiantes veran esta información','<font size=\'4\'>Debe asistir a una charla en la Unidad de Salud, ademas completar un cuestionario donde&nbsp;podr&aacute;n&nbsp;interpretar sus resultados,&nbsp;&nbsp;el objetivo es que el estudiante logre una mejor calidad de vida al cuidar adecuadamente su salud f&iacute;sica y mental.&nbsp;</font>&nbsp;'),(3,'Instrucciones Multifásico','Al tocarle multifásico los estudiantes veran esta información','<font>Es un examen multidisciplinario de Salud (evaluaciones m&eacute;dicas, odontol&oacute;gicas, Psicol&oacute;gicas y ex&aacute;menes de Laboratorio Cl&iacute;nico).</font><div><br></div><div>SU EXAMEN MULTIF&Aacute;SICO ADICIONALMENTE LLEVAR UNA MUESTRA DE ORINA, ADEMAS DE SUS RESULTADOS EXAMEN.</div><div><br></div><div>SI NO PUEDE IMPRIMIR FAVOR DE IR A LA UNIDAD DE SALUD PARA PROPORCIONARLE UN EXAMEN&nbsp;ESCRITO.</div><div>&nbsp;</div>'),(4,'Instrucciones Resultados AutoEvaluacion','Al finalizar sus examen ellos veran esta información','<font size=\'4\'>Seg&uacute;n tus respuesta contestadas estos son tus resultados.&nbsp;</font>'),(5,'Instrucciones Dash de Multifásico','Al finalizar su examen podran visualizar esta información','<b><font size=\'4\'>Debes imprimir el Dash con todas tus respuestas, de no poder imprimir ven a la Unidad de Salud para completar tu cuestionario.</font></b><div style=\'font-size: 10pt; \'>&nbsp;</div>'),(6,'Instrucciones de Citas','Impresión e instrucciones de sus citas','1'),(7,'Instrucciones no ahi Citas','De no haber citas, informar pasos a seguir','1');
/*!40000 ALTER TABLE `anuncio` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edificio`
--

LOCK TABLES `edificio` WRITE;
/*!40000 ALTER TABLE `edificio` DISABLE KEYS */;
INSERT INTO `edificio` VALUES (1,'Bienestar Estudiantil','Ciudad Universitaria Zona 12, Guatemala',''),(2,'Estadio Revolución','Ciudad Universitaria, Zona 12',''),(3,'Facultad de Humanidades, Campus Central','Ciudad Universitaria, Zona 12',''),(4,'Unidad de Salud','3er nivel, Bienestar Estudiantil Cdad Universitaria Zona 12',''),(5,'CANCHA INGENIERIA, Campus Central','Ciudad Universitaria zona 12, GUATEMALA','');
/*!40000 ALTER TABLE `edificio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pregunta_paciente_titulo_respuesta`
--

DROP TABLE IF EXISTS `pregunta_paciente_titulo_respuesta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pregunta_paciente_titulo_respuesta` (
  `idpregunta` int(10) NOT NULL,
  `idpaciente` int(20) NOT NULL,
  `idtitulo_respuesta` int(11) NOT NULL,
  PRIMARY KEY (`idpregunta`,`idpaciente`,`idtitulo_respuesta`),
  KEY `FKpregunta_p830635` (`idpregunta`,`idpaciente`),
  KEY `FKpregunta_p414649` (`idtitulo_respuesta`),
  CONSTRAINT `FKpregunta_p414649` FOREIGN KEY (`idtitulo_respuesta`) REFERENCES `titulo_respuesta` (`idtitulo_respuesta`),
  CONSTRAINT `pregunta_paciente_titulo_respuesta_ibfk_1` FOREIGN KEY (`idpregunta`, `idpaciente`) REFERENCES `pregunta_paciente` (`idpregunta`, `idpaciente`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pregunta_paciente_titulo_respuesta`
--

LOCK TABLES `pregunta_paciente_titulo_respuesta` WRITE;
/*!40000 ALTER TABLE `pregunta_paciente_titulo_respuesta` DISABLE KEYS */;
INSERT INTO `pregunta_paciente_titulo_respuesta` VALUES (210,101,1),(210,103,1),(210,104,1),(212,103,1),(213,104,1),(216,103,1),(218,103,1),(220,103,1),(223,103,1),(224,101,1),(229,103,1),(245,103,1),(264,102,1),(274,101,1),(275,101,1),(276,101,1),(277,101,1),(278,101,1),(211,101,2),(211,103,2),(211,104,2),(213,101,2),(213,103,2),(214,104,2),(215,101,2),(215,104,2),(216,101,2),(216,104,2),(217,103,2),(218,104,2),(219,103,2),(220,101,2),(221,103,2),(222,101,2),(226,101,2),(227,103,2),(230,101,2),(230,103,2),(231,103,2),(233,103,2),(273,103,2),(273,104,2),(274,104,2),(275,103,2),(275,104,2),(276,103,2),(277,104,2),(278,103,2),(278,104,2),(163,103,3),(165,103,3),(169,103,3),(171,103,3),(185,101,3),(185,103,3),(187,101,3),(188,101,3),(190,101,3),(193,103,3),(195,103,3),(212,101,3),(212,104,3),(214,101,3),(214,103,3),(217,101,3),(217,104,3),(218,101,3),(219,104,3),(221,101,3),(222,103,3),(225,101,3),(227,101,3),(228,103,3),(229,101,3),(231,101,3),(232,103,3),(233,101,3),(274,103,3),(276,104,3),(277,103,3),(136,101,4),(162,104,4),(183,103,4),(189,101,4),(189,103,4),(191,101,4),(193,101,4),(194,101,4),(195,101,4),(196,101,4),(197,101,4),(197,104,4),(215,103,4),(219,101,4),(228,101,4),(232,101,4),(273,101,4),(279,101,4),(280,103,4),(281,101,4),(283,101,4),(283,103,4),(285,101,4),(285,103,4),(286,101,4),(287,103,4),(288,101,4),(289,101,4),(289,103,4),(290,101,4),(291,103,4),(293,103,4),(295,103,4),(296,101,4),(301,101,4),(304,101,4),(304,103,4),(306,101,4),(306,103,4),(308,101,4),(308,103,4),(309,101,4),(309,102,4),(310,102,4),(310,103,4),(311,101,4),(311,102,4),(312,102,4),(313,103,4),(315,101,4),(315,103,4),(322,101,4),(324,104,4),(163,101,5),(165,101,5),(186,103,5),(279,103,5),(164,101,6),(164,103,6),(167,101,6),(167,103,6),(169,101,6),(170,101,6),(170,103,6),(171,101,6),(175,101,6),(175,103,6),(183,101,6),(186,101,6),(187,103,6),(188,103,6),(190,103,6),(191,103,6),(194,103,6),(196,103,6),(176,101,7),(176,103,8),(136,103,11),(162,101,11),(162,102,11),(162,103,11),(197,102,11),(197,103,11),(280,101,11),(281,103,11),(282,101,11),(282,103,11),(284,101,11),(284,103,11),(286,103,11),(287,101,11),(288,103,11),(290,103,11),(291,101,11),(292,101,11),(292,103,11),(293,101,11),(294,103,11),(297,101,11),(298,101,11),(299,101,11),(302,101,11),(303,101,11),(303,103,11),(305,101,11),(305,103,11),(307,101,11),(307,103,11),(309,103,11),(310,101,11),(311,103,11),(312,101,11),(312,103,11),(313,102,11),(314,101,11),(314,102,11),(314,103,11),(315,102,11),(317,101,11),(317,104,11),(319,101,11),(319,103,11),(319,104,11),(321,103,11),(322,103,11),(322,104,11),(324,101,11),(324,103,11),(325,102,11),(325,104,11),(326,101,11),(326,102,11),(326,103,11),(151,101,12),(151,101,13),(152,101,13),(152,103,13),(154,103,13),(151,103,14),(152,101,14),(153,101,14),(153,103,14),(155,103,14),(157,103,14),(153,101,15),(153,103,15),(154,101,15),(155,101,15),(155,103,15),(157,101,15),(154,101,16),(155,101,16),(157,101,16),(235,101,17),(235,102,17),(235,103,17),(236,101,17),(237,102,17),(237,103,17),(238,101,17),(238,102,17),(238,104,17),(239,101,17),(239,103,17),(240,102,17),(240,104,17),(241,101,17),(241,103,17),(242,101,17),(242,102,17),(242,104,17),(243,101,17),(243,103,17),(245,101,17),(245,102,17),(245,104,17),(246,102,17),(246,103,17),(246,104,17),(247,102,17),(247,103,17),(247,104,17),(248,101,17),(248,102,17),(249,103,17),(249,104,17),(250,101,17),(250,102,17),(251,102,17),(251,103,17),(251,104,17),(252,101,17),(253,101,17),(253,102,17),(253,103,17),(253,104,17),(254,103,17),(255,101,17),(255,102,17),(255,104,17),(256,103,17),(257,101,17),(257,102,17),(257,103,17),(257,104,17),(259,101,17),(259,102,17),(259,103,17),(259,104,17),(261,101,17),(261,102,17),(261,103,17),(261,104,17),(262,102,17),(263,102,17),(263,104,17),(264,101,17),(264,103,17),(264,104,17),(265,101,17),(265,102,17),(265,103,17),(266,101,17),(266,103,17),(266,104,17),(269,101,17),(269,102,17),(269,103,17),(270,103,17),(270,104,17),(271,101,17),(271,102,17),(272,102,17),(234,101,18),(234,102,18),(234,103,18),(234,104,18),(235,104,18),(236,102,18),(236,103,18),(236,104,18),(237,101,18),(237,104,18),(238,103,18),(239,102,18),(239,104,18),(240,101,18),(240,103,18),(241,102,18),(241,104,18),(242,103,18),(243,102,18),(243,104,18),(244,101,18),(244,102,18),(244,103,18),(244,104,18),(246,101,18),(247,101,18),(248,103,18),(248,104,18),(249,101,18),(249,102,18),(250,103,18),(250,104,18),(251,101,18),(252,102,18),(252,103,18),(252,104,18),(254,101,18),(254,102,18),(254,104,18),(255,103,18),(256,101,18),(256,102,18),(256,104,18),(258,101,18),(258,102,18),(258,103,18),(258,104,18),(260,101,18),(260,102,18),(260,103,18),(260,104,18),(262,101,18),(262,103,18),(262,104,18),(263,101,18),(263,103,18),(265,104,18),(266,102,18),(269,104,18),(270,101,18),(270,102,18),(271,103,18),(271,104,18),(272,101,18),(272,103,18),(272,104,18),(128,102,36),(128,104,37),(128,103,38),(128,101,41),(129,101,45),(129,102,45),(129,103,45),(129,104,45),(129,103,48),(130,101,51),(130,102,51),(130,103,51),(130,104,55),(160,101,76),(160,103,76),(160,103,77),(160,104,80),(161,103,83),(161,101,84),(161,103,84),(161,104,84),(161,103,85),(198,103,89),(198,104,89),(198,101,90),(198,102,91),(199,101,92),(199,102,94),(199,103,94),(199,103,95),(199,104,95),(199,102,96),(199,102,97),(199,102,99),(199,102,100),(316,101,101),(316,102,101),(316,103,101),(316,104,101),(317,102,101),(317,103,101),(318,101,101),(318,102,101),(318,103,101),(318,104,101),(319,102,101),(321,101,101),(321,102,101),(321,104,101),(322,102,101),(323,101,101),(323,102,101),(323,103,101),(323,104,101),(324,102,101),(325,101,101),(325,103,101),(326,104,101);
/*!40000 ALTER TABLE `pregunta_paciente_titulo_respuesta` ENABLE KEYS */;
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
  `ciclo` int(10) NOT NULL DEFAULT '2012',
  `multifa_reporte` int(11) NOT NULL,
  `random_carne` int(11) NOT NULL DEFAULT '1' COMMENT '0 -> RANDOM , 1 -> CARNE',
  `jefe_actual` varchar(100) NOT NULL DEFAULT 'Sandra de Armas',
  `impresion_salud` int(11) NOT NULL DEFAULT '1',
  `fecha_examen` datetime DEFAULT NULL,
  PRIMARY KEY (`idconfiguracion`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuracion`
--

LOCK TABLES `configuracion` WRITE;
/*!40000 ALTER TABLE `configuracion` DISABLE KEYS */;
INSERT INTO `configuracion` VALUES (1,'24189622','saludusac@gmail.com','24189633','images/upload/imagen/','images/upload/pdf/',5,'images/upload/imagen/','images/upload/pdf/','Edificio Bienestar Estudiantil 3er Nivel, Ciudad Universitaria Zona 12, Guatemala C.A',2012,1,1,'Sandra Maria de Armas',1,'2012-03-01 00:00:00');
/*!40000 ALTER TABLE `configuracion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cita_paciente`
--

DROP TABLE IF EXISTS `cita_paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cita_paciente` (
  `idcita` int(20) NOT NULL,
  `idpaciente` int(20) NOT NULL,
  `recibo_pago` varchar(50) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  PRIMARY KEY (`idcita`,`idpaciente`),
  KEY `FKcita_pacie474199` (`idcita`),
  KEY `FKcita_pacie93322` (`idpaciente`),
  CONSTRAINT `FKcita_pacie474199` FOREIGN KEY (`idcita`) REFERENCES `cita` (`idcita`),
  CONSTRAINT `FKcita_pacie93322` FOREIGN KEY (`idpaciente`) REFERENCES `paciente` (`idpaciente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cita_paciente`
--

LOCK TABLES `cita_paciente` WRITE;
/*!40000 ALTER TABLE `cita_paciente` DISABLE KEYS */;
INSERT INTO `cita_paciente` VALUES (101,108,NULL,0),(101,117,NULL,1),(115,101,NULL,1);
/*!40000 ALTER TABLE `cita_paciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encabezado_condicion`
--

DROP TABLE IF EXISTS `encabezado_condicion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encabezado_condicion` (
  `idencabezado_condicion` int(10) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(250) DEFAULT NULL,
  `idtipo_interpretacion` int(10) NOT NULL,
  PRIMARY KEY (`idencabezado_condicion`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encabezado_condicion`
--

LOCK TABLES `encabezado_condicion` WRITE;
/*!40000 ALTER TABLE `encabezado_condicion` DISABLE KEYS */;
INSERT INTO `encabezado_condicion` VALUES (26,'IF (N1A=1 OR N1A=2 AND N2A=1) OR (N2A=2 OR N2A=3) THEN CEFALEA2=1.CEFALEA',3),(27,'IF (N2A=1 OR N2A=2 AND N1A=1) OR (N1A=2 OR N1A=3) THEN CEFALEA2=1.CEFALEA',3),(28,'IF (N1A=3 OR N1A=4 AND N2A=3 OR N2A=4) THEN CEFALEA2=2.NO CEFALEA',3),(30,'IF (N2A=1 OR N2A=2) AND (N55A=2) THEN TIPOCEFA=1.CEFALEA TENSIONAL',4),(31,'IF N55A=1 THEN TIPOCEFA=2.MIGRANA',4),(32,'IF (N3A=1 OR N3A=2) AND (N55A=2) THEN TIPOCEFA=3.OTRA CEFALEA',4),(33,'IF (N1A=4) AND (N2A=4) AND (N3A=4) AND (N55A=2) THEN TIPOCEFA=4.NO TIENE',4),(34,'IF (N4A=1 OR N4A=2 OR N4A=3) AND (N5A > 0 and < 4) and (N6A=1 OR N6A=2 or n6A=3) THEN VISTA=5.DISMINUIDA CON LENTES',5),(35,'IF (N4A=1 OR N4A=2 OR N4A=3) AND (N5A > 0 and < 4) and (N6A=4) THEN VISTA=4.VISTA LIMITROFE CON LENTES',5),(36,'IF (N4A=4) AND ((N5A=1 OR N5A=2 or n5A=3) and (N6A=1 OR N6A=2 or n6A=3)) THEN VISTA=6.DISMINUIDA SIN LENTES',5),(37,'IF (N4A=1 OR N4A=2) AND ((N5A=4) AND (N6A=4)) THEN VISTA=2.CORREGIDA CON LENTES',5),(38,'IF (N4A=1 OR N4A=2) AND ((N5A=4) AND (N6A=1 OR N6A=2)) THEN VISTA=5.DISMINUIDA CON LENTES',5),(39,'IF (N4A=4) AND ((N5A=1 OR N5A=2) AND (N6A=4)) THEN VISTA=3.VISTA LIMITROFE SIN LENTES',5),(40,'IF (N4A=4) AND ((N5A=4) AND (N6A=4)) THEN VISTA=1.VISTA NORMAL',5),(41,'IF (N4A=4) AND ((N5A=3 AND N6A=4) OR (N5A=4 AND N6A=2 OR N6A=3)) THEN VISTA=\\\'3.VISTA LIMITROFE SIN LENTES\\\'',5),(42,'IF (N4A=1 OR N4A=2 OR N4A=3) AND ((N5A=3) OR (N6A=3)) THEN VISTA=\\\'4.VISTA LIMITROFE CON LENTES\\\'',5),(43,'IF N76A=1 AND N77A=1 THEN VISTA2=\\\'MIOPIA-ASTIGMATISMO\\\'',6),(44,'IF N76A=1 AND N77A=2 THEN VISTA2=\\\'MIOPIA\\\'',6),(45,'IF N76A=2 AND N77A=1 THEN VISTA2=\\\'ASTIGMATISMO\\\'',6),(46,'IF N76A=2 AND N77A=2 THEN VISTA2=\\\'SIN DX\\\'',6),(47,'IF (N7A=1 or n7A=2) AND (N56A=1 AND N80A=1) THEN AUDICION=\\\'3.SORDERA\\\'',7),(48,'IF (N7A=3) AND (N56A=2 AND N80A=1) THEN AUDICION=\\\'2.HIPOACUSIA\\\'',7),(49,'IF (N7A> 0 AND < 3) AND (N56A=2 AND N80=2) THEN AUDICION=\\\'2.HIPOACUSIA\\\'',7),(50,'IF (N7A=3 or n7A=4) AND (N56A=2 AND N80A=2) THEN AUDICION=\\\'1.AUDICION NORMAL\\\'',7),(52,'IF (N9A=1 OR N9A=2 OR N9A=3) THEN CERUMEN2=\\\'1.PROBABLE TAPON\\\'',8),(53,'IF !(N9A=1 OR N9A=2 OR N9A=3) THEN CERUMEN2=\\\'2.NO PROBABLE\\\'',8),(54,'IF (N11A=1) OR (N11A=2) THEN POLVO=\\\'1.SI TIENE\\\'',9),(55,'IF !((N11A=1) OR (N11A=2)) THEN POLVO=\\\'2.NO TIENE\\\'',9),(56,'IF (N12A=1) OR (N12A=2) THEN MARISCOS=\\\'1.SI TIENE\\\'',10),(57,'IF not((N12A=1) OR (N12A=2)) THEN MARISCOS=\\\'2.NO TIENE\\\'',10),(59,'IF (N14A=1) OR (N14A=2) THEN CERDO=\\\'1.SI TIENE\\\'',11),(60,'IF not((N14A=1) OR (N14A=2)) THEN CERDO=\\\'2.NO TIENE\\\'',11),(61,'IF (N13A=1) OR (N13A=2) THEN FRIO=\\\'1.SI TIENE\\\'',12),(62,'IF not((N13A=1) OR (N13A=2)) THEN FRIO=\\\'2.NO TIENE\\\'',12),(63,'IF (N15A=1) OR (N15A=2) THEN PENI=\\\'1.SI TIENE\\\'',13),(64,'IF not((N15A=1) OR (N15A=2)) THEN  PENI=\\\'2.NO TIENE\\\'',13),(65,'IF (N16A=1) OR (N16A=2) THEN ACTINICA=\\\'1.SI TIENE\\\'',14),(66,'IF not((N16A=1) OR (N16A=2)) THEN ACTINICA=\\\'2.NO TIENE\\\'',14),(67,'IF (N11A=1) OR (N11A=2) OR (N12A=1) OR (N12A=2) OR (N14A=1) OR (N14A=2) OR (N13A=1) OR (N13A=2) OR (N15A=1) OR (N15A=2) OR (N16A=1) OR (N16A=2)\\n\\\'1.SI TIENE\\\'\\n',15),(68,'IF NOT((N11A=1) OR (N11A=2) OR (N12A=1) OR (N12A=2) OR (N14A=1) OR (N14A=2) OR (N13A=1) OR (N13A=2) OR (N15A=1) OR (N15A=2) OR (N16A=1) OR (N16A=2))\\n\\\'2.NO TIENE\\\'',15),(69,'IF ((N17A=1 OR N17A=2)) OR ((N18A=1 OR N18A=2)) THEN GENITO2=\\\'2.PROBABLE INFECCION\\\'',16),(70,'IF ((N17A=3 OR N17A=4)) AND ((N18A=3 OR N18A=4)) THEN GENITO2=\\\'1.NO INFECCION\\\'',16),(71,'IF ((N19A=1 OR N19A=2 OR N19=3)) THEN GENITO2=\\\'3.CALCULOS DEL RINON\\\'',16),(72,'* IF SEXO=1 AND ((N20A=1 OR N20A=2 OR N20A=3)) THEN GENITO2=\\\'4.POBLEMA DE TESTICULO\\\'',17),(74,'IF N22A=1 OR N22A=2 THEN GINE=\\\'1.FLUJO VAGINAL\\\'',18),(75,'IF N21A=3 OR N22A=4 THEN GINE=\\\'2.MENSTRUACION IRREGULAR\\\'',18),(76,'IF (N22A=1 OR N22A=2) AND (N21A=3 OR N21A=4) THEN GINE=\\\'6.1 Y 2 (TIENE LAS 2)\\\'',18),(77,'IF N23A=1 OR N23A=2 THEN GINE=\\\'3.DOLOR MENSTRUAL\\\'',18),(78,'IF N73A=1 THEN GINE=\\\'4.QUISTES DE OVARIO\\\'',18),(79,'IF (N22A=1 OR N22A=2) AND (N73A=1) THEN GINE=\\\'8. 1 Y 4\\\'',18),(80,'IF (N22A=1 OR N22A=2) AND (N23A=1 OR N23A=2) THEN GINE=\\\'7. 1 Y 3\\\'',18),(81,'IF (N22A=1 OR N22A=2) AND (N23A=1 OR N23A=2) AND N73A=1 THEN GINE=\\\'9. 1, 2 Y 3\\\'',18),(82,'IF (N22A=3 OR N22A=4) AND (N21A=1 OR N21A=2) AND (N23A=3 OR N23A=4) AND N73A=2 THEN GINE=\\\'5.SIN PROBLEMA\\\'',18),(83,'IF (N21A=4) AND (N22A=3) AND (N23A=3 OR N23A=4) AND (N73A=2) THEN GINE=\\\'5.SIN PROBLEMA\\\'',18),(85,'IF ((N24A=1 OR N25A=1 OR N26A=1) AND (N62A=2 OR N63A=2)) THEN GASTRO2=\\\'2 PROBABLE ENF. PEPTICA\\\'',19),(86,'IF ((N24A=1 OR N25A=1 OR N26A=1) AND (N62A=1 OR N63A=1)) THEN GASTRO2=\\\'1 ENF. PEPTICA\\\'',19),(87,'IF ((N24A=1 OR N25A=1 OR N26A=1) AND (N62A=1 AND N63A=1)) THEN GASTRO2=\\\'1 ENF. PEPTICA\\\'',19),(88,'IF ((N24A=2 OR N25A=2 OR N26A=2) AND (N62A=1 OR N63A=1)) THEN GASTRO2=\\\'1 ENF. PEPTICA\\\'',19),(89,'IF ((N24A=2 OR N25A=2 OR N26A=2) AND (N62A=2 AND N63A=2)) THEN GASTRO2=\\\'2 PROBABLE ENF. PEPTICA\\\'',19),(90,'IF ((N24A=4 OR N24A=3) AND (N25A=4 OR N25A=3) AND (N62A=2 AND N63A=2)) THEN GASTRO2=\\\'3.NO ENF.PEPTICA\\\'',19),(91,'IF ((N24A=4 OR N24A=3) AND (N25A=4 OR N25A=3) AND (N26A=4 OR N26A=3) AND (N62A=1 OR N63A=1)) THEN GASTRO2=\\\'1 ENF. PEPTICA\\\'',19),(92,'IF (N26a=1 or N26a=2) THEN GASTRO3=\\\'1.DIARREA CRONICA\\\'',19),(93,'IF (N27a=1 or N27a=2) THEN GASTRO3=\\\'2.CONSTIPACION\\\'',19),(94,'IF N62a=1  THEN GASTRO3=\\\'3.ULCERA GASTRICA\\\'',19),(95,'IF N63a=1  THEN GASTRO3=\\\'4.REFLUJO\\\'',19),(96,'IF (N29A=1 OR N30A=1) OR (N29A=2 OR N30A=2) THEN MUSCULAR2=\\\'1. DOLOR MUSCULAR MODERADO\\\'',20),(97,'IF (N29A=3 AND N30A=3) THEN MUSCULAR2=\\\'2. DOLOR MUSCULAR LEVE\\\'',20),(98,'IF (N29A=4 OR N30A=4) THEN MUSCULAR2=\\\'3. NO DOLOR MUSCULAR\\\'',20),(99,'IF (N31A > 0 AND < 4)  THEN TABACO2=\\\'1. FUMADOR\\\'',21),(100,'IF (N31A=1 OR N31A=2 OR N31A=3) AND (N32A=\\\'.\\\' OR N32A=4) THEN \\nTABACO2=\\\'2. EX FUMADOR\\\'\\n',21),(101,'IF (N31A=4) AND (N32A=. OR N32A=4) THEN TABACO2=\\\'3. NO FUMADOR\\\'',21),(103,'IF (N36A=1 OR N36A=2 OR N36A=3) AND (N37A=1 OR N37A=2) THEN ALCOHOL2=\\\'1. CONSUMO DE ALTO RIESGO\\\'',22),(104,'IF (N36A=1 OR N36A=2) AND (N37A=3 OR N37A=4) THEN ALCOHOL2=\\\'2. CONSUMO DE RIESGO\\\'',22),(105,'IF (N36A=3) AND (N37A=3 OR N37A=4 OR N37A=. ) THEN ALCOHOL2=\\\'3. CONSUMO SOCIAL\\\'',22),(106,'IF (N36A=4) THEN ALCOHOL2=\\\'4. NO BEBEDOR(A)\\\'',22),(107,'IF (N39A01=1 OR N39A01=2) THEN FISICA2= \\\'1. EJERCICIO ADECUADO\\\'',23),(108,'IF (N39A01=3) THEN FISICA2= \\\'2. EJERCICIO INADECUADO\\\'',23),(109,'IF (N39A01=4) THEN FISICA2= \\\'3. EJERCICIO DEFICIENTE\\\'',23),(111,'IF (N40A=1 OR N40A=2 OR N40A=3) THEN DROGAS2=\\\'1. SI CONSUME\\\'',24),(112,'IF not (N40A=1 OR N40A=2 OR N40A=3)  DROGAS2=\\\'2. NO CONSUME\\\'',24),(113,'IF (N41A=1 OR N41A=2 OR N41A=3) AND (N42A01=1) AND (N43A01=4) THEN SEXUALIDAD=\\\'1. CONDUCTA SEGURA\\\'',25),(114,'IF (N41A=1 OR N41A=2 OR N41A=3) AND (N42A01=2 OR N42A01=3) AND (N43A01=3 OR N43A01=4) THEN SEXUALIDAD=\\\'2. CONDUCTA DE RIESGO\\\'',25),(115,'IF (N41A=1 OR N41A=2 OR N41A=3) AND (N42A01=4)  AND (N43A01=4) THEN SEXUALIDAD=\\\'2. CONDUCTA DE RIESGO\\\'',25),(116,'IF (N41A=1 OR N41A=2 OR N41A=3) AND (N42A01=1)  AND (N43A01=1) THEN SEXUALIDAD=\\\'2. CONDUCTA DE RIESGO\\\'',25),(117,'IF (N41A=1 OR N41A=2 OR N41A=3) AND (N42A01=1)  AND (N43A01=3) THEN SEXUALIDAD=\\\'2. CONDUCTA DE RIESGO\\\'',25),(118,'IF (N41A=1 OR N41A=2 OR N41A=3) AND (N42A01=4) AND (N43A01=1 OR N43A01=2 OR N43A01=3) THEN SEXUALIDAD=\\\'3. CONDUCTA DE ALTO RIESGO\\\'',25),(119,'IF (N41A=4 OR N41A=.) THEN SEXUALIDAD=\\\'4. NO VIDA SEXUAL\\\'',25),(120,'IF N65A=1 THEN CIRUGIA=\\\'1.APENDICECTOMIA\\\'',28),(121,'IF N66A=1 THEN CIRUGIA=\\\'2.COLECISTECTOMIA\\\'',28),(122,'IF N67A=1 THEN CIRUGIA=\\\'3.CIRUGIA DE TESTICULO\\\'',28),(123,'IF N68A=1 THEN CIRUGIA=\\\'4.POSTATECTOMIA\\\'',28),(124,'IF N72A=1 THEN CIRUGIA=\\\'5.CIRUGIA DE OVARIO\\\'',28),(126,'IF (N43B=1 AND N44B=2) OR (N43B=2 OR N44B=1) AND (N49A01=1 OR N49A01=2 OR N49A01=3 OR N49A01=4) THEN NUTRICION=\\\'1. DIETA ADECUADA\\\'',26);
/*!40000 ALTER TABLE `encabezado_condicion` ENABLE KEYS */;
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
INSERT INTO `grupo` VALUES (1,'Siempre, Frecuentemente, Ocasionalmente, No'),(2,'A diario, 1 a 5 Veces/Semana, Ocasionalmente, No'),(3,'Muy pasado(a) de peso, Pasado(a) de peso, Bien de peso, Bajo(a) de peso'),(4,'SI, NO'),(5,'Grupo Familiar'),(6,'Siempre, A veces, Nunca');
/*!40000 ALTER TABLE `grupo` ENABLE KEYS */;
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
INSERT INTO `estado_civil` VALUES (1,'Solter@'),(2,'Casad@'),(3,'Viud@'),(4,'Unid@'),(5,'Divorciad@');
/*!40000 ALTER TABLE `estado_civil` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidad_academica`
--

DROP TABLE IF EXISTS `unidad_academica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unidad_academica` (
  `idunidad_academica` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `codigo` int(10) NOT NULL,
  PRIMARY KEY (`idunidad_academica`),
  UNIQUE KEY `codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidad_academica`
--

LOCK TABLES `unidad_academica` WRITE;
/*!40000 ALTER TABLE `unidad_academica` DISABLE KEYS */;
INSERT INTO `unidad_academica` VALUES (1,'INGENIERÍA',8),(11,'AGRONOMÍA',1),(12,'ARQUITECTURA',2),(13,'CIENCIAS ECONOMICAS',3),(14,'CIENCIAS JURÍDICAS',4),(15,'CIENCIAS MEDICAS',5),(16,'FARMACIA',6),(17,'HUMANIDADES',7),(18,'ODONTOLOGÍA',9),(19,'VETERINARIA',10),(20,'PSICOLOGÍA',13),(21,'HISTORIA',14),(22,'TRABAJO SOCIAL',15),(23,'CC. COMUNICACIÓN',16),(24,'CIENCIA POLITICA',28),(25,'E.F.P.E.M',29),(26,'LINGUISTICA',30),(27,'ESA',33),(28,'ITMES',31),(29,'ITUGS',36),(30,'CUNOC',12),(31,'CUNOR',17),(32,'CUNORI',19),(33,'CUNOROC',20),(34,'CUNSUR',21),(35,'CUNSUROC',22),(36,'CUNSURORI',23),(37,'CEMA',24),(38,'CUSAM',25),(39,'CUDEP',26),(40,'CUNIZAB',27),(41,'CUNSARO',32),(42,'JUSAC',34),(43,'CUNDECH',35),(44,'CUNBAV',37),(45,'CUN PROGRESO',38),(46,'CUNTOTO',39),(47,'CUSACQ',40),(48,'CUNZAC',41);
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
  `password` varchar(100) NOT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `estado` int(11) NOT NULL COMMENT '1-> activo, 2-> desactivado',
  `updateusuario` int(10) DEFAULT NULL,
  `createtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `no_personal` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE KEY `nick` (`nick`),
  KEY `FKusuario800841` (`updateusuario`),
  CONSTRAINT `FKusuario800841` FOREIGN KEY (`updateusuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'admin','admin','root','web@root','24328221','lucita287@gmail.com',1,1,'2012-04-22 17:12:26',''),(2,'Aura Luz','Cifuentes','lucita287','a24328221','24328221','lucita287@gmail.com',1,2,'2012-04-25 18:37:38',''),(3,'Karla','Jimenez','karladejimenez','220508140311','','',1,1,'2012-04-27 14:37:57','20100087'),(4,'Víctor Rodolfo','Comparini Estrada','vrcomparini','vr17183','','',1,4,'2012-04-27 16:22:25','17183'),(5,'David Emanuel Isarel','Velazquez Gomez','deportes','oficina23','45760848','deiv_37@hotmail.com',1,5,'2012-05-03 16:17:03',''),(6,'saul','rojas','srojas','limonada9','','',1,1,'2012-05-07 17:40:40',''),(7,'Irma Yolanda','Chanax Sarmiento','chanaxsar1','juraji','','',1,1,'2012-05-07 20:03:56',''),(8,'roderico','guerra','rguerra','rio26771z16','','',1,1,'2012-05-09 16:27:54',''),(9,'Rita Maria','Figueroa Figueroa','rmff95','solyluna22','','',1,1,'2012-05-17 20:08:18',''),(10,'Danilo','Morales','dmorales','consonante9','42117722','',1,1,'2012-05-24 16:54:36','');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `condicion`
--

DROP TABLE IF EXISTS `condicion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `condicion` (
  `idpregunta1` int(10) DEFAULT NULL,
  `signo` int(10) DEFAULT NULL COMMENT '1 : >, 2 : <, 3 >=, 4 <=, 5 ==, 6 !=',
  `valor` int(10) DEFAULT NULL,
  `tipo` int(10) DEFAULT NULL COMMENT '0 -> condicion, 1-> and, 2 -> or, 3-> parentesis, 4 -> not',
  `idcondicion` int(10) NOT NULL AUTO_INCREMENT,
  `condicion1` int(10) DEFAULT NULL,
  `condicion2` int(10) DEFAULT NULL,
  `idencabezado_condicion` int(10) NOT NULL,
  `inicio` int(10) DEFAULT NULL,
  `descripcion` varchar(300) NOT NULL,
  PRIMARY KEY (`idcondicion`),
  KEY `FKcondicion827801` (`idpregunta1`),
  KEY `FKcondicion335334` (`idencabezado_condicion`),
  KEY `FKcondicion860851` (`condicion1`),
  KEY `FKcondicion860850` (`condicion2`),
  CONSTRAINT `FKcondicion335334` FOREIGN KEY (`idencabezado_condicion`) REFERENCES `encabezado_condicion` (`idencabezado_condicion`) ON DELETE CASCADE,
  CONSTRAINT `FKcondicion827801` FOREIGN KEY (`idpregunta1`) REFERENCES `pregunta` (`idpregunta`) ON DELETE CASCADE,
  CONSTRAINT `FKcondicion860850` FOREIGN KEY (`condicion2`) REFERENCES `condicion` (`idcondicion`) ON DELETE CASCADE,
  CONSTRAINT `FKcondicion860851` FOREIGN KEY (`condicion1`) REFERENCES `condicion` (`idcondicion`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=775 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `condicion`
--

LOCK TABLES `condicion` WRITE;
/*!40000 ALTER TABLE `condicion` DISABLE KEYS */;
INSERT INTO `condicion` VALUES (210,5,1,0,82,NULL,NULL,26,NULL,'P1 = 1'),(210,5,2,0,83,NULL,NULL,26,NULL,'P1 = 2'),(211,5,1,0,84,NULL,NULL,26,NULL,'P2 = 1'),(NULL,NULL,NULL,2,85,82,83,26,NULL,'P1 = 1 OR P1 = 2'),(NULL,NULL,NULL,1,86,85,84,26,NULL,'P1 = 1 OR P1 = 2 AND P2 = 1'),(NULL,NULL,NULL,3,87,86,NULL,26,NULL,'(P1 = 1 OR P1 = 2 AND P2 = 1)'),(211,5,2,0,88,NULL,NULL,26,NULL,'P2 = 2'),(211,5,3,0,89,NULL,NULL,26,NULL,'P2 = 3'),(NULL,NULL,NULL,2,90,88,89,26,NULL,'P2 = 2 OR P2 = 3'),(NULL,NULL,NULL,3,91,90,NULL,26,NULL,'(P2 = 2 OR P2 = 3)'),(NULL,NULL,NULL,2,92,87,91,26,1,'(P1 = 1 OR P1 = 2 AND P2 = 1) OR (P2 = 2 OR P2 = 3)'),(211,5,1,0,93,NULL,NULL,27,NULL,'P2 = 1'),(211,5,2,0,94,NULL,NULL,27,NULL,'P2 = 2'),(210,5,1,0,95,NULL,NULL,27,NULL,'P1 = 1'),(NULL,NULL,NULL,2,96,93,94,27,NULL,'P2 = 1 OR P2 = 2'),(NULL,NULL,NULL,1,97,96,95,27,NULL,'P2 = 1 OR P2 = 2 AND P1 = 1'),(NULL,NULL,NULL,3,98,97,NULL,27,NULL,'(P2 = 1 OR P2 = 2 AND P1 = 1)'),(210,5,2,0,99,NULL,NULL,27,NULL,'P1 = 2'),(210,5,3,0,100,NULL,NULL,27,NULL,'P1 = 3'),(NULL,NULL,NULL,2,101,99,100,27,NULL,'P1 = 2 OR P1 = 3'),(NULL,NULL,NULL,3,102,101,NULL,27,NULL,'(P1 = 2 OR P1 = 3)'),(NULL,NULL,NULL,2,103,98,102,27,1,'(P2 = 1 OR P2 = 2 AND P1 = 1) OR (P1 = 2 OR P1 = 3)'),(210,5,3,0,104,NULL,NULL,28,NULL,'P1 = 3'),(210,5,4,0,105,NULL,NULL,28,NULL,'P1 = 4'),(211,5,3,0,106,NULL,NULL,28,NULL,'P2 = 3'),(211,5,4,0,107,NULL,NULL,28,NULL,'P2 = 4'),(NULL,NULL,NULL,2,108,104,105,28,NULL,'P1 = 3 OR P1 = 4'),(NULL,NULL,NULL,1,109,108,106,28,NULL,'P1 = 3 OR P1 = 4 AND P2 = 3'),(NULL,NULL,NULL,2,110,109,107,28,NULL,'P1 = 3 OR P1 = 4 AND P2 = 3 OR P2 = 4'),(NULL,NULL,NULL,3,111,110,NULL,28,1,'(P1 = 3 OR P1 = 4 AND P2 = 3 OR P2 = 4)'),(211,5,1,0,112,NULL,NULL,30,NULL,'P2 = 1'),(211,5,2,0,113,NULL,NULL,30,NULL,'P2 = 2'),(282,5,2,0,114,NULL,NULL,30,NULL,'P55 = 2'),(NULL,NULL,NULL,2,115,112,113,30,NULL,'P2 = 1 OR P2 = 2'),(NULL,NULL,NULL,3,116,115,NULL,30,NULL,'(P2 = 1 OR P2 = 2)'),(NULL,NULL,NULL,3,118,114,NULL,30,NULL,'(P55 = 2)'),(NULL,NULL,NULL,1,119,116,118,30,1,'(P2 = 1 OR P2 = 2) AND (P55 = 2)'),(282,5,1,0,120,NULL,NULL,31,1,'P55 = 1'),(212,5,1,0,121,NULL,NULL,32,NULL,'P3 = 1'),(212,5,2,0,122,NULL,NULL,32,NULL,'P3 = 2'),(282,5,2,0,123,NULL,NULL,32,NULL,'P55 = 2'),(NULL,NULL,NULL,2,124,121,122,32,NULL,'P3 = 1 OR P3 = 2'),(NULL,NULL,NULL,3,125,124,NULL,32,NULL,'(P3 = 1 OR P3 = 2)'),(NULL,NULL,NULL,3,126,123,NULL,32,NULL,'(P55 = 2)'),(NULL,NULL,NULL,1,127,125,126,32,1,'(P3 = 1 OR P3 = 2) AND (P55 = 2)'),(210,5,4,0,128,NULL,NULL,33,NULL,'P1 = 4'),(211,5,4,0,129,NULL,NULL,33,NULL,'P2 = 4'),(212,5,4,0,130,NULL,NULL,33,NULL,'P3 = 4'),(282,5,2,0,131,NULL,NULL,33,NULL,'P55 = 2'),(NULL,NULL,NULL,1,132,128,129,33,NULL,'P1 = 4 AND P2 = 4'),(NULL,NULL,NULL,1,133,132,130,33,NULL,'P1 = 4 AND P2 = 4 AND P3 = 4'),(NULL,NULL,NULL,1,134,133,131,33,1,'P1 = 4 AND P2 = 4 AND P3 = 4 AND P55 = 2'),(213,5,1,0,135,NULL,NULL,34,NULL,'P4 = 1'),(213,5,2,0,136,NULL,NULL,34,NULL,'P4 = 2'),(213,5,3,0,137,NULL,NULL,34,NULL,'P4 = 3'),(NULL,NULL,NULL,2,138,135,136,34,NULL,'P4 = 1 OR P4 = 2'),(NULL,NULL,NULL,2,139,138,137,34,NULL,'P4 = 1 OR P4 = 2 OR P4 = 3'),(NULL,NULL,NULL,3,140,139,NULL,34,NULL,'(P4 = 1 OR P4 = 2 OR P4 = 3)'),(214,1,0,0,141,NULL,NULL,34,NULL,'P5 > 0'),(214,2,4,0,142,NULL,NULL,34,NULL,'P5 < 4'),(NULL,NULL,NULL,1,143,141,142,34,NULL,'P5 > 0 AND P5 < 4'),(215,5,1,0,144,NULL,NULL,34,NULL,'P6 = 1'),(215,5,2,0,145,NULL,NULL,34,NULL,'P6 = 2'),(215,5,3,0,146,NULL,NULL,34,NULL,'P6 = 3'),(NULL,NULL,NULL,3,147,143,NULL,34,NULL,'(P5 > 0 AND P5 < 4)'),(NULL,NULL,NULL,2,148,144,145,34,NULL,'P6 = 1 OR P6 = 2'),(NULL,NULL,NULL,2,149,148,146,34,NULL,'P6 = 1 OR P6 = 2 OR P6 = 3'),(NULL,NULL,NULL,3,150,149,NULL,34,1,'(P6 = 1 OR P6 = 2 OR P6 = 3)'),(213,5,1,0,151,NULL,NULL,35,NULL,'P4 = 1'),(213,5,2,0,152,NULL,NULL,35,NULL,'P4 = 2'),(213,5,3,0,153,NULL,NULL,35,NULL,'P4 = 3'),(NULL,NULL,NULL,2,154,151,152,35,NULL,'P4 = 1 OR P4 = 2'),(NULL,NULL,NULL,2,155,154,153,35,NULL,'P4 = 1 OR P4 = 2 OR P4 = 3'),(NULL,NULL,NULL,3,156,155,NULL,35,NULL,'(P4 = 1 OR P4 = 2 OR P4 = 3)'),(214,1,0,0,157,NULL,NULL,35,NULL,'P5 > 0'),(214,2,4,0,158,NULL,NULL,35,NULL,'P5 < 4'),(NULL,NULL,NULL,1,159,157,158,35,NULL,'P5 > 0 AND P5 < 4'),(NULL,NULL,NULL,3,160,159,NULL,35,NULL,'(P5 > 0 AND P5 < 4)'),(215,5,4,0,161,NULL,NULL,35,NULL,'P6 = 4'),(NULL,NULL,NULL,3,162,161,NULL,35,NULL,'(P6 = 4)'),(NULL,NULL,NULL,1,163,156,160,35,NULL,'(P4 = 1 OR P4 = 2 OR P4 = 3) AND (P5 > 0 AND P5 < 4)'),(NULL,NULL,NULL,1,164,163,162,35,1,'(P4 = 1 OR P4 = 2 OR P4 = 3) AND (P5 > 0 AND P5 < 4) AND (P6 = 4)'),(213,5,4,0,165,NULL,NULL,36,NULL,'P4 = 4'),(214,5,1,0,166,NULL,NULL,36,NULL,'P5 = 1'),(214,5,2,0,167,NULL,NULL,36,NULL,'P5 = 2'),(214,5,3,0,168,NULL,NULL,36,NULL,'P5 = 3'),(NULL,NULL,NULL,3,169,165,NULL,36,NULL,'(P4 = 4)'),(NULL,NULL,NULL,2,170,166,167,36,NULL,'P5 = 1 OR P5 = 2'),(NULL,NULL,NULL,2,172,170,168,36,NULL,'P5 = 1 OR P5 = 2 OR P5 = 3'),(NULL,NULL,NULL,3,173,172,NULL,36,NULL,'(P5 = 1 OR P5 = 2 OR P5 = 3)'),(215,5,1,0,174,NULL,NULL,36,NULL,'P6 = 1'),(215,5,2,0,175,NULL,NULL,36,NULL,'P6 = 2'),(215,5,3,0,176,NULL,NULL,36,NULL,'P6 = 3'),(NULL,NULL,NULL,2,177,174,175,36,NULL,'P6 = 1 OR P6 = 2'),(NULL,NULL,NULL,2,178,177,176,36,NULL,'P6 = 1 OR P6 = 2 OR P6 = 3'),(NULL,NULL,NULL,3,179,178,NULL,36,NULL,'(P6 = 1 OR P6 = 2 OR P6 = 3)'),(NULL,NULL,NULL,1,181,173,179,36,NULL,'(P5 = 1 OR P5 = 2 OR P5 = 3) AND (P6 = 1 OR P6 = 2 OR P6 = 3)'),(NULL,NULL,NULL,3,182,181,NULL,36,NULL,'((P5 = 1 OR P5 = 2 OR P5 = 3) AND (P6 = 1 OR P6 = 2 OR P6 = 3))'),(NULL,NULL,NULL,1,183,169,182,36,1,'(P4 = 4) AND ((P5 = 1 OR P5 = 2 OR P5 = 3) AND (P6 = 1 OR P6 = 2 OR P6 = 3))'),(213,5,1,0,184,NULL,NULL,37,NULL,'P4 = 1'),(213,5,2,0,185,NULL,NULL,37,NULL,'P4 = 2'),(NULL,NULL,NULL,2,186,184,185,37,NULL,'P4 = 1 OR P4 = 2'),(NULL,NULL,NULL,3,187,186,NULL,37,NULL,'(P4 = 1 OR P4 = 2)'),(214,5,4,0,188,NULL,NULL,37,NULL,'P5 = 4'),(215,5,4,0,189,NULL,NULL,37,NULL,'P6 = 4'),(NULL,NULL,NULL,1,190,188,189,37,NULL,'P5 = 4 AND P6 = 4'),(NULL,NULL,NULL,3,191,190,NULL,37,NULL,'(P5 = 4 AND P6 = 4)'),(NULL,NULL,NULL,1,192,187,191,37,1,'(P4 = 1 OR P4 = 2) AND (P5 = 4 AND P6 = 4)'),(213,5,1,0,193,NULL,NULL,38,NULL,'P4 = 1'),(213,5,2,0,194,NULL,NULL,38,NULL,'P4 = 2'),(NULL,NULL,NULL,2,195,193,194,38,NULL,'P4 = 1 OR P4 = 2'),(NULL,NULL,NULL,3,196,195,NULL,38,NULL,'(P4 = 1 OR P4 = 2)'),(214,5,4,0,197,NULL,NULL,38,NULL,'P5 = 4'),(NULL,NULL,NULL,3,198,197,NULL,38,NULL,'(P5 = 4)'),(215,5,1,0,199,NULL,NULL,38,NULL,'P6 = 1'),(215,5,2,0,200,NULL,NULL,38,NULL,'P6 = 2'),(NULL,NULL,NULL,2,201,199,200,38,NULL,'P6 = 1 OR P6 = 2'),(NULL,NULL,NULL,3,202,201,NULL,38,NULL,'(P6 = 1 OR P6 = 2)'),(NULL,NULL,NULL,1,203,198,202,38,NULL,'(P5 = 4) AND (P6 = 1 OR P6 = 2)'),(NULL,NULL,NULL,3,204,203,NULL,38,NULL,'((P5 = 4) AND (P6 = 1 OR P6 = 2))'),(NULL,NULL,NULL,1,205,196,204,38,1,'(P4 = 1 OR P4 = 2) AND ((P5 = 4) AND (P6 = 1 OR P6 = 2))'),(213,5,4,0,206,NULL,NULL,39,NULL,'P4 = 4'),(NULL,NULL,NULL,3,207,206,NULL,39,NULL,'(P4 = 4)'),(214,5,1,0,208,NULL,NULL,39,NULL,'P5 = 1'),(214,5,2,0,209,NULL,NULL,39,NULL,'P5 = 2'),(NULL,NULL,NULL,2,210,208,209,39,NULL,'P5 = 1 OR P5 = 2'),(NULL,NULL,NULL,3,211,210,NULL,39,NULL,'(P5 = 1 OR P5 = 2)'),(215,5,4,0,212,NULL,NULL,39,NULL,'P6 = 4'),(NULL,NULL,NULL,3,213,212,NULL,39,NULL,'(P6 = 4)'),(NULL,NULL,NULL,1,214,211,213,39,NULL,'(P5 = 1 OR P5 = 2) AND (P6 = 4)'),(NULL,NULL,NULL,3,215,214,NULL,39,NULL,'((P5 = 1 OR P5 = 2) AND (P6 = 4))'),(NULL,NULL,NULL,1,216,207,215,39,1,'(P4 = 4) AND ((P5 = 1 OR P5 = 2) AND (P6 = 4))'),(213,5,4,0,217,NULL,NULL,40,NULL,'P4 = 4'),(NULL,NULL,NULL,3,218,217,NULL,40,NULL,'(P4 = 4)'),(214,5,4,0,219,NULL,NULL,40,NULL,'P5 = 4'),(215,5,4,0,220,NULL,NULL,40,NULL,'P6 = 4'),(NULL,NULL,NULL,1,221,218,219,40,NULL,'(P4 = 4) AND P5 = 4'),(NULL,NULL,NULL,1,222,221,220,40,1,'(P4 = 4) AND P5 = 4 AND P6 = 4'),(213,5,4,0,223,NULL,NULL,41,NULL,'P4 = 4'),(NULL,NULL,NULL,3,224,223,NULL,41,NULL,'(P4 = 4)'),(214,5,3,0,225,NULL,NULL,41,NULL,'P5 = 3'),(215,5,4,0,226,NULL,NULL,41,NULL,'P6 = 4'),(NULL,NULL,NULL,1,228,225,226,41,NULL,'P5 = 3 AND P6 = 4'),(NULL,NULL,NULL,3,229,228,NULL,41,NULL,'(P5 = 3 AND P6 = 4)'),(214,5,4,0,230,NULL,NULL,41,NULL,'P5 = 4'),(215,5,2,0,231,NULL,NULL,41,NULL,'P6 = 2'),(215,5,3,0,232,NULL,NULL,41,NULL,'P6 = 3'),(NULL,NULL,NULL,1,236,230,231,41,NULL,'P5 = 4 AND P6 = 2'),(NULL,NULL,NULL,2,237,236,232,41,NULL,'P5 = 4 AND P6 = 2 OR P6 = 3'),(NULL,NULL,NULL,3,238,237,NULL,41,NULL,'(P5 = 4 AND P6 = 2 OR P6 = 3)'),(NULL,NULL,NULL,2,239,229,238,41,NULL,'(P5 = 3 AND P6 = 4) OR (P5 = 4 AND P6 = 2 OR P6 = 3)'),(NULL,NULL,NULL,3,240,239,NULL,41,NULL,'((P5 = 3 AND P6 = 4) OR (P5 = 4 AND P6 = 2 OR P6 = 3))'),(NULL,NULL,NULL,1,241,224,240,41,1,'(P4 = 4) AND ((P5 = 3 AND P6 = 4) OR (P5 = 4 AND P6 = 2 OR P6 = 3))'),(213,5,1,0,242,NULL,NULL,42,NULL,'P4 = 1'),(213,5,2,0,243,NULL,NULL,42,NULL,'P4 = 2'),(213,5,3,0,244,NULL,NULL,42,NULL,'P4 = 3'),(NULL,NULL,NULL,2,245,242,243,42,NULL,'P4 = 1 OR P4 = 2'),(NULL,NULL,NULL,2,246,245,244,42,NULL,'P4 = 1 OR P4 = 2 OR P4 = 3'),(NULL,NULL,NULL,3,247,246,NULL,42,NULL,'(P4 = 1 OR P4 = 2 OR P4 = 3)'),(214,5,3,0,248,NULL,NULL,42,NULL,'P5 = 3'),(215,5,3,0,249,NULL,NULL,42,NULL,'P6 = 3'),(NULL,NULL,NULL,2,250,248,249,42,NULL,'P5 = 3 OR P6 = 3'),(NULL,NULL,NULL,3,251,250,NULL,42,NULL,'(P5 = 3 OR P6 = 3)'),(NULL,NULL,NULL,1,252,247,251,42,1,'(P4 = 1 OR P4 = 2 OR P4 = 3) AND (P5 = 3 OR P6 = 3)'),(304,5,1,0,253,NULL,NULL,43,NULL,'P76 = 1'),(305,5,1,0,254,NULL,NULL,43,NULL,'P77 = 1'),(NULL,NULL,NULL,1,255,253,254,43,1,'P76 = 1 AND P77 = 1'),(304,5,1,0,256,NULL,NULL,44,NULL,'P76 = 1'),(305,5,2,0,257,NULL,NULL,44,NULL,'P77 = 2'),(NULL,NULL,NULL,1,258,256,257,44,1,'P76 = 1 AND P77 = 2'),(304,5,2,0,259,NULL,NULL,45,NULL,'P76 = 2'),(305,5,1,0,260,NULL,NULL,45,NULL,'P77 = 1'),(NULL,NULL,NULL,1,261,259,260,45,1,'P76 = 2 AND P77 = 1'),(304,5,2,0,262,NULL,NULL,46,NULL,'P76 = 2'),(305,5,2,0,263,NULL,NULL,46,NULL,'P77 = 2'),(NULL,NULL,NULL,1,264,262,263,46,1,'P76 = 2 AND P77 = 2'),(216,5,1,0,265,NULL,NULL,47,NULL,'P7 = 1'),(216,5,2,0,266,NULL,NULL,47,NULL,'P7 = 2'),(NULL,NULL,NULL,2,267,265,266,47,NULL,'P7 = 1 OR P7 = 2'),(283,5,1,0,268,NULL,NULL,47,NULL,'P56 = 1'),(308,5,1,0,269,NULL,NULL,47,NULL,'P80 = 1'),(NULL,NULL,NULL,3,271,267,NULL,47,NULL,'(P7 = 1 OR P7 = 2)'),(NULL,NULL,NULL,1,272,268,269,47,NULL,'P56 = 1 AND P80 = 1'),(NULL,NULL,NULL,3,273,272,NULL,47,NULL,'(P56 = 1 AND P80 = 1)'),(NULL,NULL,NULL,1,274,271,273,47,1,'(P7 = 1 OR P7 = 2) AND (P56 = 1 AND P80 = 1)'),(216,5,3,0,275,NULL,NULL,48,NULL,'P7 = 3'),(283,5,2,0,276,NULL,NULL,48,NULL,'P56 = 2'),(308,5,1,0,277,NULL,NULL,48,NULL,'P80 = 1'),(NULL,NULL,NULL,1,278,276,277,48,NULL,'P56 = 2 AND P80 = 1'),(NULL,NULL,NULL,3,279,278,NULL,48,NULL,'(P56 = 2 AND P80 = 1)'),(NULL,NULL,NULL,3,280,275,NULL,48,NULL,'(P7 = 3)'),(NULL,NULL,NULL,1,281,280,279,48,1,'(P7 = 3) AND (P56 = 2 AND P80 = 1)'),(216,1,0,0,282,NULL,NULL,49,NULL,'P7 > 0'),(216,2,3,0,283,NULL,NULL,49,NULL,'P7 < 3'),(NULL,NULL,NULL,1,284,282,283,49,NULL,'P7 > 0 AND P7 < 3'),(283,5,2,0,285,NULL,NULL,49,NULL,'P56 = 2'),(308,5,2,0,286,NULL,NULL,49,NULL,'P80 = 2'),(NULL,NULL,NULL,1,287,285,286,49,NULL,'P56 = 2 AND P80 = 2'),(NULL,NULL,NULL,3,288,287,NULL,49,NULL,'(P56 = 2 AND P80 = 2)'),(NULL,NULL,NULL,3,289,284,NULL,49,NULL,'(P7 > 0 AND P7 < 3)'),(NULL,NULL,NULL,1,290,289,288,49,1,'(P7 > 0 AND P7 < 3) AND (P56 = 2 AND P80 = 2)'),(216,5,3,0,291,NULL,NULL,50,NULL,'P7 = 3'),(216,5,4,0,292,NULL,NULL,50,NULL,'P7 = 4'),(NULL,NULL,NULL,2,293,291,292,50,NULL,'P7 = 3 OR P7 = 4'),(NULL,NULL,NULL,3,294,293,NULL,50,NULL,'(P7 = 3 OR P7 = 4)'),(283,5,2,0,295,NULL,NULL,50,NULL,'P56 = 2'),(308,5,2,0,296,NULL,NULL,50,NULL,'P80 = 2'),(NULL,NULL,NULL,1,297,295,296,50,NULL,'P56 = 2 AND P80 = 2'),(NULL,NULL,NULL,3,298,297,NULL,50,NULL,'(P56 = 2 AND P80 = 2)'),(NULL,NULL,NULL,1,299,294,298,50,1,'(P7 = 3 OR P7 = 4) AND (P56 = 2 AND P80 = 2)'),(218,5,1,0,301,NULL,NULL,52,NULL,'P9 = 1'),(218,5,2,0,302,NULL,NULL,52,NULL,'P9 = 2'),(218,5,3,0,303,NULL,NULL,52,NULL,'P9 = 3'),(NULL,NULL,NULL,2,304,301,302,52,NULL,'P9 = 1 OR P9 = 2'),(NULL,NULL,NULL,2,305,304,303,52,1,'P9 = 1 OR P9 = 2 OR P9 = 3'),(218,5,1,0,306,NULL,NULL,53,NULL,'P9 = 1'),(218,5,2,0,307,NULL,NULL,53,NULL,'P9 = 2'),(218,5,3,0,308,NULL,NULL,53,NULL,'P9 = 3'),(NULL,NULL,NULL,2,309,306,307,53,NULL,'P9 = 1 OR P9 = 2'),(NULL,NULL,NULL,2,310,309,308,53,NULL,'P9 = 1 OR P9 = 2 OR P9 = 3'),(NULL,NULL,NULL,3,311,310,NULL,53,NULL,'(P9 = 1 OR P9 = 2 OR P9 = 3)'),(NULL,NULL,NULL,4,312,311,NULL,53,1,'NOT((P9 = 1 OR P9 = 2 OR P9 = 3))'),(273,5,1,0,313,NULL,NULL,54,NULL,'P11 = 1'),(273,5,2,0,314,NULL,NULL,54,NULL,'P11 = 2'),(NULL,NULL,NULL,2,315,313,314,54,1,'P11 = 1 OR P11 = 2'),(273,5,1,0,316,NULL,NULL,55,NULL,'P11 = 1'),(273,5,2,0,317,NULL,NULL,55,NULL,'P11 = 2'),(NULL,NULL,NULL,2,318,316,317,55,NULL,'P11 = 1 OR P11 = 2'),(NULL,NULL,NULL,4,319,318,NULL,55,1,'NOT(P11 = 1 OR P11 = 2)'),(274,5,1,0,320,NULL,NULL,56,NULL,'P12 = 1'),(274,5,2,0,321,NULL,NULL,56,NULL,'P12 = 2'),(NULL,NULL,NULL,2,322,320,321,56,1,'P12 = 1 OR P12 = 2'),(274,5,1,0,323,NULL,NULL,57,NULL,'P12 = 1'),(274,5,2,0,324,NULL,NULL,57,NULL,'P12 = 2'),(NULL,NULL,NULL,2,325,323,324,57,NULL,'P12 = 1 OR P12 = 2'),(NULL,NULL,NULL,4,326,325,NULL,57,1,'NOT(P12 = 1 OR P12 = 2)'),(276,5,1,0,329,NULL,NULL,59,NULL,'P14 = 1'),(276,5,2,0,330,NULL,NULL,59,NULL,'P14 = 2'),(NULL,NULL,NULL,2,331,329,330,59,1,'P14 = 1 OR P14 = 2'),(276,5,1,0,332,NULL,NULL,60,NULL,'P14 = 1'),(276,5,2,0,333,NULL,NULL,60,NULL,'P14 = 2'),(NULL,NULL,NULL,2,334,332,333,60,NULL,'P14 = 1 OR P14 = 2'),(NULL,NULL,NULL,4,335,334,NULL,60,1,'NOT(P14 = 1 OR P14 = 2)'),(275,5,1,0,336,NULL,NULL,61,NULL,'P13 = 1'),(275,5,2,0,337,NULL,NULL,61,NULL,'P13 = 2'),(NULL,NULL,NULL,2,338,336,337,61,1,'P13 = 1 OR P13 = 2'),(275,5,1,0,339,NULL,NULL,62,NULL,'P13 = 1'),(275,5,2,0,340,NULL,NULL,62,NULL,'P13 = 2'),(NULL,NULL,NULL,2,341,339,340,62,NULL,'P13 = 1 OR P13 = 2'),(NULL,NULL,NULL,4,342,341,NULL,62,1,'NOT(P13 = 1 OR P13 = 2)'),(277,5,1,0,343,NULL,NULL,63,NULL,'P15 = 1'),(277,5,2,0,344,NULL,NULL,63,NULL,'P15 = 2'),(NULL,NULL,NULL,2,345,343,344,63,1,'P15 = 1 OR P15 = 2'),(277,5,1,0,346,NULL,NULL,64,NULL,'P15 = 1'),(277,5,2,0,347,NULL,NULL,64,NULL,'P15 = 2'),(NULL,NULL,NULL,2,348,346,347,64,NULL,'P15 = 1 OR P15 = 2'),(NULL,NULL,NULL,4,349,348,NULL,64,1,'NOT(P15 = 1 OR P15 = 2)'),(278,5,1,0,350,NULL,NULL,65,NULL,'P16 = 1'),(278,5,2,0,351,NULL,NULL,65,NULL,'P16 = 2'),(NULL,NULL,NULL,2,352,350,351,65,1,'P16 = 1 OR P16 = 2'),(278,5,1,0,353,NULL,NULL,66,NULL,'P16 = 1'),(278,5,2,0,354,NULL,NULL,66,NULL,'P16 = 2'),(NULL,NULL,NULL,2,355,353,354,66,NULL,'P16 = 1 OR P16 = 2'),(NULL,NULL,NULL,4,356,355,NULL,66,1,'NOT(P16 = 1 OR P16 = 2)'),(273,5,1,0,357,NULL,NULL,67,NULL,'P11 = 1'),(273,5,2,0,358,NULL,NULL,67,NULL,'P11 = 2'),(NULL,NULL,NULL,2,359,357,358,67,NULL,'P11 = 1 OR P11 = 2'),(274,5,1,0,360,NULL,NULL,67,NULL,'P12 = 1'),(274,5,2,0,361,NULL,NULL,67,NULL,'P12 = 2'),(NULL,NULL,NULL,2,362,360,361,67,NULL,'P12 = 1 OR P12 = 2'),(275,5,1,0,363,NULL,NULL,67,NULL,'P13 = 1'),(275,5,2,0,364,NULL,NULL,67,NULL,'P13 = 2'),(NULL,NULL,NULL,2,365,363,364,67,NULL,'P13 = 1 OR P13 = 2'),(276,5,1,0,366,NULL,NULL,67,NULL,'P14 = 1'),(276,5,2,0,367,NULL,NULL,67,NULL,'P14 = 2'),(NULL,NULL,NULL,2,368,366,367,67,NULL,'P14 = 1 OR P14 = 2'),(277,5,1,0,369,NULL,NULL,67,NULL,'P15 = 1'),(277,5,2,0,370,NULL,NULL,67,NULL,'P15 = 2'),(NULL,NULL,NULL,2,371,369,370,67,NULL,'P15 = 1 OR P15 = 2'),(278,5,1,0,372,NULL,NULL,67,NULL,'P16 = 1'),(278,5,2,0,373,NULL,NULL,67,NULL,'P16 = 2'),(NULL,NULL,NULL,2,374,372,373,67,NULL,'P16 = 1 OR P16 = 2'),(NULL,NULL,NULL,2,375,359,362,67,NULL,'P11 = 1 OR P11 = 2 OR P12 = 1 OR P12 = 2'),(NULL,NULL,NULL,2,376,375,365,67,NULL,'P11 = 1 OR P11 = 2 OR P12 = 1 OR P12 = 2 OR P13 = 1 OR P13 = 2'),(NULL,NULL,NULL,2,377,376,368,67,NULL,'P11 = 1 OR P11 = 2 OR P12 = 1 OR P12 = 2 OR P13 = 1 OR P13 = 2 OR P14 = 1 OR P14 = 2'),(NULL,NULL,NULL,2,378,377,371,67,NULL,'P11 = 1 OR P11 = 2 OR P12 = 1 OR P12 = 2 OR P13 = 1 OR P13 = 2 OR P14 = 1 OR P14 = 2 OR P15 = 1 OR P15 = 2'),(NULL,NULL,NULL,2,379,378,374,67,1,'P11 = 1 OR P11 = 2 OR P12 = 1 OR P12 = 2 OR P13 = 1 OR P13 = 2 OR P14 = 1 OR P14 = 2 OR P15 = 1 OR P15 = 2 OR P16 = 1 OR P16 = 2'),(273,5,1,0,380,NULL,NULL,68,NULL,'P11 = 1'),(273,5,2,0,381,NULL,NULL,68,NULL,'P11 = 2'),(NULL,NULL,NULL,2,382,380,381,68,NULL,'P11 = 1 OR P11 = 2'),(274,5,1,0,383,NULL,NULL,68,NULL,'P12 = 1'),(274,5,2,0,384,NULL,NULL,68,NULL,'P12 = 2'),(NULL,NULL,NULL,2,385,383,384,68,NULL,'P12 = 1 OR P12 = 2'),(275,5,1,0,386,NULL,NULL,68,NULL,'P13 = 1'),(275,5,2,0,387,NULL,NULL,68,NULL,'P13 = 2'),(NULL,NULL,NULL,2,388,386,387,68,NULL,'P13 = 1 OR P13 = 2'),(276,5,1,0,389,NULL,NULL,68,NULL,'P14 = 1'),(276,5,2,0,390,NULL,NULL,68,NULL,'P14 = 2'),(NULL,NULL,NULL,2,391,389,390,68,NULL,'P14 = 1 OR P14 = 2'),(277,5,1,0,392,NULL,NULL,68,NULL,'P15 = 1'),(277,5,2,0,393,NULL,NULL,68,NULL,'P15 = 2'),(NULL,NULL,NULL,2,394,392,393,68,NULL,'P15 = 1 OR P15 = 2'),(278,5,1,0,395,NULL,NULL,68,NULL,'P16 = 1'),(278,5,2,0,396,NULL,NULL,68,NULL,'P16 = 2'),(NULL,NULL,NULL,2,397,395,396,68,NULL,'P16 = 1 OR P16 = 2'),(NULL,NULL,NULL,2,398,382,385,68,NULL,'P11 = 1 OR P11 = 2 OR P12 = 1 OR P12 = 2'),(NULL,NULL,NULL,2,399,398,388,68,NULL,'P11 = 1 OR P11 = 2 OR P12 = 1 OR P12 = 2 OR P13 = 1 OR P13 = 2'),(NULL,NULL,NULL,2,400,399,391,68,NULL,'P11 = 1 OR P11 = 2 OR P12 = 1 OR P12 = 2 OR P13 = 1 OR P13 = 2 OR P14 = 1 OR P14 = 2'),(NULL,NULL,NULL,2,401,400,394,68,NULL,'P11 = 1 OR P11 = 2 OR P12 = 1 OR P12 = 2 OR P13 = 1 OR P13 = 2 OR P14 = 1 OR P14 = 2 OR P15 = 1 OR P15 = 2'),(NULL,NULL,NULL,2,402,401,397,68,NULL,'P11 = 1 OR P11 = 2 OR P12 = 1 OR P12 = 2 OR P13 = 1 OR P13 = 2 OR P14 = 1 OR P14 = 2 OR P15 = 1 OR P15 = 2 OR P16 = 1 OR P16 = 2'),(NULL,NULL,NULL,4,403,402,NULL,68,1,'NOT(P11 = 1 OR P11 = 2 OR P12 = 1 OR P12 = 2 OR P13 = 1 OR P13 = 2 OR P14 = 1 OR P14 = 2 OR P15 = 1 OR P15 = 2 OR P16 = 1 OR P16 = 2)'),(220,5,1,0,404,NULL,NULL,69,NULL,'P17 = 1'),(220,5,2,0,405,NULL,NULL,69,NULL,'P17 = 2'),(221,5,1,0,406,NULL,NULL,69,NULL,'P18 = 1'),(221,5,2,0,407,NULL,NULL,69,NULL,'P18 = 2'),(NULL,NULL,NULL,2,408,404,405,69,NULL,'P17 = 1 OR P17 = 2'),(NULL,NULL,NULL,2,409,406,407,69,NULL,'P18 = 1 OR P18 = 2'),(NULL,NULL,NULL,3,410,408,NULL,69,NULL,'(P17 = 1 OR P17 = 2)'),(NULL,NULL,NULL,3,411,409,NULL,69,NULL,'(P18 = 1 OR P18 = 2)'),(NULL,NULL,NULL,2,412,410,411,69,1,'(P17 = 1 OR P17 = 2) OR (P18 = 1 OR P18 = 2)'),(220,5,3,0,413,NULL,NULL,70,NULL,'P17 = 3'),(220,5,4,0,414,NULL,NULL,70,NULL,'P17 = 4'),(NULL,NULL,NULL,2,415,413,414,70,NULL,'P17 = 3 OR P17 = 4'),(221,5,3,0,416,NULL,NULL,70,NULL,'P18 = 3'),(221,5,4,0,417,NULL,NULL,70,NULL,'P18 = 4'),(NULL,NULL,NULL,2,418,416,417,70,NULL,'P18 = 3 OR P18 = 4'),(NULL,NULL,NULL,3,419,415,NULL,70,NULL,'(P17 = 3 OR P17 = 4)'),(NULL,NULL,NULL,3,420,418,NULL,70,NULL,'(P18 = 3 OR P18 = 4)'),(NULL,NULL,NULL,1,421,419,420,70,1,'(P17 = 3 OR P17 = 4) AND (P18 = 3 OR P18 = 4)'),(222,5,1,0,422,NULL,NULL,71,NULL,'P19 = 1'),(222,5,2,0,423,NULL,NULL,71,NULL,'P19 = 2'),(222,5,3,0,424,NULL,NULL,71,NULL,'P19 = 3'),(NULL,NULL,NULL,2,425,422,423,71,NULL,'P19 = 1 OR P19 = 2'),(NULL,NULL,NULL,2,426,425,424,71,1,'P19 = 1 OR P19 = 2 OR P19 = 3'),(223,5,1,0,427,NULL,NULL,72,NULL,'P20 = 1'),(223,5,2,0,428,NULL,NULL,72,NULL,'P20 = 2'),(223,5,3,0,429,NULL,NULL,72,NULL,'P20 = 3'),(NULL,NULL,NULL,2,430,427,428,72,NULL,'P20 = 1 OR P20 = 2'),(NULL,NULL,NULL,2,431,430,429,72,1,'P20 = 1 OR P20 = 2 OR P20 = 3'),(225,5,1,0,435,NULL,NULL,74,NULL,'P22 = 1'),(225,5,2,0,436,NULL,NULL,74,NULL,'P22 = 2'),(NULL,NULL,NULL,2,437,435,436,74,1,'P22 = 1 OR P22 = 2'),(224,5,3,0,438,NULL,NULL,75,NULL,'P21 = 3'),(225,5,4,0,439,NULL,NULL,75,NULL,'P22 = 4'),(NULL,NULL,NULL,2,440,438,439,75,1,'P21 = 3 OR P22 = 4'),(225,5,1,0,441,NULL,NULL,76,NULL,'P22 = 1'),(225,5,2,0,442,NULL,NULL,76,NULL,'P22 = 2'),(NULL,NULL,NULL,2,443,441,442,76,NULL,'P22 = 1 OR P22 = 2'),(NULL,NULL,NULL,3,444,443,NULL,76,NULL,'(P22 = 1 OR P22 = 2)'),(224,5,3,0,445,NULL,NULL,76,NULL,'P21 = 3'),(224,5,4,0,446,NULL,NULL,76,NULL,'P21 = 4'),(NULL,NULL,NULL,2,447,445,446,76,NULL,'P21 = 3 OR P21 = 4'),(NULL,NULL,NULL,3,448,447,NULL,76,NULL,'(P21 = 3 OR P21 = 4)'),(NULL,NULL,NULL,1,449,444,448,76,1,'(P22 = 1 OR P22 = 2) AND (P21 = 3 OR P21 = 4)'),(226,5,1,0,450,NULL,NULL,77,NULL,'P23 = 1'),(226,5,2,0,451,NULL,NULL,77,NULL,'P23 = 2'),(NULL,NULL,NULL,1,452,450,451,77,1,'P23 = 1 AND P23 = 2'),(302,5,1,0,453,NULL,NULL,78,1,'P73 = 1'),(225,5,1,0,454,NULL,NULL,79,NULL,'P22 = 1'),(225,5,2,0,455,NULL,NULL,79,NULL,'P22 = 2'),(NULL,NULL,NULL,2,456,454,455,79,NULL,'P22 = 1 OR P22 = 2'),(NULL,NULL,NULL,3,457,456,NULL,79,NULL,'(P22 = 1 OR P22 = 2)'),(302,5,1,0,458,NULL,NULL,79,NULL,'P73 = 1'),(NULL,NULL,NULL,3,459,458,NULL,79,NULL,'(P73 = 1)'),(NULL,NULL,NULL,1,460,457,459,79,1,'(P22 = 1 OR P22 = 2) AND (P73 = 1)'),(225,5,1,0,461,NULL,NULL,80,NULL,'P22 = 1'),(225,5,2,0,462,NULL,NULL,80,NULL,'P22 = 2'),(NULL,NULL,NULL,2,463,461,462,80,NULL,'P22 = 1 OR P22 = 2'),(NULL,NULL,NULL,3,464,463,NULL,80,NULL,'(P22 = 1 OR P22 = 2)'),(226,5,1,0,465,NULL,NULL,80,NULL,'P23 = 1'),(226,5,2,0,466,NULL,NULL,80,NULL,'P23 = 2'),(NULL,NULL,NULL,2,467,465,466,80,NULL,'P23 = 1 OR P23 = 2'),(NULL,NULL,NULL,3,468,467,NULL,80,NULL,'(P23 = 1 OR P23 = 2)'),(NULL,NULL,NULL,1,469,464,468,80,1,'(P22 = 1 OR P22 = 2) AND (P23 = 1 OR P23 = 2)'),(225,5,1,0,470,NULL,NULL,81,NULL,'P22 = 1'),(225,5,2,0,471,NULL,NULL,81,NULL,'P22 = 2'),(NULL,NULL,NULL,2,472,470,471,81,NULL,'P22 = 1 OR P22 = 2'),(NULL,NULL,NULL,3,473,472,NULL,81,NULL,'(P22 = 1 OR P22 = 2)'),(226,5,1,0,474,NULL,NULL,81,NULL,'P23 = 1'),(226,5,2,0,475,NULL,NULL,81,NULL,'P23 = 2'),(NULL,NULL,NULL,2,476,474,475,81,NULL,'P23 = 1 OR P23 = 2'),(NULL,NULL,NULL,3,477,476,NULL,81,NULL,'(P23 = 1 OR P23 = 2)'),(302,5,1,0,478,NULL,NULL,81,NULL,'P73 = 1'),(NULL,NULL,NULL,1,479,473,477,81,NULL,'(P22 = 1 OR P22 = 2) AND (P23 = 1 OR P23 = 2)'),(NULL,NULL,NULL,1,480,479,478,81,1,'(P22 = 1 OR P22 = 2) AND (P23 = 1 OR P23 = 2) AND P73 = 1'),(225,5,3,0,481,NULL,NULL,82,NULL,'P22 = 3'),(225,5,4,0,482,NULL,NULL,82,NULL,'P22 = 4'),(224,5,1,0,483,NULL,NULL,82,NULL,'P21 = 1'),(224,5,2,0,484,NULL,NULL,82,NULL,'P21 = 2'),(NULL,NULL,NULL,2,485,481,482,82,NULL,'P22 = 3 OR P22 = 4'),(NULL,NULL,NULL,3,486,485,NULL,82,NULL,'(P22 = 3 OR P22 = 4)'),(NULL,NULL,NULL,2,487,483,484,82,NULL,'P21 = 1 OR P21 = 2'),(NULL,NULL,NULL,3,488,487,NULL,82,NULL,'(P21 = 1 OR P21 = 2)'),(226,5,3,0,489,NULL,NULL,82,NULL,'P23 = 3'),(226,5,4,0,490,NULL,NULL,82,NULL,'P23 = 4'),(NULL,NULL,NULL,2,491,489,490,82,NULL,'P23 = 3 OR P23 = 4'),(NULL,NULL,NULL,3,492,491,NULL,82,NULL,'(P23 = 3 OR P23 = 4)'),(302,5,2,0,493,NULL,NULL,82,NULL,'P73 = 2'),(NULL,NULL,NULL,1,494,486,488,82,NULL,'(P22 = 3 OR P22 = 4) AND (P21 = 1 OR P21 = 2)'),(NULL,NULL,NULL,1,495,494,492,82,NULL,'(P22 = 3 OR P22 = 4) AND (P21 = 1 OR P21 = 2) AND (P23 = 3 OR P23 = 4)'),(NULL,NULL,NULL,1,496,495,493,82,1,'(P22 = 3 OR P22 = 4) AND (P21 = 1 OR P21 = 2) AND (P23 = 3 OR P23 = 4) AND P73 = 2'),(224,5,4,0,497,NULL,NULL,83,NULL,'P21 = 4'),(225,5,3,0,498,NULL,NULL,83,NULL,'P22 = 3'),(NULL,NULL,NULL,3,499,497,NULL,83,NULL,'(P21 = 4)'),(NULL,NULL,NULL,3,500,498,NULL,83,NULL,'(P22 = 3)'),(226,5,3,0,501,NULL,NULL,83,NULL,'P23 = 3'),(226,5,4,0,502,NULL,NULL,83,NULL,'P23 = 4'),(NULL,NULL,NULL,2,503,501,502,83,NULL,'P23 = 3 OR P23 = 4'),(NULL,NULL,NULL,3,504,503,NULL,83,NULL,'(P23 = 3 OR P23 = 4)'),(302,5,2,0,505,NULL,NULL,83,NULL,'P73 = 2'),(NULL,NULL,NULL,3,506,505,NULL,83,NULL,'(P73 = 2)'),(NULL,NULL,NULL,1,507,499,500,83,NULL,'(P21 = 4) AND (P22 = 3)'),(NULL,NULL,NULL,1,508,507,504,83,NULL,'(P21 = 4) AND (P22 = 3) AND (P23 = 3 OR P23 = 4)'),(NULL,NULL,NULL,1,509,508,506,83,1,'(P21 = 4) AND (P22 = 3) AND (P23 = 3 OR P23 = 4) AND (P73 = 2)'),(229,5,1,0,510,NULL,NULL,85,NULL,'P24 = 1'),(230,5,1,0,511,NULL,NULL,85,NULL,'P25 = 1'),(231,5,1,0,512,NULL,NULL,85,NULL,'P26 = 1'),(NULL,NULL,NULL,2,513,510,511,85,NULL,'P24 = 1 OR P25 = 1'),(NULL,NULL,NULL,2,514,513,512,85,NULL,'P24 = 1 OR P25 = 1 OR P26 = 1'),(NULL,NULL,NULL,3,515,514,NULL,85,NULL,'(P24 = 1 OR P25 = 1 OR P26 = 1)'),(289,5,2,0,516,NULL,NULL,85,NULL,'P62 = 2'),(290,5,2,0,517,NULL,NULL,85,NULL,'P63 = 2'),(NULL,NULL,NULL,2,518,516,517,85,NULL,'P62 = 2 OR P63 = 2'),(NULL,NULL,NULL,3,519,518,NULL,85,NULL,'(P62 = 2 OR P63 = 2)'),(NULL,NULL,NULL,1,520,515,519,85,1,'(P24 = 1 OR P25 = 1 OR P26 = 1) AND (P62 = 2 OR P63 = 2)'),(229,5,1,0,521,NULL,NULL,86,NULL,'P24 = 1'),(230,5,1,0,522,NULL,NULL,86,NULL,'P25 = 1'),(231,5,1,0,523,NULL,NULL,86,NULL,'P26 = 1'),(NULL,NULL,NULL,2,524,521,522,86,NULL,'P24 = 1 OR P25 = 1'),(NULL,NULL,NULL,2,525,524,523,86,NULL,'P24 = 1 OR P25 = 1 OR P26 = 1'),(NULL,NULL,NULL,3,526,525,NULL,86,NULL,'(P24 = 1 OR P25 = 1 OR P26 = 1)'),(289,5,1,0,527,NULL,NULL,86,NULL,'P62 = 1'),(290,5,1,0,528,NULL,NULL,86,NULL,'P63 = 1'),(NULL,NULL,NULL,2,529,527,528,86,NULL,'P62 = 1 OR P63 = 1'),(NULL,NULL,NULL,3,530,529,NULL,86,NULL,'(P62 = 1 OR P63 = 1)'),(NULL,NULL,NULL,1,531,526,530,86,1,'(P24 = 1 OR P25 = 1 OR P26 = 1) AND (P62 = 1 OR P63 = 1)'),(229,5,1,0,532,NULL,NULL,87,NULL,'P24 = 1'),(230,5,1,0,533,NULL,NULL,87,NULL,'P25 = 1'),(231,5,1,0,534,NULL,NULL,87,NULL,'P26 = 1'),(NULL,NULL,NULL,2,536,532,533,87,NULL,'P24 = 1 OR P25 = 1'),(NULL,NULL,NULL,2,537,536,534,87,NULL,'P24 = 1 OR P25 = 1 OR P26 = 1'),(NULL,NULL,NULL,3,538,537,NULL,87,NULL,'(P24 = 1 OR P25 = 1 OR P26 = 1)'),(289,5,1,0,539,NULL,NULL,87,NULL,'P62 = 1'),(290,5,1,0,540,NULL,NULL,87,NULL,'P63 = 1'),(NULL,NULL,NULL,1,541,539,540,87,NULL,'P62 = 1 AND P63 = 1'),(NULL,NULL,NULL,3,542,541,NULL,87,NULL,'(P62 = 1 AND P63 = 1)'),(NULL,NULL,NULL,1,543,538,542,87,1,'(P24 = 1 OR P25 = 1 OR P26 = 1) AND (P62 = 1 AND P63 = 1)'),(229,5,2,0,544,NULL,NULL,88,NULL,'P24 = 2'),(230,5,2,0,545,NULL,NULL,88,NULL,'P25 = 2'),(231,5,2,0,546,NULL,NULL,88,NULL,'P26 = 2'),(NULL,NULL,NULL,2,547,544,545,88,NULL,'P24 = 2 OR P25 = 2'),(NULL,NULL,NULL,2,548,547,546,88,NULL,'P24 = 2 OR P25 = 2 OR P26 = 2'),(NULL,NULL,NULL,3,549,548,NULL,88,NULL,'(P24 = 2 OR P25 = 2 OR P26 = 2)'),(289,5,1,0,550,NULL,NULL,88,NULL,'P62 = 1'),(290,5,1,0,551,NULL,NULL,88,NULL,'P63 = 1'),(NULL,NULL,NULL,2,552,550,551,88,NULL,'P62 = 1 OR P63 = 1'),(NULL,NULL,NULL,3,553,552,NULL,88,NULL,'(P62 = 1 OR P63 = 1)'),(NULL,NULL,NULL,1,554,549,553,88,NULL,'(P24 = 2 OR P25 = 2 OR P26 = 2) AND (P62 = 1 OR P63 = 1)'),(NULL,NULL,NULL,3,555,554,NULL,88,1,'((P24 = 2 OR P25 = 2 OR P26 = 2) AND (P62 = 1 OR P63 = 1))'),(229,5,2,0,556,NULL,NULL,89,NULL,'P24 = 2'),(230,5,2,0,557,NULL,NULL,89,NULL,'P25 = 2'),(231,5,2,0,558,NULL,NULL,89,NULL,'P26 = 2'),(NULL,NULL,NULL,2,559,556,557,89,NULL,'P24 = 2 OR P25 = 2'),(NULL,NULL,NULL,2,560,559,558,89,NULL,'P24 = 2 OR P25 = 2 OR P26 = 2'),(NULL,NULL,NULL,3,561,560,NULL,89,NULL,'(P24 = 2 OR P25 = 2 OR P26 = 2)'),(289,5,2,0,562,NULL,NULL,89,NULL,'P62 = 2'),(290,5,3,0,563,NULL,NULL,89,NULL,'P63 = 3'),(NULL,NULL,NULL,1,564,562,563,89,NULL,'P62 = 2 AND P63 = 3'),(NULL,NULL,NULL,3,565,564,NULL,89,NULL,'(P62 = 2 AND P63 = 3)'),(NULL,NULL,NULL,1,566,561,565,89,NULL,'(P24 = 2 OR P25 = 2 OR P26 = 2) AND (P62 = 2 AND P63 = 3)'),(NULL,NULL,NULL,3,567,566,NULL,89,1,'((P24 = 2 OR P25 = 2 OR P26 = 2) AND (P62 = 2 AND P63 = 3))'),(229,5,4,0,568,NULL,NULL,90,NULL,'P24 = 4'),(229,5,3,0,569,NULL,NULL,90,NULL,'P24 = 3'),(NULL,NULL,NULL,2,570,568,569,90,NULL,'P24 = 4 OR P24 = 3'),(NULL,NULL,NULL,3,571,570,NULL,90,NULL,'(P24 = 4 OR P24 = 3)'),(230,5,4,0,572,NULL,NULL,90,NULL,'P25 = 4'),(230,5,3,0,573,NULL,NULL,90,NULL,'P25 = 3'),(NULL,NULL,NULL,2,574,572,573,90,NULL,'P25 = 4 OR P25 = 3'),(NULL,NULL,NULL,3,575,574,NULL,90,NULL,'(P25 = 4 OR P25 = 3)'),(289,5,2,0,576,NULL,NULL,90,NULL,'P62 = 2'),(290,5,2,0,577,NULL,NULL,90,NULL,'P63 = 2'),(NULL,NULL,NULL,1,578,576,577,90,NULL,'P62 = 2 AND P63 = 2'),(NULL,NULL,NULL,3,579,578,NULL,90,NULL,'(P62 = 2 AND P63 = 2)'),(NULL,NULL,NULL,1,580,571,575,90,NULL,'(P24 = 4 OR P24 = 3) AND (P25 = 4 OR P25 = 3)'),(NULL,NULL,NULL,1,581,580,579,90,NULL,'(P24 = 4 OR P24 = 3) AND (P25 = 4 OR P25 = 3) AND (P62 = 2 AND P63 = 2)'),(NULL,NULL,NULL,3,582,581,NULL,90,1,'((P24 = 4 OR P24 = 3) AND (P25 = 4 OR P25 = 3) AND (P62 = 2 AND P63 = 2))'),(229,5,4,0,583,NULL,NULL,91,NULL,'P24 = 4'),(229,5,3,0,584,NULL,NULL,91,NULL,'P24 = 3'),(NULL,NULL,NULL,2,585,583,584,91,NULL,'P24 = 4 OR P24 = 3'),(NULL,NULL,NULL,3,586,585,NULL,91,NULL,'(P24 = 4 OR P24 = 3)'),(230,5,4,0,587,NULL,NULL,91,NULL,'P25 = 4'),(230,5,3,0,588,NULL,NULL,91,NULL,'P25 = 3'),(NULL,NULL,NULL,2,589,587,588,91,NULL,'P25 = 4 OR P25 = 3'),(NULL,NULL,NULL,3,590,589,NULL,91,NULL,'(P25 = 4 OR P25 = 3)'),(231,5,4,0,591,NULL,NULL,91,NULL,'P26 = 4'),(231,5,3,0,592,NULL,NULL,91,NULL,'P26 = 3'),(NULL,NULL,NULL,2,593,591,592,91,NULL,'P26 = 4 OR P26 = 3'),(NULL,NULL,NULL,3,594,593,NULL,91,NULL,'(P26 = 4 OR P26 = 3)'),(289,5,1,0,595,NULL,NULL,91,NULL,'P62 = 1'),(290,5,1,0,596,NULL,NULL,91,NULL,'P63 = 1'),(NULL,NULL,NULL,2,597,595,596,91,NULL,'P62 = 1 OR P63 = 1'),(NULL,NULL,NULL,3,598,597,NULL,91,NULL,'(P62 = 1 OR P63 = 1)'),(NULL,NULL,NULL,1,599,586,590,91,NULL,'(P24 = 4 OR P24 = 3) AND (P25 = 4 OR P25 = 3)'),(NULL,NULL,NULL,1,600,599,594,91,NULL,'(P24 = 4 OR P24 = 3) AND (P25 = 4 OR P25 = 3) AND (P26 = 4 OR P26 = 3)'),(NULL,NULL,NULL,1,601,600,598,91,1,'(P24 = 4 OR P24 = 3) AND (P25 = 4 OR P25 = 3) AND (P26 = 4 OR P26 = 3) AND (P62 = 1 OR P63 = 1)'),(231,5,1,0,602,NULL,NULL,92,NULL,'P26 = 1'),(231,5,2,0,603,NULL,NULL,92,NULL,'P26 = 2'),(NULL,NULL,NULL,2,604,602,603,92,NULL,'P26 = 1 OR P26 = 2'),(NULL,NULL,NULL,3,605,604,NULL,92,1,'(P26 = 1 OR P26 = 2)'),(232,5,1,0,606,NULL,NULL,93,NULL,'P27 = 1'),(232,5,2,0,607,NULL,NULL,93,NULL,'P27 = 2'),(NULL,NULL,NULL,2,608,606,607,93,1,'P27 = 1 OR P27 = 2'),(289,5,1,0,609,NULL,NULL,94,1,'P62 = 1'),(290,5,1,0,610,NULL,NULL,95,1,'P63 = 1'),(227,5,1,0,611,NULL,NULL,96,NULL,'P29 = 1'),(228,5,1,0,612,NULL,NULL,96,NULL,'P30 = 1'),(NULL,NULL,NULL,2,613,611,612,96,NULL,'P29 = 1 OR P30 = 1'),(NULL,NULL,NULL,3,614,613,NULL,96,NULL,'(P29 = 1 OR P30 = 1)'),(227,5,2,0,615,NULL,NULL,96,NULL,'P29 = 2'),(228,5,2,0,616,NULL,NULL,96,NULL,'P30 = 2'),(NULL,NULL,NULL,2,617,615,616,96,NULL,'P29 = 2 OR P30 = 2'),(NULL,NULL,NULL,3,618,617,NULL,96,NULL,'(P29 = 2 OR P30 = 2)'),(NULL,NULL,NULL,2,619,614,618,96,1,'(P29 = 1 OR P30 = 1) OR (P29 = 2 OR P30 = 2)'),(227,5,3,0,620,NULL,NULL,97,NULL,'P29 = 3'),(228,5,3,0,621,NULL,NULL,97,NULL,'P30 = 3'),(NULL,NULL,NULL,1,622,620,621,97,NULL,'P29 = 3 AND P30 = 3'),(227,5,4,0,623,NULL,NULL,98,NULL,'P29 = 4'),(228,5,4,0,624,NULL,NULL,98,NULL,'P30 = 4'),(NULL,NULL,NULL,2,625,623,624,98,NULL,'P29 = 4 OR P30 = 4'),(NULL,NULL,NULL,3,626,625,NULL,98,1,'(P29 = 4 OR P30 = 4)'),(183,1,0,0,627,NULL,NULL,99,NULL,'P31 > 0'),(183,2,4,0,628,NULL,NULL,99,NULL,'P31 < 4'),(NULL,NULL,NULL,1,629,627,628,99,NULL,'P31 > 0 AND P31 < 4'),(NULL,NULL,NULL,3,630,629,NULL,99,1,'(P31 > 0 AND P31 < 4)'),(183,5,1,0,631,NULL,NULL,100,NULL,'P31 = 1'),(183,5,2,0,632,NULL,NULL,100,NULL,'P31 = 2'),(183,5,3,0,633,NULL,NULL,100,NULL,'P31 = 3'),(NULL,NULL,NULL,2,634,631,632,100,NULL,'P31 = 1 OR P31 = 2'),(NULL,NULL,NULL,2,635,634,633,100,NULL,'P31 = 1 OR P31 = 2 OR P31 = 3'),(NULL,NULL,NULL,3,636,635,NULL,100,NULL,'(P31 = 1 OR P31 = 2 OR P31 = 3)'),(185,5,4,0,637,NULL,NULL,100,NULL,'P32 = 4'),(NULL,NULL,NULL,1,638,636,637,100,1,'(P31 = 1 OR P31 = 2 OR P31 = 3) AND P32 = 4'),(183,5,4,0,641,NULL,NULL,101,NULL,'P31 = 4'),(185,5,4,0,642,NULL,NULL,101,NULL,'P32 = 4'),(NULL,NULL,NULL,1,643,641,642,101,1,'P31 = 4 AND P32 = 4'),(189,5,1,0,644,NULL,NULL,103,NULL,'P36 = 1'),(189,5,2,0,645,NULL,NULL,103,NULL,'P36 = 2'),(189,5,3,0,646,NULL,NULL,103,NULL,'P36 = 3'),(NULL,NULL,NULL,2,647,644,645,103,NULL,'P36 = 1 OR P36 = 2'),(NULL,NULL,NULL,2,648,647,646,103,NULL,'P36 = 1 OR P36 = 2 OR P36 = 3'),(NULL,NULL,NULL,3,649,648,NULL,103,NULL,'(P36 = 1 OR P36 = 2 OR P36 = 3)'),(190,5,1,0,650,NULL,NULL,103,NULL,'P37 = 1'),(190,5,2,0,653,NULL,NULL,103,NULL,'P37 = 2'),(NULL,NULL,NULL,2,654,650,653,103,NULL,'P37 = 1 OR P37 = 2'),(NULL,NULL,NULL,3,655,654,NULL,103,NULL,'(P37 = 1 OR P37 = 2)'),(NULL,NULL,NULL,1,656,649,655,103,1,'(P36 = 1 OR P36 = 2 OR P36 = 3) AND (P37 = 1 OR P37 = 2)'),(189,5,1,0,657,NULL,NULL,104,NULL,'P36 = 1'),(189,5,2,0,658,NULL,NULL,104,NULL,'P36 = 2'),(NULL,NULL,NULL,2,659,657,658,104,NULL,'P36 = 1 OR P36 = 2'),(NULL,NULL,NULL,3,660,659,NULL,104,NULL,'(P36 = 1 OR P36 = 2)'),(190,5,3,0,661,NULL,NULL,104,NULL,'P37 = 3'),(190,5,4,0,662,NULL,NULL,104,NULL,'P37 = 4'),(NULL,NULL,NULL,2,663,661,662,104,NULL,'P37 = 3 OR P37 = 4'),(NULL,NULL,NULL,3,664,663,NULL,104,NULL,'(P37 = 3 OR P37 = 4)'),(NULL,NULL,NULL,1,665,660,664,104,1,'(P36 = 1 OR P36 = 2) AND (P37 = 3 OR P37 = 4)'),(189,5,3,0,666,NULL,NULL,105,NULL,'P36 = 3'),(190,5,3,0,667,NULL,NULL,105,NULL,'P37 = 3'),(190,5,4,0,668,NULL,NULL,105,NULL,'P37 = 4'),(NULL,NULL,NULL,2,669,667,668,105,NULL,'P37 = 3 OR P37 = 4'),(NULL,NULL,NULL,3,670,669,NULL,105,NULL,'(P37 = 3 OR P37 = 4)'),(NULL,NULL,NULL,1,671,666,670,105,1,'P36 = 3 AND (P37 = 3 OR P37 = 4)'),(189,5,4,0,672,NULL,NULL,106,1,'P36 = 4'),(193,5,1,0,673,NULL,NULL,107,NULL,'P39 = 1'),(193,5,2,0,674,NULL,NULL,107,NULL,'P39 = 2'),(NULL,NULL,NULL,2,675,673,674,107,1,'P39 = 1 OR P39 = 2'),(193,5,3,0,677,NULL,NULL,108,1,'P39 = 3'),(193,5,4,0,678,NULL,NULL,109,1,'P39 = 4'),(194,5,1,0,679,NULL,NULL,111,NULL,'P40 = 1'),(194,5,2,0,680,NULL,NULL,111,NULL,'P40 = 2'),(194,5,3,0,681,NULL,NULL,111,NULL,'P40 = 3'),(NULL,NULL,NULL,2,682,679,680,111,NULL,'P40 = 1 OR P40 = 2'),(NULL,NULL,NULL,2,683,682,681,111,1,'P40 = 1 OR P40 = 2 OR P40 = 3'),(194,5,1,0,684,NULL,NULL,112,NULL,'P40 = 1'),(194,5,2,0,685,NULL,NULL,112,NULL,'P40 = 2'),(194,5,3,0,686,NULL,NULL,112,NULL,'P40 = 3'),(NULL,NULL,NULL,2,687,684,685,112,NULL,'P40 = 1 OR P40 = 2'),(NULL,NULL,NULL,2,688,687,686,112,NULL,'P40 = 1 OR P40 = 2 OR P40 = 3'),(NULL,NULL,NULL,4,689,688,NULL,112,1,'NOT(P40 = 1 OR P40 = 2 OR P40 = 3)'),(195,5,1,0,690,NULL,NULL,113,NULL,'P41 = 1'),(195,5,2,0,691,NULL,NULL,113,NULL,'P41 = 2'),(195,5,3,0,692,NULL,NULL,113,NULL,'P41 = 3'),(NULL,NULL,NULL,2,693,690,691,113,NULL,'P41 = 1 OR P41 = 2'),(NULL,NULL,NULL,2,695,693,692,113,NULL,'P41 = 1 OR P41 = 2 OR P41 = 3'),(196,5,1,0,697,NULL,NULL,113,NULL,'P42 = 1'),(279,5,4,0,699,NULL,NULL,113,NULL,'P43 = 4'),(NULL,NULL,NULL,3,701,695,NULL,113,NULL,'(P41 = 1 OR P41 = 2 OR P41 = 3)'),(NULL,NULL,NULL,3,702,697,NULL,113,NULL,'(P42 = 1)'),(NULL,NULL,NULL,3,703,699,NULL,113,NULL,'(P43 = 4)'),(NULL,NULL,NULL,1,704,701,702,113,NULL,'(P41 = 1 OR P41 = 2 OR P41 = 3) AND (P42 = 1)'),(NULL,NULL,NULL,1,705,704,703,113,1,'(P41 = 1 OR P41 = 2 OR P41 = 3) AND (P42 = 1) AND (P43 = 4)'),(195,5,1,0,706,NULL,NULL,114,NULL,'P41 = 1'),(195,5,2,0,707,NULL,NULL,114,NULL,'P41 = 2'),(195,5,3,0,708,NULL,NULL,114,NULL,'P41 = 3'),(NULL,NULL,NULL,2,709,706,707,114,NULL,'P41 = 1 OR P41 = 2'),(NULL,NULL,NULL,2,710,709,708,114,NULL,'P41 = 1 OR P41 = 2 OR P41 = 3'),(NULL,NULL,NULL,3,711,710,NULL,114,NULL,'(P41 = 1 OR P41 = 2 OR P41 = 3)'),(196,5,2,0,712,NULL,NULL,114,NULL,'P42 = 2'),(196,5,3,0,713,NULL,NULL,114,NULL,'P42 = 3'),(NULL,NULL,NULL,2,714,712,713,114,NULL,'P42 = 2 OR P42 = 3'),(NULL,NULL,NULL,3,715,714,NULL,114,NULL,'(P42 = 2 OR P42 = 3)'),(279,5,3,0,716,NULL,NULL,114,NULL,'P43 = 3'),(279,5,4,0,717,NULL,NULL,114,NULL,'P43 = 4'),(NULL,NULL,NULL,2,718,716,717,114,NULL,'P43 = 3 OR P43 = 4'),(NULL,NULL,NULL,3,719,718,NULL,114,NULL,'(P43 = 3 OR P43 = 4)'),(NULL,NULL,NULL,1,720,711,715,114,NULL,'(P41 = 1 OR P41 = 2 OR P41 = 3) AND (P42 = 2 OR P42 = 3)'),(NULL,NULL,NULL,1,721,720,719,114,1,'(P41 = 1 OR P41 = 2 OR P41 = 3) AND (P42 = 2 OR P42 = 3) AND (P43 = 3 OR P43 = 4)'),(195,5,1,0,722,NULL,NULL,115,NULL,'P41 = 1'),(195,5,2,0,723,NULL,NULL,115,NULL,'P41 = 2'),(195,5,3,0,724,NULL,NULL,115,NULL,'P41 = 3'),(NULL,NULL,NULL,2,725,722,723,115,NULL,'P41 = 1 OR P41 = 2'),(NULL,NULL,NULL,2,726,725,724,115,NULL,'P41 = 1 OR P41 = 2 OR P41 = 3'),(NULL,NULL,NULL,3,727,726,NULL,115,NULL,'(P41 = 1 OR P41 = 2 OR P41 = 3)'),(196,5,4,0,728,NULL,NULL,115,NULL,'P42 = 4'),(279,5,4,0,729,NULL,NULL,115,NULL,'P43 = 4'),(NULL,NULL,NULL,2,730,727,728,115,NULL,'(P41 = 1 OR P41 = 2 OR P41 = 3) OR P42 = 4'),(NULL,NULL,NULL,2,731,730,729,115,1,'(P41 = 1 OR P41 = 2 OR P41 = 3) OR P42 = 4 OR P43 = 4'),(195,5,1,0,732,NULL,NULL,116,NULL,'P41 = 1'),(195,5,2,0,733,NULL,NULL,116,NULL,'P41 = 2'),(195,5,3,0,734,NULL,NULL,116,NULL,'P41 = 3'),(NULL,NULL,NULL,2,735,732,733,116,NULL,'P41 = 1 OR P41 = 2'),(NULL,NULL,NULL,2,736,735,734,116,NULL,'P41 = 1 OR P41 = 2 OR P41 = 3'),(NULL,NULL,NULL,3,737,736,NULL,116,NULL,'(P41 = 1 OR P41 = 2 OR P41 = 3)'),(196,5,1,0,738,NULL,NULL,116,NULL,'P42 = 1'),(279,5,1,0,739,NULL,NULL,116,NULL,'P43 = 1'),(NULL,NULL,NULL,1,740,737,738,116,NULL,'(P41 = 1 OR P41 = 2 OR P41 = 3) AND P42 = 1'),(NULL,NULL,NULL,1,741,740,739,116,1,'(P41 = 1 OR P41 = 2 OR P41 = 3) AND P42 = 1 AND P43 = 1'),(195,5,1,0,742,NULL,NULL,117,NULL,'P41 = 1'),(195,5,2,0,743,NULL,NULL,117,NULL,'P41 = 2'),(195,5,3,0,744,NULL,NULL,117,NULL,'P41 = 3'),(196,5,1,0,745,NULL,NULL,117,NULL,'P42 = 1'),(279,5,3,0,746,NULL,NULL,117,NULL,'P43 = 3'),(NULL,NULL,NULL,2,747,742,743,117,NULL,'P41 = 1 OR P41 = 2'),(NULL,NULL,NULL,2,748,747,744,117,NULL,'P41 = 1 OR P41 = 2 OR P41 = 3'),(NULL,NULL,NULL,3,749,748,NULL,117,NULL,'(P41 = 1 OR P41 = 2 OR P41 = 3)'),(NULL,NULL,NULL,1,750,749,745,117,NULL,'(P41 = 1 OR P41 = 2 OR P41 = 3) AND P42 = 1'),(NULL,NULL,NULL,1,751,750,746,117,1,'(P41 = 1 OR P41 = 2 OR P41 = 3) AND P42 = 1 AND P43 = 3'),(195,5,1,0,752,NULL,NULL,118,NULL,'P41 = 1'),(195,5,2,0,753,NULL,NULL,118,NULL,'P41 = 2'),(195,5,3,0,754,NULL,NULL,118,NULL,'P41 = 3'),(NULL,NULL,NULL,2,755,752,753,118,NULL,'P41 = 1 OR P41 = 2'),(NULL,NULL,NULL,2,756,755,754,118,NULL,'P41 = 1 OR P41 = 2 OR P41 = 3'),(NULL,NULL,NULL,3,757,756,NULL,118,NULL,'(P41 = 1 OR P41 = 2 OR P41 = 3)'),(196,5,4,0,758,NULL,NULL,118,NULL,'P42 = 4'),(NULL,NULL,NULL,3,760,758,NULL,118,NULL,'(P42 = 4)'),(279,5,1,0,761,NULL,NULL,118,NULL,'P43 = 1'),(279,5,2,0,762,NULL,NULL,118,NULL,'P43 = 2'),(279,5,3,0,763,NULL,NULL,118,NULL,'P43 = 3'),(NULL,NULL,NULL,2,764,761,762,118,NULL,'P43 = 1 OR P43 = 2'),(NULL,NULL,NULL,2,765,764,763,118,NULL,'P43 = 1 OR P43 = 2 OR P43 = 3'),(NULL,NULL,NULL,3,766,765,NULL,118,NULL,'(P43 = 1 OR P43 = 2 OR P43 = 3)'),(NULL,NULL,NULL,1,767,757,760,118,NULL,'(P41 = 1 OR P41 = 2 OR P41 = 3) AND (P42 = 4)'),(NULL,NULL,NULL,1,768,767,766,118,1,'(P41 = 1 OR P41 = 2 OR P41 = 3) AND (P42 = 4) AND (P43 = 1 OR P43 = 2 OR P43 = 3)'),(195,5,4,0,769,NULL,NULL,119,1,'P41 = 4'),(292,5,1,0,770,NULL,NULL,120,1,'P65 = 1'),(293,5,1,0,771,NULL,NULL,121,1,'P66 = 1'),(294,5,1,0,772,NULL,NULL,122,1,'P67 = 1'),(295,5,1,0,773,NULL,NULL,123,1,'P68 = 1'),(299,5,1,0,774,NULL,NULL,124,1,'P72 = 1');
/*!40000 ALTER TABLE `condicion` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `titulo_respuesta`
--

LOCK TABLES `titulo_respuesta` WRITE;
/*!40000 ALTER TABLE `titulo_respuesta` DISABLE KEYS */;
INSERT INTO `titulo_respuesta` VALUES (1,'Siempre'),(2,'Frecuentemente'),(3,'Ocasionalmente'),(4,'No'),(5,'A diario'),(6,'1 a 5 Veces/Semana'),(7,'Muy pasado(a) de peso'),(8,'Pasado(a) de peso'),(9,'Bien de peso'),(10,'Bajo(a) de peso'),(11,'Si'),(12,'Madre'),(13,'Padre'),(14,'Abuelos'),(15,'Abuelas'),(16,'Yo'),(17,'A Veces'),(18,'Nunca'),(36,'Hogar Completo'),(37,'Falta del padre por fallecimiento'),(38,'Falta del padre por divorcio o separación'),(39,'Falta de la madre por fallecimiento'),(40,'Falta de la madre por divorcio o separacion'),(41,'Falta de ambos padres'),(42,'Falta del conyuge por fallecimiento'),(43,'Falta de conyuge por divorcio o separacion'),(44,'Hogar reintegrado'),(45,'Ambos padres'),(46,'Cónyuge'),(47,'Estudiante'),(48,'Hnos.'),(49,'Suegros'),(50,'Otro'),(51,'Casa de sus padres'),(52,'Casa de otro familiar'),(53,'Casa propia'),(54,'Casa alquilada'),(55,'Casa de familia'),(56,'Casa de huéspedes o pension'),(57,'Asma Bronquial'),(58,'Rinitis Alérgica'),(59,'Migraña'),(60,'Convulsiones'),(61,'Gonorrea'),(62,'Sifilis'),(63,'Hepatitis b'),(64,'Virus del papiloma humano'),(65,'Craneo'),(66,'Nariz'),(67,'Clavícula'),(68,'Hombro'),(69,'Brazo'),(70,'Antebrazo'),(71,'Puño'),(72,'Mano'),(73,'Dedos'),(74,'Pierna'),(75,'Pie'),(76,'Antidepresivos'),(77,'Depresores del apetito'),(78,'Antiepilépticos'),(79,'Cortisona'),(80,'Tabletas para diabetes'),(81,'Tabletas para dolor de cabeza'),(82,'Píldoras para dormir'),(83,'Diazepan'),(84,'Librium'),(85,'Valium'),(86,'Mogadon'),(87,'Frisium'),(88,'etc'),(89,'De 1 a 4 horas'),(90,'De 5 a 8 horas'),(91,'Más de 8 horas'),(92,'Práctica deportiva'),(93,'Observador deportes'),(94,'Practicando arte'),(95,'Observando arte'),(96,'Televisión o cine'),(97,'Música'),(98,'Baile'),(99,'Meditación'),(100,'Lectura'),(101,'No aplica');
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
INSERT INTO `dependencia` VALUES (1,'Rector&iacute;a'),(2,'Facultad de Agronom&iacute;a'),(3,'Facultad de Arquitectura'),(4,'Facultad de Ciencias Jur&iacute;dicas y Sociales'),(5,'Facultad de Ciencias Economicas'),(6,'Facultad de Ciencias Qu&iacute;micas y Farmacia'),(7,'Facultad de Humanidades'),(8,'Facultad de Ingenier&iacute;a'),(9,'Facultad de Ciencias M&eacute;dicas'),(10,'Facultad de Odontolog&iacute;a'),(11,'Facultad de Medicina Veterinaria y Zootecnia'),(12,'Centro Universitario de occidente'),(13,'Escuela de Historia'),(14,'Escuela de Ciencias Psicol&oacute;gicas'),(15,'Centro universitario del Norte'),(16,'Centro de Estudios urbanos y Regionales'),(17,'Escuela de Ciencias de la Comunicaci&oacute;n'),(18,'Divisi&oacute;n de Bienestar Estudiantil Unviersitario'),(19,'inst. de investigacines econ&oacute;micas y sociales'),(20,'Centro Universitario de Oriente'),(21,'Centro Universitario de Noroccidente'),(22,'Centro de Estudios del Mar y Acuicultura'),(23,'Finca Bulbuxya'),(24,'Finca Sabana Grande'),(25,'Finca San Julian'),(26,'Departamento de Registro y Estad&iacute;stica'),(27,'Direcci&oacute;n General Financiera'),(28,'Direcci&oacute;n General de Extensi&oacute;n'),(29,'Centro Universitario del Sur'),(30,'Centro Universitario de Sur oriente'),(31,'Departamento de Auditoria Interna'),(32,'Finca Medio Monte'),(33,'Secretaria General'),(34,'Biblioteca Central'),(35,'Divisi&oacute;n Servicios Generales'),(36,'Centro universitario de Suroccidente'),(37,'Farmacia Universitaria'),(38,'Direcci&oacute;n General de Investigaci&oacute;n'),(39,'Direcci&oacute;n General de Administraci&oacute;n'),(40,'Centro universitario de San Marcos'),(41,'Centro Universitario del Peten'),(42,'Escuela de Trabajo Social'),(43,'Plan de Prestaciones'),(44,'Escuela de Ciencia Pol&iacute;tica'),(45,'EFPEM Central'),(46,'Direcci&oacute;n General de Docencia'),(47,'Centro Universitario Metropolitano'),(48,'Centro universitario de Izabal'),(49,'Centro de Estudios Conservacionistas'),(50,'Escuela de Ciencias Ling&uuml;isticas'),(51,'Granja Experimental Veterinaria'),(52,'Plan de Prestaciones'),(53,'Centro Universitario de Santa rosa'),(54,'Escuela Superior de Arte'),(55,'unidad ejecutora Programa USAC/BCIE'),(56,'Centro Universitario de Chimaltenango'),(57,'Centro Universitario de Jutiapa'),(58,'Sistema de Estudios de Postgrado'),(59,'direcci&oacute;n de Asuntos Jur&iacute;dicos'),(60,'Instituto T&eacute;cnologico Universitario Guatemala'),(61,'Centro Universitario de el Quiche'),(62,'Centro Universitario de el Progreso'),(63,'Centro Universitario de Baja Verapaz'),(64,'Centro Universitario de Totonicapan');
/*!40000 ALTER TABLE `dependencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo_titulo_respuesta`
--

DROP TABLE IF EXISTS `grupo_titulo_respuesta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `grupo_titulo_respuesta` (
  `idgrupo` int(10) NOT NULL,
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
INSERT INTO `encabezado` VALUES (1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20),(1,21),(2,71),(2,169),(2,170),(2,171),(3,22),(3,23),(3,24),(3,25),(4,47),(4,165),(5,40),(5,41),(5,42),(5,127),(6,72),(6,73),(6,74),(6,75),(6,76),(6,77),(6,78),(6,79),(7,152),(7,153),(7,154),(7,155),(9,44),(9,45),(9,46);
/*!40000 ALTER TABLE `encabezado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_interpretacion`
--

DROP TABLE IF EXISTS `tipo_interpretacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo_interpretacion` (
  `idtipo_interpretacion` int(10) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`idtipo_interpretacion`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_interpretacion`
--

LOCK TABLES `tipo_interpretacion` WRITE;
/*!40000 ALTER TABLE `tipo_interpretacion` DISABLE KEYS */;
INSERT INTO `tipo_interpretacion` VALUES (3,'CEFALEA'),(4,'TIPO DE CEFALEA'),(5,'AGUDEZA VISUAL'),(6,'YA SABEN CUAL ES SU DEFICIENCIA / AGUDEZA VISUAL'),(7,'AUDICION'),(8,'TAPON DE CERUMEN'),(9,'ALERGIA AL POLVO'),(10,'ALERGIA A MARISCOS'),(11,'ALERGIA AL CERDO'),(12,'ALERGIA AL FRIO'),(13,'ALERGIA A LA PENICILINA'),(14,'ALERGIA AL SOL'),(15,'ALERGIAS EN GENERAL'),(16,'PROBLEMAS URINARIOS'),(17,'PROBLEMAS TESTICULARES'),(18,'PROBLEMAS GINECOLOGICOS'),(19,'PROBLEMAS GASTROENTEROLOGICOS'),(20,'DOLOR MUSCULAR'),(21,'TABAQUISMO'),(22,'CONSUMO DE ALCOHOL'),(23,'ACTIVIDAD FISICA'),(24,'CONSUMO DE DROGAS'),(25,'CONDUCTA SEXUAL'),(26,'NUTRICION'),(27,'RIESGO DE PADECER DIABETES'),(28,'CIRUGIAS PREVIAS');
/*!40000 ALTER TABLE `tipo_interpretacion` ENABLE KEYS */;
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
INSERT INTO `area_usuario` VALUES (1,7),(2,2),(4,4),(5,6),(5,8),(5,10),(6,3),(6,10),(7,6),(7,8),(7,10),(8,5),(8,6),(8,8),(8,10),(9,6),(9,8),(9,9),(9,10);
/*!40000 ALTER TABLE `area_usuario` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `titulo_secundaria`
--

LOCK TABLES `titulo_secundaria` WRITE;
/*!40000 ALTER TABLE `titulo_secundaria` DISABLE KEYS */;
INSERT INTO `titulo_secundaria` VALUES (1,'AUXILIAR DE ENFERMERA CON GRADO DE BACHILLER'),(2,'BACH CON ORIENT.TECNICA OCUP. EN ELECTRICIDAD Y SOLDADURA'),(3,'BACH CON ORIENT.TECNICA Y OCUP.CORTE Y CONFECCION Y ALIMENTO'),(4,'BACH INDUST Y PERITO EN DIBUJO DE ARQUITECTURA E INGENIERIA'),(5,'BACH. EN CC Y LL CON ORIENT. OCUP. EN MECANICA AUTOMOTRIZ'),(6,'BACH. EN CC.LL. CON ESPECIALIDAD EN SEGURIDAD CIUDADANA'),(7,'BACH. EN CIENCIAS CON ORIENTACION EN EDUC. PARA EL HOGAR'),(8,'BACH. EN CIENCIAS Y LETRAS CON ESPEC. EN MUSICA'),(9,'BACH. INDUSTRIAL Y PER. EN ELECTRONICA'),(11,'BACHILLER INDUST.Y PERITO EN CONSTRUCC Y DIBUJO COMPUTARIZA'),(12,'BACHILLER INDUSTRIAL Y PERITO EN CONSTRUCCION'),(13,'BACHILLERATO AGRICOLA Y COMPUTACION'),(14,'BACHILLERATO AGRO-INDUSTRIAL Y PERITO EN TECNICAS AZUCARERAS'),(15,'BACHILLERATO BILINGUE EN CIENCIAS Y HUMANIDADES'),(16,'BACHILLERATO EN ADMINISTRACION DE EMPRESAS'),(17,'BACHILLERATO EN ADMINISTRACION PUBLICA'),(18,'BACHILLERATO EN ADMON INDUST. Y PERITO EN ALGUNA ESPEC.'),(19,'BACHILLERATO EN ADMON. INDUS Y P. EN ELECTRICIDAD'),(20,'BACHILLERATO EN ADMON. INDUSTRIAL Y P. DIBUJO CONSTRUCCION'),(21,'BACHILLERATO EN AGRICULTURA'),(22,'BACHILLERATO EN CC Y LL Y PERITO EN MECANICA DE AVIACION'),(23,'BACHILLERATO EN CIENCIAS DE LA COMUNICACION'),(24,'BACHILLERATO EN CIENCIAS DE LA SALUD'),(25,'BACHILLERATO EN CIENCIAS Y HUMANIDADES'),(26,'BACHILLERATO EN CIENCIAS Y LETRA CON ORIENTA.EN COMPUTACION'),(27,'BACHILLERATO EN CIENCIAS Y LETRAS'),(28,'BACHILLERATO EN CIENCIAS Y LETRAS CON ORIENT EN AGRONOMIA'),(29,'BACHILLERATO EN CIENCIAS Y LETRAS CON ORIENTAC. EN MEDICINA'),(30,'BACHILLERATO EN CIENCIAS Y LETRAS POR MADUREZ'),(31,'BACHILLERATO EN CIENCIAS Y LETRAS Y AUXILIAR DE ENFERMERIA'),(32,'BACHILLERATO EN CIENCIAS Y LETRAS Y SECRETARIADO BILINGUE'),(33,'BACHILLERATO EN CIENCIAS Y LETRAS Y TECNICO EN LAB. CLINICO'),(34,'BACHILLERATO EN COMPUTACION'),(35,'BACHILLERATO EN COMPUTACION CON ORIENTACION CIENTIFICA'),(36,'BACHILLERATO EN COMPUTACION CON ORIENTACION COMERCIAL'),(37,'BACHILLERATO EN COMPUTACION CON ORIENTACION QUIMICA BIOLOGIA'),(38,'BACHILLERATO EN CONSTRUCCION'),(39,'BACHILLERATO EN CONSTRUCCION Y DIBUJO COMPUTARIZADO'),(40,'BACHILLERATO EN COSMETOLOGIA'),(41,'BACHILLERATO EN DIBUJO TECNICO Y CONSTRUCION CON COMPUTACION'),(42,'BACHILLERATO EN DIBUJO TECNICO Y DE CONSTRUCCION'),(46,'BACHILLERATO EN ELECTRICIDAD'),(47,'BACHILLERATO EN ELECTRONICA'),(48,'BACHILLERATO EN FILOSOFIA Y TEOLOGIA'),(49,'BACHILLERATO EN HOTELERIA Y HOGAR'),(50,'BACHILLERATO EN MECANICA AGRICOLA'),(51,'BACHILLERATO EN MECANICA GENERAL'),(52,'BACHILLERATO EN MERCADOTECNIA'),(53,'BACHILLERATO EN ODONTOLOGIA'),(54,'BACHILLERATO EN PUBLICIDAD'),(55,'BACHILLERATO EN RECURSOS NATURALES RENOVABLES'),(56,'BACHILLERATO EN TECNICAS PARA EL DESARROLLO COMUNITARIO'),(57,'BACHILLERATO EN TELECOMUNICACIONES'),(58,'BACHILLERATO EN TURISMO'),(59,'BACHILLERATO EN TURISMO CON ORIENTACION EN COMPUTACION'),(60,'BACHILLERATO EN TURISMO Y ADMINISTRACION EN HOTELES'),(61,'BACHILLERATO EN TURISMO Y LINEAS AEREAS'),(62,'BACHILLERATO INDUS Y PERITO EN COSTURA INDUSTRIAL'),(63,'BACHILLERATO INDUS Y PERITO EN RADIO Y TELEVISION'),(64,'BACHILLERATO INDUST Y PERITO EN ELECTRONICA DIGITAL Y MICROP'),(65,'BACHILLERATO INDUSTRIAL'),(66,'BACHILLERATO INDUSTRIAL FEMENINO DE ALTA COSTURA'),(67,'BACHILLERATO INDUSTRIAL Y PERITO CON ESP. EN DISE'),(68,'BACHILLERATO INDUSTRIAL Y PERITO CON ESPECIALIDAD EN COMPU.'),(69,'BACHILLERATO INDUSTRIAL Y PERITO EN DIBUJO COMPUTARIZADO'),(70,'BACHILLERATO INDUSTRIAL Y PERITO EN DIBUJO DE CONSTRUCCION'),(71,'BACHILLERATO INDUSTRIAL Y PERITO EN DISE'),(72,'BACHILLERATO INDUSTRIAL Y PERITO EN ELECTRICIDAD'),(73,'BACHILLERATO INDUSTRIAL Y PERITO EN ELECTRONICA'),(74,'BACHILLERATO INDUSTRIAL Y PERITO EN ELECTRONICA INDUSTRIAL'),(75,'BACHILLERATO INDUSTRIAL Y PERITO EN MECANICA AUTOMOTRIZ'),(76,'BACHILLERATO INDUSTRIAL Y PERITO EN UNA ESPECIALIDAD'),(77,'BACHILLERATO TECNICO BILINGUE'),(78,'BACHTO. EN CIENCIAS Y LETRAS Y SECRET. BILG.'),(79,'DIBUJO DE CONSTRUCCION CON ORIENTACION EN COMPUTACION'),(80,'MAESTRA DE EDUCACION PREPRIMARIA RURAL BILINGUE (CONADEP)'),(81,'MAESTRA DE EDUCACION PRIMARIA RURAL BILINGUE (CONADEP)'),(82,'MAESTRO DE EDUCACION PRIMARIA URBANA BILINGUE (ESPA'),(83,'MAGISTERIO BILINGUE CON ORIENTACIN EN DESARROLLO COMUNITARIO'),(84,'MAGISTERIO DE EDUC. PREPRIMARIA CON ORIENT. A LA DEMOCRACIA'),(85,'MAGISTERIO DE EDUC. PRIMARIA CON INSTRUCCION TECNICA'),(86,'MAGISTERIO DE EDUCACION INFANTIL BILINGUE INTERCULTURAL'),(87,'MAGISTERIO DE EDUCACION INFANTIL INTERCULTURAL'),(88,'MAGISTERIO DE EDUCACION PREPRIMARIA BILINGUE ESPA'),(89,'MAGISTERIO DE EDUCACION PRIMARIA BILINGUE (MAM-ESPA'),(90,'MAGISTERIO DE EDUCACION PRIMARIA BILINGUE '),(91,'MAGISTERIO DE EDUCACION PRIMARIA BILINGUE INTERCULTURAL'),(92,'MAGISTERIO DE EDUCACION PRIMARIA INTERCULTURAL'),(93,'NORMAL ARTES PLASTICAS'),(94,'NORMAL DE EDUCACION FISICA'),(95,'NORMAL DE EDUCACION MUSICAL'),(96,'NORMAL DE EDUCACION PRIMARIA BILINGUE'),(97,'NORMAL EDUCACION PARA EL HOGAR'),(98,'NORMAL PREPRIMARIA'),(99,'NORMAL PREPRIMARIA BILINGUE'),(100,'NORMAL PREPRIMARIA CON ORIENTACION AMBIENTAL'),(101,'NORMAL PRIMARIA'),(102,'NORMAL PRIMARIA BILINGUE CON ORIENTACION AMBIENTAL'),(103,'NORMAL PRIMARIA CON ORIENTACION AMBIENTAL'),(104,'NORMAL PRIMARIA RURAL'),(105,'NORMAL PRIMARIA URBANA'),(106,'PERITO AGRONOMO'),(107,'PERITO CONT. CON ESP. EN ADMON. DE PEQUE'),(108,'PERITO CONTADOR'),(109,'PERITO CONTADOR BILINGUE (ESPA'),(110,'PERITO CONTADOR CON ORIENTACION ARTESANAL Y COMPUTACION'),(111,'PERITO CONTADOR CON ORIENTACION COMERCIAL Y TURISMO'),(112,'PERITO CONTADOR CON ORIENTACION EN ADMINISTRACION PORTUARIA'),(113,'PERITO CONTADOR CON ORIENTACION EN COMPUTACION'),(114,'PERITO CONTADOR CON ORIENTACION EN COMPUTACION COMERCIAL'),(115,'PERITO EN ADMINISTRACION BANCARIA DIPLOMADO EN COMPUTACION'),(116,'PERITO EN ADMINISTRACION COMERCIAL'),(117,'PERITO EN ADMINISTRACION DE AGROINDUSTRIA'),(118,'PERITO EN ADMINISTRACION DE EMPRESAS'),(119,'PERITO EN ADMINISTRACION DE EMPRESAS AGROPECUARIAS'),(120,'PERITO EN ADMINISTRACION DE EMPRESAS CON ORIENTACION EN COMP'),(121,'PERITO EN ADMINISTRACION PUBLICA'),(122,'PERITO EN ADMINISTRACION TELEGRAFICA Y POSTAL'),(123,'PERITO EN ADMINISTRACION TURISTICA Y HOTELERA'),(124,'PERITO EN ADMON. PUBLICA CON ORIENTACION EN COMPUTACION'),(125,'PERITO EN AGRICULTURA'),(126,'PERITO EN ARQUEOLOGIA'),(127,'PERITO EN BIENESTAR RURAL Y DESARROLLO COMUNITARIO'),(128,'PERITO EN CIEN DE LA COMUNI CON ESPECI EN TELE RADIO COMUNIC'),(129,'PERITO EN CIENCIAS AMBIENTALES'),(130,'PERITO EN CIENCIAS DE LA COMUNICACION'),(131,'PERITO EN CIENCIAS TURISTICAS'),(132,'PERITO EN COMPUTACION'),(133,'PERITO EN CONSTRUCCION Y DIBUJO DE INGENIERIA'),(134,'PERITO EN DEPORTES'),(135,'PERITO EN DIBUJO'),(136,'PERITO EN DIBUJO DE CONSTRUCCION'),(137,'PERITO EN DIBUJO TECNICO DE INGENIERIA Y ARQUITECTURA'),(138,'PERITO EN ECOTURISMO'),(139,'PERITO EN ELECTRICIDAD'),(140,'PERITO EN ELECTRICIDAD INDUSTRIAL'),(141,'PERITO EN ELECTRONICA CON ORIENTACION EN COMPUTACION'),(142,'PERITO EN ELECTRONICA DE COMPUTACION'),(143,'PERITO EN ELECTRONICA INDUSTRIAL'),(144,'PERITO EN ELECTRONICA Y MICROPROCESADORES'),(145,'PERITO EN GERENCIA ADMINISTRATIVA'),(146,'PERITO EN GESTION DE RECURSOS HIDRICOS'),(147,'PERITO EN HIGIENE DENTAL'),(148,'PERITO EN INDUSTRIA ALIMENTARIA'),(149,'PERITO EN INDUSTRIA DE LA MADERA'),(150,'PERITO EN LA ENSE'),(151,'PERITO EN MECANICA AUTOMOTRIZ'),(152,'PERITO EN MECANICA GENERAL (TORNOS)'),(153,'PERITO EN MERCADOTECNIA Y PUB. DIPLOMADO EN COMPU. COMERCIAL'),(154,'PERITO EN MERCADOTECNIA Y PUBLICIDAD'),(155,'PERITO EN OPTOMETRIA'),(156,'PERITO EN ORGANIZACION Y DESARROLLO SOSTENIBLE'),(157,'PERITO EN RECURSOS NATURALES RENOVABLES'),(158,'PERITO EN RELACIONES PUBLICAS EMPRESARIALES'),(159,'PERITO EN SISTEMAS DE PRODUCCION AGROPECUARIA'),(160,'PERITO EN TECNICAS DE DESARROLLO COMUNITARIO'),(161,'SECRET BILINGUE CON ORIENT EN IDIOMAS DIPLOMACIA Y REL INTER'),(162,'SECRETARIADO BILINGUE'),(163,'SECRETARIADO BILINGUE CON ORIENTA.TURISMO Y HOTELERIA'),(164,'SECRETARIADO BILINGUE CON ORIENTACION CIENTIFICA'),(165,'SECRETARIADO BILINGUE CON ORIENTACION EN COMPUTACION'),(166,'SECRETARIADO BILINGUE ORIENTACION TURISMO-AGENCIA DE VIAJES'),(167,'SECRETARIADO BILINGUE Y OFICINISTA'),(168,'SECRETARIADO COMERCIAL'),(169,'SECRETARIADO COMERCIAL CON ORIENTACION EN COMPUTACION'),(170,'SECRETARIADO COMERCIAL Y OFICINISTA'),(171,'SECRETARIADO COMERCIAL Y OFICINISTA TECNICO'),(172,'SECRETARIADO CON ORIENTACION JURIDICA'),(173,'SECRETARIADO EJECUTIVO'),(174,'SECRETARIADO EJECUTIVO BILINGUE'),(175,'SECRETARIADO EJECUTIVO BILINGUE CON ORIENT. EN MERC. Y PUB.'),(176,'SECRETARIADO EJECUTIVO BILINGUE CON ORIENTA. COMP.COMERCIAL'),(177,'SECRETARIADO EJECUTIVO EN ESPA'),(178,'SECRETARIADO OFICINISTA CON ORIENTACION EN COMPUTACION'),(179,'SECRETARIADO TRILINGUE CON ORIENT EN COMERCIO INTERNACIONAL'),(180,'SECRETARIADO Y OFICINISTA'),(181,'TECNICO EN DESARROLLO COMUNITARIO'),(182,'TECNICO EN EDUCACION ALTERNATIVA');
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
) ENGINE=InnoDB AUTO_INCREMENT=1077 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalleactividad`
--

LOCK TABLES `detalleactividad` WRITE;
/*!40000 ALTER TABLE `detalleactividad` DISABLE KEYS */;
INSERT INTO `detalleactividad` VALUES (1,'2012-04-30 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(2,'2012-05-02 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(3,'2012-05-07 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(4,'2012-05-09 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(5,'2012-05-14 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(6,'2012-05-16 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(7,'2012-05-21 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(8,'2012-05-23 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(9,'2012-05-28 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(10,'2012-05-30 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(11,'2012-06-04 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(12,'2012-06-06 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(13,'2012-06-11 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(14,'2012-06-13 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(15,'2012-06-18 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(16,'2012-06-20 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(17,'2012-06-25 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(18,'2012-06-27 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(19,'2012-07-02 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(20,'2012-07-04 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(21,'2012-07-09 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(22,'2012-07-11 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(23,'2012-07-16 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(24,'2012-07-18 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(25,'2012-07-23 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(26,'2012-07-25 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(27,'2012-07-30 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(28,'2012-08-01 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(29,'2012-08-06 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(30,'2012-08-08 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(31,'2012-08-13 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(32,'2012-08-15 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(33,'2012-08-20 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(34,'2012-08-22 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(35,'2012-08-27 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(36,'2012-08-29 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(37,'2012-09-03 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(38,'2012-09-05 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(39,'2012-09-10 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(40,'2012-09-12 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(41,'2012-09-17 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(42,'2012-09-19 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(43,'2012-09-24 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(44,'2012-09-26 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(45,'2012-10-01 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(46,'2012-10-03 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(47,'2012-10-08 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(48,'2012-10-10 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(49,'2012-10-15 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(50,'2012-10-17 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(51,'2012-10-22 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(52,'2012-10-24 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(53,'2012-10-29 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(54,'2012-10-31 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(55,'2012-11-05 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(56,'2012-11-07 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(57,'2012-11-12 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(58,'2012-11-14 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(59,'2012-11-19 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(60,'2012-11-21 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(61,'2012-11-26 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(62,'2012-11-28 00:00:00','1970-01-01 09:00:00','1970-01-01 10:00:00',1),(63,'2012-04-30 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(64,'2012-05-02 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(65,'2012-05-07 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(66,'2012-05-09 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(67,'2012-05-14 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(68,'2012-05-16 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(69,'2012-05-21 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(70,'2012-05-23 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(71,'2012-05-28 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(72,'2012-05-30 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(73,'2012-06-04 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(74,'2012-06-06 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(75,'2012-06-11 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(76,'2012-06-13 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(77,'2012-06-18 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(78,'2012-06-20 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(79,'2012-06-25 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(80,'2012-06-27 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(81,'2012-07-02 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(82,'2012-07-04 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(83,'2012-07-09 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(84,'2012-07-11 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(85,'2012-07-16 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(86,'2012-07-18 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(87,'2012-07-23 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(88,'2012-07-25 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(89,'2012-07-30 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(90,'2012-08-01 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(91,'2012-08-06 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(92,'2012-08-08 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(93,'2012-08-13 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(94,'2012-08-15 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(95,'2012-08-20 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(96,'2012-08-22 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(97,'2012-08-27 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(98,'2012-08-29 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(99,'2012-09-03 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(100,'2012-09-05 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(101,'2012-09-10 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(102,'2012-09-12 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(103,'2012-09-17 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(104,'2012-09-19 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(105,'2012-09-24 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(106,'2012-09-26 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(107,'2012-10-01 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(108,'2012-10-03 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(109,'2012-10-08 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(110,'2012-10-10 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(111,'2012-10-15 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(112,'2012-10-17 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(113,'2012-10-22 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(114,'2012-10-24 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(115,'2012-10-29 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(116,'2012-10-31 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(117,'2012-11-05 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(118,'2012-11-07 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(119,'2012-11-12 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(120,'2012-11-14 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(121,'2012-11-19 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(122,'2012-11-21 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(123,'2012-11-26 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(124,'2012-11-28 00:00:00','1970-01-01 10:00:00','1970-01-01 11:00:00',1),(125,'2012-04-25 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(126,'2012-04-30 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(127,'2012-05-02 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(128,'2012-05-07 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(129,'2012-05-09 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(130,'2012-05-14 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(131,'2012-05-16 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(132,'2012-05-21 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(133,'2012-05-23 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(134,'2012-05-28 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(135,'2012-05-30 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(136,'2012-06-04 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(137,'2012-06-06 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(138,'2012-06-11 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(139,'2012-06-13 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(140,'2012-06-18 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(141,'2012-06-20 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(142,'2012-06-25 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(143,'2012-06-27 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(144,'2012-07-02 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(145,'2012-07-04 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(146,'2012-07-09 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(147,'2012-07-11 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(148,'2012-07-16 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(149,'2012-07-18 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(150,'2012-07-23 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(151,'2012-07-25 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(152,'2012-07-30 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(153,'2012-08-01 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(154,'2012-08-06 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(155,'2012-08-08 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(156,'2012-08-13 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(157,'2012-08-15 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(158,'2012-08-20 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(159,'2012-08-22 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(160,'2012-08-27 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(161,'2012-08-29 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(162,'2012-09-03 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(163,'2012-09-05 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(164,'2012-09-10 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(165,'2012-09-12 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(166,'2012-09-17 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(167,'2012-09-19 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(168,'2012-09-24 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(169,'2012-09-26 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(170,'2012-10-01 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(171,'2012-10-03 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(172,'2012-10-08 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(173,'2012-10-10 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(174,'2012-10-15 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(175,'2012-10-17 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(176,'2012-10-22 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(177,'2012-10-24 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(178,'2012-10-29 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(179,'2012-10-31 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(180,'2012-11-05 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(181,'2012-11-07 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(182,'2012-11-12 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(183,'2012-11-14 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(184,'2012-11-19 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(185,'2012-11-21 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(186,'2012-11-26 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(187,'2012-11-28 00:00:00','1970-01-01 11:00:00','1970-01-01 12:00:00',2),(188,'2012-04-30 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(189,'2012-05-02 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(190,'2012-05-07 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(191,'2012-05-09 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(192,'2012-05-14 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(193,'2012-05-16 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(194,'2012-05-21 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(195,'2012-05-23 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(196,'2012-05-28 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(197,'2012-05-30 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(198,'2012-06-04 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(199,'2012-06-06 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(200,'2012-06-11 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(201,'2012-06-13 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(202,'2012-06-18 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(203,'2012-06-20 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(204,'2012-06-25 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(205,'2012-06-27 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(206,'2012-07-02 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(207,'2012-07-04 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(208,'2012-07-09 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(209,'2012-07-11 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(210,'2012-07-16 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(211,'2012-07-18 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(212,'2012-07-23 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(213,'2012-07-25 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(214,'2012-07-30 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(215,'2012-08-01 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(216,'2012-08-06 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(217,'2012-08-08 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(218,'2012-08-13 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(219,'2012-08-15 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(220,'2012-08-20 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(221,'2012-08-22 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(222,'2012-08-27 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(223,'2012-08-29 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(224,'2012-09-03 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(225,'2012-09-05 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(226,'2012-09-10 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(227,'2012-09-12 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(228,'2012-09-17 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(229,'2012-09-19 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(230,'2012-09-24 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(231,'2012-09-26 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(232,'2012-10-01 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(233,'2012-10-03 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(234,'2012-10-08 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(235,'2012-10-10 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(236,'2012-10-15 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(237,'2012-10-17 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(238,'2012-10-22 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(239,'2012-10-24 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(240,'2012-10-29 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(241,'2012-10-31 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(242,'2012-11-05 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(243,'2012-11-07 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(244,'2012-11-12 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(245,'2012-11-14 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(246,'2012-11-19 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(247,'2012-11-21 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(248,'2012-11-26 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(249,'2012-11-28 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',2),(250,'2012-05-01 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(251,'2012-05-03 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(252,'2012-05-08 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(253,'2012-05-10 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(254,'2012-05-15 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(255,'2012-05-17 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(256,'2012-05-22 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(257,'2012-05-24 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(258,'2012-05-29 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(259,'2012-05-31 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(260,'2012-06-05 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(261,'2012-06-07 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(262,'2012-06-12 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(263,'2012-06-14 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(264,'2012-06-19 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(265,'2012-06-21 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(266,'2012-06-26 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(267,'2012-06-28 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(268,'2012-07-03 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(269,'2012-07-05 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(270,'2012-07-10 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(271,'2012-07-12 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(272,'2012-07-17 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(273,'2012-07-19 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(274,'2012-07-24 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(275,'2012-07-26 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(276,'2012-07-31 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(277,'2012-08-02 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(278,'2012-08-07 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(279,'2012-08-09 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(280,'2012-08-14 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(281,'2012-08-16 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(282,'2012-08-21 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(283,'2012-08-23 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(284,'2012-08-28 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(285,'2012-08-30 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(286,'2012-09-04 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(287,'2012-09-06 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(288,'2012-09-11 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(289,'2012-09-13 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(290,'2012-09-18 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(291,'2012-09-20 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(292,'2012-09-25 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(293,'2012-09-27 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(294,'2012-10-02 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(295,'2012-10-04 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(296,'2012-10-09 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(297,'2012-10-11 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(298,'2012-10-16 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(299,'2012-10-18 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(300,'2012-10-23 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(301,'2012-10-25 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(302,'2012-10-30 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(303,'2012-11-01 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(304,'2012-11-06 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(305,'2012-11-08 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(306,'2012-11-13 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(307,'2012-11-15 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(308,'2012-11-20 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(309,'2012-11-22 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(310,'2012-11-27 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(311,'2012-11-29 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',3),(312,'2012-04-27 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(313,'2012-05-04 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(314,'2012-05-11 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(315,'2012-05-18 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(316,'2012-05-25 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(317,'2012-06-01 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(318,'2012-06-08 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(319,'2012-06-15 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(320,'2012-06-22 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(321,'2012-06-29 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(322,'2012-07-06 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(323,'2012-07-13 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(324,'2012-07-20 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(325,'2012-07-27 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(326,'2012-08-03 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(327,'2012-08-10 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(328,'2012-08-17 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(329,'2012-08-24 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(330,'2012-08-31 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(331,'2012-09-07 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(332,'2012-09-14 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(333,'2012-09-21 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(334,'2012-09-28 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(335,'2012-10-05 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(336,'2012-10-12 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(337,'2012-10-19 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(338,'2012-10-26 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(339,'2012-11-02 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(340,'2012-11-09 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(341,'2012-11-16 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(342,'2012-11-23 00:00:00','1970-01-01 11:00:00','1970-01-01 13:00:00',4),(343,'2012-04-26 00:00:00','1970-01-01 14:00:00','1970-01-01 15:00:00',5),(344,'2012-05-03 00:00:00','1970-01-01 14:00:00','1970-01-01 15:00:00',5),(345,'2012-05-10 00:00:00','1970-01-01 14:00:00','1970-01-01 15:00:00',5),(346,'2012-05-17 00:00:00','1970-01-01 14:00:00','1970-01-01 15:00:00',5),(347,'2012-05-24 00:00:00','1970-01-01 14:00:00','1970-01-01 15:00:00',5),(348,'2012-04-23 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(349,'2012-04-24 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(350,'2012-04-25 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(351,'2012-04-26 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(352,'2012-04-27 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(353,'2012-04-30 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(354,'2012-05-01 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(355,'2012-05-02 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(356,'2012-05-03 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(357,'2012-05-04 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(358,'2012-05-07 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(359,'2012-05-08 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(360,'2012-05-09 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(361,'2012-05-10 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(362,'2012-05-11 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(363,'2012-05-14 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(364,'2012-05-15 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(365,'2012-05-16 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(366,'2012-05-17 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(367,'2012-05-18 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(368,'2012-05-21 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(369,'2012-05-22 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(370,'2012-05-23 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(371,'2012-05-24 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(372,'2012-05-25 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(373,'2012-05-28 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(374,'2012-05-29 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(375,'2012-05-30 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(376,'2012-05-31 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(377,'2012-06-01 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(378,'2012-06-04 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(379,'2012-06-05 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(380,'2012-06-06 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(381,'2012-06-07 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(382,'2012-06-08 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(383,'2012-06-11 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(384,'2012-06-12 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(385,'2012-06-13 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(386,'2012-06-14 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(387,'2012-06-15 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(388,'2012-06-18 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(389,'2012-06-19 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(390,'2012-06-20 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(391,'2012-06-21 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(392,'2012-06-22 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(393,'2012-06-25 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(394,'2012-06-26 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(395,'2012-06-27 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(396,'2012-06-28 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(397,'2012-06-29 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(398,'2012-07-02 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(399,'2012-07-03 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(400,'2012-07-04 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(401,'2012-07-05 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(402,'2012-07-06 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(403,'2012-07-09 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(404,'2012-07-10 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(405,'2012-07-11 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(406,'2012-07-12 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(407,'2012-07-13 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(408,'2012-07-16 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(409,'2012-07-17 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(410,'2012-07-18 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(411,'2012-07-19 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(412,'2012-07-20 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(413,'2012-07-23 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(414,'2012-07-24 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(415,'2012-07-25 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(416,'2012-07-26 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(417,'2012-07-27 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(418,'2012-07-30 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(419,'2012-07-31 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(420,'2012-08-01 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(421,'2012-08-02 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(422,'2012-08-03 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(423,'2012-08-06 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(424,'2012-08-07 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(425,'2012-08-08 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(426,'2012-08-09 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(427,'2012-08-10 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(428,'2012-08-13 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(429,'2012-08-14 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(430,'2012-08-15 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(431,'2012-08-16 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(432,'2012-08-17 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(433,'2012-08-20 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(434,'2012-08-21 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(435,'2012-08-22 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(436,'2012-08-23 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(437,'2012-08-24 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(438,'2012-08-27 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(439,'2012-08-28 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(440,'2012-08-29 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(441,'2012-08-30 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(442,'2012-08-31 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(443,'2012-09-03 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(444,'2012-09-04 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(445,'2012-09-05 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(446,'2012-09-06 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(447,'2012-09-07 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(448,'2012-09-10 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(449,'2012-09-11 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(450,'2012-09-12 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(451,'2012-09-13 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(452,'2012-09-14 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(453,'2012-09-17 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(454,'2012-09-18 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(455,'2012-09-19 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(456,'2012-09-20 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(457,'2012-09-21 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(458,'2012-09-24 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(459,'2012-09-25 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(460,'2012-09-26 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(461,'2012-09-27 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(462,'2012-09-28 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(463,'2012-10-01 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(464,'2012-10-02 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(465,'2012-10-03 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(466,'2012-10-04 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(467,'2012-10-05 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(468,'2012-10-08 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(469,'2012-10-09 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(470,'2012-10-10 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(471,'2012-10-11 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(472,'2012-10-12 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(473,'2012-10-15 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(474,'2012-10-16 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(475,'2012-10-17 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(476,'2012-10-18 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(477,'2012-10-19 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(478,'2012-10-22 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(479,'2012-10-23 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(480,'2012-10-24 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(481,'2012-10-25 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(482,'2012-10-26 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(483,'2012-10-29 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(484,'2012-10-30 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(485,'2012-10-31 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(486,'2012-11-01 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(487,'2012-11-02 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(488,'2012-11-05 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(489,'2012-11-06 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(490,'2012-11-07 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(491,'2012-11-08 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(492,'2012-11-09 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(493,'2012-11-12 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(494,'2012-11-13 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(495,'2012-11-14 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(496,'2012-11-15 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(497,'2012-11-16 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(498,'2012-11-19 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(499,'2012-11-20 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(500,'2012-11-21 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(501,'2012-11-22 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(502,'2012-11-23 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(503,'2012-11-26 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(504,'2012-11-27 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(505,'2012-11-28 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(506,'2012-11-29 00:00:00','1970-01-01 07:30:00','1970-01-01 19:00:00',6),(507,'2012-04-28 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(508,'2012-05-05 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(509,'2012-05-12 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(510,'2012-05-19 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(511,'2012-05-26 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(512,'2012-06-02 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(513,'2012-06-09 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(514,'2012-06-16 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(515,'2012-06-23 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(516,'2012-06-30 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(517,'2012-07-07 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(518,'2012-07-14 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(519,'2012-07-21 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(520,'2012-07-28 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(521,'2012-08-04 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(522,'2012-08-11 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(523,'2012-08-18 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(524,'2012-08-25 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(525,'2012-09-01 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(526,'2012-09-08 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(527,'2012-09-15 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(528,'2012-09-22 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(529,'2012-09-29 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(530,'2012-10-06 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(531,'2012-10-13 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(532,'2012-10-20 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(533,'2012-10-27 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(534,'2012-11-03 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(535,'2012-11-10 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(536,'2012-11-17 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(537,'2012-11-24 00:00:00','1970-01-01 08:00:00','1970-01-01 13:00:00',6),(538,'2012-05-07 00:00:00','1970-01-01 14:00:00','1970-01-01 16:00:00',7),(539,'2012-05-14 00:00:00','1970-01-01 14:00:00','1970-01-01 16:00:00',7),(540,'2012-05-21 00:00:00','1970-01-01 14:00:00','1970-01-01 16:00:00',7),(541,'2012-05-08 00:00:00','1970-01-01 14:00:00','1970-01-01 16:00:00',8),(542,'2012-05-15 00:00:00','1970-01-01 14:00:00','1970-01-01 16:00:00',8),(543,'2012-05-22 00:00:00','1970-01-01 14:00:00','1970-01-01 16:00:00',8),(544,'2012-05-02 00:00:00','1970-01-01 14:00:00','1970-01-01 16:00:00',9),(545,'2012-05-09 00:00:00','1970-01-01 14:00:00','1970-01-01 16:00:00',9),(546,'2012-05-16 00:00:00','1970-01-01 14:00:00','1970-01-01 16:00:00',9),(547,'2012-05-23 00:00:00','1970-01-01 14:00:00','1970-01-01 16:00:00',9),(548,'2012-05-03 00:00:00','1970-01-01 14:00:00','1970-01-01 16:00:00',10),(549,'2012-05-10 00:00:00','1970-01-01 14:00:00','1970-01-01 16:00:00',10),(550,'2012-05-17 00:00:00','1970-01-01 14:00:00','1970-01-01 16:00:00',10),(551,'2012-05-24 00:00:00','1970-01-01 14:00:00','1970-01-01 16:00:00',10),(552,'2012-05-05 00:00:00','1970-01-01 10:00:00','1970-01-01 12:00:00',11),(553,'2012-05-12 00:00:00','1970-01-01 10:00:00','1970-01-01 12:00:00',11),(554,'2012-05-19 00:00:00','1970-01-01 10:00:00','1970-01-01 12:00:00',11),(555,'2012-05-26 00:00:00','1970-01-01 10:00:00','1970-01-01 12:00:00',11),(556,'2012-05-02 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(557,'2012-05-04 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(558,'2012-05-07 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(559,'2012-05-09 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(560,'2012-05-11 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(561,'2012-05-14 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(562,'2012-05-16 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(563,'2012-05-18 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(564,'2012-05-21 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(565,'2012-05-23 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(566,'2012-05-25 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(567,'2012-05-28 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(568,'2012-05-30 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(569,'2012-06-01 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(570,'2012-06-04 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(571,'2012-06-06 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(572,'2012-06-08 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(573,'2012-06-11 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(574,'2012-06-13 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(575,'2012-06-15 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(576,'2012-06-18 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(577,'2012-06-20 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(578,'2012-06-22 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(579,'2012-06-25 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(580,'2012-06-27 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(581,'2012-06-29 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(582,'2012-07-02 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(583,'2012-07-04 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(584,'2012-07-06 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(585,'2012-07-09 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(586,'2012-07-11 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(587,'2012-07-13 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(588,'2012-07-16 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(589,'2012-07-18 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(590,'2012-07-20 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(591,'2012-07-23 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(592,'2012-07-25 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(593,'2012-07-27 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(594,'2012-07-30 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(595,'2012-08-01 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(596,'2012-08-03 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(597,'2012-08-06 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(598,'2012-08-08 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(599,'2012-08-10 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(600,'2012-08-13 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(601,'2012-08-15 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(602,'2012-08-17 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(603,'2012-08-20 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(604,'2012-08-22 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(605,'2012-08-24 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(606,'2012-08-27 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(607,'2012-08-29 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(608,'2012-08-31 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(609,'2012-09-03 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(610,'2012-09-05 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(611,'2012-09-07 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(612,'2012-09-10 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(613,'2012-09-12 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(614,'2012-09-14 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(615,'2012-09-17 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(616,'2012-09-19 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(617,'2012-09-21 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(618,'2012-09-24 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(619,'2012-09-26 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(620,'2012-09-28 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(621,'2012-10-01 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(622,'2012-10-03 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(623,'2012-10-05 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(624,'2012-10-08 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(625,'2012-10-10 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(626,'2012-10-12 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(627,'2012-10-15 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(628,'2012-10-17 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(629,'2012-10-19 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(630,'2012-10-22 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(631,'2012-10-24 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(632,'2012-10-26 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(633,'2012-10-29 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(634,'2012-10-31 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(635,'2012-11-02 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(636,'2012-11-05 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(637,'2012-11-07 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(638,'2012-11-09 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(639,'2012-11-12 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(640,'2012-11-14 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(641,'2012-11-16 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(642,'2012-11-19 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(643,'2012-11-21 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(644,'2012-11-23 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(645,'2012-11-26 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(646,'2012-11-28 00:00:00','1970-01-01 12:00:00','1970-01-01 13:00:00',13),(647,'2012-05-02 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(648,'2012-05-04 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(649,'2012-05-07 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(650,'2012-05-09 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(651,'2012-05-11 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(652,'2012-05-14 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(653,'2012-05-16 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(654,'2012-05-18 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(655,'2012-05-21 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(656,'2012-05-23 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(657,'2012-05-25 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(658,'2012-05-28 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(659,'2012-05-30 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(660,'2012-06-01 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(661,'2012-06-04 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(662,'2012-06-06 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(663,'2012-06-08 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(664,'2012-06-11 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(665,'2012-06-13 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(666,'2012-06-15 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(667,'2012-06-18 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(668,'2012-06-20 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(669,'2012-06-22 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(670,'2012-06-25 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(671,'2012-06-27 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(672,'2012-06-29 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(673,'2012-07-02 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(674,'2012-07-04 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(675,'2012-07-06 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(676,'2012-07-09 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(677,'2012-07-11 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(678,'2012-07-13 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(679,'2012-07-16 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(680,'2012-07-18 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(681,'2012-07-20 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(682,'2012-07-23 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(683,'2012-07-25 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(684,'2012-07-27 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(685,'2012-07-30 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(686,'2012-08-01 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(687,'2012-08-03 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(688,'2012-08-06 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(689,'2012-08-08 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(690,'2012-08-10 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(691,'2012-08-13 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(692,'2012-08-15 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(693,'2012-08-17 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(694,'2012-08-20 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(695,'2012-08-22 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(696,'2012-08-24 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(697,'2012-08-27 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(698,'2012-08-29 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(699,'2012-08-31 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(700,'2012-09-03 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(701,'2012-09-05 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(702,'2012-09-07 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(703,'2012-09-10 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(704,'2012-09-12 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(705,'2012-09-14 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(706,'2012-09-17 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(707,'2012-09-19 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(708,'2012-09-21 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(709,'2012-09-24 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(710,'2012-09-26 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(711,'2012-09-28 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(712,'2012-10-01 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(713,'2012-10-03 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(714,'2012-10-05 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(715,'2012-10-08 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(716,'2012-10-10 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(717,'2012-10-12 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(718,'2012-10-15 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(719,'2012-10-17 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(720,'2012-10-19 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(721,'2012-10-22 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(722,'2012-10-24 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(723,'2012-10-26 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(724,'2012-10-29 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(725,'2012-10-31 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(726,'2012-11-02 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(727,'2012-11-05 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(728,'2012-11-07 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(729,'2012-11-09 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(730,'2012-11-12 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(731,'2012-11-14 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(732,'2012-11-16 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(733,'2012-11-19 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(734,'2012-11-21 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(735,'2012-11-23 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(736,'2012-11-26 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(737,'2012-11-28 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(738,'2012-11-30 00:00:00','1970-01-01 13:00:00','1970-01-01 14:00:00',13),(739,'2012-05-02 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(740,'2012-05-04 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(741,'2012-05-07 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(742,'2012-05-09 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(743,'2012-05-11 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(744,'2012-05-14 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(745,'2012-05-16 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(746,'2012-05-18 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(747,'2012-05-21 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(748,'2012-05-23 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(749,'2012-05-25 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(750,'2012-05-28 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(751,'2012-05-30 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(752,'2012-06-01 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(753,'2012-06-04 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(754,'2012-06-06 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(755,'2012-06-08 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(756,'2012-06-11 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(757,'2012-06-13 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(758,'2012-06-15 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(759,'2012-06-18 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(760,'2012-06-20 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(761,'2012-06-22 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(762,'2012-06-25 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(763,'2012-06-27 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(764,'2012-06-29 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(765,'2012-07-02 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(766,'2012-07-04 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(767,'2012-07-06 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(768,'2012-07-09 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(769,'2012-07-11 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(770,'2012-07-13 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(771,'2012-07-16 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(772,'2012-07-18 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(773,'2012-07-20 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(774,'2012-07-23 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(775,'2012-07-25 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(776,'2012-07-27 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(777,'2012-07-30 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(778,'2012-08-01 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(779,'2012-08-03 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(780,'2012-08-06 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(781,'2012-08-08 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(782,'2012-08-10 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(783,'2012-08-13 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(784,'2012-08-15 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(785,'2012-08-17 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(786,'2012-08-20 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(787,'2012-08-22 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(788,'2012-08-24 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(789,'2012-08-27 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(790,'2012-08-29 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(791,'2012-08-31 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(792,'2012-09-03 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(793,'2012-09-05 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(794,'2012-09-07 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(795,'2012-09-10 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(796,'2012-09-12 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(797,'2012-09-14 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(798,'2012-09-17 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(799,'2012-09-19 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(800,'2012-09-21 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(801,'2012-09-24 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(802,'2012-09-26 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(803,'2012-09-28 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(804,'2012-10-01 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(805,'2012-10-03 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(806,'2012-10-05 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(807,'2012-10-08 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(808,'2012-10-10 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(809,'2012-10-12 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(810,'2012-10-15 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(811,'2012-10-17 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(812,'2012-10-19 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(813,'2012-10-22 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(814,'2012-10-24 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(815,'2012-10-26 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(816,'2012-10-29 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(817,'2012-10-31 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(818,'2012-11-02 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(819,'2012-11-05 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(820,'2012-11-07 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(821,'2012-11-09 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(822,'2012-11-12 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(823,'2012-11-14 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(824,'2012-11-16 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(825,'2012-11-19 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(826,'2012-11-21 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(827,'2012-11-23 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(828,'2012-11-26 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(829,'2012-11-28 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(830,'2012-11-30 00:00:00','1970-01-01 15:00:00','1970-01-01 15:50:00',13),(831,'2012-05-02 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(832,'2012-05-04 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(833,'2012-05-07 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(834,'2012-05-09 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(835,'2012-05-11 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(836,'2012-05-14 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(837,'2012-05-16 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(838,'2012-05-18 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(839,'2012-05-21 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(840,'2012-05-23 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(841,'2012-05-25 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(842,'2012-05-28 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(843,'2012-05-30 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(844,'2012-06-01 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(845,'2012-06-04 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(846,'2012-06-06 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(847,'2012-06-08 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(848,'2012-06-11 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(849,'2012-06-13 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(850,'2012-06-15 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(851,'2012-06-18 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(852,'2012-06-20 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(853,'2012-06-22 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(854,'2012-06-25 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(855,'2012-06-27 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(856,'2012-06-29 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(857,'2012-07-02 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(858,'2012-07-04 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(859,'2012-07-06 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(860,'2012-07-09 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(861,'2012-07-11 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(862,'2012-07-13 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(863,'2012-07-16 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(864,'2012-07-18 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(865,'2012-07-20 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(866,'2012-07-23 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(867,'2012-07-25 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(868,'2012-07-27 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(869,'2012-07-30 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(870,'2012-08-01 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(871,'2012-08-03 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(872,'2012-08-06 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(873,'2012-08-08 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(874,'2012-08-10 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(875,'2012-08-13 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(876,'2012-08-15 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(877,'2012-08-17 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(878,'2012-08-20 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(879,'2012-08-22 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(880,'2012-08-24 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(881,'2012-08-27 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(882,'2012-08-29 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(883,'2012-08-31 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(884,'2012-09-03 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(885,'2012-09-05 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(886,'2012-09-07 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(887,'2012-09-10 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(888,'2012-09-12 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(889,'2012-09-14 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(890,'2012-09-17 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(891,'2012-09-19 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(892,'2012-09-21 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(893,'2012-09-24 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(894,'2012-09-26 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(895,'2012-09-28 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(896,'2012-10-01 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(897,'2012-10-03 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(898,'2012-10-05 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(899,'2012-10-08 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(900,'2012-10-10 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(901,'2012-10-12 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(902,'2012-10-15 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(903,'2012-10-17 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(904,'2012-10-19 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(905,'2012-10-22 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(906,'2012-10-24 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(907,'2012-10-26 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(908,'2012-10-29 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(909,'2012-10-31 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(910,'2012-11-02 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(911,'2012-11-05 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(912,'2012-11-07 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(913,'2012-11-09 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(914,'2012-11-12 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(915,'2012-11-14 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(916,'2012-11-16 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(917,'2012-11-19 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(918,'2012-11-21 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(919,'2012-11-23 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(920,'2012-11-26 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(921,'2012-11-28 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(922,'2012-11-30 00:00:00','1970-01-01 15:50:00','1970-01-01 16:30:00',13),(923,'2012-05-01 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(924,'2012-05-02 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(925,'2012-05-03 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(926,'2012-05-04 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(927,'2012-05-07 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(928,'2012-05-08 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(929,'2012-05-09 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(930,'2012-05-10 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(931,'2012-05-11 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(932,'2012-05-14 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(933,'2012-05-15 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(934,'2012-05-16 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(935,'2012-05-17 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(936,'2012-05-18 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(937,'2012-05-21 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(938,'2012-05-22 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(939,'2012-05-23 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(940,'2012-05-24 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(941,'2012-05-25 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(942,'2012-05-28 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(943,'2012-05-29 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(944,'2012-05-30 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(945,'2012-05-31 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(946,'2012-06-01 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(947,'2012-06-04 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(948,'2012-06-05 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(949,'2012-06-06 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(950,'2012-06-07 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(951,'2012-06-08 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(952,'2012-06-11 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(953,'2012-06-12 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(954,'2012-06-13 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(955,'2012-06-14 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(956,'2012-06-15 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(957,'2012-06-18 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(958,'2012-06-19 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(959,'2012-06-20 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(960,'2012-06-21 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(961,'2012-06-22 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(962,'2012-06-25 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(963,'2012-06-26 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(964,'2012-06-27 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(965,'2012-06-28 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(966,'2012-06-29 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(967,'2012-07-02 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(968,'2012-07-03 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(969,'2012-07-04 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(970,'2012-07-05 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(971,'2012-07-06 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(972,'2012-07-09 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(973,'2012-07-10 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(974,'2012-07-11 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(975,'2012-07-12 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(976,'2012-07-13 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(977,'2012-07-16 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(978,'2012-07-17 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(979,'2012-07-18 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(980,'2012-07-19 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(981,'2012-07-20 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(982,'2012-07-23 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(983,'2012-07-24 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(984,'2012-07-25 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(985,'2012-07-26 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(986,'2012-07-27 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(987,'2012-07-30 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(988,'2012-07-31 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(989,'2012-08-01 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(990,'2012-08-02 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(991,'2012-08-03 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(992,'2012-08-06 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(993,'2012-08-07 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(994,'2012-08-08 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(995,'2012-08-09 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(996,'2012-08-10 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(997,'2012-08-13 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(998,'2012-08-14 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(999,'2012-08-15 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1000,'2012-08-16 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1001,'2012-08-17 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1002,'2012-08-20 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1003,'2012-08-21 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1004,'2012-08-22 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1005,'2012-08-23 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1006,'2012-08-24 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1007,'2012-08-27 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1008,'2012-08-28 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1009,'2012-08-29 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1010,'2012-08-30 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1011,'2012-08-31 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1012,'2012-09-03 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1013,'2012-09-04 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1014,'2012-09-05 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1015,'2012-09-06 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1016,'2012-09-07 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1017,'2012-09-10 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1018,'2012-09-11 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1019,'2012-09-12 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1020,'2012-09-13 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1021,'2012-09-14 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1022,'2012-09-17 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1023,'2012-09-18 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1024,'2012-09-19 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1025,'2012-09-20 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1026,'2012-09-21 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1027,'2012-09-24 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1028,'2012-09-25 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1029,'2012-09-26 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1030,'2012-09-27 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1031,'2012-09-28 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1032,'2012-10-01 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1033,'2012-10-02 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1034,'2012-10-03 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1035,'2012-10-04 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1036,'2012-10-05 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1037,'2012-10-08 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1038,'2012-10-09 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1039,'2012-10-10 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1040,'2012-10-11 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1041,'2012-10-12 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1042,'2012-10-15 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1043,'2012-10-16 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1044,'2012-10-17 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1045,'2012-10-18 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1046,'2012-10-19 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1047,'2012-10-22 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1048,'2012-10-23 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1049,'2012-10-24 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1050,'2012-10-25 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1051,'2012-10-26 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1052,'2012-10-29 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1053,'2012-10-30 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1054,'2012-10-31 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1055,'2012-11-01 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1056,'2012-11-02 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1057,'2012-11-05 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1058,'2012-11-06 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1059,'2012-11-07 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1060,'2012-11-08 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1061,'2012-11-09 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1062,'2012-11-12 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1063,'2012-11-13 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1064,'2012-11-14 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1065,'2012-11-15 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1066,'2012-11-16 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1067,'2012-11-19 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1068,'2012-11-20 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1069,'2012-11-21 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1070,'2012-11-22 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1071,'2012-11-23 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1072,'2012-11-26 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1073,'2012-11-27 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1074,'2012-11-28 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1075,'2012-11-29 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14),(1076,'2012-11-30 00:00:00','1970-01-01 12:00:00','1970-01-01 19:00:00',14);
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
INSERT INTO `responsable_actividad` VALUES (1,1),(1,2),(1,3),(1,4),(2,5),(5,9),(5,12),(6,10),(6,12),(8,13);
/*!40000 ALTER TABLE `responsable_actividad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'websalud'
--

--
-- Dumping routines for database 'websalud'
--
/*!50003 DROP FUNCTION IF EXISTS `asignar_cita` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `asignar_cita`(pidcita int,pidpaciente int) RETURNS int(11)
    DETERMINISTIC
BEGIN
   DECLARE vcupo int DEFAULT 0;
   DECLARE vidcita int DEFAULT 0;
   
   select (c.cupo-
   (
    select count(*) from cita_paciente pc where pc.idcita=pidcita
    and pc.estado=1
    )) as cupo_d into vcupo
    from cita c
    where c.idcita=pidcita;
    if vcupo>0 then
        
        select idcita into vidcita from cita_paciente where idcita=pidcita and idpaciente=pidpaciente;
        
        
        if vidcita<=0 then
                INSERT INTO cita_paciente
                      (idcita, 
                      idpaciente, 
                      estado) 
                    VALUES 
                      (pidcita, 
                      pidpaciente, 
                      1);
        else
                UPDATE cita_paciente SET 
                  estado = 1 
                WHERE
                  idcita = pidcita AND idpaciente = pidpaciente;
        end if;
        
        return 1;    
    else
        return 0;
    
    end if;
   return 0;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `EliminarActividad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
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
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
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
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
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
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
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
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
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
                      
            DELETE FROM menu WHERE idmenu=pidmenu;
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
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
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
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
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
/*!50003 DROP FUNCTION IF EXISTS `InsertarCita` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `InsertarCita`(pfecha datetime,phorai datetime,phoraf datetime,pcupo INT,pestado INT, pexamen INT ) RETURNS int(11)
    DETERMINISTIC
BEGIN
   DECLARE idday int DEFAULT 0;
   select ifnull(max(idcita),0) into idday from cita where fecha=pfecha and hora_inicio=phorai and tipo_examen=pexamen ;

if idday=0 then

    INSERT INTO cita
  (estado, 
  tipo_examen, 
  cupo, 
  fecha, 
  hora_inicio,
  hora_fin) 
VALUES 
  (pestado, 
  pexamen, 
  pcupo,
  pfecha,
  phorai,
  phoraf);

end if;
    RETURN 1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `Rango_cintas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `Rango_cintas`(fecha_inicio DATETIME,fecha_fin DATETIME,hora_inicio DATETIME,hora_fin DATETIME, cupo INT, examen INT, estado INT, lunes INT,martes INT,miercoles INT,jueves INT, viernes INT, sabado INT,domingo INT) RETURNS int(11)
    DETERMINISTIC
BEGIN
    DECLARE mydate DATETIME;
    DECLARE mday int;
    SET mday=0;
    SET mydate = fecha_inicio;
    SET fecha_fin = date_add(fecha_fin, INTERVAL 1 DAY);
    IF fecha_inicio<=fecha_fin  then
        WHILE mydate < fecha_fin DO
            
            if (lunes=1 and DAYOFWEEK(mydate)=2) then
                
                SET mday=mday+InsertarCita(mydate,hora_inicio,hora_fin,cupo,estado , examen );
            end if;
            if (martes=1 and DAYOFWEEK(mydate)=3) then
                SET mday=mday+InsertarCita(mydate,hora_inicio,hora_fin,cupo,estado , examen );
            end if;
            if (miercoles=1 and DAYOFWEEK(mydate)=4) then
                SET mday=mday+InsertarCita(mydate,hora_inicio,hora_fin,cupo,estado , examen );
            end if;
            if (jueves=1 and DAYOFWEEK(mydate)=5) then
                SET mday=mday+InsertarCita(mydate,hora_inicio,hora_fin,cupo,estado , examen );
            end if;
            if (viernes=1 and DAYOFWEEK(mydate)=6) then
                SET mday=mday+InsertarCita(mydate,hora_inicio,hora_fin,cupo,estado , examen );
            end if;
            if (sabado=1 and DAYOFWEEK(mydate)=7) then
                SET mday=mday+InsertarCita(mydate,hora_inicio,hora_fin,cupo,estado , examen );
            end if;
            if (domingo=1 and DAYOFWEEK(mydate)=1) then
                SET mday=mday+InsertarCita(mydate,hora_inicio,hora_fin,cupo,estado , examen );
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
/*!50003 DROP FUNCTION IF EXISTS `Rango_fechas` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `Rango_fechas`(idactividad int,fecha_inicio DATETIME,fecha_fin DATETIME,hora_inicio DATETIME,hora_fin DATETIME, lunes INT,martes INT,miercoles INT,jueves INT, viernes INT, sabado INT,domingo INT) RETURNS int(11)
    DETERMINISTIC
BEGIN
    DECLARE mydate DATETIME;
    DECLARE mday int;
    SET mday=0;
    SET mydate = fecha_inicio;
    SET fecha_fin = date_add(fecha_fin, INTERVAL 1 DAY);
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

-- Dump completed on 2012-06-03 14:01:43
