CREATE TABLE noticia (
  idnoticia              int(11) NOT NULL AUTO_INCREMENT, 
  titulo                 varchar(100) NOT NULL, 
  descripcion            varchar(400) NOT NULL, 
  areaidarea             int(11) NOT NULL, 
  fecha_inicio           datetime NOT NULL, 
  fecha_fin              datetime NOT NULL, 
  prioridad              int(11) DEFAULT 1 NOT NULL, 
  multimediaidmultimedia int(11), 
  descripcion_corta      varchar(100) NOT NULL, 
  estado                 int(10) DEFAULT 1 NOT NULL comment '1-> activo, 0 -> inactivo', 
  createtime             timestamp DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY (idnoticia));
CREATE TABLE menu (
  idmenu      int(11) NOT NULL AUTO_INCREMENT, 
  descripcion varchar(50) NOT NULL, 
  areaidarea  int(11) NOT NULL, 
  contenido   text, 
  idmenu_rec  int(11), 
  size        int(11) DEFAULT 4 NOT NULL, 
  PRIMARY KEY (idmenu));
CREATE TABLE area (
  idarea                 int(11) NOT NULL AUTO_INCREMENT, 
  nombre                 varchar(60) NOT NULL, 
  areaidarea             int(11), 
  descripcion            text, 
  size                   int(11) DEFAULT 3 NOT NULL comment '0-> sin texto, 1 -> pequeño , 2 -> mediano, 3 -> Grande', 
  multimediaidmultimedia int(11), 
  PRIMARY KEY (idarea));
CREATE TABLE encabezado (
  areaidarea             int(11) NOT NULL, 
  multimediaidmultimedia int(11) NOT NULL, 
  PRIMARY KEY (areaidarea, 
  multimediaidmultimedia));
CREATE TABLE contenido (
  menuidmenu             int(11) NOT NULL, 
  idcontenido            int(11) NOT NULL AUTO_INCREMENT, 
  descripcion            text NOT NULL, 
  titulo                 varchar(100) NOT NULL, 
  multimediaidmultimedia int(11) NOT NULL, 
  PRIMARY KEY (idcontenido));
CREATE TABLE actividad (
  idactividad int(11) NOT NULL AUTO_INCREMENT, 
  titulo      varchar(255) NOT NULL, 
  fechainicio datetime NOT NULL, 
  fechafin    datetime, 
  Hora        datetime, 
  responsable varchar(255), 
  areaidarea  int(11) NOT NULL, 
  PRIMARY KEY (idactividad));
CREATE TABLE usuario (
  idusuario  int(10) NOT NULL AUTO_INCREMENT, 
  nombre     varchar(150) NOT NULL, 
  apellido   varchar(255) NOT NULL, 
  nick       varchar(50) NOT NULL, 
  password   varchar(255) NOT NULL UNIQUE, 
  telefono   varchar(50), 
  email      varchar(100), 
  areaidarea int(11) NOT NULL, 
  PRIMARY KEY (idusuario));
CREATE TABLE permisos (
  idpermiso   int(10) NOT NULL AUTO_INCREMENT, 
  descripcion varchar(255) NOT NULL, 
  PRIMARY KEY (idpermiso));
CREATE TABLE usuario_permisos (
  usuarioidusuario  int(10) NOT NULL, 
  permisosidpermiso int(10) NOT NULL, 
  PRIMARY KEY (usuarioidusuario, 
  permisosidpermiso));
CREATE TABLE configuracion (
  idconfiguracion    int(10) NOT NULL AUTO_INCREMENT, 
  telefono           varchar(50), 
  correo_electronico varchar(100), 
  fax                varchar(50), 
  direccion_imagen   varchar(100) NOT NULL, 
  direccion_pdf      varchar(100) NOT NULL, 
  tamanio_sub        int(10) NOT NULL, 
  dir_rel_imagen     varchar(100) NOT NULL, 
  dir_rel_pdf        varchar(100) NOT NULL, 
  direccion          varchar(255), 
  PRIMARY KEY (idconfiguracion));
CREATE TABLE multimedia (
  idmultimedia       int(11) NOT NULL AUTO_INCREMENT, 
  direccion          varchar(255) NOT NULL, 
  direccion_relativa varchar(255) NOT NULL, 
  tamanio            longtext NOT NULL, 
  usuarioidusuario   int(10) NOT NULL, 
  createtime         timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL, 
  tipo               int(11) DEFAULT 1 NOT NULL comment '1-> imagen 2-> pdf', 
  PRIMARY KEY (idmultimedia));
ALTER TABLE noticia ADD INDEX FKnoticia378758 (areaidarea), ADD CONSTRAINT FKnoticia378758 FOREIGN KEY (areaidarea) REFERENCES area (idarea);
ALTER TABLE menu ADD INDEX FKmenu590668 (areaidarea), ADD CONSTRAINT FKmenu590668 FOREIGN KEY (areaidarea) REFERENCES area (idarea);
ALTER TABLE encabezado ADD INDEX FKencabezado458445 (areaidarea), ADD CONSTRAINT FKencabezado458445 FOREIGN KEY (areaidarea) REFERENCES area (idarea);
ALTER TABLE contenido ADD INDEX FKcontenido303639 (menuidmenu), ADD CONSTRAINT FKcontenido303639 FOREIGN KEY (menuidmenu) REFERENCES menu (idmenu);
ALTER TABLE menu ADD INDEX FKmenu855382 (idmenu_rec), ADD CONSTRAINT FKmenu855382 FOREIGN KEY (idmenu_rec) REFERENCES menu (idmenu);
ALTER TABLE actividad ADD INDEX FKactividad858803 (areaidarea), ADD CONSTRAINT FKactividad858803 FOREIGN KEY (areaidarea) REFERENCES area (idarea);
ALTER TABLE usuario ADD INDEX FKusuario397971 (areaidarea), ADD CONSTRAINT FKusuario397971 FOREIGN KEY (areaidarea) REFERENCES area (idarea);
ALTER TABLE usuario_permisos ADD INDEX FKusuario_pe657117 (usuarioidusuario), ADD CONSTRAINT FKusuario_pe657117 FOREIGN KEY (usuarioidusuario) REFERENCES usuario (idusuario);
ALTER TABLE usuario_permisos ADD INDEX FKusuario_pe436420 (permisosidpermiso), ADD CONSTRAINT FKusuario_pe436420 FOREIGN KEY (permisosidpermiso) REFERENCES permisos (idpermiso);
ALTER TABLE area ADD INDEX FKarea245370 (areaidarea), ADD CONSTRAINT FKarea245370 FOREIGN KEY (areaidarea) REFERENCES area (idarea);
ALTER TABLE multimedia ADD INDEX FKmultimedia696932 (usuarioidusuario), ADD CONSTRAINT FKmultimedia696932 FOREIGN KEY (usuarioidusuario) REFERENCES usuario (idusuario);
ALTER TABLE contenido ADD INDEX FKcontenido417686 (multimediaidmultimedia), ADD CONSTRAINT FKcontenido417686 FOREIGN KEY (multimediaidmultimedia) REFERENCES multimedia (idmultimedia);
ALTER TABLE area ADD INDEX FKarea432514 (multimediaidmultimedia), ADD CONSTRAINT FKarea432514 FOREIGN KEY (multimediaidmultimedia) REFERENCES multimedia (idmultimedia);
ALTER TABLE encabezado ADD INDEX FKencabezado219439 (multimediaidmultimedia), ADD CONSTRAINT FKencabezado219439 FOREIGN KEY (multimediaidmultimedia) REFERENCES multimedia (idmultimedia);
ALTER TABLE noticia ADD INDEX FKnoticia914947 (multimediaidmultimedia), ADD CONSTRAINT FKnoticia914947 FOREIGN KEY (multimediaidmultimedia) REFERENCES multimedia (idmultimedia);
