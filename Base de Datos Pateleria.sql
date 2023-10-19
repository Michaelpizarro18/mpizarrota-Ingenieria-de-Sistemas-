--//Nuevo
create database P_Sales_System

use P_Sales_System
go
-------------------------


CREATE TABLE Categoria(
	idCategoria int identity(100,1) primary key,
	catnombre varchar(100)
);
GO

CREATE TABLE Proveedor(
	idProveedor int identity(1000,5) primary key,
	pronombre varchar(100),
	direccion varchar(255)
);
GO

CREATE TABLE Producto(
	idProducto int identity (418,6) primary key, 
	nombre varchar(100),
	precio float,
	categoria int foreign key references Categoria(idCategoria),
	proveedor int foreign key references Proveedor(idProveedor)
);
GO

CREATE TABLE Venta(
	idVenta int identity(1,1) primary key,
	fecha date,
	total float
);
GO

CREATE TABLE DetalleVenta(
	idDetalleVenta int identity(1,1) primary key,
	idVenta int,
	r_producto varchar(100),
	cantidad int,
	descuento float,
	subtotal float,
	impuesto float,
	total float,
	foreign key (idVenta) REFERENCES Venta(idVenta)
);
GO

CREATE TABLE Factura(
	idFactura int identity (1,1) primary key,
	fecha datetime,
	total float,
	venta int foreign key references Venta(idVenta)
);
GO

-----------------------------------
--CATEGORÍAS
INSERT INTO Categoria (catnombre) VALUES
('Pasteles'),
('Galletas'),
('Flanes'),
('Gelatinas');
go

--PROVEEDORES
INSERT INTO Proveedor (pronombre, direccion) VALUES
('Mercado de Ingeniería', 'Av. Luna Pizarro 277, San Martín de Porres 15103'),
('Mercado Milagros','Ca. Sta. Mercedes 184, San Martín de Porres 15103')
go

--PRODUCTOS
INSERT INTO Producto (nombre,precio,categoria,proveedor) VALUES
('Keke de Chocolate', 20.0, 100, 1005),
('Pastel 3 Leches', 22.0, 100, 1000),
('Pie de Manzana', 18.0, 100, 1000),
('Pastel de Queso', 25.0, 100, 1000),
('Pastel de Selva Negra', 45.0, 100, 1005),
('Pastel de Moka', 50.0, 100, 1005),

('Rosquita', 0.20, 101, 1005),
('Alfajores', 0.30, 101, 1000),
('Empanadas Dulces', 1.0, 101, 1000),
('Empanadas Dulces con relleno', 0.40, 101, 1000),
('Galletas de Chocolate', 0.40, 101, 1005),
('Milhojas', 1.50, 101, 1000),

('Flan Clasico', 1.50, 102, 1005),
('Flan de Coco', 2.0, 102, 1005),
('Flan de Maracuya', 2.0, 102, 1005),
('Flan de Chocolate', 2.0, 102, 1005),
('Flan con Gelatina', 2.0, 102, 1005),
('Flan Napolitano', 2.0, 102, 1005),

('Gelatina de Mosaico', 2.50, 103, 1005),
('Gelatina con Leche', 1.50, 103, 1000),
('Torta Helada', 50.0, 103, 1005)
Go

--------------------------------

CREATE PROCEDURE SP_E_DETALLEVENTA 
	@idVenta int,
	@r_producto varchar(100),
	@cantidad int,
	@descuento float,
	@subtotal float,
	@impuesto float,
	@total float
AS
BEGIN	
	INSERT INTO DetalleVenta (idVenta, r_producto, cantidad, descuento, subtotal, impuesto, total)
					  VALUES (@idVenta, @r_producto, @cantidad, @descuento, @subtotal, @impuesto, @total)
END;


CREATE PROCEDURE SP_E_VENTA
	@total float
AS
BEGIN
	INSERT INTO Venta (fecha, total)	
			   VALUES (GETDATE(), @total)
END;


CREATE PROCEDURE SP_E_FACTURA
	@total float,
	@venta int
AS
BEGIN
	INSERT INTO Factura (fecha, total, venta)
				 VALUES (GETDATE(), @total, @venta)
END;

