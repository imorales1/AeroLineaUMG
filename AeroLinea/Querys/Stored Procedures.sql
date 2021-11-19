	
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
    
    DELIMITER $$
	CREATE PROCEDURE UpSCiudades(IN PPais INT, IN PNombre VARCHAR(50))
    BEGIN
		SELECT CONCAT(b.IdPais, "-", b.Nombre) Pais , CONCAT(a.IdPais, "-", a.Nombre) Ciudad, a.IdCiudad, a.IdPais
        FROM TblCiudades a
        INNER JOIN TblPaises b ON a.IdPais = b.IdPais
        WHERE b.IdPais = IFNULL(PPais, b.IdPais)
        AND a.Nombre LIKE CONCAT("%",IFNULL(PNombre, a.Nombre),"%");
    END	
    $$
    
    DELIMITER $$
    CREATE PROCEDURE UpIUCiudades(IN PNombre VARCHAR(50), IN PIdPais INT, IN PIdCiudad INT)
    BEGIN 
		IF NOT EXISTS(SELECT NULL
					  FROM TblCiudades
                      WHERE IdCiudad = PidCiudad
        )
        THEN
			INSERT INTO TblCiudades(Nombre, IdPais)
            VALUES(PNombre, PIdPais);
		ELSE
			UPDATE TblCiudades SET Nombre = PNombre, IdPais = PIdPais
            WHERE IdCiudad = PIdCiudad;
		END IF;
    END 
    $$
    
    CALL UpSCiudades(null,null);
    
    SELECT * FROM TblCiudades
    where idciudad = 0
    
    INSERT INTO TblCiudades(Nombre, IdPais)
    VALUES("Guatemala",1),("Ciudad de México", 2)
    
    DELIMITER $$
    CREATE PROCEDURE UpDCiudades(IN PIdCiudad INT)
    BEGIN
		DELETE FROM TblCiudades
        WHERE IdCiudad = PIdCiudad;
    END
    $$
    
    
    # COntrol de Clientes
    
    DELIMITER $$
    CREATE PROCEDURE UpSClientes(IN PCriterio VARCHAR(40))
    BEGIN
		SELECT Nombres, Apellidos, DPI, Direccion, IdCliente
        FROM TblClientes
        WHERE (Nombres LIKE CONCAT("%",IFNULL(PCriterio, Nombres), "%")
				OR Apellidos LIKE CONCAT("%",IFNULL(PCriterio, Nombres), "%")
                OR DPI LIKE CONCAT("%",IFNULL(PCriterio, Nombres), "%")
                OR Direccion LIKE CONCAT("%",IFNULL(PCriterio, Nombres), "%"));
    END
    $$
    
    CALL UpSClientes(NULL)
    
    INSERT INTO TblClientes(Nombres, Apellidos, DPI, Direccion)
    SELECT "Ismar Ernesto ALEJANDRO", "Morales", "318834344", "Escuintla, escuintla Guatemala"
    
    DELIMITER $$
    CREATE PROCEDURE UpIUClientes(IN PNombres VARCHAR(35), IN PApellidos VARCHAR(40)
						, IN PDPI VARCHAR(15), IN PDireccion VARCHAR(60), IN PIdCliente INT)
	BEGIN 
		IF NOT EXISTS(SELECT NULL
					  FROM TblClientes 
                      WHERE IdCliente = PIdCliente
					 )
		THEN
			INSERT INTO TblClientes(Nombres, Apellidos, DPI, Direccion)
            VALUES(PNombres, PApellidos, PDPI, PDireccion);
		ELSE
			UPDATE TblClientes SET Nombres = PNombres
								   ,Apellidos = PApellidos
                                   ,DPI = PDPI
                                   ,Direccion = PDireccion
			WHERE IdCliente = PIdCliente;
        END IF;
    END
    $$