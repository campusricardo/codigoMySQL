-- ------------------------------------------------------------ SQL BASICO --------------------------------------------------------


--Sentencia para crear una base de datos si no existe
CREATE DATABASE IF NOT EXISTS mundo;

--Usar la base de datos 
USE mundo;
-- Crear Tabla si no existe
CREATE TABLE IF NOT EXISTS pais (
    id INT PRIMARY KEY,
     nombre VARCHAR(20),
     continente VARCHAR(50),
     poblacion INT
);
-- Le agregamos una PRIMARY KEY llamada id
ALTER TABLE pais
ADD PRIMARY KEY (id);
-- Creamos una tabla Temp
CREATE TABLE Temp (
    id INTEGER,
    dato VARCHAR(20)
);
 -- Insertamos datos a la tabla pais
INSERT INTO pais(id, nombre, continente, poblacion)
VALUES (101, "Colombia", "Sur America", 50000000);
INSERT INTO pais(id, nombre, continente, poblacion)
VALUES (102, "Ecuador", "Sur America", 17000000);

INSERT INTO pais(id, nombre, continente, poblacion)
VALUES (103, "Guatemala", "Centro America", 17000000);

INSERT INTO pais(id, nombre, continente, poblacion)
VALUES (104, "Mexico", "Centro America", 126000000);

INSERT INTO pais(id, nombre, continente, poblacion)
VALUES (105, "Estados Unidos", "Norte America", 331000000);

INSERT INTO pais(id, nombre, continente, poblacion)
VALUES (106, "Canada", "Norte America", 380000000);

INSERT INTO pais(id, nombre, continente)
VALUES (107, "Paraguay", "Sur America" );

-- Borramos la tabla Temp

DROP TABLE IF EXISTS Temp;

-- UPDATE de la poblacion de Colombia.
UPDATE pais
SET poblacion = 50887423
WHERE id= 101;

-- DELETE Canada

DELETE FROM pais
WHERE id = 106;

-- Seleciona todas las columnas de pais
SELECT * FROM pais;

-- Seleciona todas las tuplas con poblacion menor a 100 millones

SELECT nombre
FROM pais
WHERE poblacion <= 100000000;

-- Operadores logicos con WHERE

-- = igual a / <> Diferente de / < Menor que / > Mayor que / <= Menor o igual que / >= Mayor o igual que


-- Operadores Logicos

-- AND Si todas las condiciones son verdad devuelve verdadero

-- OR Evalua las condiciones y si una es verdadera devuelve verdadero

-- NOT Niega una condicion y devuelve verdadero si la condicion es FAILED_LOGIN_ATTEMPTS

-- Ordenas los paises con menos de 100 millones de personas alfabeticamente

SELECT nombre
FROM pais
WHERE poblacion <= 100000000
ORDER BY nombre DESC
LIMIT 2;


-- DESC siver para ordenarlos de mayor a menor

-- ASC de menor a mayor

-- ------------------------------------------------------------ SQL INTERMEDIO --------------------------------------------------------

-- Crea una tabla tempPais con un select

CREATE TABLE tempPais
AS
SELECT nombre, poblacion
FROM pais
WHERE poblacion <= 100000000;

SELECT * FROM tempPais;

-- Describir una tabla

DESCRIBE tempPais;

-- Crea una tabla ciudad que se relaciona con la tabla pais de uno a muchos.

CREATE TABLE ciudad (
    id INT PRIMARY KEY,
    nombre VARCHAR(20),
    id_pais INT,
    FOREIGN KEY (id_pais)
    REFERENCES pais(id)

);
-- Creamos una tabla idioma
CREATE TABLE idioma (
    id INT PRIMARY KEY,
    idioma VARCHAR(50)
);

-- Creamos una tabla idioma_pais donde vamos a relacionar idioma y pais
CREATE TABLE idioma_pais (
    id_idioma INT,
    id_pais INT,
    es_oficial BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (id_idioma, id_pais),
    FOREIGN KEY (id_idioma) REFERENCES idioma(id),
    FOREIGN KEY (id_pais) REFERENCES pais(id)
);

-- Selecciona la poblacion del pais

SELECT poblacion AS xd FROM pais;

-- Seleciona el promedio de poblacion de todos los paises de la tabla 
-- Con funciones 
SELECT AVG(poblacion) AS promedio_poblacion FROM pais;

-- Seleccion con expresiones

SELECT id * poblacion as xd2 FROM pais;

-- Crea el alias p que es la tabla pais

SELECT p.poblacion
FROM pais AS p;

-- Asigna los alias c a ciudad y p a pais y despues unimos las dos tablas 

SELECT p.nombre, p.poblacion
FROM  pais AS p
JOIN ciudad AS c ON p.id = c.id_pais;

-- Crea un alias p que seleciona una subconsulta

SELECT p.nombre
FROM (SELECT * FROM pais WHERE poblacion > 1 ) AS p;

-- Funciones en campos


-- CONCAT() concatena dos o mas cadenas de texto

SELECT CONCAT(nombre," ",continente) AS pais_continente FROM pais;

-- UPPER() Convierte una cadena a mayusculas
SELECT UPPER(nombre) AS NOMBRE FROM pais;

-- LOWER() Convierte una cadena a minusculas

SELECT LOWER(continente) AS conti FROM pais;

-- LENGTH() devuelve la longitud de la cadena

SELECT LENGTH(nombre) AS nombre_length FROM pais;

-- SUBSTRIN() Extrae una parte de una cadena

SELECT SUBSTRING(nombre, 1,3)
AS sub_nombre FROM pais;


-- TRIM() Elimina espacios en blanco de una cadena

SELECT TRIM(continente) AS nombre_no_espacios FROM pais;

-- ROUND() redondea un numero

SELECT ROUND(poblacion, 2) AS
    poblacion_red FROM pais;

-- DATA_FORMAT() Formatea una fecha

SELECT DATA_FORMAT(fecha_nacimiento, "%d-%m-%Y") AS fecha_formato FROM usuarios;

-- NOW() Devuelve la fecha y hora actual

SELECT NOW() AS fecha FROM pais;

-- IFNULL() Devuelve un valor alternativo si no es nulo

SELECT IFNULL(poblacion, "N/A") AS xd FROM pais;

-- Asignacion condicional

SELECT IF(poblacion > 100000000, "Alta Poblacion", "No sobrepoblados") AS sobrepoblacion
FROM pais;

-- Calculo Condicional

SELECT nombre, poblacion, 
    IF (poblacion > 90000000, poblacion + id, poblacion ) AS pobid
    FROM pais;


-- Operaciones de combinacion de tablas

-- Sirven para combinar datos diferentres de una manera significativa y util 

-- Tipos de JOINs

-- INNER JOIN: Selecciona registros que tienen valores coincidentes en ambas tablas

-- En termios de conjuntos seria los registros comunes a las dos tablas con referencia al campo de enlace

SELECT pais.nombre as pais, ciudad.nombre as ciudad
FROM pais
INNER JOIN ciudad
ON pais.id = ciudad.id_pais
WHERE pais.nombre = "Mexico";


SELECT * FROM pais;

INSERT INTO ciudad(id, nombre, id_pais)
VALUES (107, "Tijuana", 104 );

INSERT INTO ciudad(id, nombre, id_pais)
VALUES (108, "Xupultepeq", 104 );


-- LEFT JOINS devuelve todos los registros de la tabla izquierda y los registros coincidentes de la tabla derecha. el resultado es NULL en el lado derecho si no hay coincidencia.

SELECT pais.nombre AS pais, ciudad.nombre as ciudad
FROM pais
LEFT JOIN ciudad
ON pais.id = ciudad.id_pais;

-- RIGHT JOIN: Devuelve todos los registros de la tabla derecha, y los registros coincidentes de la tabla izquierda. El resultado es NULL en el lado izquierdo si no hay coincidencia.


SELECT pais.nombre AS pais, ciudad.nombre AS ciudad
FROM pais

RIGHT JOIN ciudad
ON pais.id = ciudad.id_pais;

-- Consultas anidadas

-- Son consultas dentro de otras consultas. Las subconsultas pueden retornar datos a la consulta principal, donde pueden ser usados para mas operaciones.

-- subconsultas.

-- Son consultas anidadas

SELECT nombre
FROM pais
WHERE poblacion > (SELECT AVG(poblacion) FROM pais);

-- Consultas anidada para selecionar las ciudades con menor poblacion

SELECT min(poblacion) FROM pais;

SELECT C.nombre
FROM ciudad AS C
INNER JOIN pais AS P ON P.id = C.id_pais
WHERE P.poblacion = (SELECT min(poblacion) FROM pais);


-- Seleccionar la mayor multa impuesta a un prestamo de un libro

SELECT max(multa) AS maxima
FROM prestamo;

SELECT prestamo AS P
SELECT P.numero_pres, P.fecha_pres, U.nombre_usu, P.multa
FROM usuarios AS U
INNER JOIN P ON U.codigo_usu = P.codigo_usu
WHERE P.multa = (SELECT max(multa) AS maxima FROM P) ORDER BY P.multa DESC;

-- Los indices son una caracteristica crucial en cualquier base de datos relacional, incluyendo MySQL. Proporcionan una manera rapida de buscar y acceder a datos especificos en una tabla.

-- Una vista es un objeto de base de datos virtual que se crea a partir de una consulta SQL. Se puede pensar en una vista como una tabla virtual que no cotiene datos fisicos, sino que muestra los datos de otras tablas o vistas. 

-- Uso de indices para mejorar el rendimineto de las consultas

-- Un indice es una estructura de datos que mejora la velocidad de las operaciones de datos en una tabla de base de datos. MySQL puede usar indices para encontrar rapidamente los registros con un valor de columna especifico: sin un indice, MySQL debe comenzar con el primer registro y luego leer a traves de toda la tabla para encontrar los registros correspondientes.


CREATE INDEX index_name
ON table_name (column1,column2,...);

CREATE INDEX nombre
ON pais(nombre);

-- Indice Simple (Single-Column Index):

-- Es un indice que se crea en una sola columna de una tabla. Un ejemplo de un indice simple es crear uo para el nombre de la ciudad en la tabla ciudad asi:

CREATE INDEX idx_nombre_ciudad
ON ciudad(nombre);

-- Indice compuesto (Composite Index): Es un indice que se crea en dos o mas columnas de una tabla. Los indices compuestos son utiles para consultas que buscan en varias columnas.

CREATE INDEX idx_apellido_nombre
ON usuario (apellido, nombre);

-- Indice Unico (Unique Index): MySQL no permite que se inserten dos filas con el mismo valor de indice en una tabla si esa columna esta definida como indice unico. El indice primario es un tipo de indice unico donde no se permite ningun valor duplicado o NULL

CREATE UNIQUE INDEX idx_email
ON usuarios(email);


CREATE UNIQUE INDEX idx_nombre_pais
ON pais(nombre);

-- Indice de texto completo (Full-Text Index): MySQL ofrece indcies de texto completo en tablas MyISAM y partir de MySQL 5.6, tambien en tablas InnoDB. Son utiles para buscar palabras en cadenas de texto. Estos indices son estructuras de datos utlizadas para mejorar la busqueda y recuperacion de texto en campos de texto largo (como cadenas de caracteres o documentos) en una tabla de MySQL. This index are desing especificamente para realizar busquedas de texto en lugar de busquedas exactas. Los indices de texto completo permiten realizar busquedas basadas en palabras clave o frases, en lugar de simplemente buscar coincidencias exactas de palabras. Estos indices proporcionan una forma eficiente de buscar palabras clave deontro de un texto, teniendo en cuenta factores como el orden de las palabras, la proximidad de las palabras y la relevancia del texto. Es importante tener en cuenta que los indices de texto completo en MySQL requieren un almacenamiento adicional y un mantenimineto regular para mantener la integridad de los indices. Ademas, no todos los tipos de datos de texto son compatibles con los indices de texto completo.


CREATE FULLTEXT INDEX idx_content
ON posts(content);

-- Cuando se debe utilizar los indices

-- Los indices son muy utles y pueden mejorar significativaemente el rendimiento de la base de datos. sin embargo, tambien tienen sus costos. Los indices ocupan espacio de almacenamineto y cada vez que insertamos , actualizamos o eliminamos filas en una tabla, los indices correspondientes tambien deben actualizarse. Por lo tanto, los indices deben utilizarse de manera estrategica.

-- Situaciones en que es util crear indices:

-- En columnas que se utilizan con frecuencia en clausulas WHERE.

-- En columnas usadas para unir tablas.

-- En columnas con un alto numero de valores unicos.

-- En columnas usadas en ORDER BY, GROUP BY.

-- No es recomendable utilizar indices en estas situaciones

-- Tablas que son mas modificafas (INSERT, UPDATE, DELETE) que leidas (SELECT).

-- Columnas que tienen muchos datos duplicados.

-- Uso de vistas para simplificar y agilizar las consultas.

-- Las vistas son tablas virtuales creadas por vairas consultas sobre una o mas tablas. Estas tienen la misma estructura de filas y columnas que otras tablas en MySQL. En una base de datos no pueden existir dos vistas con el mismo nombre.

CREATE[OR REPLACE] VIEW nombre_vista[lista_columnas]
AS consulta;

-- nombre_vista: Es el nombre que tendra la tabla virtual

-- lista_columnas: Aqui se listan las columnas que tendra la vista

-- consulta: Es una consulta SELECT que devuelve los datos que haran parte de la vista

-- CREATE OR REPLACE: Las vistas se pueden crear o remplazar. Si se usa REPLACE y la vista no existe se creara, si ya existe se remplazara por esta.

-- Ventajas por usar vistas.

--Simplificacion y abstraccion de datos.

-- Seguridad y control de acceso

-- Simplificacion de consultas complejas

-- Mejora del rendimiento 

-- Modularidad y reutilizacion del codigo

-- Ahora si viene los chido

-- Crear vistas

-- Vista que contendra la informacion de las ciudades , a que pais pertenecen y cual es el idioma oficial que se habla en ellas. El SQL para crear esta vista es:

CREATE VIEW vistaPais AS 
SELECT  C.nombre, P.nombre, IP.es_oficial, I.idioma
FROM pais AS P 
INNER JOIN ciudad AS C ON P.id = C.id_pais
INNER JOIN idioma_pais AS IP on P.id = IP.id_pais
INNER JOIN idioma AS I on IP.id_idioma = I.id
WHERE IP.es_oficial = TRUE;

-- Ver vista

SELECT * FROM vistaPais;

-- Borrar vista 

DROP VIEW vistaPais;


-- MYSQL AVANZADO 

-- Procedimientos almacenados

-- Son bloques de codigo SQL que se almacena en el servidor de la base de datos y se ejecutan en respuesta a una llamada o invocacion desde una aplicacion o programa. Estos procedimientos encapsulan una serie de instrucciones SQL que se pueden llamr de manera repetitiva y reutilizable.

-- Ventajas

-- Modularidad: Los procedimientos almacenados permiten dividir la logica de negocio en unidades mas pequenias y manejables. Esto facilita la organizacion del codigo y la reutilizacion de funcionalidades en diferentes partes de la aplicacion.

-- Mayor rendimiento: Al ejecutar instrucciones SQL en el servidor de la base de datos en lugar de enviar multiples consultas desde la aplicacion, se puede reducir la cantidad de trafico de red y mejorar el rendimiento de la aplicacion.

-- Seguridad: Los procedimientos alamacenados pueden ayudar a garantizar la seguridad de los datos al permitir un control mas granular sobre las operaciones que se realizan en la base de datos. Tambien pueden proporcionar una capa adicional de proteccion contra ataques de inyeccion SQL.

-- Mantenibilidad: Ak centralizar la logica de negocio en los procedimientos almacenados, se facilita el mantenimiento y la actualizacion de la aplicacion. Los cambios en la logica se pueden realizar en el procedimiento almacenado sin tener que modificar la aplicacion web en si.

-- Sintaxis

CREATE
    [DEFINER = {user | CURRENT_USER}]
    PROCEDURE sp_name([proc_parameter[,...]])
    [characteristic...] routine_body

proc_parameter:
    [ IN | OUT | INOUT ] param_name type

func_parameter:
    param_name type

type:

    Any valid MySQL data type

characteristic:
    COMMENT 'string'
    | LANGUAGE SQL
    | [NOT] DETERMINISTIC
    | { CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA}
    | SQL SECURITY { DEFINER | INVOKER}

routine_body:
    Valid SQL routine statement


;

-- DELIMITER

-- Es la definicion de un procedimiento almacenado se debe modificar, temporalmente, el caracter separador que se utiliza para separar y delimitar sentencias SQL. Por defecto el caracter separador es el punto y coma ( ; ). En los ejemplos del documento, usaremos el caracter pesos ( $ ) dos veces ( $$ ) para delimitar las instrucciones SQL, pero se puede usar cualquier otro caracter.

-- Ejemplo de delimitador:

DELIMITER $$;

-- Para volver a definir que el caracter separador es el punto y coma se escribe

DELIMITER ;

-- Parametros de entrada, salida y de entrada / salida

--Entrada (IN) Se indican poniendo la palabra reservada IN delante del nombre del parametro. Estos paramentros no pueden cambiar su valor dentro del procedimiento, es decir, cuando el procedimiento finalice estos paramentros tendran el mismo valor que tenian cuando se hizo la llamada al procedimiento. En programacion seria equivalente al paso por valor de un parametro.

-- Salida (OUT): Se indica poniendo la palabra reservada OUT delante del nombre del parametro. Estos parametros cambian su valor dentro del procedimiento. CUando se hace la llamada al procedimiento empiezan con un valor inicial y cuando finaliza la ejecucion del procedimiento pueden terminar con otro valor diferente. En programacion seria equivalente al paso por referencia de un parametro. 

-- Entrada / Salida (IN OUT): Es una combinacion de los tipos IN y OUT. Estos parametros se indican poniendo la palabra reservada IN/OUT delante del nombrre del parametro

--Lista ciudades de un pais y que reciba por parametro el nombre del pais

DELIMITER ;

DROP PROCEDURE IF EXISTS listar$$

;
CREATE PROCEDURE listar(IN nom_pais VARCHAR(50))
BEGIN 
    SELECT C.nombre
    FROM pais AS P
    INNER JOIN ciudad AS C on P.id = C.id_pais
    WHERE P.nombre = nom_pais;
END
;

-- Crear un procedimineto que cuente la cantidad de un pais y que reciba por parametor el nombre del pais.


DELIMITER ;
CREATE PROCEDURE contar_ciudades_nom_pais(IN nom_pais VARCHAR(50), OUT total INT UNSIGNED)
BEGIN 
    SELECT COUNT(*) INTO total
    FROM pais AS P
    INNER JOIN ciudad AS C ON P.id = C.id_pais
    WHERE P.nombre = nom_pais;
END

;

-- Llamar al procedimiento almacenado

CALL listar("Mexico");

CALL contar_ciudades_nom_pais('Mexico', @total);
SELECT @total;

-- Estructuras IF - THEN - ELSE 

-- Como en javascript XD

IF search_condition THEN
    statement_list

[ELSEIF serach_condition THEN
    statement_list]...

[ELSE 
    statement_list]

END IF

-- Procedimiento almacenado que informe cuantos idiomas hay que no se hablen en ningun pais.

DELIMITER $$
CREATE PROCEDURE verificar_idiomas_sin_pais()
BEGIN
    DECLARE num_idiomas_sin_pais INT;

-- Contar el numero de idiomas que no se hablan en ningun pais

    SELECT COUNT(*) INTO num_idiomas_sin_pais
    FROM idioma
    WHERE id NOT IN (SELECT id_idioma FROM idioma_pais);

-- Verificar si hay o no hay idiomas sin pais y mostrar el resultado

IF num_idiomas_sin_pais > 0 THEN
SELECT CONCAT('Existen', num_idiomas_sin_pais, 'idiomas que no se hablan en ningun pais') AS mensaje;

    ELSE 
    SELECT 'No hay idiomas que no se hablen en ningun pais' AS mensaje;

    END IF;

END;

CALL verificar_idiomas_sin_pais();

-- Estructura CASE 
CASE 
    WHEN search_condition THEN statement_list
    [WHEN search_condition THEN statement_list]...
    [ELSE statement_list]
END CASE;

-- Un procedimiento almacenado que dado el id de una ciudad muestre informacion de esa ciudad, por ejemplo, el pais y continente al que pertenecen y el tipo de ciudad dependiendo de su cantidad de poblacion.

CREATE PROCEDURE obtener_info_ciudad(IN ciudad_id INT)
BEGIN
    DECLARE ciudad_nombre VARCHAR(20);
    DECLARE pais_nombre VARCHAR(20);
    DECLARE continente_nombre VARCHAR(50);
    DECLARE poblacion INT;
    DECLARE info VARCHAR(100);

    -- Obtener informacion de la ciudad y su pais usando la estructura CASE 
    SELECT C.nombre, P.nombre, P.continente, P.poblacion

    INTO ciudad_nombre, pais_nombre, continente_nombre, poblacion FROM ciudad AS C
    INNER JOIN pais AS P ON C.id_pais = P.id
    WHERE C.id = ciudad_id;

    -- Construir el mensaje de informacion usando la estructura CASE


    SET info = CASE

    WHEN poblacion > 1000000 THEN CONCAT(ciudad_nombre, "es una gran ciudad en", continente_nombre,".")

    WHEN poblacion > 500000 THEN CONCAT(ciudad_nombre, "es una ciudad de tamanio mediano en", continente_nombre,".")

    ELSE CONCAT(ciudad_nombre, "es una pequenia ciudad en", continente_nombre,".")
    END;

    SELECT CONCAT("la ciudad de", ciudad_nombre, "se encunetra en el pais de", pais_nombre,".", info) AS informacion
    END;


-- XD no funciona este codigo :c


-- Estructura LOOP

-- Esta esctructura perimite ejecutar un bloque de codigo def forma infinita hasta que se encuentre una instruccion BREAK dentro del loop

[begin_label:] LOOP
statement_list

END LOOP [end_label];

CREATE PROCEDURE cicloloop(p1 INT, OUT x INT)
BEGIN
    label1: LOOP
    SET p1 = p1 + 1;

    IF p1 < 10 THEN
    ITERATE label1;
    END IF;

    LEAVE label1;
    END LOOP label1;

    SET X = p1;

END;

CALL cicloloop(1, @fin);
SELECT @fin;

-- Estructura REPEAT

-- Permite ejecutar un bloque de codigo repetidamente hasta que cunmpla una condicion especifica. La condicion se verfica al final de cada iteracion.
REPAT 
    -- codigo a ejecutar

UNTIL condicion;

DROP PROCEDURE IF EXISTS ejemplo_bucle_repeat;

CREATE PROCEDURE IF NOT EXISTS ejemplo_bucle_repeat(IN tope INT, OUT suma INT)

BEGIN
    DECLARE contador INT;
    SET contador = 1;
    SET suma = 0;

    REPEAT
        SET suma = suma + contador;
        SET contador = contador + 1;

        UNTIL contador > tope
        END REPEAT;

END;

CALL ejemplo_bucle_repeat(10, @resultado);
SELECT @resultado;

-- Estructura WHILE

-- La estructura while iterara una lista de sentencia mientras la condicion sea cierta.

[begin_label:] WHILE search_condition DO
    statement_list
END WHILE [end_label];

DROP PROCEDURE IF EXISTS ejemplo_bucle_while;

CREATE PROCEDURE IF NOT EXISTS ejemplo_bucle_while (IN tope INT, OUT suma INT)
BEGIN
    DECLARE contador INT;
    SET contador = 1;
    SET suma = 0;

    WHILE contador <= tope DO
    SET suma = suma + contador;
    SET contador = contador + 1;
    END WHILE;

END;

CALL ejemplo_bucle_while(10, @resultado);
SELECT @resultado;

-- Manejo de errores

-- Es posible que en los procedimientos almacenados se produzca algun tipo de error en su ejecucion

-- Declarar un controlador

DECLARE action HANDLER FOR condition_value statement;

-- Si el valor de la condicion es igual a condition_value se ejecutara statement.

-- Las operaciones permitidas en action son:

-- CONTINUE: permite continuar ejecutando el bloque de codigo

-- EXIT: declara la finalizacion del bloque de codigo.

-- Los valores que pueden tomar en codition_value:

-- Un codigo de error de MySQL
-- UN valor de SQLSTATE
--SQLWARNING
-- NOT FOUND
--SQLEXCEPTION

DECLARE handler_action HANDLER

 FOR condition_value [, condition_value]...
    Statement

handler_action:
CONTINUE
| EXIT
| UNDO

condition_value:

mysql_error_code
| SQLSTATE [VALUE] sqlstate_value
| condition_name
| SQLWARNING
| NOT FOUND
| SQLEXCEPTION


-- Declarar un SQLEXCEPTION que al darse permita continuar con la ejecucion del procedimiento y establezca la variable has_error a 1.

-- DECLARE CONTINUE HANDLER: Se utiliza para declarar un manejador de errores que capturara excepciones especificas en tiempo de ejecucion.

-- FOR SQLEXCEPTION: Indica que el manejador de errores se activara cuando se produzca una excepcion SQL.

-- SET has_error = 1: Establece la variable has_error con el valor 1 cuando se produce una excepcion SQL.

-- Esta instruccion se utiliza para capturar y manejar excepciones SQL que ocurran durante la ejecucion de un bloque de codigo en MySQL. Cuando se produce una excepcion SQL, la variable has_error se establece en 1, lo que puede ser utilizada posteriormente en el codigo para tomar decisiones o realizar acciones especificas en caso de error.

-- Example 2

-- Escribir una excepcion que salga del bloque de codigo y revierta el lo que se ha hecho en la base de datos.

DECLARE EXIT HANDLER FOR SQLEXCEPTION 
BEGIN
    ROLLBACK;
    SELECT 'An error has ocurred, operation rollbacked and the stored procedure was terminated';
END;


-- DECLARE EXIT HANDLER FOR SQLEXCEPTION: Esta linea declara un manejador de excepciones para capturar cualquier excepcion generada durante la ejecucion del procedimiento almacenado que corresponda a la categoria "SQLEXCEPTION"


-- BEGIN Indica el inicio del bloque de codigo que se ejecutara en cado de que se produzca una excepcion.

-- ROLLBACK: Esta instruccion deshace cualquier cambio realizado en la transaccion actual, restaurando los datos a su estado anterior a la ejecucion del procedimiento almacenado.

-- SELECT 'An error has ocurred, operation rollbacked and the stored procedure was terminated': Eata sentencia SELECT simplemente muestra un mensaje indicando que se ha producido un error, que la operacion ha sido revertida y que el procedimiento almacenado ha sido terminado.

-- Este bloque de codigo se encarga de manejar las excepciones de tipo SQL en el contexto de un procedimineto almacenado. Si se produce una excepcion, se deshace cualquier cambio realizado y se muestra un mensaje de error indicando que la operacion ha sido revertida y el procedimiento almacenado ha finalizado

-- Ejemplo 3: Escrbir un procedimiento almacenado que inserte paises en la tabla pais. Si se intenta insertar un pais con un id que ya existe, maneje la excepcion mostrnado un mensaje de que la llave ya existe.

-- Mostramos la estructura de la tabla pais.

CREATE PROCEDURE insert_pais(IN pais_id INT, IN nombre VARCHAR(20), IN continente VARCHAR(50), IN poblacion INT)
BEGIN
    DECLARE CONTINUE HANDLER FOR 1062
    SELECT CONCAT ('llave primaria duplicada(',pais_id,',',nombre,')found') AS msg;

-- insertar un nuevo registro en la tabla pais

INSERT INTO pais(id, nombre,continente,poblacion)
VALUES (pais_id,nombre,continente,poblacion);

-- retornar cuantos paises hay en la tabla pais
SELECT COUNT(*) FROM pais;
END;

DESCRIBE pais;

SELECT * FROM pais;


CALL insert_pais(400, "Argentina", "Sur America", 44938712);

-- Funciones definidad por el usuario

-- Las funciones personalizadas en MySQL son una poderosa caracteristica que te permite encapsular una serie de declaraciones SQL en un solo bloque de codigo que puede ser llamado por su nombre en una consulta.

-- Son bloques de codigo que realizan una tarea especifica y luego devuelven un valor. Son similares a las funciones incorporadas de MySQL como COUNT() etc. pero se definen por el usuario para realizar tareas que no peuden ser realizadas facilmente por las funciones incorporadas.

CREATE FUNCTION function_name([parameter1 [type1], ...])
RETURNS return_datatype
[LANGUAGE SQL]
[DETERMINISTIC | NOT DETERMINISTIC]
[SQL DATA ACCESS {CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA}]
[COMMENT 'string']
BEGIN 
    declaration_section
    executable_section
END;


-- Funcion que devuelve la poblacion de un pais dado su nombre

CREATE FUNCTION obtener_poblacion(pais_nombre VARCHAR(20))
RETURNS INT DETERMINISTIC
READS SQL DATA
BEGIN
DECLARE poblacion INT;

SELECT poblacion INTO poblacion
FROM pais
WHERE nombre = pais_nombre;

RETURN poblacion;
END;

--DETERMINISTIC indica que para un conjunto dado de entradas, la funcion siempre devolvera el mismo resultado

-- READS SQL DATA : que solo lee los datos de la base de datos, no los modifica.

-- DECLARE poblacion INT: Dentro del cuerpo de la funcion se declara una variable llamada poblacion de tipo entero. Esta variable se utiliza para almacenar el resultado de la consulta SQL que se realizara despues

-- SELECT poblacion INTO poblacion FROM pais WHERE nombre = pais_nombre; Esta es una consulta SQL que selecciona el valor de la columna poblacion de la tabla 'pais' donde el nombre del pais coincide con el valor del parametro de entrada pais_nombre. El resultado de esta consulta se almacena en la variable poblacion

-- RETURN poblacion; Finalmente el valor almacenado en la varible poblacion se devuelve como resultado de la funcion

-- No funciona xd

SELECT obtener_poblacion('Colombia');

-- Ejemplo 2 
-- Crea una funcion que devuelva el numero total de ciudades en un pais dado su id.

CREATE FUNCTION contar_ciudades(pais_id INT)
RETURNS INT DETERMINISTIC
READ SQL DATA
BEGIN 
DECLARE cantidad INT;

SELECT COUNT(*) INTO cantidad
FROM ciudad
WHERE id_pais = pais_id;

RETURN cantidad;

END;

SELECT contar_ciudades(1);

-- Ni fui capaz de crearla xd creo que es porque cantidad no existe en ciudad xd

-- Vamos a crear una funcion en MySQL que es NOT DETERMINISTIC lo que significa que los valores pueden cambiar incluso si son los mismos datos, un ejemplo clasico es una funcion que retorna el valor actual de la hora del sistema.

CREATE FUNCTION contar_ciudades_y_hora(pais_id INT)
RETURNS VARCHAR(255) NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE cantidad INT;
    DECLARE resultado VARCHAR(255);

    SELECT COUNT(*) INTO cantidad
    FROM ciudad
    WHERE id_pais = pais_id;

    SET resultado = CONCAT('El pais con id', pais_id, 'tiene', cantidad,'ciudades. Hora actual:', CURRENT_TIMESTAMP);

    RETURN resultado;
END;

SELECT contar_ciudades_y_hora(104);

-- Yei si funciona

-- Ventajas de las funciones personalizadas

--Reutilizacion de codigo: Si tienes una operacion que se realiza repetidamente en tu base de datos, puedes encapsularla en una funcion y reutilizarla.

-- Mejorar la legibilidad: Al agrupar varias operaciones en una funcion, puedes hacer que tu codigo sea mas facil de leer y mantener.

-- Eficiencia: Algunas operaciones pueden ser mas eficientes si se realizan en el servidor de la base de datos en lugar de ser realizadas por la aplicacion cliente.

-- Cuando usarlas ?

-- Las funciones personalizadas son utiles cuando necesitamos realizar operaciones que son demasiado complejas para ser realizadas por una simple consulta SQL o cuando la misma operacion se realiza en varios lugares.


-- Ejercicios xd 
--Crea una función que devuelva el nombre del país con la mayor población.
--Crea una función que devuelva la cantidad de países en un continente dado el nombre del continente.
--Crea una función que devuelva TRUE si un país dado tiene un idioma oficial y FALSE en caso contrario.

-- Aqui es donde voy a hacer los ejercicios 

-- TRIGGERS

-- Los triggers o disparadores son objetos o programas asociados a las tablas, las cuales se activan cuando ocurre dicho evento. En esta seccion profundizaremos mas en estos elementos importantes.

-- Los eventos que pueden ocurrir sobre la tabla son:
-- INSERT: El trigger se activa cuando se inserta una nueva fila sobre la tabla asociada.

-- UPDATE: El trigger se activa cuando se actualiza una fila sobre la tabla asociada.

-- DELETE: El trigger se activa cuando se elimina una fila sobre la tabla asociada

-- Creacion y uso de trigger para automatizar acciones en la base de datos

CREATE
 [DEFINER = {user | CURRENT_USER}]
 TRIGGER trigger_name

trigger_time {BEFORE|AFTER} trigger_event {UPDATE|INSERT|DELETE}
ON tbl_name FOR EACH ROW
[trigger_order]
<bloque_de_instrucciones>

trigger_time: {BEFORE | AFTER}

trigger_event {INSERT | UPDATE | DELETE}

tirgger_order {FOLLOWS | PRECEDES } other_trigger_name;

-- DEFINER = {usuario | CURRENT_USER}

-- Indica al gestor de bases de datos que usuario tiene privilegios en su cuenta, para la invocacion de los triggers cuando surjan los enventos DML. Por defecto esta caracteristica tiene el valor CURRENT_USER que hace referencia al usuario actual que esta creando el trigger.

-- Nomenclatura para triggers

-- Primero escribir el nombre de la tabla, luego especifique con la incial de la operacion DML y seguidoo usamos la incial del momento de ejecucion (AFTER o BEFORE). Por Ejemplo:

BEFORE INSERT clientes_BI_TRIGGER;

-- BEFORE| AFTER : Especifica si el Trigger se ejecuta antes o despues del evento DML.

-- UPDATE | INSERT | DELETE: Aqui elija que sentencia usa para que se ejecute el Trigger.

-- ON nombre_de_la_tabla: En esta seccion establece el nombre de la tabla asociada.

-- FOR EACH ROW: Establece que el trigger se ejecuta por cada fila en la tabla asocioada

--<bloque_de_intrucciones>: Define el bloque de sentencias que el trigger ejecuta al ser invocada

--Se creará una base de datos llamada campus y contendrá una tabla llamada camper. 


CREATE DATABASE IF NOT EXISTS campus;

USE campus;

CREATE TABLE campers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    apellido1 VARCHAR(45) NOT NULL,
    apellido2 VARCHAR(45) NULL,
    nota INT NOT NULL
);

DROP TABLE campers;

-- Caracteristicas del trigger

-- Se ejecuta sobre la tabla campers
-- Se ejecutara antes de una operacion de insercion
-- Si el valor de la nota que se quiere insertar es negativo se colocara 0
-- Si el valor de la nota a insertar es mayor que 50, se colocara 50

DROP TRIGGER IF EXISTS trigger_check_nota_before_insert;

CREATE TRIGGER  trigger_check_nota_before_insert 
BEFORE INSERT ON campus.campers
FOR EACH ROW
BEGIN
    IF NEW.nota < 0 THEN
    SET NEW.nota = 0;

    ELSEIF NEW.nota > 50 THEN
    SET NEW.nota = 50;
    END IF;
    END;

-- Funciona Yei

-- Que no se me olvide que hay una funcion SQL arriba que no sirve

-- Trigger que se active antes de la actualizacion y verifique que la nota tenga valores validos para ingresar.

DROP TRIGGER IF EXISTS trigger_check_nota_before_update;

CREATE TRIGGER trigger_check_nota_before_update

BEFORE UPDATE
ON campers FOR EACH ROW

BEGIN
    IF NEW.nota < 0 THEN
    SET NEW.nota = 0;
    ELSEIF NEW.nota > 50 THEN
    SET NEW.nota = 50;

END IF;
END;

-- El la misma monda solo que ahora lo hace cuando se actualiza

-- Se hacen unos insert a la tabla campers

INSERT INTO campers VALUES (3,'Pepe', 'Lopez', 'Pablo', -1);
INSERT INTO campers VALUES (4,'Juan', 'Gutierrez', 'Pablo', 234);

SELECT * FROM campers;

-- No se puede colocar numeros negativos ni mayores de 50

-- Ahora con actualizaciones

UPDATE campers SET nota = -4 WHERE id =3;
UPDATE campers SET nota = 12318 WHERE id =4;


-- Lo mismo