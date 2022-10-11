-- Ejemplos Sesion 02 LIKE
use tienda;
SELECT * FROM empleado WHERE nombre LIKE 'M%';
SELECT * FROM empleado WHERE nombre LIKE '%a';
SELECT * FROM empleado WHERE nombre LIKE 'M%a';
SELECT * FROM empleado WHERE nombre LIKE 'M_losa';

################ RETO 1 SESION 02 #################################
-- ¿Qué artículos incluyen la palabra Pasta en su nombre?
select * from articulo where nombre like '%Pasta%';
-- ¿Qué artículos incluyen la palabra Cannelloni en su nombre?
select * from articulo where nombre like '%Cannelloni%';
-- ¿Qué nombres están separados por un guión (-) por ejemplo Puree - Kiwi?
select nombre from articulo where nombre like '%-%';
################ FIN RETO 1 SESION 02 #############################

-- Ejemplos 2 -FUNCIONES DE AGRUPAMIENTO 
SELECT (1 + 7) * (10 / (6 - 4));
SELECT avg(precio) FROM articulo;
SELECT count(*) FROM articulo;
SELECT max(precio) FROM articulo;
SELECT min(precio) FROM articulo;
SELECT sum(precio) FROM articulo;

####################Reto 2: Funciones de agrupamiento####################
-- ¿Cuál es el promedio de salario de los puestos?
select avg(salario) as PromedioSalario from puesto;
-- ¿Cuántos artículos incluyen la palabra Pasta en su nombre?
select count(*) as Articulos from articulo where nombre like '%Pasta%';
-- ¿Cuál es el salario mínimo y máximo?
select min(salario) as SalarioMinimo, max(salario) as SalarioMaximo from puesto;
-- ¿Cuál es la suma del salario de los últimos cinco puestos agregados?
-- select * from puesto order by id_puesto desc limit 5;
-- select sum(salario) as salario from puesto where id_puesto in (select id_puesto from puesto order by id_puesto desc limit 5);
select sum(salario) as salario from puesto where id_puesto in (1000,998,996,999,997);
#########################################################################


-- Ejemplo 3: Agrupamientos
SELECT nombre, sum(precio) AS total FROM articulo GROUP BY nombre;
SELECT nombre, count(*) AS cantidad FROM articulo GROUP BY nombre ORDER BY cantidad DESC;
SELECT nombre, min(salario) AS menor, max(salario) AS mayor FROM puesto GROUP BY nombre;

################################################## Reto 3: Agrupamientos #####################
USE tienda;
-- ¿Cuántos registros hay por cada uno de los puestos?
select nombre,count(*) as cantidadPuestos from puesto group by nombre;

-- ¿Cuánto dinero se paga en total por puesto?
select nombre,sum(salario) as dineroPuesto from puesto group by nombre;

-- ¿Cuál es el número total de ventas por vendedor?
select id_empleado,count(id_venta) as cantidadVentas from venta group by id_empleado;

-- ¿Cuál es el número total de ventas por artículo?
select id_articulo, count(*) as ventaXArt from venta group by id_articulo;
##############################################################################################


-- ___________________________Ejemplo 4: Subconsultas________________________________________________________________________

SELECT * FROM empleado WHERE id_puesto IN (SELECT id_puesto   FROM puesto   WHERE nombre = 'Junior Executive');
SELECT id_articulo, min(cantidad), max(cantidad) FROM    (SELECT clave, id_articulo, count(*) AS cantidad   FROM venta   GROUP BY clave, id_articulo   ORDER BY clave) AS subconsulta GROUP BY id_articulo;
SELECT nombre, apellido_paterno, (SELECT salario FROM puesto WHERE id_puesto = e.id_puesto) AS sueldo FROM empleado AS e;

############################################# Reto 4: Subconsultas ##################################################
-- ¿Cuál es el nombre de los empleados cuyo sueldo es menor a $10,000?
select nombre from empleado where id_puesto in (select id_puesto from puesto where salario<10000);
-- ¿Cuál es la cantidad mínima y máxima de ventas de cada empleado?
select id_empleado, min(id_venta) as cantidadMinima, max(id_venta) as cantidadMaxima from venta group by id_empleado; 
-- ¿Cuál es el nombre del puesto de cada empleado?
select id_empleado, (select nombre from puesto where id_puesto=e.id_puesto) as puesto from empleado e;

########################################### Fin reto 4 #############################################################



-- ********************************* Ejercicios Sesión 2 ***********************************************************************
use classicmodels;
-- 1.-Dentro de la tabla employees, obtén el número de empleado, apellido y nombre de todos los empleados cuyo nombre empiece con A.
select employeeNumber,lastName,firstName from employees where firstName like 'A%';

-- 2.-Dentro de la tabla employees, obtén el número de empleado, apellido y nombre de todos los empleados cuyo apellido termina con on.
select employeeNumber,lastName,firstName from employees where lastName like '%on';

-- 3.-Dentro de la tabla employees, obtén el número de empleado, apellido y nombre de todos los empleados cuyo nombre incluye la cadena on.
select employeeNumber,lastName,firstName from employees where firstName like '%on%';

-- 4.-Dentro de la tabla employees, obtén el número de empleado, apellido y nombre de todos los empleados cuyos nombres tienen seis letras e inician con G.
select employeeNumber,lastName,firstName from employees where firstName like 'G_____';

-- 5.-Dentro de la tabla employees, obtén el número de empleado, apellido y nombre de todos los empleados cuyo nombre no inicia con B.
select employeeNumber,lastName,firstName from employees where firstName not like 'B%';

-- 6.-Dentro de la tabla products, obtén el código de producto y nombre de los productos cuyo código incluye la cadena _20.
select productCode,productName from products where productCode like '%_20%';

-- 7.-Dentro de la tabla orderdetails, obtén el total de cada orden.
select orderNumber,sum(quantityOrdered) as Total from orderdetails group by orderNumber;

-- 8.-Dentro de la tabla orders obtén el número de órdenes por año.
select year(orderDate) as 'Año', count(orderNumber) Ordenes from orders group by year(orderDate);

-- 9.-Obtén el apellido y nombre de los empleados cuya oficina está ubicada en USA.
select lastName,firstName from employees where officeCode in (select officeCode from offices where country='USA');

-- 10.-Obtén el número de cliente, número de cheque y cantidad del cliente que ha realizado el pago más alto.
select customerNumber,checkNumber,amount from payments order by amount desc limit 1;

-- 11.-Obtén el número de cliente, número de cheque y cantidad de aquellos clientes cuyo pago es más alto que el promedio.
select customerNumber,checkNumber,amount from payments where amount > (select avg(amount) from payments);


-- 12.-Obtén el nombre de aquellos clientes que no han hecho ninguna orden.
select customerName from customers where customerNumber not in (select customerNumber from orders);

-- 13.-Obtén el máximo, mínimo y promedio del número de productos en las órdenes de venta.
select max(tabla.numProductos) as Maximo, min(tabla.numProductos) as Minimo, avg(tabla.numProductos) as Promedio
from 
(select productCode,count(productCode) as numProductos from orderdetails group by productCode) tabla;


-- 14.-Dentro de la tabla orders, Obtén el número de órdenes que hay por cada estado.
select state, (select count(orderNumber) as numOrdenes from orders where customerNumber=c.customerNumber group by customerNumber)  as ordenes from customers c;
select status,count(ordernumber) ordenes from orders group by status;
