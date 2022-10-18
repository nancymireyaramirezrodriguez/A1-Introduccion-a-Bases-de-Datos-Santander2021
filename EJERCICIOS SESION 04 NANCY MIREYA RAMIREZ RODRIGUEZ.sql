CREATE DATABASE IF NOT EXISTS NMireyaRR;
use NMireyaRR;
CREATE TABLE IF NOT EXISTS users (
   id INT PRIMARY KEY, 
   genero VARCHAR(1), 
   edad INT,
   ocup INT,
   cp VARCHAR(20)
);
############################################## RETO 1 ########################################################
-- Definir los campos y tipos de datos para la tabla movies haciendo uso de los archivos movies.dat y README.
-- Crear la tabla movies (recuerda usar el mismo nombre del archivo sin la extensión para vincular nombres de tablas con archivos).
-- Definir los campos y tipos de datos para la tabla ratings haciendo uso de los archivos ratings.dat y README.
-- Crear la tabla ratings (recuerda usar el mismo nombre del archivo sin la extensión para vincular nombres de tablas con archivos)


CREATE TABLE IF NOT EXISTS movies (
   id INT PRIMARY KEY, 
   titulos VARCHAR(70), 
   generos VARCHAR(20) 
);

CREATE TABLE IF NOT EXISTS ratings (
   userid INT, 
   movieid INT, 
   rating INT, 
   time_stamp BIGINT,
   FOREIGN KEY (userid) REFERENCES users(id),
   FOREIGN KEY (movieid) REFERENCES movies(id)
);
####################################################################################################################

SHOW TABLES;
SELECT * FROM users LIMIT 10;
INSERT INTO users (id,genero,edad,ocup,cp) VALUES (7000,'F',25,20,'03100');   

######################################### RETO 2 ##################################################################
-- Usando como base el archivo movies.dat, limpiarlo e importar los datos en la tabla movies creada en el Reto 1.
-- Importante: Este archivo presenta un problema muy común de encoding, es decir, la codificación con la que fue definido, no es reconocida por MySQL. Para solucionar este problema, elige una codificación diferente al momento de cargar los datos.
SELECT * FROM users order by id desc LIMIT 10;
SELECT * FROM movies order by id desc LIMIT 10;
SELECT * FROM ratings order by userid desc LIMIT 10;
 
-- Usando como base el archivo ratings.dat, limpiarlo e importar los datos en la tabla ratings creada en el Reto 2.
-- Importante: Como podrás notar, este archivo tiene demasiados registros, de manera que es normal que la carga sea muy lenta. Esto es algo muy común cuando nos enfrentamos a la carga de archivos. Si ya lleva mucho tiempo y no finaliza, no te preocupes, puedes cancelar la carga.

-- Finalmente, añade un registro en cada tabla usando INSERT INTO.
INSERT INTO movies (id,titulos,generos) VALUES (3953,'Lo que el viento se llevo',"Drama");  
insert into ratings (userid,movieid,rating,time_stamp) values (7000,3953,10,991699425);
##########################################################################################################################
