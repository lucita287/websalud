DELIMITER $$
DROP FUNCTION IF EXISTS `EliminarMenu`$$
CREATE FUNCTION EliminarMenu(pidmenu int ) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE done BOOLEAN DEFAULT FALSE;
    declare eliminar int;
    declare vidmultimedia int;
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
                    SELECT multimediaidmultimedia INTO vidmultimedia FROM contenido where idcontenido=vidcontenido;
                    DELETE FROM contenido WHERE idcontenido=vidcontenido ;
                    DELETE FROM Multimedia WHERE idmultimedia=vidmultimedia;
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