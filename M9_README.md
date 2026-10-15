# RetailPro – Proyecto integrador de Data Analytics

Proyecto integrador del curso de Data Analytics (Coderhouse). RetailPro es una distribuidora de tecnología ficticia que opera en Argentina, con regiones Norte, Centro, Sur y Este. El objetivo es modelar sus datos comerciales, consultarlos con SQL para responder preguntas de negocio y, en etapas posteriores, construir un dashboard ejecutivo en Power BI.

> Todos los datos del repositorio son ficticios y de ejemplo.

## Dos bases de datos, dos propósitos

El repositorio trabaja con **dos bases distintas**; no hay que mezclarlas:

| Base de datos | Script que la crea | Qué es |
|---|---|---|
| `entrega_m3_retail_pro` | `entrega_m3_retail_pro.sql` | Modelo propio de RetailPro con 7 tablas (categorias, productos, territorios, canales, clientes, vendedores y ventas). Es la práctica del módulo 3. |
| `Ventas_Tech_DB` | `ventas_tech_db.sql` | Base de ejemplo de una tienda de tecnología con 4 tablas (categorias, clientes, productos y ventas). Es la base sobre la que trabajan las consultas de M4 y M5. |

## Contenido del repositorio

| Archivo | Base de datos | Descripción |
|---|---|---|
| `entrega_m3_retail_pro.sql` | `entrega_m3_retail_pro` | Crea las 7 tablas de RetailPro con sus claves y carga datos de ejemplo. |
| `ventas_tech_db.sql` | `Ventas_Tech_DB` | Crea la base, las 4 tablas y los datos de ejemplo. Termina con consultas `SELECT` de verificación. |
| `m4_consultas_negocio.sql` | `Ventas_Tech_DB` | Consultas de negocio sobre la tabla `ventas`: resumen mensual, ranking de productos, clientes recurrentes y comparación contra el promedio. |
| `m5_consultas_joins.sql` | `Ventas_Tech_DB` | Consultas con INNER JOIN, LEFT JOIN y UNION ALL sobre las 4 tablas. |

## Herramientas

- SQL Server 2016 o superior (los scripts usan `DROP TABLE IF EXISTS`)
- SQL Server Management Studio (SSMS)
- Power BI Desktop (etapas posteriores del proyecto)
- Git y GitHub

## Cómo ejecutar los scripts

Los scripts están escritos en **T-SQL (SQL Server)**: usan `TOP` y `MONTH()`, no `LIMIT` ni `EXTRACT`.

### Ventas_Tech_DB (M3, M4 y M5)

1. En SSMS abrí `ventas_tech_db.sql` (**Archivo → Abrir → Archivo**) y ejecutalo completo con **F5**. Crea la base, las tablas y los datos.
2. Abrí `m5_consultas_joins.sql` (empieza con `USE Ventas_Tech_DB`) y ejecutalo, o seleccioná una consulta y ejecutala con **F5**.
3. `m4_consultas_negocio.sql` **no incluye `USE`**: antes de ejecutarlo, elegí `Ventas_Tech_DB` en el selector de bases de datos de SSMS.
4. Para volver a cargar los datos: la base ya existe y `CREATE DATABASE` devuelve el error "la base de datos ya existe". Para evitarlo, seleccioná desde la línea `USE Ventas_Tech_DB;` hasta el final del script y ejecutá solo la selección con **F5**. Las tablas se eliminan y se recrean.

### entrega_m3_retail_pro

1. Seleccioná solo la línea `CREATE DATABASE entrega_m3_retail_pro` y ejecutala con **F5**.
2. Elegí `entrega_m3_retail_pro` en el selector de bases de datos. El script no incluye `USE`: si no lo hacés, las tablas se crean en la base activa (normalmente `master`).
3. Ejecutá el resto del script. No elimina tablas previas: para repetirlo, borrá la base (`DROP DATABASE entrega_m3_retail_pro;`, ejecutado desde `master`) y empezá de nuevo.

## Mejoras previstas

- Control de existencia ("si existe, eliminar") al crear las bases, para poder re-ejecutar los scripts sin pasos manuales.
- Organizar los scripts en carpetas por módulo.
- Agregar datos de ejemplo para que las consultas de clientes y productos sin ventas devuelvan filas.
- Dashboard ejecutivo de RetailPro en Power BI.

## Autora

Camila Salgado · [GitHub](https://github.com/camila-salgado-agustina)
