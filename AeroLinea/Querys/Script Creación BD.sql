	
    CREATE DATABASE DbAerolinea
    
    USE DbAerolinea
    
    CREATE TABLE TblPaises(
		IdPais INT AUTO_INCREMENT,
        Nombre VARCHAR(35),
        PRIMARY KEY(IdPais)
    )
    
    CREATE TABLE TblCiudades(
		IdCiudad INT AUTO_INCREMENT,
        Nombre VARCHAR(50),
        IdPais INT,
        PRIMARY KEY(IdCiudad),
        FOREIGN KEY(IdPais) REFERENCES TblPaises(IdPais)
    )
    
    CREATE TABLE TblCompañias(
		IdCompañia INT AUTO_INCREMENT,
        Nombre VARCHAR(40),
        Direccion VARCHAR(60),
        Correo VARCHAR(60),
        Telefono NUMERIC(16),
        PRIMARY KEY(IdCompañia)
    )
    
    CREATE TABLE TblAviones(
		IdAvion INT AUTO_INCREMENT,
        Turbinas INT,
        Pasajeros INT,
        Peso DECIMAL(4,2),
        Modelo VARCHAR(25),
        IdCompañia INT,
        PRIMARY KEY(IdAvion),
        FOREIGN KEY(IdCompañia) REFERENCES TblCompañias(IdCompañia)
    )
    
    CREATE TABLE TblVuelos(
		IdVuelo INT AUTO_INCREMENT,
        Fecha DATETIME,
        IdAvion INT,
        PRIMARY KEY(IdVuelo),
        FOREIGN KEY(IdAvion) REFERENCES TblAviones(IdAvion)
    )
    
    
    CREATE TABLE TblOrigenDestino(
		ID INT AUTO_INCREMENT,
        IdCiudad INT,
        IdVuelo INT,
        PRIMARY KEY(ID),
        FOREIGN KEY(IdCiudad) REFERENCES TblCiudades(IdCiudad),
		FOREIGN KEY(IdVuelo) REFERENCES TblVuelos(IdVuelo)
    )
    
    ALTER TABLE `dbaerolinea`.`tblorigendestino` 
ADD COLUMN `Tipo` TINYINT NULL AFTER `IdVuelo`;


    
    CREATE TABLE TblClientes(
		IdCliente INT AUTO_INCREMENT,
        Nombres VARCHAR(35),
        Apellidos VARCHAR(40),
        DPI NUMERIC(15),
        Direccion VARCHAR(75),
        PRIMARY KEY(IdCliente)
    )
    
    CREATE TABLE TblBoletos(
		IdBoleto INT AUTO_INCREMENT,
        Clase CHAR(2),
        Asiento INT,
        Costo DECIMAL(4,2),
        IdVuelo INT,
        IdCliente INT,
        PRIMARY KEY(IdBoleto),
        FOREIGN KEY(IdVuelo) REFERENCES TblVuelos(IdVuelo),
        FOREIGN KEY(IdCliente) REFERENCES TblClientes(IdCliente)
    )
    
    VALUES('AeroGuate', '3 Calle 4 avenida Zona 10 Edificio Norte', 'tuvuelo@aeroguate.com.gt', '78201456')
    
    
    CREATE TABLE TblSecRoles(
		IdRol INT AUTO_INCREMENT,
        Nombre VARCHAR(30),
        Iniciales CHAR(3),
        Descripcion VARCHAR(100),
		PRIMARY KEY(IdRol)
    )
    
    CREATE TABLE TblSecUsuarios(
		IdUsuario INT AUTO_INCREMENT,
        Nombres VARCHAR(35),
        Apellidos VARCHAR(35),
        Fotografia LONGBLOB,
        IdRol INT,
        PRIMARY KEY(IdUsuario),
        FOREIGN KEY(IdRol) REFERENCES TblSecRoles(IdRol)
    )
    
    ALTER TABLE `dbaerolinea`.`tblsecusuarios` 
	ADD COLUMN `Usuario` VARCHAR(30) NULL AFTER `Fotografia`,
	ADD COLUMN `Contraseña` INT NULL AFTER `Usuario`;
	
    ALTER TABLE `dbaerolinea`.`tblsecroles` 
CHANGE COLUMN `Descripcion` `Descripcion` VARCHAR(300) NULL DEFAULT NULL ;
    
    ALTER TABLE `dbaerolinea`.`tblboletos` 
CHANGE COLUMN `Costo` `Costo` DECIMAL(7,3) NULL DEFAULT NULL ;