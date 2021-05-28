/* Listar las base de datos de nuestra instancia SQL Server */
SELECT 
    database_id,
    name,    
    create_date
FROM
    sys.databases
GO

/* Crear la base de datos Biblioteca */
CREATE DATABASE Biblioteca
GO

/* Poner en uso la base de datos Biblioteca */
USE Biblioteca
GO

/* Crear la tabla Libros */
CREATE TABLE Libros
(
    CODLIB int NOT NULL,
    NOMLIB VARCHAR(60) NOT NULL, /* Se refiere al nombre o título del libro */
    EDITLIB VARCHAR(40) NOT NULL, /* Se refiere a la editorial del libro */
    AUTLIB VARCHAR(40) NOT NULL, /* Se refiere al autor del libro */
    GENLIB VARCHAR(40) NOT NULL, /* Se refiere al género del libro */
    NUMPAGLIB INT NOT NULL, /* Se refiere al número de páginas del libro */
    FECEDICLIB DATE NOT NULL, /* Se refiere a la fecha de edición del libro */
    CONSTRAINT CODLIB_PK PRIMARY KEY(CODLIB) /* Definiendo la clave principal */
)
GO

/* Listar tablas de la base de datos */
SELECT * FROM INFORMATION_SCHEMA.TABLES;
GO

/* Crear tabla USUARIOS (Lectores) */
CREATE TABLE USUARIOS
(
    CODUS INT NOT NULL,
    NOMUS VARCHAR(50) NOT NULL,
    APEUS VARCHAR(50) NOT NULL,
    DNI CHAR(8) NOT NULL,
    DIRUS VARCHAR(80) NOT NULL,
    DISTUS VARCHAR(60) NOT NULL,
    PROVUS VARCHAR(60) NOT NULL,
    FECNAC DATE NOT NULL
    CONSTRAINT CODUS_PK PRIMARY KEY(CODUS)
)
GO

/* Crear la tabla PRESTAMOS (TRANSACCIONAL) */
CREATE TABLE PRESTAMOS
(
    NUMPRES INT NOT NULL,
    CODLIB INT NOT NULL,
    CODUS INT NOT NULL,
    FECSALPRES DATE NOT NULL,
    FECDEVPRES DATE NOT NULL,
    CONSTRAINT NUMPRES_PK PRIMARY KEY (NUMPRES)
)
GO

/* Creando buenas relaciones entre tablas (PRESTAMOS - LIBROS, PRESTAMOS - USUARIOS) */
ALTER TABLE PRESTAMOS
    ADD CONSTRAINT LIBRO_PRESTAMOS_CODLIB FOREIGN KEY (CODLIB) REFERENCES LIBROS (CODLIB),
        CONSTRAINT USUARIO_PRESTAMOS_CODUS FOREIGN KEY (CODUS) REFERENCES USUARIOS (CODUS)
GO

/* Ver las relacionaes de la tabla Prestamo */
SELECT 
	fk.name [Constraint],
    OBJECT_NAME(fk.parent_object_id) [Tabla],
    COL_NAME(fc.parent_object_id,fc.parent_column_id) [Columna],
    OBJECT_NAME (fk.referenced_object_id) AS [Tabla base],
    COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS [Columna de tabla base (PK)]
FROM 
	sys.foreign_keys fk
	INNER JOIN sys.foreign_key_columns fc ON (fk.OBJECT_ID = fc.constraint_object_id)
WHERE
	(OBJECT_NAME(fk.parent_object_id) = 'Prestamos')
GO

/* Ver estructura de una tabla */
SELECT 
    column_name, 
    data_type 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'LIBROS'
GO

/* Ingresar el primer registro en la tabla Libros */
INSERT INTO Libros
(CODLIB, NOMLIB, EDITLIB, AUTLIB, GENLIB, NUMPAGLIB, FECEDICLIB)
VALUES
('1', 'Don Quijote de la Mancha I', 'Anaya', 'Miguel de Cervantes Saavedra', 'Caballeresco', '520', '05/25/1950')
GO

/* Cómo saber que formato o idioma está instalado el motor de base de datos */
SELECT @@LANGUAGE AS 'Formato de IDIOMA del servidor'
GO

/* Ver formatos de fecha de acuerdo al idioma del motor de base de datos */
SP_HELPLANGUAGE
GO

/* Listar registros de la tabla LIBROS */
SELECT * FROM Libros
GO

/* Configurando el ingreso formato de fecha: día/mes/año */
SET DATEFORMAT dmy 
GO

/* Ingresar el primer registro en la tabla Libros */
INSERT INTO Libros
(CODLIB, NOMLIB, EDITLIB, AUTLIB, GENLIB, NUMPAGLIB, FECEDICLIB)
VALUES
('2', 'Don Quijote de la Mancha II', 'Anaya', 'Miguel de Cervantes Saavedra', 'Caballeresco', '520', '20/01/1980')
GO

/* Configurar para que liste las fechas en el formato: dd/mm/yyyy*/
SELECT
    NOMLIB AS 'Nombre',
    GENLIB AS 'Género',
    FORMAT(FECEDICLIB, 'd', 'es_ES') AS 'Fecha de edición'
FROM
    Libros
GO

/* Configurar para que liste las fechas en el formato de texto completo: Martes, 25 de mayo de 2025*/
SELECT
    NOMLIB AS 'Nombre',
    GENLIB AS 'Género',
    FORMAT(FECEDICLIB, 'D', 'es_ES') AS 'Fecha de edición'
FROM
    Libros
GO

/* Ingresar el tercer registro en la tabla Libros */
INSERT INTO Libros
(CODLIB, NOMLIB, EDITLIB, AUTLIB, GENLIB, NUMPAGLIB, FECEDICLIB)
VALUES
('3', 'Historia de Gokú', 'Animes forever', 'Akira Toriyama', 'Anime', '1200', '06/JUNE/1976')
GO

/* Listar registros de la tabla Libros*/
SELECT * FROM Libros
GO

/* Ingresar más registros en la tabla Libros */
INSERT INTO Libros
(CODLIB, NOMLIB, EDITLIB, AUTLIB, GENLIB, NUMPAGLIB, FECEDICLIB)
VALUES
('4', 'El Principito', 'Andina', 'Antonie Saint', 'Aventura', '120', '09/APRIL/1996'),
('5', 'El Príncipe', 'S.M', 'Maquiavelo', 'Político', '210', '12/AUGUST/1995'),
('6', 'Diplomacia', 'S.M', 'Henry Kissinger', 'Político', '825', '10/JUNE/1975')
GO

/* Ver estructura de una tabla usuarios*/
SELECT 
    column_name, 
    data_type 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'USUARIOS'
GO

/* Insertar registros en la tabla USUARIOS */
Insert into Usuarios
(CodUs, NomUs, ApeUs, DNI, DIRUS, DISTUS, PROVUS, FECNAC)
Values
('1', 'Inés', 'Posadas Gil','25786321', 'Av. Las Escaleritas 125', 'Nuevo Imperial', 'Cañete', '04/JULY/1971'),
('2', 'José', 'Sánchez Pons','40155263', 'Meza y López 51', 'Lunahuaná', 'Cañete', '06/SEPTEMBER/1966'),
('3', 'Miguel', 'Gómez Sáenz','15478952', 'Gran Vía 71', 'Imperial', 'Cañete','09/DECEMBER/1976'),
('4', 'Eva', 'Santana Páez','01563289', 'Pío Baroja 23', 'San Vicente', 'Cañete', '23/MAY/1980'),
('5', 'Yolanda', 'Betancor Díaz','45896325', 'El Cid 45', 'San Luis', 'Cañete','17/SEPTEMBER/1976')
GO

/* Listar registros de la tabla USUARIOS*/
SELECT * FROM USUARIOS
GO