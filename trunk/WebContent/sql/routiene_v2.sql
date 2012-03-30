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
                      
            DELETE FROM Menu WHERE idmenu=pidmenu;
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