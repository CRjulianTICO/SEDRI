DROP VIEW vista_alumno;
CREATE VIEW VISTA_ALUMNO AS 
SELECT p.cedula,p.nombre,p.apellido1,p.apellido2,p.sexo,n.pais,g.nombreGrado,ga.annio,p.direccion FROM alumno a,persona p,nacionalidad n, grado g,grado_alumno ga where a.Persona_idPersona = p.idPersona and p.idNacionalidad = n.idNacionalidad and a.idalumno = ga.alumno_idalumno and ga.grado_idgrado = g.idgrado;


CREATE VIEW VISTA_PROFESOR AS 
SELECT CEDULA,NOMBRE,APELLIDO1,APELLIDO2
SEXO,DIRECCION,TELEFONO,EMAIL,PAIS,DISPONIBLE 
FROM PERSONA P, PROFESOR PE, NACIONALIDAD N
WHERE P.idPersona = PE.Persona_idPersona AND P.idNacionalidad = N.idNacionalidad;