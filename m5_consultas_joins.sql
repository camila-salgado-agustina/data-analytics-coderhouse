USE Ventas_Tech_DB

-- ---------------------------------------------------------------------
-- Consulta 1 - Vista base del proyecto (INNER JOIN)
-- Una fila por venta con cliente, producto, categoría y ciudad.
-- Columnas para agrupar en Power BI: categoria, ciudad_cliente, fecha_venta.
-- Columnas para filtrar: cliente, producto, categoria, ciudad_cliente.
-- ---------------------------------------------------------------------
SELECT
    v.id_venta,
    v.fecha_venta,
    c.id_cliente,
    c.nombre                          AS cliente,
    c.ciudad                          AS ciudad_cliente,
    p.nombre_producto                 AS producto,
    cat.nombre_categoria              AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario    AS total_venta
FROM ventas AS v
INNER JOIN clientes   AS c   ON v.id_cliente   = c.id_cliente
INNER JOIN productos  AS p   ON v.id_producto  = p.id_producto
INNER JOIN categorias AS cat ON p.id_categoria = cat.id_categoria;
 
 
-- ---------------------------------------------------------------------
-- Consulta 2 - Clientes sin ventas (LEFT JOIN)
-- Se conservan todos los clientes; los que no tienen ventas quedan con las columnas de ventas en NULL y se aíslan con IS NULL.
-- ---------------------------------------------------------------------
SELECT
    c.nombre    AS cliente,
    c.email,
    c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;
 
 
-- ---------------------------------------------------------------------
-- Consulta 3 - Productos sin ventas (LEFT JOIN)
-- Se conservan todos los productos del catálogo; los que no tienen ventas quedan con id_venta en NULL y se aíslan con IS NULL.
-- La categoría también va con LEFT JOIN para no perder productos que pudieran no tener categoría asignada.
-- ---------------------------------------------------------------------
SELECT
    p.nombre_producto      AS producto,
    cat.nombre_categoria   AS categoria,
    p.precio
FROM productos AS p
LEFT JOIN categorias AS cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas     AS v   ON p.id_producto  = v.id_producto
WHERE v.id_venta IS NULL;
 
 
-- ---------------------------------------------------------------------
-- Consulta 4 - Consolidado por canal (UNION ALL)
-- La columna "canal" no se consulta, se crea: es un valor literal dentro de cada SELECT que identifica el origen de las ventas.
-- Criterio de separación: dos períodos de fecha_venta.
-- Los filtros (<= y >) no se superponen: cada venta cae en un solo SELECT. Ambos SELECT devuelven las mismas 3 columnas, en el mismo orden y con tipos compatibles. Se usa UNION ALL (y no UNION) para no eliminar filas repetidas: cada venta se cuenta una sola vez.
-- ---------------------------------------------------------------------
SELECT
    canal,
    SUM(total) AS total_canal
FROM (
    SELECT fecha_venta, cantidad * precio_unitario AS total, 'Periodo 1 (05/03 al 10/03)' AS canal
    FROM ventas
    WHERE fecha_venta <= '2024-03-10'
 
    UNION ALL
 
    SELECT fecha_venta, cantidad * precio_unitario AS total, 'Periodo 2 (11/03 al 15/03)' AS canal
    FROM ventas
    WHERE fecha_venta > '2024-03-10'
) AS consolidado
GROUP BY canal;