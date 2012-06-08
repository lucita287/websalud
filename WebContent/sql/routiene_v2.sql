DELIMITER $$
DROP FUNCTION IF EXISTS `EliminarMenu`$$
CREATE FUNCTION EliminarMenu(pidmenu int ) RETURNS int
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
END
$$
DELIMITER $$
DROP FUNCTION IF EXISTS `Rango_fechas`$$
CREATE FUNCTION Rango_fechas(idactividad int,fecha_inicio DATETIME,fecha_fin DATETIME,hora_inicio DATETIME,hora_fin DATETIME, lunes INT,martes INT,miercoles INT,jueves INT, viernes INT, sabado INT,domingo INT) RETURNS int
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
END
$$
DELIMITER $$
DROP FUNCTION IF EXISTS `InsertarActividadFecha`$$
CREATE FUNCTION InsertarActividadFecha(pidactividad int,pfecha datetime,phorainicio datetime, phorafin datetime ) RETURNS int
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
END
$$
DELIMITER $$
DROP FUNCTION IF EXISTS `EliminarDetalleActividad`$$
CREATE FUNCTION EliminarDetalleActividad(pidactividad int ) RETURNS int
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
END
$$
DELIMITER $$
DROP FUNCTION IF EXISTS `EliminarActividad`$$
CREATE FUNCTION EliminarActividad(pidactividad int ) RETURNS int
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
END
$$
DELIMITER $$
DROP FUNCTION IF EXISTS `EliminarContenido`$$
CREATE FUNCTION EliminarContenido(pidcontenido int ) RETURNS int
    DETERMINISTIC
BEGIN
        DELETE FROM contenido WHERE idcontenido=pidcontenido ;
    
    RETURN 1;
END
$$
DELIMITER $$
DROP FUNCTION IF EXISTS `EliminarEncabezado`$$
CREATE FUNCTION EliminarEncabezado(pidarea int,pidmultimedia int ) RETURNS int
    DETERMINISTIC
BEGIN
        DELETE FROM encabezado WHERE areaidarea=pidarea and multimediaidmultimedia=pidmultimedia ;
    
    RETURN 1;
END
$$
DELIMITER $$
DROP FUNCTION IF EXISTS `EliminarNoticia`$$
CREATE FUNCTION EliminarNoticia(pidnoticia int ) RETURNS int
    DETERMINISTIC
BEGIN
    
        DELETE FROM noticia WHERE idnoticia=pidnoticia;
    
    RETURN 1;
END
$$
DELIMITER $$
DROP FUNCTION IF EXISTS `Rango_cintas`$$
CREATE FUNCTION Rango_cintas(fecha_inicio DATETIME,fecha_fin DATETIME,hora_inicio DATETIME,hora_fin DATETIME, cupo INT, examen INT, estado INT, lunes INT,martes INT,miercoles INT,jueves INT, viernes INT, sabado INT,domingo INT) RETURNS int
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
END
$$

DELIMITER $$
DROP FUNCTION IF EXISTS `InsertarCita`$$
CREATE FUNCTION `InsertarCita`(pfecha datetime,phorai datetime,phoraf datetime,pcupo INT,pestado INT, pexamen INT ) RETURNS int(11)
    DETERMINISTIC
BEGIN

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

    RETURN 1;
END
$$

DELIMITER $$
DROP FUNCTION IF EXISTS `asignar_cita`$$
CREATE FUNCTION asignar_cita(pidcita int,pidpaciente int, boleta varchar(30)) RETURNS int
    DETERMINISTIC
BEGIN
   DECLARE vcupo int DEFAULT 0;
   DECLARE vidcita int DEFAULT 0;
   
   select (c.cupo-
   (
    select count(*) from cita_paciente pc where pc.idcita=pidcita
    and (pc.estado=1 or pc.estado=3)
    )) as cupo_d into vcupo
    from cita c
    where c.idcita=pidcita;
    if vcupo>0 then
        
        select idcita into vidcita from cita_paciente where idcita=pidcita and idpaciente=pidpaciente;
        
        
        if vidcita<=0 then
                INSERT INTO cita_paciente
                      (idcita, 
                      idpaciente, 
                      estado,recibo_pago) 
                    VALUES 
                      (pidcita, 
                      pidpaciente, 
                      1, boleta);
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
END
$$
DELIMITER $$
DROP FUNCTION IF EXISTS `estado_cita_paciente`$$
CREATE FUNCTION estado_cita_paciente(pidcita int,pidpaciente int) RETURNS int
    DETERMINISTIC
BEGIN
   DECLARE vestado int DEFAULT -1;
   DECLARE vcupo int DEFAULT 0;
   select ifnull(estado,-1) into vestado from cita_paciente where idcita=pidcita and idpaciente = pidpaciente;
   
    if vestado = -1 then
        return 0;
    end if;
    if vestado = 0 then
        update cita_paciente set estado = 2 where idcita=pidcita and idpaciente=pidpaciente;
        return 1;
    end if;
    if vestado = 2 then
            
            
                        select (c.cupo-( select count(*) from cita_paciente pc where pc.idcita=pidcita
                        and pc.estado=1
                        )) as cupo_d into vcupo
                        from cita c
                        where c.idcita=pidcita;    
                if vcupo>0 then
                        update cita_paciente set estado = 1 where idcita=pidcita and idpaciente=pidpaciente;
                        return 1;
                else
                        update cita_paciente set estado = 3 where idcita=pidcita and idpaciente=pidpaciente;
                        return 0;
                end if;
    end if;
    if vestado = 1 then
        update cita_paciente set estado = 3 where idcita=pidcita and idpaciente=pidpaciente;
        return 1;
    end if;
    if vestado = 3 then
        update cita_paciente set estado = 0 where idcita=pidcita and idpaciente=pidpaciente;
        return 1;
    end if;
END
$$