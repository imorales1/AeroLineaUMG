	
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
    
    
    