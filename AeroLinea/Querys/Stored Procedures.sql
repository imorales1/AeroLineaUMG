	
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
    
    SELECT * FROM TblCompañias
    WHERE 
    
    DELIMITER $$
    CREATE PROCEDURE UpsCompañiasCombo()
    BEGIN
		SELECT 0 ID, "Ninguna" Descripcion
        UNION ALL
		SELECT IdCompañia ID, CONCAT(IdCompañia, "-", Nombre) Descripcion
        FROM TblCompañias;
    END
    $$
    
    #---Creacion de procedimientos Tabla Aviones
    
    CALL UpIuAeroNavesCompañias(4,24,2000,"PRUEBA", 1, 0);
    
    DELIMITER $$
    CREATE PROCEDURE UpIuAeroNavesCompañias(IN PTurbinas INT
											, IN PAsientos INT
                                            , IN PPeso DECIMAL(6,2)
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
								 ,Peso = PPeso, Modelo = PModelo, IdCompañia = PIdCompañia
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
    
    call UpSAeroNavesCompañias(null,null,null);
    
    DELIMITER $$
    CREATE PROCEDURE UpDAeroNaves(IN PIdAvion INT)
    BEGIN
		DELETE FROM TblAviones
        WHERE IdAvion = PIdAvion;
    END
    $$
    
    
    #------------ MAESTRO DE PAÍSES Y CIUDADES ------
    
    SELECT * FROM TblPaises;
    # INSERT INTO TblPaises(Nombre)
    VALUES("Guatemala"), ("Mexico"), ("El Salvador"), ("Estados Unidos")
    
    DELIMITER $$
		CREATE PROCEDURE UpSPaisesCombo()
        BEGIN
			SELECT 0 ID, "Ninguno" Descripcion
            UNION ALL
            SELECT IdPais ID, CONCAT(IdPais,"-",Nombre) Descripcion
            FROM TblPaises;
        END
    $$
    