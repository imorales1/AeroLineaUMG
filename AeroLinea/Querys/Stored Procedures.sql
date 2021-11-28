	
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
    
    DELIMITER $$
    CREATE PROCEDURE UpDClientes(IN PIdCliente INT)
    BEGIN 
		DELETE FROM TblClientes
        WHERE IdCliente = PIdCliente;
    END;
    $$
     
     
	## CONTROL DE ROLES DE USUARIO
    
    select * from TblSecRoles
    insert into TblSecRoles(Nombre, Iniciales, Descripcion)
    VALUES("Administrador", "ADM", "Usuario encargado de la administración del sistema, creación, modificación y eliminar usuarios")
    
     insert into TblSecRoles(Nombre, Iniciales, Descripcion)
    VALUES("Operador", "OPR", "Usuario encargado de llevar el control de viajes y de clientes")
    
    DELIMITER $$
    CREATE PROCEDURE UpSRolesCombo()
    BEGIN
		SELECT 0 ID, "Ninguno" Descripcion
        UNION ALL
		SELECT IdRol ID, CONCAT(IdRol,"-",Nombre) Descripcion
        FROM TblSecRoles;
    END
    $$
    call UpSRolesCombo();
    
    ### CONTROL DE USUARIOS
    
    DELIMITER $$
    CREATE PROCEDURE UpIuUsuarios(IN PNombres VARCHAR(35), IN PApellidos VARCHAR(40), IN PFoto longblob
								 , IN PUsuario VARCHAR(30), IN PContraseña VARCHAR(100), IN PIdRol INT, IN PIdUsuario INT)
    BEGIN
		IF NOT EXISTS(SELECT NULL
					  FROM TblSecUsuarios
                      WHERE IdUsuario = PIdUsuario)
		THEN
			INSERT INTO TblSecUsuarios(Nombres, Apellidos, Fotografia, Usuario, Contraseña, IdRol)
			VALUES(PNombres, PApellidos, PFoto, PUsuario, PContraseña, PIdRol);
		ELSE
			UPDATE TblSecUsuarios SET Nombres = PNombres, Apellidos = PApellidos, Fotografia = PFoto, Usuario = PUsuario
										, Contraseña = PContraseña, IdRol = PIdRol
			WHERE IdUsuario = PIdUsuario;
		END IF;
    END;
    $$
    
    drop procedure UpIuUsuarios
    SELECT * FROM TblSecUsuarios
    select * from TblSecRoles
    DELIMITER $$
    CREATE PROCEDURE UpsUsuarios(IN PCriterio VARCHAR(40), IN PId INT)
    BEGIN
		SELECT a.Usuario, a.Nombres, a.Apellidos, CONCAT(b.IdRol, "-", b.Nombre) Rol, a.IdUsuario
        FROM TblSecUsuarios a
        LEFT JOIN TblSecRoles b ON a.IdRol = b.IdRol
        WHERE (Nombres LIKE CONCAT("%", IFNULL(PCriterio, Nombres), "%")
			   OR Apellidos LIKE CONCAT("%", IFNULL(PCriterio, Apellidos), "%")
               OR Usuario LIKE CONCAT("%", IFNULL(PCriterio, Usuario), "%")
               )
        AND IdUsuario = IFNULL(PId, IdUsuario); 
    END
    $$
    
    call UpsUsuarios(null,null)
    
    DELIMITER $$
    CREATE PROCEDURE UpsUsuarioDatos(IN PId INT)
    BEGIN
		SELECT a.Usuario, a.Nombres, a.Apellidos, a.IdRol, a.Fotografia
        FROM TblSecUsuarios a
        WHERE IdUsuario = PId; 
    END
    $$
    
    select * from tblsecusuarios
    
    call UpsUsuarioDatos(1);
    
    DELIMITER $$
    CREATE PROCEDURE UpDUsuarios(IN PIdUsuario INT)
    BEGIN
		DELETE FROM TblSecUsuarios
        WHERE IdUsuario = PIdUsuario;
    END
    $$
    
    call UpDUsuarios(null)
    drop procedure UpDUsuarios
    
    ### Conctrol de vuelos
    
    select * from tblvuelos;
    select * from TblOrigenDestino
    SELECT * FROM TblAviones
    select * from tBLCIUDADES
    
    call UpIUVuelos("2021/11/28", 1, 1, 2, 6);
    
    DELIMITER $$
	CREATE PROCEDURE UpIUVuelos(IN PFecha DATETIME, IN PIdAvion INT, IN PCiudadOrigen INT, PCiudadDestino INT, IN PIdVuelo INT)
    BEGIN
		IF NOT EXISTS(SELECT NULL
					 FROM TblVuelos
                     WHERE IdVuelo = PIdVuelo
					  )
		THEN
			INSERT INTO TblVuelos(Fecha, IdAvion)
			VALUES(PFecha, PIdAvion);
            
            # OBTENDREMOS EL VUELO INSERTADO
            SET @NVuelo = (SELECT MAX(IdVuelo) FROM TblVuelos);
            
            # CREAREMOS EL REGISTRO DEL ORIGEN
            INSERT INTO TblOrigenDestino(IdCiudad, IdVuelo, Tipo)
            VALUES(PCiudadOrigen,@NVuelo, 1);
            
            #Registramos el Destino
            INSERT INTO TblOrigenDestino(IdCiudad, IdVuelo, Tipo)
            VALUES(PCiudadDestino,@NVuelo, 2);
		ELSE
			UPDATE TblVuelos SET Fecha = PFecha, IdAvion = PIdAvion
            WHERE IdVuelo = PIdVuelo;
            
            #Modificamos el origen
            UPDATE TblOrigenDestino SET IdCiudad = PCiudadOrigen
            WHERE IdVuelo = PIdVuelo 
            AND Tipo = 1;
            
            #Modificacion del destino
            UPDATE TblOrigenDestino SET IdCiudad = PCiudadDestino
            WHERE IdVuelo = PIdVuelo 
            AND Tipo = 2;
		END IF;
    END
    $$
    
    select * FROM TblOrigenDestino
    SELECT * FROM TblVuelos
    DELIMITER $$
	CREATE PROCEDURE UpSVuelos(IN PIdVuelo INT, IN PFecha DATETIME)
    BEGIN
		SELECT a.IdVuelo, f.IdAvion, d.IdCiudad IdOrigen, e.IdCiudad IdDestino, a.Fecha, d.Nombre Origen
				, e.Nombre Destino, f.Modelo, f.Pasajeros Boletos, g.Nombre Compañia
        FROM TblVuelos a
        INNER JOIN (SELECT a.IdCiudad Origen, a.IdVuelo
					FROM TblOrigenDestino a
                    WHERE a.Tipo = 1) b ON a.IdVuelo = b.IdVuelo
        INNER JOIN (SELECT a.IdCiudad Destino, a.IdVuelo
					FROM TblOrigenDestino a
                    WHERE a.Tipo = 2) c ON a.IdVuelo = c.IdVuelo
        INNER JOIN TblCiudades d ON b.Origen = d.IdCiudad
        INNER JOIN TblCiudades e ON c.Destino = e.IdCiudad 
        INNER JOIN TblAviones f ON a.IdAvion = f.IdAvion
        INNER JOIN TblCompañias g ON f.IdCompañia = g.IdCompañia
        WHERE a.IdVuelo = IFNULL(PIdVuelo, a.IdVuelo)
        AND a.Fecha = IFNULL(PFecha, a.Fecha);
    END
    $$
    
    call UpSVuelos(null,null)
    drop procedure UpSVuelos
    
    SELECT * FROM TblOrigenDestino
    drop procedure UpDVuelos
    
    DELIMITER $$
    CREATE PROCEDURE UpDVuelos(IN PIdVuelo INT)
    BEGIN
		DELETE FROM TblOrigenDestino
        WHERE IdVuelo = PIdVuelo;
        
		DELETE FROM TblVuelos
        WHERE IdVuelo = PIdVuelo;
    END
    $$
    
    DELIMITER $$
    CREATE PROCEDURE UpSVuelosCombo()
    BEGIN
		SELECT 0 ID, "Ninguno" Descripcion
        UNION ALL
		SELECT a.IdVuelo ID, CONCAT(a.IdVuelo," - ", CONCAT(d.Nombre," - ", e.Nombre) ) Descripcion
        FROM TblVuelos a
        INNER JOIN (SELECT a.IdCiudad Origen, a.IdVuelo
					FROM TblOrigenDestino a
                    WHERE a.Tipo = 1) b ON a.IdVuelo = b.IdVuelo
        INNER JOIN (SELECT a.IdCiudad Destino, a.IdVuelo
					FROM TblOrigenDestino a
                    WHERE a.Tipo = 2) c ON a.IdVuelo = c.IdVuelo
		INNER JOIN TblCiudades d ON b.Origen = d.IdCiudad
        INNER JOIN TblCiudades e ON c.Destino = e.IdCiudad;
    END
    $$
    
    drop procedure UpSVuelosCombo
    CALL UpSVuelosCombo()
    
    # PROCEDIMIENTOS COMBOS 
    
    DELIMITER $$
    CREATE PROCEDURE UpSAvionesCombo()
    BEGIN 
		SELECT 0 ID, "Ninguno" Descripcion
        UNION ALL
		SELECT IdAvion ID, CONCAT(IdAvion, "-", Modelo) Descripcion
        FROM TblAviones;
    END
    $$
    
    DELIMITER $$
    CREATE PROCEDURE UpSCiudadesCombo(IN PIdCiudad INT)
    BEGIN
		IF PIdCiudad <> 0
        THEN
			SELECT 0 ID, "Ninguna" Descripcion
			UNION ALL
			SELECT IdCiudad ID, CONCAT(IdCiudad, "-", Nombre) Descripcion
			FROM TblCiudades
			WHERE IdCiudad <> PIdCiudad;
        ELSE
			SELECT 0 ID, "Ninguna" Descripcion
			UNION ALL
			SELECT IdCiudad ID, CONCAT(IdCiudad, "-", Nombre) Descripcion
			FROM TblCiudades;
		END IF;
    END
    $$
    
    call UpSCiudadesCombo(null)
    
    DROP PROCEDURE UpSCiudadesCombo
    
    SELECT * FROM TblClientes
    
    ##  VENTA DE BOLETOS A CLIENTES
    
    DELIMITER $$
    CREATE PROCEDURE UpIUBoletos(IN PClase CHAR(2), IN PAsiento INT, IN PCosto Decimal(7,3), IN PIdVuelo INT, IN PIdCliente INT, IN PIdBoleto INT)
    BEGIN 
		IF NOT EXISTS(SELECT NULL
					  FROM TblBoletos
                      WHERE IdBoleto = PIdBoleto
		)
		THEN
			INSERT INTO TblBoletos(Clase, Asiento, Costo, IdVuelo, IdCliente)
			VALUES(PClase, PAsiento, PCosto, PIdVuelo, PIdCliente);
		ELSE
			UPDATE TblBoletos SET Clase = PClase, Asiento = PAsiento, Costo = PCosto
									,IdVuelo = PIcVuelo
			WHERE IdBoleto = PIdBoleto;
		END IF;
    END;
    $$
    
    CALL UpIUBoletos("A", 3, 2500, 6, 5,0)
    
    DROP PROCEDURE UpIUBoletos
    SELECT * FROM TblBoletos
    SELECT  * FROM TblClientes
    
    DELIMITER $$
    CREATE PROCEDURE UpSBoletos(IN PIdBoleto INT, IN PClase CHAR(2), IN PIdVuelo INT)
    BEGIN
		SELECT a.Fecha, h.IdBoleto, a.IdVuelo, CONCAT(h.IdBoleto, "-", d.Nombre, " - ", e.Nombre) Boleto
				, f.Modelo, g.Nombre Compañia, h.Asiento, CONCAT(i.IdCliente, "-", i.Nombres, ",", i.Apellidos) Cliente
                , h.Costo 
        FROM TblVuelos a
        INNER JOIN (SELECT a.IdCiudad Origen, a.IdVuelo
					FROM TblOrigenDestino a
                    WHERE a.Tipo = 1) b ON a.IdVuelo = b.IdVuelo
        INNER JOIN (SELECT a.IdCiudad Destino, a.IdVuelo
					FROM TblOrigenDestino a
                    WHERE a.Tipo = 2) c ON a.IdVuelo = c.IdVuelo
        INNER JOIN TblCiudades d ON b.Origen = d.IdCiudad
        INNER JOIN TblCiudades e ON c.Destino = e.IdCiudad 
        INNER JOIN TblAviones f ON a.IdAvion = f.IdAvion
        INNER JOIN TblCompañias g ON f.IdCompañia = g.IdCompañia
        INNER JOIN TblBoletos h ON a.IdVuelo = h.IdVuelo
        INNER JOIN TblClientes i ON h.IdCliente = i.IdCliente
        WHERE a.IdVuelo = IFNULL(PIdVuelo, a.IdVuelo)
        AND h.IdBoleto = IFNULL(PIdBoleto, h.IdBoleto)
        AND h.Clase = IFNULL(PClase, h.Clase);
    END
    $$
    
    CALL UpSBoletos(NULL, NULL, NULL)
    
    drop procedure UpSBoletos


