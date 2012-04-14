CREATE TABLE noticia (
  idnoticia                  int(11) NOT NULL AUTO_INCREMENT, 
  titulo                     varchar(100) NOT NULL, 
  descripcion                varchar(400) NOT NULL, 
  areaidarea                 int(11) NOT NULL, 
  fecha_inicio               datetime NOT NULL, 
  fecha_fin                  datetime NOT NULL, 
  prioridad                  int(11) DEFAULT 1 NOT NULL, 
  multimediaidmultimedia     int(11), 
  descripcion_corta          varchar(100) NOT NULL, 
  estado                     int(10) DEFAULT 1 NOT NULL comment '1-> activo, 0 -> inactivo', 
  createtime                 timestamp DEFAULT CURRENT_TIMESTAMP, 
  multimediaidmultimedia_pdf int(11) NOT NULL, 
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
  idactividad        int(11) NOT NULL AUTO_INCREMENT, 
  titulo             varchar(150) NOT NULL, 
  areaidarea         int(11) NOT NULL, 
  descripcion        text, 
  edificioidedificio int(11) NOT NULL, 
  salon              varchar(100), 
  PRIMARY KEY (idactividad));
CREATE TABLE usuario (
  idusuario     int(10) NOT NULL AUTO_INCREMENT, 
  nombre        varchar(150) NOT NULL, 
  apellido      varchar(150) NOT NULL, 
  nick          varchar(50) NOT NULL, 
  password      varchar(100) NOT NULL UNIQUE, 
  telefono      varchar(50), 
  email         varchar(100), 
  estado        int(11) NOT NULL comment '1-> activo, 2-> desactivado', 
  updateusuario int(10) NOT NULL, 
  createtime    timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL, 
  no_personal   varchar(20), 
  PRIMARY KEY (idusuario));
CREATE TABLE permiso (
  idpermiso           int(10) NOT NULL AUTO_INCREMENT, 
  descripcion         varchar(255) NOT NULL, 
  idcategoria_permiso int(10) NOT NULL, 
  PRIMARY KEY (idpermiso));
CREATE TABLE usuario_permisos (
  usuarioidusuario int(10) NOT NULL, 
  permisoidpermiso int(10) NOT NULL, 
  PRIMARY KEY (usuarioidusuario, 
  permisoidpermiso));
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
CREATE TABLE responsable (
  idresponsable    int(11) NOT NULL AUTO_INCREMENT, 
  nombre           varchar(150) NOT NULL, 
  apellido         varchar(150) NOT NULL, 
  usuarioidusuario int(10), 
  areaidarea       int(11) NOT NULL, 
  PRIMARY KEY (idresponsable));
CREATE TABLE edificio (
  idedificio int(11) NOT NULL AUTO_INCREMENT, 
  nombre     varchar(100), 
  direccion  varchar(250), 
  telefono   varchar(50), 
  PRIMARY KEY (idedificio));
CREATE TABLE detalleactividad (
  iddetalleactividad   int(20) NOT NULL AUTO_INCREMENT, 
  fecha                datetime NOT NULL, 
  horainicio           datetime NOT NULL, 
  horafin              datetime NOT NULL, 
  actividadidactividad int(11) NOT NULL, 
  PRIMARY KEY (iddetalleactividad));
CREATE TABLE responsable_actividad (
  responsableidresponsable int(11) NOT NULL, 
  actividadidactividad     int(11) NOT NULL, 
  PRIMARY KEY (responsableidresponsable, 
  actividadidactividad));
CREATE TABLE pregunta (
  idpregunta           int(10) NOT NULL AUTO_INCREMENT, 
  orden                int(11) NOT NULL, 
  requerida            int(10) DEFAULT 0 NOT NULL, 
  pregunta             varchar(255) NOT NULL, 
  categoriaidcategoria int(10) NOT NULL, 
  descripcion          varchar(200), 
  idtipo_pregunta      int(10) NOT NULL, 
  auto_evaluacion      int(10) NOT NULL, 
  multifasico          int(11) NOT NULL, 
  largo                int(10) comment '1->pequeño,2->mediano,3->Grande', 
  multiple             int(11), 
  estado               int(11) DEFAULT 1 NOT NULL, 
  PRIMARY KEY (idpregunta));
CREATE TABLE categoria (
  idcategoria    int(10) NOT NULL AUTO_INCREMENT, 
  descripcion    varchar(100) NOT NULL, 
  orden          int(11) NOT NULL, 
  autoevaluacion int(10) NOT NULL, 
  multifasico    int(10) NOT NULL, 
  estado         int(11) DEFAULT 1 NOT NULL, 
  PRIMARY KEY (idcategoria));
CREATE TABLE titulo_respuesta (
  idtitulo_respuesta int(11) NOT NULL AUTO_INCREMENT, 
  descripcion        varchar(100) NOT NULL, 
  PRIMARY KEY (idtitulo_respuesta));
CREATE TABLE categoria_interpretacion (
  idcategoria_interpretacion int(10) NOT NULL AUTO_INCREMENT, 
  ponderacion_max            int(10) NOT NULL, 
  ponderacion_min            int(10) NOT NULL, 
  interpretacion             text, 
  idcategoria                int(10) NOT NULL, 
  PRIMARY KEY (idcategoria_interpretacion));
CREATE TABLE paciente (
  idpaciente                           int(20) NOT NULL AUTO_INCREMENT, 
  nombre                               varchar(300) NOT NULL, 
  fecha_nac                            datetime NOT NULL, 
  carne                                int(11) UNIQUE, 
  direccion                            varchar(300) NOT NULL, 
  telefono                             varchar(50) NOT NULL, 
  movil                                varchar(50) NOT NULL, 
  email                                varchar(80) NOT NULL, 
  emer_nombre                          varchar(200), 
  idemer_parentesco                    int(11), 
  emer_telefono                        varchar(50), 
  emer_movil                           varchar(50), 
  carreraidcarrera                     int(11), 
  tipo_sangreidtipo_sangre             int(11), 
  estado_civilidestado_civil           int(11), 
  centro_regionalidcentro_regional     int(11), 
  unidad_academicaidunidad_academica   int(11), 
  titulo_secundariaidtitulo_secundaria int(11), 
  dependenciaiddependencia             int(11), 
  password                             varchar(50), 
  usuario                              varchar(20), 
  parentesco_ced                       int(11), 
  ced                                  varchar(50) NOT NULL, 
  sexo                                 int(11) DEFAULT 1 NOT NULL, 
  PRIMARY KEY (idpaciente));
CREATE TABLE estado_civil (
  idestado_civil int(11) NOT NULL AUTO_INCREMENT, 
  nombre         varchar(100) NOT NULL, 
  PRIMARY KEY (idestado_civil));
CREATE TABLE tipo_sangre (
  idtipo_sangre int(11) NOT NULL AUTO_INCREMENT, 
  nombre        varchar(100) NOT NULL, 
  PRIMARY KEY (idtipo_sangre));
CREATE TABLE unidad_academica (
  idunidad_academica int(11) NOT NULL AUTO_INCREMENT, 
  nombre             varchar(100) NOT NULL, 
  PRIMARY KEY (idunidad_academica));
CREATE TABLE carrera (
  idcarrera int(11) NOT NULL AUTO_INCREMENT, 
  nombre    varchar(100) NOT NULL, 
  PRIMARY KEY (idcarrera));
CREATE TABLE centro_regional (
  idcentro_regional          int(11) NOT NULL AUTO_INCREMENT, 
  nombre                     varchar(100) NOT NULL, 
  departamentoiddepartamento int(11), 
  PRIMARY KEY (idcentro_regional));
CREATE TABLE departamento (
  iddepartamento int(11) NOT NULL AUTO_INCREMENT, 
  nombre         varchar(100) NOT NULL, 
  PRIMARY KEY (iddepartamento));
CREATE TABLE parentesco (
  idparentesco            int(11) NOT NULL AUTO_INCREMENT, 
  nombre                  varchar(100) NOT NULL, 
  grupo_familiar          int(11) NOT NULL, 
  antecedentes_familiares int(10) NOT NULL, 
  emergencia              int(10) NOT NULL, 
  PRIMARY KEY (idparentesco));
CREATE TABLE categoria_permiso (
  idcategoria_permiso int(10) NOT NULL AUTO_INCREMENT, 
  nombre              varchar(150) NOT NULL, 
  PRIMARY KEY (idcategoria_permiso));
CREATE TABLE area_usuario (
  areaidarea       int(11) NOT NULL, 
  usuarioidusuario int(10) NOT NULL, 
  PRIMARY KEY (areaidarea, 
  usuarioidusuario));
CREATE TABLE titulo_secundaria (
  idtitulo_secundaria int(11) NOT NULL AUTO_INCREMENT, 
  nombre              varchar(150) NOT NULL, 
  PRIMARY KEY (idtitulo_secundaria));
CREATE TABLE dependencia (
  iddependencia int(11) NOT NULL AUTO_INCREMENT, 
  nombre        varchar(100), 
  PRIMARY KEY (iddependencia));
CREATE TABLE grupo_titulo_respuesta (
  idgrupo            int(10) NOT NULL, 
  idtitulo_respuesta int(11) NOT NULL, 
  orden              int(11) NOT NULL, 
  grupoidgrupo       int(11), 
  PRIMARY KEY (idgrupo, 
  idtitulo_respuesta));
CREATE TABLE pregunta_titulo_respuesta (
  idtitulo_respuesta int(11) NOT NULL, 
  idpregunta         int(10) NOT NULL, 
  ponderacion        int(10), 
  PRIMARY KEY (idtitulo_respuesta, 
  idpregunta));
CREATE TABLE tipo_pregunta (
  idtipo_pregunta int(10) NOT NULL AUTO_INCREMENT, 
  descripcion     varchar(100) NOT NULL, 
  idgrupo         int(11) UNIQUE, 
  PRIMARY KEY (idtipo_pregunta));
CREATE TABLE grupo (
  idgrupo     int(11) NOT NULL AUTO_INCREMENT, 
  descripcion varchar(100), 
  PRIMARY KEY (idgrupo));
ALTER TABLE noticia ADD INDEX FKnoticia378758 (areaidarea), ADD CONSTRAINT FKnoticia378758 FOREIGN KEY (areaidarea) REFERENCES area (idarea);
ALTER TABLE menu ADD INDEX FKmenu590668 (areaidarea), ADD CONSTRAINT FKmenu590668 FOREIGN KEY (areaidarea) REFERENCES area (idarea);
ALTER TABLE encabezado ADD INDEX FKencabezado458445 (areaidarea), ADD CONSTRAINT FKencabezado458445 FOREIGN KEY (areaidarea) REFERENCES area (idarea);
ALTER TABLE contenido ADD INDEX FKcontenido303639 (menuidmenu), ADD CONSTRAINT FKcontenido303639 FOREIGN KEY (menuidmenu) REFERENCES menu (idmenu);
ALTER TABLE menu ADD INDEX FKmenu855382 (idmenu_rec), ADD CONSTRAINT FKmenu855382 FOREIGN KEY (idmenu_rec) REFERENCES menu (idmenu);
ALTER TABLE actividad ADD INDEX FKactividad858803 (areaidarea), ADD CONSTRAINT FKactividad858803 FOREIGN KEY (areaidarea) REFERENCES area (idarea);
ALTER TABLE usuario_permisos ADD INDEX FKusuario_pe657117 (usuarioidusuario), ADD CONSTRAINT FKusuario_pe657117 FOREIGN KEY (usuarioidusuario) REFERENCES usuario (idusuario);
ALTER TABLE usuario_permisos ADD INDEX FKusuario_pe202856 (permisoidpermiso), ADD CONSTRAINT FKusuario_pe202856 FOREIGN KEY (permisoidpermiso) REFERENCES permiso (idpermiso);
ALTER TABLE area ADD INDEX FKarea245370 (areaidarea), ADD CONSTRAINT FKarea245370 FOREIGN KEY (areaidarea) REFERENCES area (idarea);
ALTER TABLE multimedia ADD INDEX FKmultimedia696932 (usuarioidusuario), ADD CONSTRAINT FKmultimedia696932 FOREIGN KEY (usuarioidusuario) REFERENCES usuario (idusuario);
ALTER TABLE contenido ADD INDEX FKcontenido417686 (multimediaidmultimedia), ADD CONSTRAINT FKcontenido417686 FOREIGN KEY (multimediaidmultimedia) REFERENCES multimedia (idmultimedia);
ALTER TABLE area ADD INDEX FKarea432514 (multimediaidmultimedia), ADD CONSTRAINT FKarea432514 FOREIGN KEY (multimediaidmultimedia) REFERENCES multimedia (idmultimedia);
ALTER TABLE encabezado ADD INDEX FKencabezado219439 (multimediaidmultimedia), ADD CONSTRAINT FKencabezado219439 FOREIGN KEY (multimediaidmultimedia) REFERENCES multimedia (idmultimedia);
ALTER TABLE noticia ADD INDEX FKnoticia914947 (multimediaidmultimedia), ADD CONSTRAINT FKnoticia914947 FOREIGN KEY (multimediaidmultimedia) REFERENCES multimedia (idmultimedia);
ALTER TABLE usuario ADD INDEX FKusuario800841 (updateusuario), ADD CONSTRAINT FKusuario800841 FOREIGN KEY (updateusuario) REFERENCES usuario (idusuario);
ALTER TABLE responsable ADD INDEX FKresponsabl927589 (usuarioidusuario), ADD CONSTRAINT FKresponsabl927589 FOREIGN KEY (usuarioidusuario) REFERENCES usuario (idusuario);
ALTER TABLE responsable ADD INDEX FKresponsabl680991 (areaidarea), ADD CONSTRAINT FKresponsabl680991 FOREIGN KEY (areaidarea) REFERENCES area (idarea);
ALTER TABLE actividad ADD INDEX FKactividad401066 (edificioidedificio), ADD CONSTRAINT FKactividad401066 FOREIGN KEY (edificioidedificio) REFERENCES edificio (idedificio);
ALTER TABLE detalleactividad ADD INDEX FKdetalleact662754 (actividadidactividad), ADD CONSTRAINT FKdetalleact662754 FOREIGN KEY (actividadidactividad) REFERENCES actividad (idactividad);
ALTER TABLE responsable_actividad ADD INDEX FKresponsabl971119 (responsableidresponsable), ADD CONSTRAINT FKresponsabl971119 FOREIGN KEY (responsableidresponsable) REFERENCES responsable (idresponsable);
ALTER TABLE responsable_actividad ADD INDEX FKresponsabl144858 (actividadidactividad), ADD CONSTRAINT FKresponsabl144858 FOREIGN KEY (actividadidactividad) REFERENCES actividad (idactividad);
ALTER TABLE centro_regional ADD INDEX FKcentro_reg197935 (departamentoiddepartamento), ADD CONSTRAINT FKcentro_reg197935 FOREIGN KEY (departamentoiddepartamento) REFERENCES departamento (iddepartamento);
ALTER TABLE paciente ADD INDEX FKpaciente761424 (idemer_parentesco), ADD CONSTRAINT FKpaciente761424 FOREIGN KEY (idemer_parentesco) REFERENCES parentesco (idparentesco);
ALTER TABLE paciente ADD INDEX FKpaciente156346 (carreraidcarrera), ADD CONSTRAINT FKpaciente156346 FOREIGN KEY (carreraidcarrera) REFERENCES carrera (idcarrera);
ALTER TABLE paciente ADD INDEX FKpaciente497631 (tipo_sangreidtipo_sangre), ADD CONSTRAINT FKpaciente497631 FOREIGN KEY (tipo_sangreidtipo_sangre) REFERENCES tipo_sangre (idtipo_sangre);
ALTER TABLE paciente ADD INDEX FKpaciente544904 (estado_civilidestado_civil), ADD CONSTRAINT FKpaciente544904 FOREIGN KEY (estado_civilidestado_civil) REFERENCES estado_civil (idestado_civil);
ALTER TABLE paciente ADD INDEX FKpaciente1089 (centro_regionalidcentro_regional), ADD CONSTRAINT FKpaciente1089 FOREIGN KEY (centro_regionalidcentro_regional) REFERENCES centro_regional (idcentro_regional);
ALTER TABLE paciente ADD INDEX FKpaciente178128 (unidad_academicaidunidad_academica), ADD CONSTRAINT FKpaciente178128 FOREIGN KEY (unidad_academicaidunidad_academica) REFERENCES unidad_academica (idunidad_academica);
ALTER TABLE permiso ADD INDEX FKpermiso30573 (idcategoria_permiso), ADD CONSTRAINT FKpermiso30573 FOREIGN KEY (idcategoria_permiso) REFERENCES categoria_permiso (idcategoria_permiso);
ALTER TABLE area_usuario ADD INDEX FKarea_usuar302492 (areaidarea), ADD CONSTRAINT FKarea_usuar302492 FOREIGN KEY (areaidarea) REFERENCES area (idarea);
ALTER TABLE area_usuario ADD INDEX FKarea_usuar665501 (usuarioidusuario), ADD CONSTRAINT FKarea_usuar665501 FOREIGN KEY (usuarioidusuario) REFERENCES usuario (idusuario);
ALTER TABLE noticia ADD INDEX FKnoticia744912 (multimediaidmultimedia_pdf), ADD CONSTRAINT FKnoticia744912 FOREIGN KEY (multimediaidmultimedia_pdf) REFERENCES multimedia (idmultimedia);
ALTER TABLE paciente ADD INDEX FKpaciente34221 (titulo_secundariaidtitulo_secundaria), ADD CONSTRAINT FKpaciente34221 FOREIGN KEY (titulo_secundariaidtitulo_secundaria) REFERENCES titulo_secundaria (idtitulo_secundaria);
ALTER TABLE paciente ADD INDEX FKpaciente702060 (dependenciaiddependencia), ADD CONSTRAINT FKpaciente702060 FOREIGN KEY (dependenciaiddependencia) REFERENCES dependencia (iddependencia);
ALTER TABLE grupo_titulo_respuesta ADD INDEX FKgrupo_titu883601 (idtitulo_respuesta), ADD CONSTRAINT FKgrupo_titu883601 FOREIGN KEY (idtitulo_respuesta) REFERENCES titulo_respuesta (idtitulo_respuesta);
ALTER TABLE pregunta_titulo_respuesta ADD INDEX FKpregunta_t278188 (idtitulo_respuesta), ADD CONSTRAINT FKpregunta_t278188 FOREIGN KEY (idtitulo_respuesta) REFERENCES titulo_respuesta (idtitulo_respuesta);
ALTER TABLE pregunta_titulo_respuesta ADD INDEX FKpregunta_t722293 (idpregunta), ADD CONSTRAINT FKpregunta_t722293 FOREIGN KEY (idpregunta) REFERENCES pregunta (idpregunta);
ALTER TABLE categoria_interpretacion ADD INDEX FKcategoria_569059 (idcategoria), ADD CONSTRAINT FKcategoria_569059 FOREIGN KEY (idcategoria) REFERENCES categoria (idcategoria);
ALTER TABLE pregunta ADD INDEX FKpregunta916024 (categoriaidcategoria), ADD CONSTRAINT FKpregunta916024 FOREIGN KEY (categoriaidcategoria) REFERENCES categoria (idcategoria);
ALTER TABLE pregunta ADD INDEX FKpregunta179647 (idtipo_pregunta), ADD CONSTRAINT FKpregunta179647 FOREIGN KEY (idtipo_pregunta) REFERENCES tipo_pregunta (idtipo_pregunta);
ALTER TABLE grupo_titulo_respuesta ADD INDEX FKgrupo_titu508512 (grupoidgrupo), ADD CONSTRAINT FKgrupo_titu508512 FOREIGN KEY (grupoidgrupo) REFERENCES grupo (idgrupo);
ALTER TABLE tipo_pregunta ADD INDEX FKtipo_pregu253906 (idgrupo), ADD CONSTRAINT FKtipo_pregu253906 FOREIGN KEY (idgrupo) REFERENCES grupo (idgrupo);
ALTER TABLE paciente ADD INDEX FKpaciente522871 (parentesco_ced), ADD CONSTRAINT FKpaciente522871 FOREIGN KEY (parentesco_ced) REFERENCES parentesco (idparentesco);
