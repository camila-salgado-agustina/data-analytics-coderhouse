-- Consulta 1 - Resumen ejecutivo mensual
SELECT
MONTH(fecha_venta) AS mes,
SUM(cantidad * precio_unitario) AS total_facturado,
COUNT(*) AS cantidad_de_pedidos,
AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- Consulta 2 — Ranking de productos 
SELECT TOP 5 
id_producto,
SUM(cantidad * precio_unitario) AS total_facturado,
SUM(cantidad) AS unidades_vendidas
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

-- Consulta 3 — Clientes recurrentes
SELECT
id_cliente,
SUM(cantidad * precio_unitario) AS total_facturado,
COUNT(cantidad) AS cantidad_pedidos
FROM ventas
GROUP BY id_cliente
HAVING COUNT(cantidad) > 1;

-- Consulta 4 — Meses por encima/por debajo del promedio
SELECT
MONTH(fecha_venta) AS mes,
SUM(cantidad * precio_unitario) AS total_facturado,
CASE
	WHEN SUM(cantidad * precio_unitario) >= AVG(SUM(cantidad * precio_unitario)) OVER ()
	THEN 'Por encima'
	ELSE 'Por debajo'
	END AS  comparacion_mensual_segun_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- Bloque de cierre: 1) El producto 1 es el que más facturación concentra, pero el producto 2 es el que más volúmen ha generado. 2) El Producto 1 genera el 55,8% de la facturación total ($3.600 de los $6.444 totales) con tan solo 3 unidades vendidas. 3) Los Clientes 1 y 5 concentran el 73,5% de las ventas totales ($4.740 de $6.444).