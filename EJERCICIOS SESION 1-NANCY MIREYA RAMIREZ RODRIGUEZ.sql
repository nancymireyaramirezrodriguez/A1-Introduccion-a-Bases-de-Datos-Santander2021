#####################################EJERCICIOS SESION 1 NANCY MIREYA RAMIREZ RODRIGUEZ########################################
-- 1.	Dentro del mismo servidor de bases de datos, conéctate al esquema classicmodels.
use classicmodels;

-- 2.	Dentro de la tabla employees, obtén el apellido de todos los empleados.
Select lastname from classicmodels.employees;

-- 3.	Dentro de la tabla employees, obtén el apellido, nombre y puesto de todos los empleados.
Select lastname,firstName,jobTitle from classicmodels.employees;

-- 4.	Dentro de la tabla employees, obtén todos los datos de cada empleado.
Select * from classicmodels.employees;

-- 5.	Dentro de la tabla employees, obtén el apellido, nombre y puesto de todos los empleados que tengan el puesto Sales Rep.
Select lastname,firstName,jobTitle from classicmodels.employees where jobTitle='Sales Rep';

-- 6.	Dentro de la tabla employees, obtén el apellido, nombre, puesto y código de oficina de todos los empleados que tengan el puesto Sales Rep y código de oficina 1.
Select lastname,firstName,jobTitle,officeCode from classicmodels.employees where jobTitle='Sales Rep' And officeCode=1;


-- 7.	Dentro de la tabla employees, obtén el apellido, nombre, puesto y código de oficina de todos los empleados que tengan el puesto Sales Rep o código de oficina 1.
Select lastname,firstName,jobTitle,officeCode from classicmodels.employees where jobTitle='Sales Rep' or officeCode=1;


-- 8.	Dentro de la tabla employees, obtén el apellido, nombre y código de oficina de todos los empleados que tenga código de oficina 1, 2 o 3.
Select lastname,firstName, officeCode from classicmodels.employees where officeCode in(1,2,3);


-- 9.	Dentro de la tabla employees, obten el apellido, nombre y puesto de todos los empleados que tengan un puesto distinto a Sales Rep.
Select lastname,firstName, officeCode from classicmodels.employees where jobTitle<>'Sales Rep';


-- 10.	Dentro de la tabla employees, obtén el apellido, nombre y código de oficina de todos los empleados cuyo código de oficina sea mayor a 5.
Select lastname,firstName, officeCode from classicmodels.employees where officeCode>5;


-- 11.	Dentro de la tabla employees, obtén el apellido, nombre y código de oficina de todos los empleados cuyo cdigo de oficina sea menor o igual 4.
Select lastname,firstName, officeCode from classicmodels.employees where officeCode<=4;


-- 12.	Dentro de la tabla customers, obtén el nombre, país y estado de todos los clientes cuyo país sea USA y cuyo estado sea CA.
Select customerName,country,state from classicmodels.customers where country="USA" and state='CA';


-- 13.	Dentro de la tabla customers, obtén el nombre, país, estado y límite de crédito de todos los clientes cuyo país sea, USA, cuyo estado sea CA y cuyo límite de crédito sea mayor a 100000.
Select customerName,country,state,creditLimit from classicmodels.customers where country="USA" and state='CA' and creditLimit>100000;


-- 14.	Dentro de la tabla customers, obtén el nombre y país de todos los clientes cuyo país sea USA o France.
Select customerName,country from classicmodels.customers where country="USA" or country='FRANCE';


-- 15.	Dentro de la tabla customers, obtén el nombre, pas y límite de crédito de todos los clientes cuyo país sea USA o France y cuyo límite de crédito sea mayor a 100000. Para este ejercicio ten cuidado con los paréntesis.
Select customerName,country,creditLimit from classicmodels.customers where country in('USA','FRANCE') and (creditLimit>100000);


-- 16.	Dentro de la tabla offices, obtén el código de la oficina, ciudad, teléfono y país de aquellas oficinas que se encuentren en USA o France.
Select officeCode,city,phone,country from classicmodels.offices where country='USA' or country='FRANCE';


-- 17.	Dentro de la tabla offices, obtén el código de la oficina, ciudad, teléfono y país de aquellas oficinas que no se encuentren en USA o France.
Select officeCode,city,phone,country from classicmodels.offices where country not in('USA','FRANCE');


-- 18.	Dentro de la tabla orders, obtén el número de orden, número de cliente, estado y fecha de envío de todas las órdenes con el número 10165, 10287 o 10310.
Select orderNumber,customerNumber,status,shippedDate from classicmodels.orders where orderNumber in(10165,10287,10310);


-- 19.	Dentro de la tabla customers, obtén el apellido de contacto y nombre de cada cliente y ordena los resultados por apellido de forma ascendente.
Select contactLastName,customerName from classicmodels.customers order by contactLastName asc;


-- 20.	Dentro de la tabla customers, obtén el apellido de contacto y nombre de cada cliente y ordena los resultados por apellido de forma descendente.
Select contactLastName,customerName from classicmodels.customers order by contactLastName desc;


-- 21.	Dentro de la tabla customers, obtén el apellido y nombre de cada cliente y ordena los resultados por apellido de forma descendente y luego por nombre de forma ascendente.
Select contactLastName,customerName from classicmodels.customers order by contactLastName desc,customerName asc;


-- 22.	Dentro de la tabla customers, obtén el número de cliente, nombre de cliente y el límite de crédito de los cinco clientes con el límite de crédito más alto (top 5).
Select customerNumber,customerName,creditLimit from classicmodels.customers order by creditLimit desc limit 5;

-- 23.	Dentro de la tabla customers, obtén el número de cliente, nombre de cliente y el límite de crédito de los cinco clientes con el límite de crédito más bajo diferente de 0.
Select customerNumber,customerName,creditLimit from classicmodels.customers where creditLimit<>0 order by creditLimit asc limit 5;

