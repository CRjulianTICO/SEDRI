DROP VIEW vista_alumno;
CREATE VIEW VISTA_ALUMNO AS 
SELECT p.cedula,p.nombre,p.apellido1,p.apellido2,p.sexo,n.pais,g.nombreGrado,ga.annio,p.direccion 
FROM alumno a,persona p,nacionalidad n, grado g,grado_alumno ga where a.Persona_idPersona = p.idPersona 
and p.idNacionalidad = n.idNacionalidad and a.idalumno = ga.alumno_idalumno and ga.grado_idgrado = g.idgrado;




CREATE TABLE `profesor_grado` (
  `idProfesor` int(11) NOT NULL,
  `idGrado` int(11) NOT NULL,
  `annio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
ALTER TABLE `profesor_grado`
  ADD PRIMARY KEY (`idProfesor`,`idGrado`),
  ADD KEY `fk_grado_p` (`idGrado`);


ALTER TABLE `profesor_grado`
  ADD CONSTRAINT `fk_grado_p` FOREIGN KEY (`idGrado`) REFERENCES `grado` (`idgrado`),
  ADD CONSTRAINT `fk_profesor_p` FOREIGN KEY (`idProfesor`) REFERENCES `profesor` (`idprofesor`);
COMMIT;


CREATE VIEW VISTA_PROFESOR AS 
SELECT CEDULA,NOMBRE,APELLIDO1,APELLIDO2
SEXO,DIRECCION,TELEFONO,EMAIL,PAIS,DISPONIBLE,g.nombreGrado,pg.annio
FROM PERSONA P, PROFESOR PE, NACIONALIDAD N,grado g,profesor_grado pg 
WHERE P.idPersona = PE.Persona_idPersona AND pe.idprofesor = pg.idProfesor AND
g.idgrado = pg.idGrado AND
P.idNacionalidad = N.idNacionalidad;
