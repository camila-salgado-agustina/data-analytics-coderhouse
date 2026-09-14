CREATE DATABASE entrega_m3_retail_pro

CREATE TABLE categorias (
id_categoria INT PRIMARY KEY,
nombre_categoria VARCHAR(100) NOT NULL
);

INSERT INTO categorias (id_categoria, nombre_categoria)
VALUES
(1, 'Computadoras'),
(2, 'Periféricos'),
(3, 'Audio'),
(4, 'Monitores'),
(5, 'Componentes');

CREATE TABLE territorios (
id_territorio INT PRIMARY KEY,
region VARCHAR(100) NOT NULL,
pais VARCHAR(100) NOT NULL,
zona VARCHAR(100) NOT NULL
);

INSERT INTO territorios (id_territorio, region, pais, zona)
VALUES
(1, 'Norte', 'Argentina', 'Salta'),
(2, 'Centro', 'Argentina', 'Córdoba'),
(3, 'Sur', 'Argentina', 'Río Negro'),
(4, 'Este', 'Argentina', 'Buenos Aires');

CREATE TABLE canales (
id_canal INT PRIMARY KEY,
nombre_canal VARCHAR(100) NOT NULL
);

INSERT INTO canales (id_canal, nombre_canal)
VALUES
(1, 'Tienda Online'),
(2, 'Locales'),
(3, 'Mercado Libre');


CREATE TABLE productos (
id_producto INT PRIMARY KEY,
nombre_producto VARCHAR(100) NOT NULL,
id_categoria INT,
FOREIGN KEY(id_categoria) REFERENCES categorias(id_categoria),
subcategoria VARCHAR(100) NOT NULL,
precio DECIMAL(10,2) NOT NULL,
costo DECIMAL(10,2) NOT NULL
);

INSERT INTO productos (id_producto, nombre_producto, id_categoria, subcategoria, precio, costo)
VALUES
(1, 'Notebook Core i5 8GB', 1, 'Notebooks', 650.00, 480.00),
(2, 'Notebook Core i7 16GB', 1, 'Notebooks', 980.00, 720.00),
(3, 'Mouse Inalámbrico', 2, 'Mouse', 25.00, 12.00),
(4, 'Teclado Mecánico RGB', 2, 'Teclado', 65.00, 38.00),
(5, 'Auriculares Bluetooth', 3, 'Auriculares', 45.00, 22.00),
(6, 'Monitor 24" Full HD', 4, 'Monitor LED', 180.00, 120.00),
(7, 'SSD 480GB', 5, 'Almacenamiento', 55.00, 32.00),
(8, 'Memoria RAM 8GB DDR4', 5, 'Memoria', 40.00, 24.00);

CREATE TABLE clientes (
id_cliente INT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL,
ciudad VARCHAR(100) NOT NULL,
segmento VARCHAR(100) NOT NULL,
fecha_registro DATE NOT NULL,
id_territorio INT,
FOREIGN KEY(id_territorio) REFERENCES territorios(id_territorio)
);

INSERT INTO clientes (id_cliente, nombre, email, ciudad, segmento, fecha_registro, id_territorio)
VALUES
(1, 'María López', 'maria.lopez@mail.com', 'Salta', 'Corporativo', '2024-02-10', 1),
(2, 'Carlos Ruiz', 'carlos.ruiz@mail.com', 'Córdoba', 'PyME', '2024-01-15', 2),
(3, 'Ana Gómez', 'ana.gomez@mail.com', 'Bariloche', 'Individual', '2024-03-05', 3),
(4, 'Pedro Sanz', 'pedro.sanz@mail.com', 'Buenos Aires', 'Corporativo', '2023-11-20', 4),
(5, 'Laura Torres', 'laura.torres@mail.com', 'Salta', 'PyME', '2024-04-01', 1);

CREATE TABLE vendedores (
id_vendedor INT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
id_territorio INT,
FOREIGN KEY(id_territorio) REFERENCES territorios(id_territorio)
);

INSERT INTO vendedores (id_vendedor, nombre, id_territorio)
VALUES
(1, 'Diego Martínez', 1),
(2, 'Sofía Álvarez', 2),
(3, 'Nicolás Herrera', 4);

CREATE TABLE ventas (
id_ventas INT PRIMARY KEY,
fecha_venta DATE NOT NULL,
cantidad INT NOT NULL,
total_venta DECIMAL (10,2) NOT NULL,
id_cliente INT,
FOREIGN KEY(id_cliente) REFERENCES clientes(id_cliente),
id_producto INT,
FOREIGN KEY(id_producto) REFERENCES productos(id_producto),
id_vendedor INT,
FOREIGN KEY(id_vendedor) REFERENCES vendedores(id_vendedor),
id_territorio INT,
FOREIGN KEY(id_territorio) REFERENCES territorios(id_territorio),
id_canal INT,
FOREIGN KEY(id_canal) REFERENCES canales(id_canal)
);

INSERT INTO ventas (id_ventas, fecha_venta, id_cliente, id_producto, id_vendedor, id_territorio, id_canal, cantidad, total_venta)
VALUES
(1,  '2026-02-15', 1, 1, 1, 1, 1, 1, 650.00),
(2,  '2026-02-20', 2, 3, 2, 2, 2, 3, 75.00),
(3,  '2026-03-01', 3, 6, 3, 3, 1, 1, 180.00),
(4,  '2026-03-10', 4, 2, 1, 4, 3, 1, 980.00),
(5,  '2026-03-15', 5, 4, 1, 1, 2, 2, 130.00),
(6,  '2026-04-02', 1, 5, 1, 1, 1, 2, 90.00),
(7,  '2026-04-18', 2, 7, 2, 2, 3, 3, 165.00),
(8,  '2026-05-05', 3, 8, 3, 3, 2, 4, 160.00),
(9,  '2026-05-22', 4, 3, 1, 4, 1, 5, 125.00),
(10, '2026-06-10', 5, 6, 1, 1, 2, 1, 180.00),
(11, '2026-07-01', 1, 2, 1, 1, 3, 1, 980.00),
(12, '2026-07-15', 3, 4, 3, 3, 1, 2, 130.00);