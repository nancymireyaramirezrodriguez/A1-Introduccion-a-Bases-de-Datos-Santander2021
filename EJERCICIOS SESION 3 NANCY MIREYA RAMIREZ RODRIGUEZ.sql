-- --------------------------Sesión 3: Joins y Vistas -------------------------
USE tienda;
SHOW KEYS FROM venta;
SELECT * FROM empleado AS e JOIN puesto AS p   ON e.id_puesto = p.id_puesto;
SELECT * FROM puesto AS p LEFT JOIN empleado e ON p.id_puesto = e.id_puesto;
################################### RETO 1 ####################################
-- ¿Cuál es el nombre de los empleados que realizaron cada venta?
SELECT Distinct(concat(nombre, ' ',apellido_paterno,' ',apellido_materno)) as Nombre FROM empleado e INNER JOIN venta v on e.id_empleado=v.id_empleado order by 1;

-- ¿Cuál es el nombre de los artículos que se han vendido?
SELECT distinct(nombre) as NOmbre FROM articulo a INNER JOIN venta v on a.id_articulo=v.id_articulo order by 1;

-- ¿Cuál es el total de cada venta?
select v.id_venta,sum((precio*cantidad)+iva) as TotalVenta from articulo a inner join venta v on v.id_articulo=a.id_articulo group by v.id_venta;

#################################################################################
-- 2223582-368
CREATE VIEW tickets_368 AS
(
SELECT v.clave, v.fecha, a.nombre producto, a.precio, concat(e.nombre, ' ', e.apellido_paterno) empleado 
FROM venta v
JOIN empleado e
  ON v.id_empleado = e.id_empleado
JOIN articulo a
  ON v.id_articulo = a.id_articulo);
  
  SELECT * FROM tickets_368;
  
  SELECT clave, round(sum(precio),2) total FROM tickets_368 GROUP BY clave;	

################################################# RETO 2 ####################################################
-- Usando la base de datos tienda, define las siguientes vistas que permitan obtener la siguiente información.
-- AÑADE A TODOS LOS NOMBRES DE TUS VISTAS EL SUFIJO _<tu identificador>. Por ejemplo mi_vista_hermosa_123.
-- ------------------------------------------------------------------------------------------------------------------
-- Obtener el puesto de un empleado.
 CREATE VIEW vwPuestoEmpleado_368 as
 (
SELECT e.id_empleado,concat(e.nombre, ' ',e.apellido_paterno,' ',e.apellido_materno) AS nombreEmpleado, p.nombre 
FROM empleado e INNER JOIN puesto p on p.id_puesto=e.id_puesto
 );
 
 select nombre from vwPuestoEmpleado_368 where id_empleado=3;
 -- --------------------------------------------------------------------------------------------------------------------
-- Saber qué artículos ha vendido cada empleado.
CREATE VIEW vwArticuloXempleado_368 as
 (
SELECT concat(e.nombre, ' ',e.apellido_paterno,' ',e.apellido_materno) AS nombreEmpleado,a.nombre as Articulo
FROM articulo a INNER JOIN venta v on a.id_articulo=v.id_articulo INNER JOIN empleado e on e.id_empleado=v.id_empleado order by 1
);

SELECT * FROM vwArticuloXempleado_368;
-- -------------------------------------------------------------------------------------------------------------------------------
-- Saber qué puesto ha tenido más ventas.
CREATE VIEW vwPuestosConVentas_368 as
 (SELECT p.nombre as Puesto, sum((a.precio*a.cantidad)+a.iva) as TotalVenta 
FROM puesto p 
INNER JOIN empleado e on e.id_puesto=p.id_puesto 
INNER JOIN venta v on v.id_empleado=e.id_empleado 
INNER JOIN articulo a on a.id_articulo = v.id_articulo
GROUP BY p.nombre
order by 2);

SELECT Puesto FROM vwPuestosConVentas_368 ORDER BY TotalVenta DESC LIMIT 1;

-- --------------------------------------------------------------------------------------------------------------
-- Ejercicios Sesión 3
-- Todos los ejercicios debes hacerlos usando la base classicmodels.
-- Todas las consultas que realices deberás mantenerlas dentro del editor de textos de MySQL Workbench. Al finalizar, guarda este archivo, llendo al menú File > Save script. Recuerda añadir a todos los nombres te tus vistas el sufijo con tu identificador.

-- Para estas consultas usa INNER JOIN
-- Obtén la cantidad de productos de cada orden.
USE classicmodels;
select  o.orderNumber,count(productCode) as cantidadProductos from orders o inner join orderdetails od on od.orderNumber=o.orderNumber group by o.orderNUmber;

-- Obtén el número de orden, estado y costo total de cada orden.
select  o.orderNumber,o.status,sum(od.quantityOrdered*od.priceEach) as costoTotal from orders o inner join orderdetails od on od.orderNumber=o.orderNumber group by o.orderNUmber,o.status;

-- Obtén el número de orden, fecha de orden, línea de orden, nombre del producto, cantidad ordenada y precio de cada pieza.
select o.orderNumber,o.orderDate,p.productLine,p.productname,od.quantityOrdered,od.priceEach 
from orders o inner join orderdetails od on od.orderNumber=o.orderNumber
inner join products p on p.productCode=od.productCode;

-- Obtén el número de orden, nombre del producto, el precio sugerido de fábrica (msrp) y precio de cada pieza.
select od.orderNumber,p.productname,p.msrp,od.priceEach from products p inner join orderdetails od;



-- Para estas consultas usa LEFT JOIN
-- Obtén el número de cliente, nombre de cliente, número de orden y estado de cada orden hecha por cada cliente. ¿De qué nos sirve hacer LEFT JOIN en lugar de JOIN?
select c.customerNumber,concat(c.customerName,' ', c.contactlastname) as Nombre,o.orderNumber, o.status 
from customers c left Join orders o on c.customerNumber=o.customerNumber;
-- SIRVE PARA MOSTRAR TODOS LOS DATOS DE LOS CLIENTES Y VER QUIERES SI TIENEN COMPRAS Y QUIEN NO

-- Obtén los clientes que no tienen una orden asociada.
select c.customerNumber,concat(c.customerName,' ', c.contactlastname) as Nombre,o.orderNumber, o.status 
from customers c left Join orders o on c.customerNumber=o.customerNumber
WHERE o.orderNumber IS NULL;

-- Obtén el apellido de empleado, nombre de empleado, nombre de cliente, número de cheque y total, es decir, los clientes asociados a cada empleado.
select e.lastName, e.firstName, c.customerName, p.checkNumber,p.amount
from customers c
left join  employees e  on c.salesRepEmployeeNumber=e.employeeNumber
left join payments p on p.customerNumber=c.customerNumber;



-- Para estas consultas usa RIGHT JOIN
-- Repite los ejercicios 5 a 7 usando RIGHT JOIN. ¿Representan lo mismo? Explica las diferencias en un comentario. Para poner comentarios usa --.
-- Obtén el número de cliente, nombre de cliente, número de orden y estado de cada orden hecha por cada cliente. ¿De qué nos sirve hacer LEFT JOIN en lugar de JOIN?
select c.customerNumber,concat(c.customerName,' ', c.contactlastname) as Nombre,o.orderNumber, o.status 
from customers c RIGHT JOIN orders o on c.customerNumber=o.customerNumber;
-- HAY MESNOS REGISTROS QUE CON LEFT Y QUITO LOS NULOS

-- Obtén los clientes que no tienen una orden asociada.
select c.customerNumber,concat(c.customerName,' ', c.contactlastname) as Nombre,o.orderNumber, o.status 
from customers c RIGHT JOIN orders o on c.customerNumber=o.customerNumber
WHERE o.orderNumber IS NULL;
-- NO ME MOSTRO NADA Y CON LEFT SI AUNQUE CON NULOS

-- Obtén el apellido de empleado, nombre de empleado, nombre de cliente, número de cheque y total, es decir, los clientes asociados a cada empleado.
select e.lastName, e.firstName, c.customerName, p.checkNumber,p.amount
from customers c
RIGHT JOIN  employees e  on c.salesRepEmployeeNumber=e.employeeNumber
RIGHT JOIN payments p on p.customerNumber=c.customerNumber;
-- MOSTRO MENOS REGISTROS Y QUITO LOS NULOS



-- Escoge 3 consultas de los ejercicios anteriores, crea una vista y escribe una consulta para cada una.
use classicmodels;
CREATE VIEW vwOrdenes_368 as 
(
select  o.orderNumber,count(productCode) as cantidadProductos 
from orders o inner join orderdetails od on od.orderNumber=o.orderNumber
group by o.orderNUmber
);
select * from  vwOrdenes_368 order by 1 desc;


CREATE VIEW  vwClientesOrdernes_368 as
(
select c.customerNumber,concat(c.customerName,' ', c.contactlastname) as Nombre,o.orderNumber, o.status 
from customers c RIGHT JOIN orders o on c.customerNumber=o.customerNumber
WHERE o.orderNumber IS NULL);
select * from  vwClientesOrdernes_368 order by 4 desc;


CREATE VIEW  vwCantidadPrecio_368 as
(
select o.orderNumber,o.orderDate,p.productLine,p.productname,od.quantityOrdered,od.priceEach 
from orders o inner join orderdetails od on od.orderNumber=o.orderNumber
inner join products p on p.productCode=od.productCode
);
select * from vwCantidadPrecio_368 order by 2 desc;

