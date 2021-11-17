	
    USE DBAEROLINEA
    
    SELECT * FROM TblCompañias
    
    INSERT INTO TblCompañias(Nombre,Direccion, Correo, Telefono)
    
   DELIMITER $$
    CREATE PROCEDURE UpSCompañias(
		IN PIdCompañia INT 
        ,IN PNombre VARCHAR(40))
    BEGIN
		SELECT IdCompañia, Nombre, Direccion, Correo, Telefono
        FROM TblCompañias
        WHERE IdCompañia = IFNULL(PIdCompañia,IdCompañia)
        AND Nombre = IFNULL(PNombre,Nombre);
    END 
    $$
    
    
	DELIMITER $$
    CREATE PROCEDURE UpIuCompañias(
		IN PNombre varchar(40)
        , IN PDireccion VARCHAR(60)
        , IN PCorreo VARCHAR(60)
        , IN PTelefono BIGINT
        , IN PIdCompañia INT
	)
    BEGIN
		IF NOT EXISTS(SELECT null
						FROM TblCompañias
                        WHERE IdCompañia = PIdCompañia
		)
        THEN
			INSERT INTO TblCompañias(Nombre, Direccion, Correo, Telefono)
            VALUES(PNombre, PDireccion, PCorreo, PTelefono);
        ELSE
			UPDATE TblCompañias SET Nombre = PNombre, Direccion = PDireccion
								, Correo = PDireccion, Telefono = PTelefono
			WHERE IdCOmpañia = PIdCompañia;
		END IF;
    END
    $$
    
    DELIMITER $$
    CREATE PROCEDURE UpEliminarCompañias(IN PIdCompañia INT)
    BEGIN
		DELETE FROM TblCompañias
        WHERE IdCompañia = PIdCompañia;
    END
    $$
    


    #---Creacion de procedimientos Tabla Aviones
    
    DELIMITER $$
    CREATE PROCEDURE UpIuAeroNavesCompañias(IN PTurbinas INT
											, IN PAsientos INT
                                            , IN PPeso DECIMAL(4,2)
                                            , IN PModelo VARCHAR(25)
                                            , IN PIdCompañia INT
                                            , IN PIdAvion INT)
	BEGIN 
		IF NOT EXISTS(SELECT NULL
					  FROM TblAviones 
                      WHERE IdAvion = PIdAvion
        )
        THEN
			INSERT INTO TblAviones(Turbinas, Pasajeros, Peso, Modelo, IdCompañia)
            VALUES(PTurbinas, PAsientos, PPeso, PModelo, PIdCompañia);
		ELSE
			UPDATE TblAviones SET Turbinas = PTurbinas, Pasajeros = PAsientos
								 ,Peso = PPeso, Modelo = PModelo, PIdCompañia = IdCompañia
			WHERE IdAvion = PIdAvion;
        END IF;
    END
    $$
    
      DELIMITER $$
	CREATE PROCEDURE UpSAeroNavesCompañias(IN PIdCompañia INT, IN PTurbinas INT, IN PModelo VARCHAR(25))
    BEGIN
		SELECT CONCAT(b.IdCompañia, "-", b.Nombre) AS Compañia, a.IdAvion, a.Turbinas, a.Pasajeros, a.Peso, a.Modelo,  a.IdCompañia
        FROM TblAviones a
        INNER JOIN TblCompañias b ON a.IdCompañia = b.IdCompañia
        WHERE b.IdCompañia = IFNULL(PIdCompañia, b.IdCompañia) 
        AND a.Turbinas = IFNULL(PTurbinas, a.Turbinas)
        AND a.Modelo = IFNULL(PModelo, a.Modelo);
    END
    $$

