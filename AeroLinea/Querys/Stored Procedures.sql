	
    USE DBAEROLINEA
    
    SELECT * FROM TblCompañias
    
    INSERT INTO TblCompañias(Nombre,Direccion, Correo, Telefono)
    
    
    DELIMITER $$
    CREATE PROCEDURE UpSCompañias(
		IN PIdCompañia INT 
        ,OUT PNombre VARCHAR(40))
    BEGIN
		SELECT IdCompañia, Nombre, Direccion, Correo, Telefono
        FROM TblCompañias
        WHERE IdCompañia = IFNULL(PIdCompañia,IdCompañia)
        AND Nombre = IFNULL(PNombre,Nombre);
    END 
    $$
    
	CALL UpSCompañias(NULL,NULL);
    
    
    