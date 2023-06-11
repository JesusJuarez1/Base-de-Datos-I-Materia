1. Consultar los datos generales de todos los clientes.
SELECT * FROM CLIENTE;

2. Consultar el nombre completo de los agentes de ventas en una sola columna.
SELECT * FROM AGENTE;

SELECT APATERNO,AMATERNO,NOMBRE FROM AGENTE;
SELECT APATERNO || AMATERNO || NOMBRE FROM AGENTE;
SELECT APATERNO ||' ' || AMATERNO || ' ' || NOMBRE FROM AGENTE;

SELECT APATERNO ||' ' || AMATERNO || ' ' || NOMBRE FROM AGENTE;

SELECT APATERNO ||' ' || AMATERNO || ' ' || NOMBRE AS AGENTE FROM AGENTE;
SELECT APATERNO ||' ' || AMATERNO || ' ' || NOMBRE AGENTE FROM AGENTE;
SELECT APATERNO ||' ' || AMATERNO || ' ' || NOMBRE "Agente" FROM AGENTE;
SELECT APATERNO ||' ' || AMATERNO || ' ' || NOMBRE "Agente de Ventas" FROM AGENTE;


3. Consultar el salario anual de los ajustadores.
SELECT * FROM AJUSTADOR;

SELECT ID_AJUSTADOR, APATERNO, AMATERNO, NOMBRE, 
      SALARIO AS SALARIO_MENSUAL, 
      SALARIO * 12 AS SALARIO_ANUAL
FROM AJUSTADOR;

4. Consultar los datos generales de todos los veh�culos de una determinada marca.
SELECT * FROM AUTOMOVIL;

SELECT * FROM AUTOMOVIL
WHERE MARCA = 'NISSAN';

5. Consultar los datos generales de los autom�viles cuyo costo est� entre 100000 y 250000.
SELECT * FROM AUTOMOVIL;

SELECT * FROM AUTOMOVIL
WHERE COSTO BETWEEN 100000 AND 250000; 

6. Consultar el total de p�lizas generadas.
SELECT * FROM POLIZA;

SELECT COUNT(*) AS TOTAL_POLIZAS 
FROM POLIZA;

--FUNCIONES DE GRUPO   COUNT(*) |  COUNT(COLUMNA)  SUM(COLUMNA) MAX(COLUMNA)  MIN(COLUMNA  AVG(COLUMNA)
--NOTA_ LAS FUNCIONES DE GRUPO IGNORAN LOS VALORES NULL
SELECT * FROM AJUSTADOR;
SELECT SUM(SALARIO) AS NOMINA FROM AJUSTADOR;
SELECT * FROM AUTOMOVIL;
SELECT MAX(COSTO) FROM AUTOMOVIL;
SELECT MIN(COSTO) FROM AUTOMOVIL;


7. Consultar el total de clientes registrados de cada municipio.
SELECT * FROM CLIENTE;

SELECT MUNICIPIO, COUNT(*) AS TOTAL
FROM CLIENTE
GROUP BY MUNICIPIO;

COMMIT;
8. Consultar el nombre completo de los clientes que tienen autom�vil.
SELECT * FROM CLIENTE;
SELECT * FROM CLIENTE_AUTOMOVIL;

SELECT APATERNO, AMATERNO, NOMBRE 
FROM CLIENTE JOIN CLIENTE_AUTOMOVIL ON CLIENTE.ID_CLIENTE = CLIENTE_AUTOMOVIL.ID_CLIENTE;

--B)  ALIAS DE TABLA
SELECT APATERNO, AMATERNO, NOMBRE 
FROM CLIENTE C JOIN CLIENTE_AUTOMOVIL CA ON C.ID_CLIENTE = CA.ID_CLIENTE;

9. Consultar el total de autom�viles que tiene cada cliente.
SELECT * FROM CLIENTE;
SELECT * FROM CLIENTE_AUTOMOVIL;

--A)
SELECT APATERNO, AMATERNO, NOMBRE, COUNT(*) AS TOTAL
FROM CLIENTE C JOIN CLIENTE_AUTOMOVIL CA ON C.ID_CLIENTE = CA.ID_CLIENTE
GROUP BY APATERNO, AMATERNO, NOMBRE;

--B)
SELECT APATERNO ||' ' || AMATERNO || ' ' || NOMBRE AS CLIENTE, COUNT(*) AS TOTAL
FROM CLIENTE C JOIN CLIENTE_AUTOMOVIL CA ON C.ID_CLIENTE = CA.ID_CLIENTE
GROUP BY APATERNO, AMATERNO, NOMBRE;

--10. Consultar el total de pólizas que ha vendido cada empleado.
SELECT AV.*,TMP.TOTAL FROM AGENTE_VENTAS AV,(SELECT ID_VENDEDOR,COUNT(*)AS TOTAL 
FROM POLIZA GROUP BY ID_VENDEDOR)TMP WHERE AV.ID_VENDEDOR = TMP.ID_VENDEDOR;

--11. Consultar el total de pólizas emitidas por cada tipo de seguro.
SELECT TS.*,TMP.TOTAL FROM TIPO_SEGURO TS,(SELECT ID_SEGURO,COUNT(*)AS TOTAL FROM POLIZA GROUP BY ID_SEGURO)TMP
WHERE TS.ID_SEGURO = TMP.ID_SEGURO;

--12. Consultar el nombre de los empleados que no ha vendido pólizas.
SELECT APATERNO,AMATERNO,NOMBRE
FROM AGENTE_VENTAS WHERE ID_VENDEDOR NOT IN(SELECT ID_VENDEDOR FROM POLIZA);

--13. Consultar el nombre de los clientes que no tienen automóvil asignado.
SELECT * FROM CLIENTE WHERE ID_CLIENTE NOT IN (SELECT ID_CLIENTE FROM CLIENTE_AUTOMOVIL);

--14. Consultar los datos generales de las pólizas (datos generales de todas las tablas que se relacionan con la póliza).
SELECT AG.APATERNO || ' ' || AG.AMATERNO || ' ' || AG.NOMBRE AS AGENTE, DESCRIPCION,
CL.APATERNO || ' ' || CL.AMATERNO || ' ' || CL.NOMBRE AS CLIENTE,
AU.*,
P.FOLIO,P.FECHA_E,P.FECHA_I,P.FECHA_F,P.COSTO
FROM AGENTE_VENTAS AG JOIN POLIZA P ON AG.ID_VENDEDOR = P.ID_VENDEDOR
JOIN TIPO_SEGURO TS ON TS.ID_SEGURO = P.ID_SEGURO
JOIN CLIENTE_AUTOMOVIL CA ON CA.ID_CLIENTE = P.ID_CLIENTE AND CA.MATRICULA = P.MATRICULA AND CA.FECHA = P.FECHA
JOIN CLIENTE CL ON CL.ID_CLIENTE = CA.ID_CLIENTE
JOIN AUTOMOVIL AU ON AU.MATRICULA = CA.MATRICULA;

--15. Consultar el tipo de seguro que no se ha vendido.
SELECT * FROM TIPO_SEGURO WHERE ID_SEGURO NOT IN (SELECT ID_SEGURO FROM POLIZA);

--16. Consultar el total de accidentes que haya atendido cada ajustador.
SELECT AJ.*,TMP.NUM_ACCIDENTES FROM AJUSTADOR AJ, (SELECT ID_AJUSTADOR,COUNT(*) AS NUM_ACCIDENTES FROM ACCIDENTE GROUP BY ID_AJUSTADOR)TMP
WHERE AJ.ID_AJUSTRADOR = TMP.ID_AJUSTADOR;
--17. Consultar los datos generales de los vehículos y en caso de que estén asegurados, mostrar los datos generales de las pólizas.
SELECT * FROM CLIENTE;

SELECT AU.*,P.*
FROM AUTOMOVIL AU LEFT OUTER JOIN CLIENTE_AUTOMOVIL CA ON AU.MATRICULA = CA.MATRICULA
               LEFT OUTER JOIN POLIZA P ON CA.MATRICULA = P.MATRICULA;
--SELECT C.*,A.*
--FROM CLIENTE C JOIN CLIENTE_AUTOMOVIL CA ON C.ID_CLIENTE = CA.ID_CLIENTE
--               JOIN AUTOMOVIL A ON A.NUM_SERIE = CA.NUM_SERIE;

--18. Consultar los datos generales de los ajustadores que no han atendido accidentes.
SELECT * FROM AJUSTADOR WHERE ID_AJUSTRADOR NOT IN (SELECT ID_AJUSTRADOR FROM POLIZA);

--19. Consultar el nombre completo de los clientes que no se han accidentado.
SELECT NOMBRE||' '||APATERNO||' '||AMATERNO AS NOMBRE_COMPLETO FROM CLIENTE WHERE ID_CLIENTE NOT IN (SELECT ID_CLIENTE FROM ACCIDENTE);

--20. Consultar los datos generales de los automóviles que más se ha accidentado.
SELECT AU.* FROM AUTOMOVIL AU WHERE AU.MATRICULA IN (SELECT MATRICULA FROM
(SELECT MATRICULA,COUNT(*) AS TOTAL FROM ACCIDENTE GROUP BY MATRICULA)TMP 
WHERE TMP.TOTAL = (SELECT MAX(TOTAL) FROM (SELECT MATRICULA,COUNT(*) AS TOTAL FROM ACCIDENTE GROUP BY MATRICULA)));

--21. Consultar el nombre completo de los clientes que más automóviles tienen.
SELECT * FROM CLIENTE;
SELECT * FROM CLIENTE_AUTOMOVIL;
 
PASO 1: OBTENER EL TOTAL DE AUTOS QUE TIENE CADA CLIENTE

SELECT APATERNO, AMATERNO, NOMBRE, COUNT(*) AS TOTAL
FROM CLIENTE C JOIN CLIENTE_AUTOMOVIL CA ON C.ID_CLIENTE = CA.ID_CLIENTE
GROUP BY APATERNO, AMATERNO, NOMBRE;


PASO 2: OBTENER EL VALOR M�S ALTO DEL CONTEO DEL PASO 1

SELECT MAX(COUNT(*)) AS TOTAL
FROM CLIENTE C JOIN CLIENTE_AUTOMOVIL CA ON C.ID_CLIENTE = CA.ID_CLIENTE
GROUP BY APATERNO, AMATERNO, NOMBRE;


PASO 3: INTEGRAR EN UNA SOLA CONSULTA EL PASO 1 Y EL PASO 2 
(PARA FILTAR LOS DATOS AGRUPADOS) -- HAVING 
;


SELECT APATERNO, AMATERNO, NOMBRE, COUNT(*) AS TOTAL
    FROM CLIENTE C JOIN CLIENTE_AUTOMOVIL CA ON C.ID_CLIENTE = CA.ID_CLIENTE
    GROUP BY APATERNO, AMATERNO, NOMBRE
    HAVING COUNT(*) = 
(
  SELECT MAX(COUNT(*))
  FROM CLIENTE C JOIN CLIENTE_AUTOMOVIL CA ON C.ID_CLIENTE = CA.ID_CLIENTE
  GROUP BY APATERNO, AMATERNO, NOMBRE
);

--22. Consultar el nombre completo de los clientes que han tenido más de 2 seguros.
SELECT ID_CLIENTE, COUNT(*) AS TOTAL FROM POLIZA GROUP BY ID_CLIENTE;
SELECT NOMBRE||' '||APATERNO||' '||AMATERNO AS NOMBRE_COMPLETO FROM CLIENTE WHERE ID_CLIENTE IN 
(SELECT ID_CLIENTE FROM (SELECT ID_CLIENTE, COUNT(*) AS TOTAL FROM POLIZA GROUP BY ID_CLIENTE)TMP WHERE TMP.TOTAL > 2);

--23. Consultar el nombre del agente de ventas que más seguros ha vendido.
SELECT NOMBRE||' '||APATERNO AS NOMBRE FROM AGENTE_VENTAS WHERE ID_VENDEDOR IN
(SELECT ID_VENDEDOR FROM (SELECT ID_VENDEDOR,COUNT(*)AS TOTAL FROM POLIZA GROUP BY ID_VENDEDOR)TMP 
WHERE TMP.TOTAL = (SELECT MAX(TOTAL) FROM (SELECT ID_VENDEDOR,COUNT(*)AS TOTAL FROM POLIZA GROUP BY ID_VENDEDOR)));

--24. Consultar el nombre completo del empleado que menos pólizas ha vendido.
SELECT NOMBRE||' '||APATERNO AS NOMBRE FROM AGENTE_VENTAS WHERE ID_VENDEDOR IN
(SELECT ID_VENDEDOR FROM (SELECT ID_VENDEDOR,COUNT(*)AS TOTAL FROM POLIZA GROUP BY ID_VENDEDOR)TMP 
WHERE TMP.TOTAL = (SELECT MIN(TOTAL) FROM (SELECT ID_VENDEDOR,COUNT(*)AS TOTAL FROM POLIZA GROUP BY ID_VENDEDOR)));

--25. Consultar el tipo de seguro menos vendido.
SELECT * FROM TIPO_SEGURO WHERE ID_SEGURO IN (SELECT ID_SEGURO 
FROM (SELECT ID_SEGURO,COUNT(*)AS TOTAL FROM POLIZA GROUP BY ID_SEGURO)TMP WHERE TMP.TOTAL = (SELECT MIN(TOTAL) 
FROM (SELECT ID_SEGURO,COUNT(*)AS TOTAL FROM POLIZA GROUP BY ID_SEGURO)));
