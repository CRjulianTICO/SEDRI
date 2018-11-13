-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 12-11-2018 a las 03:52:53
-- Versión del servidor: 10.1.36-MariaDB
-- Versión de PHP: 7.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `escuela`
--
CREATE DATABASE IF NOT EXISTS `escuela` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `escuela`;

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActivaBeca` (IN `VCED` VARCHAR(20))  BEGIN
	SELECT idPersona
    FROM persona
    WHERE cedula = VCED LIMIT 1
    INTO @idP;
    SELECT idAlumno
    FROM alumno
    WHERE Persona_idPersona = @idP
    INTO @idA;
    UPDATE beca
    SET estado = 1
    WHERE idAlumno = @idA;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizaAsistencia` (IN `VJUST` TINYINT, IN `VNOTA` VARCHAR(100), IN `VCED` VARCHAR(20), IN `VFECHA` DATE)  BEGIN
	SELECT idPersona
    FROM persona
    WHERE cedula = VCED LIMIT 1
    INTO @idP;
    SELECT idAlumno
    FROM alumno
    WHERE Persona_idPersona = @idP
    INTO @idA;
   	UPDATE asistencia SET
	AUSENCIA = VJUST,
	NOTA = VNOTA
	WHERE IDALUMNO = @idA and FECHA = VFECHA;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizaBeca` (IN `VDESC` VARCHAR(500), IN `VMON` VARCHAR(40), IN `VCED` VARCHAR(20))  BEGIN
	SELECT idPersona
    FROM persona
    WHERE cedula = VCED LIMIT 1
    INTO @idP;
    SELECT idAlumno
    FROM alumno
    WHERE Persona_idPersona = @idP
    INTO @idA;
    UPDATE beca
    SET descripcion_beca = VDESC,
    monto_beca = VMON
    WHERE idAlumno = @idA;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarEmpleado` (IN `CED` VARCHAR(20), IN `NOM` VARCHAR(35), IN `APE1` VARCHAR(35), IN `APE2` VARCHAR(35), IN `SEX` VARCHAR(20), IN `DIRECC` VARCHAR(50), IN `TEL` VARCHAR(25), IN `NAC` INT, IN `PUE` INT)  BEGIN

 UPDATE persona SET
 NOMBRE = NOM,
 APELLIDO1=APE1,
 APELLIDO2=APE2,
 SEXO=SEX,
 DIRECCION =DIRECC,
 TELEFONO=TEL,
 idNacionalidad=NAC
 WHERE CEDULA = CED LIMIT 1;

 SELECT idPersona FROM persona WHERE CEDULA = CED INTO @id ;

UPDATE empleado SET
idPuesto = PUE
WHERE idPersona = @id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_DesactivaBeca` (IN `VCED` VARCHAR(20))  BEGIN
	SELECT idPersona
    FROM persona
    WHERE cedula = VCED LIMIT 1
    INTO @idP;
    SELECT idAlumno
    FROM alumno
    WHERE Persona_idPersona = @idP
    INTO @idA;
    UPDATE beca
    SET estado = 0
    WHERE idAlumno = @idA;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_desactivarUsuario` (IN `VCED` VARCHAR(100))  NO SQL
BEGIN

UPDATE persona set disponible ='0' where cedula = VCED;

 SELECT idPersona
 FROM persona
 WHERE cedula = VCED LIMIT 1 
 INTO @id;
 
 DELETE FROM usuario where idPersona = @id;
 

        
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertaAlumno` (IN `VCED` VARCHAR(20), IN `VNOM` VARCHAR(40), IN `VAPE1` VARCHAR(40), IN `VAPE2` VARCHAR(40), IN `VSEX` VARCHAR(20), IN `VDIR` VARCHAR(50), IN `VNAC` INT, IN `VNOT` VARCHAR(650), IN `VGRA` INT)  BEGIN
 INSERT INTO persona( cedula, nombre, apellido1, apellido2, sexo, direccion,idNacionalidad,nota_medica)
 VALUES(VCED,VNOM,VAPE1,VAPE2,VSEX,VDIR,VNAC,VNOT);

 SELECT idPersona
 FROM persona
 WHERE cedula = VCED
 INTO @id;

 INSERT INTO alumno(Persona_idPersona)VALUES(@id);

 SELECT idalumno
 FROM alumno
 WHERE persona_idPersona = @id LIMIT 1
 INTO @id_alumno;

 SELECT ciclo
 into @vciclo
 from grado
 where idgrado=VGRA;

SELECT MIN(idmateria), MAX(idmateria)
INTO @min,@max
FROM materia;

WHILE @min <= @max DO
SET @tri =1;
WHILE @tri <= 3 DO
INSERT INTO `nota` (`idnota`, `trabajo_cotidiano`, `asistencia`, `tareas`, `pruebas`) VALUES (NULL, '0.00', '0.00', '0.00', '0.00');

SELECT idnota
into @idNota
FROM nota
ORDER BY idnota
DESC LIMIT 1;

INSERT INTO grado_estudiante_nota(idGrado,idMateria,idNota,idEstudiante,trimestre,aprobado) values (VGRA,@min,@idNota,@id_alumno,@tri,0);
SET @tri = @tri +1;
END WHILE;

SET @min=@min+1;
END WHILE;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertaAsistencia` (IN `VESTADO` TINYINT, IN `VNOTA` VARCHAR(100), IN `VCED` VARCHAR(25), IN `VFECHA` DATE, IN `VIDGR` INT, IN `VID` INT)  BEGIN
    SELECT idPersona
    FROM persona
    WHERE cedula = VCED  COLLATE utf8mb4_unicode_ci
    INTO @id;
    SELECT idProfesor
    from profesor
    WHERE Persona_idPersona = VID
    INTO @idPr;
    SELECT idAlumno
    FROM alumno
    WHERE Persona_idPersona = @id  COLLATE utf8mb4_unicode_ci
    INTO @idA;
    INSERT INTO asistencia(ESTADO,NOTA,IDALUMNO,FECHA,IDGRADO,idProfesor)
	VALUES(VESTADO,VNOTA,@idA,VFECHA,VIDGR,@idPr);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertaBeca` (IN `VCED` VARCHAR(50) COLLATE utf8mb4_unicode_ci, IN `VDES` VARCHAR(500) COLLATE utf8mb4_unicode_ci, IN `VMON` VARCHAR(45) COLLATE utf8mb4_unicode_ci)  BEGIN
    SELECT idPersona
    FROM persona
    WHERE cedula = VCED  COLLATE utf8mb4_unicode_ci
    INTO @id;
    SELECT idAlumno
    FROM alumno
    WHERE Persona_idPersona = @id  COLLATE utf8mb4_unicode_ci
    INTO @idA;
    INSERT INTO BECA(descripcion_beca,monto_beca,idAlumno)
    VALUES(VDES,VMON,@idA);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertaEncargado` (IN `VCED` VARCHAR(45), IN `VNOM` VARCHAR(45), IN `VAP1` VARCHAR(45), IN `VAP2` VARCHAR(45), IN `VSEXO` VARCHAR(45), IN `VDIR` VARCHAR(100), IN `VTEL` VARCHAR(45), IN `VTEL2` VARCHAR(45), IN `VNAC` VARCHAR(45))  BEGIN
 INSERT INTO persona( cedula, nombre, apellido1, apellido2, sexo, direccion,telefono,telefono_secundario,idNacionalidad)
 VALUES(VCED,VNOM,VAP1,VAP2,VSEXO,VDIR,VTEL,VTEL2,VNAC);
 SELECT idPersona
 FROM persona
 WHERE cedula = VCED LIMIT 1
 into @id;


 INSERT INTO encargado(Persona_idPersona)VALUES(@id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertaNotas` (IN `VCED` VARCHAR(45), IN `VIDMAT` VARCHAR(45), IN `VIDGR` INT, IN `VCOT` DECIMAL, IN `VPRU` DECIMAL, IN `VTAREA` DECIMAL, IN `VASIS` DECIMAL, IN `VTRI` INT)  BEGIN

SELECT p.idPersona
FROM persona p
WHERE p.cedula = VCED and p.disponible != 0 LIMIT 1
INTO @idPer;

SELECT a.idalumno
FROM alumno a
WHERE a.Persona_idPersona = @idPer
INTO @idAlumno;

SELECT gan.idNota
FROM grado_estudiante_nota gan
WHERE gan.idGrado = VIDGR AND gan.idMateria = VIDMAT AND gan.idEstudiante = @idAlumno AND gan.trimestre = VTRI
INTO @idNota;

UPDATE nota
SET trabajo_cotidiano = VCOT,
pruebas = VPRU,
tareas = VTAREA,
asistencia = VASIS
WHERE idnota = @idNota;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertaProfesor` (IN `VCED` VARCHAR(45), IN `VNOM` VARCHAR(45), IN `VAP1` VARCHAR(45), IN `VAP2` VARCHAR(45), IN `VSEXO` VARCHAR(20), IN `VDIR` VARCHAR(100), IN `VTEL` VARCHAR(45), IN `VEMAIL` VARCHAR(45), IN `VNAC` INT, IN `VGRADO` INT, IN `VPASS` VARCHAR(80), IN `VMAT` INT, IN `VTIPO` INT)  BEGIN
 INSERT INTO persona( cedula, nombre, apellido1, apellido2, sexo, direccion,telefono,email,idNacionalidad)
 VALUES(VCED,VNOM,VAP1,VAP2,VSEXO,VDIR,VTEL,VEMAIL,VNAC);

 SELECT idPersona
 FROM persona
 WHERE cedula = VCED LIMIT 1
 INTO @id;


 INSERT INTO profesor(Persona_idPersona,tipo)VALUES(@id,VTIPO);


 SELECT idprofesor
 FROM profesor
 WHERE Persona_idPersona = @id LIMIT 1
 INTO @idP;

 INSERT INTO usuario(idPersona,idRol,password,cambio)
 VALUES (@id,1,VPASS,1);

IF VTIPO !=0 THEN
SELECT MIN(idGrado), MAX(idGrado)
INTO @min,@max
FROM grado
WHERE LOWER(nombreGrado) NOT LIKE '%primero%'and LOWER(nombreGrado) NOT LIKE '%1%';
WHILE @min <= @max DO
    INSERT INTO profesor_materia_grado(profesor_idprofesor,materia_idmateria,id_grado)VALUES(@idP,VMAT,@min);
    SET @min=@min+1;
END WHILE;
ELSE
	SELECT MIN(mat.idmateria), MAX(mat.idmateria)
    INTO @minTipo,@maxTipo
    FROM materia mat;

    WHILE @minTipo <= @maxTipo DO
    	SELECT ma.idmateria
        INTO @idMa
        FROM materia ma, tipo_materia ti
        WHERE LOWER(ti.tipo) LIKE '%basica%' AND ma.idTipoMateria = ti.idTipo AND ma.idmateria = @minTipo;
       IF @idMa IS NOT NULL THEN
        INSERT INTO profesor_materia_grado(profesor_idprofesor,materia_idmateria,id_grado)VALUES(@idP,@idMa,VGRADO);
        SET @idMa = NULL;
        END IF;
    	SET @minTipo=@minTipo+1;

    END WHILE;
END IF;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarEmpleado` (IN `CED` VARCHAR(20), IN `NOM` VARCHAR(35), IN `APE1` VARCHAR(35), IN `APE2` VARCHAR(35), IN `SEX` VARCHAR(20), IN `DIRECC` VARCHAR(50), IN `TEL` VARCHAR(25), IN `NAC` INT, IN `PUE` INT)  BEGIN

 INSERT INTO persona (CEDULA,NOMBRE,APELLIDO1,APELLIDO2,SEXO,DIRECCION,TELEFONO,idNacionalidad) VALUES(CED,NOM,APE1,APE2,SEX,DIRECC,TEL,NAC);

 SELECT idPersona FROM persona WHERE CEDULA = CED LIMIT 1 INTO @id ;

 INSERT INTO empleado(idPersona,idPuesto) VALUES(@id,PUE);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Login` (OUT `pass` VARCHAR(150), IN `ced` VARCHAR(25), OUT `id` INT, OUT `rol` VARCHAR(50), OUT `nombre` VARCHAR(50), OUT `ocambio` INT, OUT `ogrupo` VARCHAR(80), OUT `idgrado` INT, OUT `oemail` VARCHAR(60), OUT `ogrado` VARCHAR(50), OUT `idtipo` INT, OUT `tipoPro` INT)  BEGIN
select u.password,p.idPersona, r.tiporol ,CONCAT(p.nombre,' ',CONCAT(p.apellido1,' ',p.apellido2)) as nombre,u.cambio ,concat(gr.nombreGrado,' ',gr.annio) as grado,gr.idGrado,p.email,gr.nombreGrado,ti.idTipo,pro.tipo
into pass,id,rol,nombre,ocambio,ogrupo,idgrado,oemail,ogrado,idtipo,tipoPro
from usuario u, persona p , rol r ,profesor_materia_grado pmg,profesor pro,grado gr,tipo_materia ti, materia ma
where gr.idGrado = pmg.id_grado and pro.idProfesor = pmg.profesor_idprofesor and  u.idRol = r.IDROL and p.idPersona = u.idPersona and pro.Persona_idPersona = p.idPersona and p.cedula=ced and pmg.materia_idmateria = ma.idmateria and ma.idTipoMateria = ti.idTipo LIMIT 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ModificarProfesor` (IN `VCED` VARCHAR(40), IN `VNOM` VARCHAR(40), IN `VAP1` VARCHAR(40), IN `VAP2` VARCHAR(40), IN `VEXO` VARCHAR(24), IN `VDIR` VARCHAR(100), IN `VTEL` VARCHAR(50), IN `VEMAIL` VARCHAR(50), IN `VNAC` INT, IN `VANNIO` INT, IN `VGRADO` INT)  NO SQL
BEGIN
UPDATE persona SET
nombre=VNOM,
apellido1=VAP1,
apellido2=VAP2,
sexo=VSEXO,
direccion=VDIR,
telefono=VTEL,
email=VEMAIL,
idNacionalidad=VNAC
WHERE cedula = VCED LIMIT 1;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno`
--

CREATE TABLE `alumno` (
  `idalumno` int(11) NOT NULL,
  `Persona_idPersona` int(11) NOT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=630 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `alumno`
--

INSERT INTO `alumno` (`idalumno`, `Persona_idPersona`) VALUES
(1, 11),
(2, 12),
(3, 13),
(4, 15),
(5, 80),
(6, 81),
(7, 82),
(8, 133),
(9, 134),
(10, 136),
(11, 138),
(12, 140),
(13, 146),
(14, 147),
(15, 149),
(16, 150),
(27, 174),
(28, 175),
(29, 177),
(30, 179),
(31, 189),
(32, 193),
(33, 195),
(34, 196),
(35, 198),
(36, 200),
(37, 202),
(38, 203);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno_encargado`
--

CREATE TABLE `alumno_encargado` (
  `ID_ALUMNO` int(11) NOT NULL,
  `ID_ENCARGADO` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `alumno_encargado`
--

INSERT INTO `alumno_encargado` (`ID_ALUMNO`, `ID_ENCARGADO`) VALUES
(16, 2),
(16, 3),
(28, 1),
(29, 1),
(34, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia`
--

CREATE TABLE `asistencia` (
  `IDASISTENCIA` int(11) NOT NULL,
  `ESTADO` tinyint(1) DEFAULT NULL,
  `NOTA` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `IDALUMNO` int(11) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  `IDGRADO` int(11) NOT NULL,
  `AUSENCIA` tinyint(1) DEFAULT NULL,
  `idProfesor` int(11) DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=512 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `asistencia`
--

INSERT INTO `asistencia` (`IDASISTENCIA`, `ESTADO`, `NOTA`, `IDALUMNO`, `FECHA`, `IDGRADO`, `AUSENCIA`, `idProfesor`) VALUES
(48, 1, 'No se ingresaron comentarios.', 5, '2018-10-21', 1, NULL, NULL),
(49, 0, '1', 3, '2018-10-21', 1, NULL, NULL),
(50, 1, 'No se ingresaron comentarios.', 6, '2018-10-21', 1, NULL, NULL),
(51, 0, '5', 7, '2018-10-21', 1, NULL, NULL),
(52, 0, '3', 1, '2018-10-21', 1, NULL, NULL),
(58, 1, 'No se ingresaron comentarios.', 7, '2018-10-22', 1, NULL, NULL),
(59, 1, 'No se ingresaron comentarios.', 6, '2018-10-22', 1, NULL, NULL),
(60, 1, 'No se ingresaron comentarios.', 5, '2018-10-22', 1, NULL, NULL),
(61, 1, 'No se ingresaron comentarios.', 1, '2018-10-22', 1, NULL, NULL),
(62, 1, 'No se ingresaron comentarios.', 3, '2018-10-22', 1, NULL, NULL),
(63, 1, 'No se ingresaron comentarios.', 1, '2018-10-22', 1, NULL, NULL),
(64, 1, 'No se ingresaron comentarios.', 3, '2018-10-22', 1, NULL, NULL),
(65, 0, 'Porque es gay', 5, '2018-10-22', 1, NULL, NULL),
(66, 0, 'Porque es muy guapo', 6, '2018-10-22', 1, NULL, NULL),
(67, 1, 'No se ingresaron comentarios.', 7, '2018-10-22', 1, NULL, NULL),
(68, 0, 'No se ingresaron comentarios.', 3, '2018-10-22', 1, NULL, NULL),
(69, 1, 'No se ingresaron comentarios.', 6, '2018-10-22', 1, NULL, NULL),
(70, 0, 'No se ingresaron comentarios.', 5, '2018-10-22', 1, NULL, NULL),
(71, 1, 'No se ingresaron comentarios.', 7, '2018-10-22', 1, NULL, NULL),
(72, 1, 'No se ingresaron comentarios.', 1, '2018-10-22', 1, NULL, NULL),
(155, 1, 'No se ingresaron comentarios.', 1, '2018-10-26', 1, NULL, NULL),
(156, 0, 'Por fea', 3, '2018-10-26', 1, 1, NULL),
(157, 1, 'No se ingresaron comentarios.', 6, '2018-10-26', 1, NULL, NULL),
(158, 0, 'Enfermo y playo', 5, '2018-10-26', 1, 1, NULL),
(159, 0, 'No se ingresaron comentarios.', 7, '2018-10-26', 1, 0, NULL),
(160, 1, 'No se ingresaron comentarios.', 1, '2018-10-27', 1, NULL, NULL),
(161, 1, 'No se ingresaron comentarios.', 3, '2018-10-27', 1, NULL, NULL),
(162, 1, 'No se ingresaron comentarios.', 6, '2018-10-27', 1, NULL, NULL),
(163, 1, 'No se ingresaron comentarios.', 7, '2018-10-27', 1, NULL, NULL),
(164, 1, 'No se ingresaron comentarios.', 5, '2018-10-27', 1, NULL, NULL),
(165, 0, 'No se ingresaron comentarios.', 1, '2018-10-28', 1, 1, NULL),
(166, 0, 'No quizo venir', 3, '2018-10-28', 1, 1, NULL),
(167, 1, 'No se ingresaron comentarios.', 6, '2018-10-28', 1, NULL, NULL),
(168, 0, 'No se ingresaron comentarios.', 5, '2018-10-28', 1, 1, NULL),
(169, 0, 'No se ingresaron comentarios.', 7, '2018-10-28', 1, 0, NULL);

--
-- Disparadores `asistencia`
--
DELIMITER $$
CREATE TRIGGER `trgg_ausencia` BEFORE INSERT ON `asistencia` FOR EACH ROW BEGIN
           IF NEW.ESTADO = 0 THEN
               SET NEW.AUSENCIA = 0;
           END IF;
       END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `beca`
--

CREATE TABLE `beca` (
  `idbeca` int(11) NOT NULL,
  `descripcion_beca` varchar(500) CHARACTER SET utf8 NOT NULL,
  `monto_beca` varchar(45) CHARACTER SET utf8 NOT NULL,
  `idAlumno` int(11) NOT NULL,
  `estado` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `beca`
--

INSERT INTO `beca` (`idbeca`, `descripcion_beca`, `monto_beca`, `idAlumno`, `estado`) VALUES
(1, 'Motivo de la beca es privado y no puede ser revelado', '55000', 2, 1),
(2, 'Motivo personal', '35000', 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `director`
--

CREATE TABLE `director` (
  `idDirector` int(11) NOT NULL,
  `Persona_idPersona` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `idEmpleado` int(11) NOT NULL,
  `idPersona` int(11) NOT NULL,
  `idPuesto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`idEmpleado`, `idPersona`, `idPuesto`) VALUES
(1, 10, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `encargado`
--

CREATE TABLE `encargado` (
  `idencargado` int(11) NOT NULL,
  `Persona_idPersona` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `encargado`
--

INSERT INTO `encargado` (`idencargado`, `Persona_idPersona`) VALUES
(1, 184),
(2, 185),
(3, 191),
(4, 204);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grado`
--

CREATE TABLE `grado` (
  `idgrado` int(11) NOT NULL,
  `nombreGrado` varchar(45) CHARACTER SET utf8 NOT NULL,
  `annio` int(11) NOT NULL,
  `ciclo` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB AVG_ROW_LENGTH=1820 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `grado`
--

INSERT INTO `grado` (`idgrado`, `nombreGrado`, `annio`, `ciclo`) VALUES
(1, 'Primero', 2018, 3),
(2, 'Segundo', 2018, 0),
(3, 'Tercero', 2018, 1),
(4, 'Cuarto', 2018, 1),
(5, 'Quinto', 2018, 0),
(6, 'Sexto', 2018, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grado_estudiante_nota`
--

CREATE TABLE `grado_estudiante_nota` (
  `idGrado` int(11) NOT NULL,
  `idMateria` int(11) NOT NULL,
  `idNota` int(11) NOT NULL,
  `idEstudiante` int(11) NOT NULL,
  `trimestre` int(11) DEFAULT NULL,
  `aprobado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `grado_estudiante_nota`
--

INSERT INTO `grado_estudiante_nota` (`idGrado`, `idMateria`, `idNota`, `idEstudiante`, `trimestre`, `aprobado`) VALUES
(1, 5, 2, 8, 1, 0),
(1, 5, 9, 9, 1, 0),
(1, 5, 16, 10, 1, 0),
(1, 5, 23, 11, 1, 0),
(1, 5, 30, 12, 1, 0),
(1, 6, 3, 8, 1, 0),
(1, 6, 10, 9, 1, 0),
(1, 6, 17, 10, 1, 0),
(1, 6, 24, 11, 1, 0),
(1, 6, 31, 12, 1, 0),
(1, 7, 4, 8, 1, 0),
(1, 7, 11, 9, 1, 0),
(1, 7, 18, 10, 1, 0),
(1, 7, 25, 11, 1, 0),
(1, 7, 32, 12, 1, 0),
(1, 8, 5, 8, 1, 0),
(1, 8, 12, 9, 1, 0),
(1, 8, 19, 10, 1, 0),
(1, 8, 26, 11, 1, 0),
(1, 8, 33, 12, 1, 0),
(1, 9, 6, 8, 1, 0),
(1, 9, 13, 9, 1, 0),
(1, 9, 20, 10, 1, 0),
(1, 9, 27, 11, 1, 0),
(1, 9, 34, 12, 1, 0),
(1, 10, 7, 8, 1, 0),
(1, 10, 14, 9, 1, 0),
(1, 10, 21, 10, 1, 0),
(1, 10, 28, 11, 1, 0),
(1, 10, 35, 12, 1, 0),
(1, 11, 8, 8, 1, 0),
(1, 11, 15, 9, 1, 0),
(1, 11, 22, 10, 1, 0),
(1, 11, 29, 11, 1, 0),
(1, 11, 36, 12, 1, 0),
(2, 5, 37, 13, 1, 0),
(2, 6, 38, 13, 1, 0),
(2, 7, 39, 13, 1, 0),
(2, 8, 40, 13, 1, 0),
(2, 9, 41, 13, 1, 0),
(2, 10, 42, 13, 1, 0),
(2, 11, 43, 13, 1, 0),
(3, 5, 44, 14, 1, 0),
(3, 6, 45, 14, 1, 0),
(3, 7, 46, 14, 1, 0),
(3, 8, 47, 14, 1, 0),
(3, 9, 48, 14, 1, 0),
(3, 10, 49, 14, 1, 0),
(3, 11, 50, 14, 1, 0),
(4, 5, 389, 31, 1, 0),
(4, 5, 390, 31, 2, 0),
(4, 5, 391, 31, 3, 0),
(4, 6, 392, 31, 1, 0),
(4, 6, 393, 31, 2, 0),
(4, 6, 394, 31, 3, 0),
(4, 7, 395, 31, 1, 0),
(4, 7, 396, 31, 2, 0),
(4, 7, 397, 31, 3, 0),
(4, 8, 398, 31, 1, 0),
(4, 8, 399, 31, 2, 0),
(4, 8, 400, 31, 3, 0),
(4, 9, 401, 31, 1, 0),
(4, 9, 402, 31, 2, 0),
(4, 9, 403, 31, 3, 0),
(4, 10, 404, 31, 1, 0),
(4, 10, 405, 31, 2, 0),
(4, 10, 406, 31, 3, 0),
(4, 11, 407, 31, 1, 0),
(4, 11, 408, 31, 2, 0),
(4, 11, 409, 31, 3, 0),
(5, 5, 51, 15, 1, 0),
(5, 5, 58, 16, 1, 0),
(5, 5, 305, 27, 1, 0),
(5, 5, 306, 27, 2, 0),
(5, 5, 307, 27, 3, 0),
(5, 5, 326, 28, 1, 0),
(5, 5, 327, 28, 2, 0),
(5, 5, 328, 28, 3, 0),
(5, 5, 347, 29, 1, 0),
(5, 5, 348, 29, 2, 0),
(5, 5, 349, 29, 3, 0),
(5, 5, 368, 30, 1, 0),
(5, 5, 369, 30, 2, 0),
(5, 5, 370, 30, 3, 0),
(5, 5, 410, 32, 1, 0),
(5, 5, 411, 32, 2, 0),
(5, 5, 412, 32, 3, 0),
(5, 5, 431, 33, 1, 0),
(5, 5, 432, 33, 2, 0),
(5, 5, 433, 33, 3, 0),
(5, 5, 452, 34, 1, 0),
(5, 5, 453, 34, 2, 0),
(5, 5, 454, 34, 3, 0),
(5, 5, 473, 35, 1, 0),
(5, 5, 474, 35, 2, 0),
(5, 5, 475, 35, 3, 0),
(5, 5, 494, 36, 1, 0),
(5, 5, 495, 36, 2, 0),
(5, 5, 496, 36, 3, 0),
(5, 5, 515, 37, 1, 0),
(5, 5, 516, 37, 2, 0),
(5, 5, 517, 37, 3, 0),
(5, 5, 536, 38, 1, 0),
(5, 5, 537, 38, 2, 0),
(5, 5, 538, 38, 3, 0),
(5, 6, 52, 15, 1, 0),
(5, 6, 59, 16, 1, 0),
(5, 6, 308, 27, 1, 0),
(5, 6, 309, 27, 2, 0),
(5, 6, 310, 27, 3, 0),
(5, 6, 329, 28, 1, 0),
(5, 6, 330, 28, 2, 0),
(5, 6, 331, 28, 3, 0),
(5, 6, 350, 29, 1, 0),
(5, 6, 351, 29, 2, 0),
(5, 6, 352, 29, 3, 0),
(5, 6, 371, 30, 1, 0),
(5, 6, 372, 30, 2, 0),
(5, 6, 373, 30, 3, 0),
(5, 6, 413, 32, 1, 0),
(5, 6, 414, 32, 2, 0),
(5, 6, 415, 32, 3, 0),
(5, 6, 434, 33, 1, 0),
(5, 6, 435, 33, 2, 0),
(5, 6, 436, 33, 3, 0),
(5, 6, 455, 34, 1, 0),
(5, 6, 456, 34, 2, 0),
(5, 6, 457, 34, 3, 0),
(5, 6, 476, 35, 1, 0),
(5, 6, 477, 35, 2, 0),
(5, 6, 478, 35, 3, 0),
(5, 6, 497, 36, 1, 0),
(5, 6, 498, 36, 2, 0),
(5, 6, 499, 36, 3, 0),
(5, 6, 518, 37, 1, 0),
(5, 6, 519, 37, 2, 0),
(5, 6, 520, 37, 3, 0),
(5, 6, 539, 38, 1, 0),
(5, 6, 540, 38, 2, 0),
(5, 6, 541, 38, 3, 0),
(5, 7, 53, 15, 1, 0),
(5, 7, 60, 16, 1, 0),
(5, 7, 311, 27, 1, 0),
(5, 7, 312, 27, 2, 0),
(5, 7, 313, 27, 3, 0),
(5, 7, 332, 28, 1, 0),
(5, 7, 333, 28, 2, 0),
(5, 7, 334, 28, 3, 0),
(5, 7, 353, 29, 1, 0),
(5, 7, 354, 29, 2, 0),
(5, 7, 355, 29, 3, 0),
(5, 7, 374, 30, 1, 0),
(5, 7, 375, 30, 2, 0),
(5, 7, 376, 30, 3, 0),
(5, 7, 416, 32, 1, 0),
(5, 7, 417, 32, 2, 0),
(5, 7, 418, 32, 3, 0),
(5, 7, 437, 33, 1, 0),
(5, 7, 438, 33, 2, 0),
(5, 7, 439, 33, 3, 0),
(5, 7, 458, 34, 1, 0),
(5, 7, 459, 34, 2, 0),
(5, 7, 460, 34, 3, 0),
(5, 7, 479, 35, 1, 0),
(5, 7, 480, 35, 2, 0),
(5, 7, 481, 35, 3, 0),
(5, 7, 500, 36, 1, 0),
(5, 7, 501, 36, 2, 0),
(5, 7, 502, 36, 3, 0),
(5, 7, 521, 37, 1, 0),
(5, 7, 522, 37, 2, 0),
(5, 7, 523, 37, 3, 0),
(5, 7, 542, 38, 1, 0),
(5, 7, 543, 38, 2, 0),
(5, 7, 544, 38, 3, 0),
(5, 8, 54, 15, 1, 0),
(5, 8, 61, 16, 1, 0),
(5, 8, 314, 27, 1, 0),
(5, 8, 315, 27, 2, 0),
(5, 8, 316, 27, 3, 0),
(5, 8, 335, 28, 1, 0),
(5, 8, 336, 28, 2, 0),
(5, 8, 337, 28, 3, 0),
(5, 8, 356, 29, 1, 0),
(5, 8, 357, 29, 2, 0),
(5, 8, 358, 29, 3, 0),
(5, 8, 377, 30, 1, 0),
(5, 8, 378, 30, 2, 0),
(5, 8, 379, 30, 3, 0),
(5, 8, 419, 32, 1, 0),
(5, 8, 420, 32, 2, 0),
(5, 8, 421, 32, 3, 0),
(5, 8, 440, 33, 1, 0),
(5, 8, 441, 33, 2, 0),
(5, 8, 442, 33, 3, 0),
(5, 8, 461, 34, 1, 0),
(5, 8, 462, 34, 2, 0),
(5, 8, 463, 34, 3, 0),
(5, 8, 482, 35, 1, 0),
(5, 8, 483, 35, 2, 0),
(5, 8, 484, 35, 3, 0),
(5, 8, 503, 36, 1, 0),
(5, 8, 504, 36, 2, 0),
(5, 8, 505, 36, 3, 0),
(5, 8, 524, 37, 1, 0),
(5, 8, 525, 37, 2, 0),
(5, 8, 526, 37, 3, 0),
(5, 8, 545, 38, 1, 0),
(5, 8, 546, 38, 2, 0),
(5, 8, 547, 38, 3, 0),
(5, 9, 55, 15, 1, 0),
(5, 9, 62, 16, 1, 0),
(5, 9, 317, 27, 1, 0),
(5, 9, 318, 27, 2, 0),
(5, 9, 319, 27, 3, 0),
(5, 9, 338, 28, 1, 0),
(5, 9, 339, 28, 2, 0),
(5, 9, 340, 28, 3, 0),
(5, 9, 359, 29, 1, 0),
(5, 9, 360, 29, 2, 0),
(5, 9, 361, 29, 3, 0),
(5, 9, 380, 30, 1, 0),
(5, 9, 381, 30, 2, 0),
(5, 9, 382, 30, 3, 0),
(5, 9, 422, 32, 1, 0),
(5, 9, 423, 32, 2, 0),
(5, 9, 424, 32, 3, 0),
(5, 9, 443, 33, 1, 0),
(5, 9, 444, 33, 2, 0),
(5, 9, 445, 33, 3, 0),
(5, 9, 464, 34, 1, 0),
(5, 9, 465, 34, 2, 0),
(5, 9, 466, 34, 3, 0),
(5, 9, 485, 35, 1, 0),
(5, 9, 486, 35, 2, 0),
(5, 9, 487, 35, 3, 0),
(5, 9, 506, 36, 1, 0),
(5, 9, 507, 36, 2, 0),
(5, 9, 508, 36, 3, 0),
(5, 9, 527, 37, 1, 0),
(5, 9, 528, 37, 2, 0),
(5, 9, 529, 37, 3, 0),
(5, 9, 548, 38, 1, 0),
(5, 9, 549, 38, 2, 0),
(5, 9, 550, 38, 3, 0),
(5, 10, 56, 15, 1, 0),
(5, 10, 63, 16, 1, 0),
(5, 10, 320, 27, 1, 0),
(5, 10, 321, 27, 2, 0),
(5, 10, 322, 27, 3, 0),
(5, 10, 341, 28, 1, 0),
(5, 10, 342, 28, 2, 0),
(5, 10, 343, 28, 3, 0),
(5, 10, 362, 29, 1, 0),
(5, 10, 363, 29, 2, 0),
(5, 10, 364, 29, 3, 0),
(5, 10, 383, 30, 1, 0),
(5, 10, 384, 30, 2, 0),
(5, 10, 385, 30, 3, 0),
(5, 10, 425, 32, 1, 0),
(5, 10, 426, 32, 2, 0),
(5, 10, 427, 32, 3, 0),
(5, 10, 446, 33, 1, 0),
(5, 10, 447, 33, 2, 0),
(5, 10, 448, 33, 3, 0),
(5, 10, 467, 34, 1, 0),
(5, 10, 468, 34, 2, 0),
(5, 10, 469, 34, 3, 0),
(5, 10, 488, 35, 1, 0),
(5, 10, 489, 35, 2, 0),
(5, 10, 490, 35, 3, 0),
(5, 10, 509, 36, 1, 0),
(5, 10, 510, 36, 2, 0),
(5, 10, 511, 36, 3, 0),
(5, 10, 530, 37, 1, 0),
(5, 10, 531, 37, 2, 0),
(5, 10, 532, 37, 3, 0),
(5, 10, 551, 38, 1, 0),
(5, 10, 552, 38, 2, 0),
(5, 10, 553, 38, 3, 0),
(5, 11, 57, 15, 1, 0),
(5, 11, 64, 16, 1, 0),
(5, 11, 323, 27, 1, 0),
(5, 11, 324, 27, 2, 0),
(5, 11, 325, 27, 3, 0),
(5, 11, 344, 28, 1, 0),
(5, 11, 345, 28, 2, 0),
(5, 11, 346, 28, 3, 0),
(5, 11, 365, 29, 1, 0),
(5, 11, 366, 29, 2, 0),
(5, 11, 367, 29, 3, 0),
(5, 11, 386, 30, 1, 0),
(5, 11, 387, 30, 2, 0),
(5, 11, 388, 30, 3, 0),
(5, 11, 428, 32, 1, 0),
(5, 11, 429, 32, 2, 0),
(5, 11, 430, 32, 3, 0),
(5, 11, 449, 33, 1, 0),
(5, 11, 450, 33, 2, 0),
(5, 11, 451, 33, 3, 0),
(5, 11, 470, 34, 1, 0),
(5, 11, 471, 34, 2, 0),
(5, 11, 472, 34, 3, 0),
(5, 11, 491, 35, 1, 0),
(5, 11, 492, 35, 2, 0),
(5, 11, 493, 35, 3, 0),
(5, 11, 512, 36, 1, 0),
(5, 11, 513, 36, 2, 0),
(5, 11, 514, 36, 3, 0),
(5, 11, 533, 37, 1, 0),
(5, 11, 534, 37, 2, 0),
(5, 11, 535, 37, 3, 0),
(5, 11, 554, 38, 1, 0),
(5, 11, 555, 38, 2, 0),
(5, 11, 556, 38, 3, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historico_usuarios`
--

CREATE TABLE `historico_usuarios` (
  `idHistorico` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pass` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historico_usuarios`
--

INSERT INTO `historico_usuarios` (`idHistorico`, `idUsuario`, `email`, `pass`, `fecha`) VALUES
(1, 40, 'osoto@gmail.com', '123', '2018-11-09'),
(2, 41, 'oscarsoto040797@gmail.com', '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', '2018-11-10'),
(3, 41, 'oscarsoto040797@gmail.com', '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMn', '2018-11-10'),
(4, 41, 'oscarsoto040797@gmail.com', '$2y$09$6xz5BYSFzFgdMVW.fORJeu3TM6G4vsAg6nGeFi10yiSvimCpk6GGq', '2018-11-10'),
(5, 41, 'oscarsoto040797@gmail.com', '$2y$09$FevSbjbrNDF/BJwH88i9neXSbgSwyvaHXJ9S9IuqhTK1J519qey6O', '2018-11-10'),
(6, 41, 'oscarsoto040797@gmail.com', '$2y$09$ccL9oKrlm2D9.QgGyfPbiOckjaDzcS.rkugkLl8nk8rHLAnYCCrBO', '2018-11-10'),
(7, 41, 'oscarsoto040797@gmail.com', '$2y$09$OhDt/gDghRt0hAFjgTKwuurEx3uWhll3F/SavO6Wx5VyLuiGUZtTy', '2018-11-10'),
(8, 41, 'oscarsoto040797@gmail.com', '$2y$09$tgzzlGdLJZELTYU1lwzfV.FTMkc459HO.MRwO5UVPsRjMejhtckaS', '2018-11-10'),
(9, 41, 'oscarsoto040797@gmail.com', '$2y$09$5R7xpLY/Beu71VipmZFs7.eFijD30zEx4XJCbQ6SCaqppdE4BYabm', '2018-11-10'),
(10, 41, 'oscarsoto040797@gmail.com', '$2y$09$luizeMfMr/67CVM5obXaV.TL5WuGaa3qrbmU6eueR5MuUbDGPqP/2', '2018-11-10'),
(11, 45, 'oscarsoto040797@gmail.com', '$2y$09$3.qUDCGulnpjBy7CCoTzou2WN07QDQyFJTUSIAX6.hgRqeJIv/WkC', '2018-11-12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materia`
--

CREATE TABLE `materia` (
  `idmateria` int(11) NOT NULL,
  `nombre` varchar(45) CHARACTER SET latin1 NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `idTipoMateria` int(11) DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=2048 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `materia`
--

INSERT INTO `materia` (`idmateria`, `nombre`, `estado`, `idTipoMateria`) VALUES
(5, 'Ingles', 1, 2),
(6, 'Español', 1, 1),
(7, 'Ciencias', 1, 1),
(8, 'Matematicas', 1, 1),
(9, 'Religion', 1, 3),
(10, 'Educacion Musical', 1, 4),
(11, 'Estudios Sociales', 1, 1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `mostrar_encargado`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `mostrar_encargado` (
`cedula_e` varchar(45)
,`cedula` varchar(45)
,`nombre` varchar(137)
,`telefono` varchar(45)
,`telefono_secundario` varchar(45)
,`direccion` varchar(100)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nacionalidad`
--

CREATE TABLE `nacionalidad` (
  `idNacionalidad` int(11) NOT NULL,
  `pais` varchar(45) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `nacionalidad`
--

INSERT INTO `nacionalidad` (`idNacionalidad`, `pais`) VALUES
(1, 'Costa Rica'),
(2, 'Nicaragua');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nota`
--

CREATE TABLE `nota` (
  `idnota` int(11) NOT NULL,
  `trabajo_cotidiano` decimal(8,2) DEFAULT '0.00',
  `asistencia` decimal(8,2) DEFAULT '0.00',
  `tareas` decimal(8,2) DEFAULT '0.00',
  `pruebas` decimal(8,2) DEFAULT '0.00',
  `total` decimal(8,2) DEFAULT '0.00'
) ENGINE=InnoDB AVG_ROW_LENGTH=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `nota`
--

INSERT INTO `nota` (`idnota`, `trabajo_cotidiano`, `asistencia`, `tareas`, `pruebas`, `total`) VALUES
(1, '0.00', '0.00', '0.00', '0.00', '0.00'),
(2, '0.00', '0.00', '0.00', '0.00', '0.00'),
(3, '0.00', '0.00', '0.00', '0.00', '0.00'),
(4, '0.00', '0.00', '0.00', '0.00', '0.00'),
(5, '0.00', '0.00', '0.00', '0.00', '0.00'),
(6, '0.00', '0.00', '0.00', '0.00', '0.00'),
(7, '0.00', '0.00', '0.00', '0.00', '0.00'),
(8, '0.00', '0.00', '0.00', '0.00', '0.00'),
(9, '0.00', '0.00', '0.00', '0.00', '0.00'),
(10, '0.00', '0.00', '0.00', '0.00', '0.00'),
(11, '0.00', '0.00', '0.00', '0.00', '0.00'),
(12, '0.00', '0.00', '0.00', '0.00', '0.00'),
(13, '0.00', '0.00', '0.00', '0.00', '0.00'),
(14, '0.00', '0.00', '0.00', '0.00', '0.00'),
(15, '0.00', '0.00', '0.00', '0.00', '0.00'),
(16, '0.00', '0.00', '0.00', '0.00', '0.00'),
(17, '0.00', '0.00', '0.00', '0.00', '0.00'),
(18, '0.00', '0.00', '0.00', '0.00', '0.00'),
(19, '0.00', '0.00', '0.00', '0.00', '0.00'),
(20, '0.00', '0.00', '0.00', '0.00', '0.00'),
(21, '0.00', '0.00', '0.00', '0.00', '0.00'),
(22, '0.00', '0.00', '0.00', '0.00', '0.00'),
(23, '0.00', '0.00', '0.00', '0.00', '0.00'),
(24, '0.00', '0.00', '0.00', '0.00', '0.00'),
(25, '0.00', '0.00', '0.00', '0.00', '0.00'),
(26, '0.00', '0.00', '0.00', '0.00', '0.00'),
(27, '0.00', '0.00', '0.00', '0.00', '0.00'),
(28, '0.00', '0.00', '0.00', '0.00', '0.00'),
(29, '0.00', '0.00', '0.00', '0.00', '0.00'),
(30, '0.00', '0.00', '0.00', '0.00', '0.00'),
(31, '0.00', '0.00', '0.00', '0.00', '0.00'),
(32, '0.00', '0.00', '0.00', '0.00', '0.00'),
(33, '0.00', '0.00', '0.00', '0.00', '0.00'),
(34, '0.00', '0.00', '0.00', '0.00', '0.00'),
(35, '0.00', '0.00', '0.00', '0.00', '0.00'),
(36, '0.00', '0.00', '0.00', '0.00', '0.00'),
(37, '0.00', '0.00', '0.00', '0.00', '0.00'),
(38, '0.00', '0.00', '0.00', '0.00', '0.00'),
(39, '0.00', '0.00', '0.00', '0.00', '0.00'),
(40, '0.00', '0.00', '0.00', '0.00', '0.00'),
(41, '0.00', '0.00', '0.00', '0.00', '0.00'),
(42, '0.00', '0.00', '0.00', '0.00', '0.00'),
(43, '0.00', '0.00', '0.00', '0.00', '0.00'),
(44, '0.00', '0.00', '0.00', '0.00', '0.00'),
(45, '0.00', '0.00', '0.00', '0.00', '0.00'),
(46, '0.00', '0.00', '0.00', '0.00', '0.00'),
(47, '0.00', '0.00', '0.00', '0.00', '0.00'),
(48, '0.00', '0.00', '0.00', '0.00', '0.00'),
(49, '0.00', '0.00', '0.00', '0.00', '0.00'),
(50, '0.00', '0.00', '0.00', '0.00', '0.00'),
(51, '0.00', '0.00', '0.00', '0.00', '0.00'),
(52, '6.00', '0.00', '0.00', '0.00', '0.00'),
(53, '0.00', '0.00', '0.00', '0.00', '0.00'),
(54, '0.00', '0.00', '0.00', '0.00', '0.00'),
(55, '0.00', '0.00', '0.00', '0.00', '0.00'),
(56, '0.00', '0.00', '0.00', '0.00', '0.00'),
(57, '0.00', '0.00', '0.00', '0.00', '0.00'),
(58, '0.00', '0.00', '0.00', '0.00', '0.00'),
(59, '5.00', '0.00', '0.00', '0.00', '0.00'),
(60, '0.00', '0.00', '0.00', '0.00', '0.00'),
(61, '0.00', '0.00', '0.00', '0.00', '0.00'),
(62, '5.00', '5.00', '1.00', '15.00', '0.00'),
(63, '0.00', '0.00', '0.00', '0.00', '0.00'),
(64, '0.00', '0.00', '0.00', '0.00', '0.00'),
(305, '0.00', '0.00', '0.00', '0.00', '0.00'),
(306, '0.00', '0.00', '0.00', '0.00', '0.00'),
(307, '0.00', '0.00', '0.00', '0.00', '0.00'),
(308, '10.00', '0.00', '0.00', '0.00', '0.00'),
(309, '0.00', '0.00', '0.00', '0.00', '0.00'),
(310, '0.00', '0.00', '0.00', '0.00', '0.00'),
(311, '0.00', '0.00', '0.00', '0.00', '0.00'),
(312, '0.00', '0.00', '0.00', '0.00', '0.00'),
(313, '0.00', '0.00', '0.00', '0.00', '0.00'),
(314, '0.00', '0.00', '0.00', '0.00', '0.00'),
(315, '0.00', '0.00', '0.00', '0.00', '0.00'),
(316, '0.00', '0.00', '0.00', '0.00', '0.00'),
(317, '0.00', '0.00', '0.00', '0.00', '0.00'),
(318, '0.00', '0.00', '0.00', '0.00', '0.00'),
(319, '0.00', '0.00', '0.00', '0.00', '0.00'),
(320, '0.00', '0.00', '0.00', '0.00', '0.00'),
(321, '0.00', '0.00', '0.00', '0.00', '0.00'),
(322, '0.00', '0.00', '0.00', '0.00', '0.00'),
(323, '0.00', '0.00', '0.00', '0.00', '0.00'),
(324, '0.00', '0.00', '0.00', '0.00', '0.00'),
(325, '0.00', '0.00', '0.00', '0.00', '0.00'),
(326, '0.00', '0.00', '0.00', '0.00', '0.00'),
(327, '0.00', '0.00', '0.00', '0.00', '0.00'),
(328, '0.00', '0.00', '0.00', '0.00', '0.00'),
(329, '7.00', '0.00', '0.00', '0.00', '0.00'),
(330, '0.00', '0.00', '0.00', '0.00', '0.00'),
(331, '0.00', '0.00', '0.00', '0.00', '0.00'),
(332, '0.00', '0.00', '0.00', '0.00', '0.00'),
(333, '0.00', '0.00', '0.00', '0.00', '0.00'),
(334, '0.00', '0.00', '0.00', '0.00', '0.00'),
(335, '0.00', '0.00', '0.00', '0.00', '0.00'),
(336, '0.00', '0.00', '0.00', '0.00', '0.00'),
(337, '0.00', '0.00', '0.00', '0.00', '0.00'),
(338, '0.00', '0.00', '0.00', '0.00', '0.00'),
(339, '0.00', '0.00', '0.00', '0.00', '0.00'),
(340, '0.00', '0.00', '0.00', '0.00', '0.00'),
(341, '0.00', '0.00', '0.00', '0.00', '0.00'),
(342, '0.00', '0.00', '0.00', '0.00', '0.00'),
(343, '0.00', '0.00', '0.00', '0.00', '0.00'),
(344, '0.00', '0.00', '0.00', '0.00', '0.00'),
(345, '0.00', '0.00', '0.00', '0.00', '0.00'),
(346, '0.00', '0.00', '0.00', '0.00', '0.00'),
(347, '0.00', '0.00', '0.00', '0.00', '0.00'),
(348, '0.00', '0.00', '0.00', '0.00', '0.00'),
(349, '0.00', '0.00', '0.00', '0.00', '0.00'),
(350, '0.00', '0.00', '0.00', '0.00', '0.00'),
(351, '0.00', '0.00', '0.00', '0.00', '0.00'),
(352, '0.00', '0.00', '0.00', '0.00', '0.00'),
(353, '0.00', '0.00', '0.00', '0.00', '0.00'),
(354, '0.00', '0.00', '0.00', '0.00', '0.00'),
(355, '0.00', '0.00', '0.00', '0.00', '0.00'),
(356, '0.00', '0.00', '0.00', '0.00', '0.00'),
(357, '0.00', '0.00', '0.00', '0.00', '0.00'),
(358, '0.00', '0.00', '0.00', '0.00', '0.00'),
(359, '0.00', '0.00', '0.00', '0.00', '0.00'),
(360, '0.00', '0.00', '0.00', '0.00', '0.00'),
(361, '0.00', '0.00', '0.00', '0.00', '0.00'),
(362, '0.00', '0.00', '0.00', '0.00', '0.00'),
(363, '0.00', '0.00', '0.00', '0.00', '0.00'),
(364, '0.00', '0.00', '0.00', '0.00', '0.00'),
(365, '0.00', '0.00', '0.00', '0.00', '0.00'),
(366, '0.00', '0.00', '0.00', '0.00', '0.00'),
(367, '0.00', '0.00', '0.00', '0.00', '0.00'),
(368, '0.00', '0.00', '0.00', '0.00', '0.00'),
(369, '0.00', '0.00', '0.00', '0.00', '0.00'),
(370, '0.00', '0.00', '0.00', '0.00', '0.00'),
(371, '0.00', '0.00', '0.00', '0.00', '0.00'),
(372, '0.00', '0.00', '0.00', '0.00', '0.00'),
(373, '0.00', '0.00', '0.00', '0.00', '0.00'),
(374, '0.00', '0.00', '0.00', '0.00', '0.00'),
(375, '0.00', '0.00', '0.00', '0.00', '0.00'),
(376, '0.00', '0.00', '0.00', '0.00', '0.00'),
(377, '0.00', '0.00', '0.00', '0.00', '0.00'),
(378, '0.00', '0.00', '0.00', '0.00', '0.00'),
(379, '0.00', '0.00', '0.00', '0.00', '0.00'),
(380, '0.00', '0.00', '0.00', '0.00', '0.00'),
(381, '0.00', '0.00', '0.00', '0.00', '0.00'),
(382, '0.00', '0.00', '0.00', '0.00', '0.00'),
(383, '0.00', '0.00', '0.00', '0.00', '0.00'),
(384, '0.00', '0.00', '0.00', '0.00', '0.00'),
(385, '0.00', '0.00', '0.00', '0.00', '0.00'),
(386, '0.00', '0.00', '0.00', '0.00', '0.00'),
(387, '0.00', '0.00', '0.00', '0.00', '0.00'),
(388, '0.00', '0.00', '0.00', '0.00', '0.00'),
(389, '0.00', '0.00', '0.00', '0.00', '0.00'),
(390, '0.00', '0.00', '0.00', '0.00', '0.00'),
(391, '0.00', '0.00', '0.00', '0.00', '0.00'),
(392, '0.00', '0.00', '0.00', '0.00', '0.00'),
(393, '0.00', '0.00', '0.00', '0.00', '0.00'),
(394, '0.00', '0.00', '0.00', '0.00', '0.00'),
(395, '0.00', '0.00', '0.00', '0.00', '0.00'),
(396, '0.00', '0.00', '0.00', '0.00', '0.00'),
(397, '0.00', '0.00', '0.00', '0.00', '0.00'),
(398, '0.00', '0.00', '0.00', '0.00', '0.00'),
(399, '0.00', '0.00', '0.00', '0.00', '0.00'),
(400, '0.00', '0.00', '0.00', '0.00', '0.00'),
(401, '0.00', '0.00', '0.00', '0.00', '0.00'),
(402, '0.00', '0.00', '0.00', '0.00', '0.00'),
(403, '0.00', '0.00', '0.00', '0.00', '0.00'),
(404, '0.00', '0.00', '0.00', '0.00', '0.00'),
(405, '0.00', '0.00', '0.00', '0.00', '0.00'),
(406, '0.00', '0.00', '0.00', '0.00', '0.00'),
(407, '0.00', '0.00', '0.00', '0.00', '0.00'),
(408, '0.00', '0.00', '0.00', '0.00', '0.00'),
(409, '0.00', '0.00', '0.00', '0.00', '0.00'),
(410, '0.00', '0.00', '0.00', '0.00', '0.00'),
(411, '0.00', '0.00', '0.00', '0.00', '0.00'),
(412, '0.00', '0.00', '0.00', '0.00', '0.00'),
(413, '0.00', '0.00', '0.00', '0.00', '0.00'),
(414, '0.00', '0.00', '0.00', '0.00', '0.00'),
(415, '0.00', '0.00', '0.00', '0.00', '0.00'),
(416, '0.00', '0.00', '0.00', '0.00', '0.00'),
(417, '0.00', '0.00', '0.00', '0.00', '0.00'),
(418, '0.00', '0.00', '0.00', '0.00', '0.00'),
(419, '0.00', '0.00', '0.00', '0.00', '0.00'),
(420, '0.00', '0.00', '0.00', '0.00', '0.00'),
(421, '0.00', '0.00', '0.00', '0.00', '0.00'),
(422, '0.00', '0.00', '0.00', '0.00', '0.00'),
(423, '0.00', '0.00', '0.00', '0.00', '0.00'),
(424, '0.00', '0.00', '0.00', '0.00', '0.00'),
(425, '0.00', '0.00', '0.00', '0.00', '0.00'),
(426, '0.00', '0.00', '0.00', '0.00', '0.00'),
(427, '0.00', '0.00', '0.00', '0.00', '0.00'),
(428, '0.00', '0.00', '0.00', '0.00', '0.00'),
(429, '0.00', '0.00', '0.00', '0.00', '0.00'),
(430, '0.00', '0.00', '0.00', '0.00', '0.00'),
(431, '0.00', '0.00', '0.00', '0.00', '0.00'),
(432, '0.00', '0.00', '0.00', '0.00', '0.00'),
(433, '0.00', '0.00', '0.00', '0.00', '0.00'),
(434, '0.00', '0.00', '0.00', '0.00', '0.00'),
(435, '0.00', '0.00', '0.00', '0.00', '0.00'),
(436, '0.00', '0.00', '0.00', '0.00', '0.00'),
(437, '0.00', '0.00', '0.00', '0.00', '0.00'),
(438, '0.00', '0.00', '0.00', '0.00', '0.00'),
(439, '0.00', '0.00', '0.00', '0.00', '0.00'),
(440, '0.00', '0.00', '0.00', '0.00', '0.00'),
(441, '0.00', '0.00', '0.00', '0.00', '0.00'),
(442, '0.00', '0.00', '0.00', '0.00', '0.00'),
(443, '0.00', '0.00', '0.00', '0.00', '0.00'),
(444, '0.00', '0.00', '0.00', '0.00', '0.00'),
(445, '0.00', '0.00', '0.00', '0.00', '0.00'),
(446, '0.00', '0.00', '0.00', '0.00', '0.00'),
(447, '0.00', '0.00', '0.00', '0.00', '0.00'),
(448, '0.00', '0.00', '0.00', '0.00', '0.00'),
(449, '0.00', '0.00', '0.00', '0.00', '0.00'),
(450, '0.00', '0.00', '0.00', '0.00', '0.00'),
(451, '0.00', '0.00', '0.00', '0.00', '0.00'),
(452, '0.00', '0.00', '0.00', '0.00', '0.00'),
(453, '0.00', '0.00', '0.00', '0.00', '0.00'),
(454, '0.00', '0.00', '0.00', '0.00', '0.00'),
(455, '0.00', '0.00', '0.00', '0.00', '0.00'),
(456, '0.00', '0.00', '0.00', '0.00', '0.00'),
(457, '0.00', '0.00', '0.00', '0.00', '0.00'),
(458, '0.00', '0.00', '0.00', '0.00', '0.00'),
(459, '0.00', '0.00', '0.00', '0.00', '0.00'),
(460, '0.00', '0.00', '0.00', '0.00', '0.00'),
(461, '0.00', '0.00', '0.00', '0.00', '0.00'),
(462, '0.00', '0.00', '0.00', '0.00', '0.00'),
(463, '0.00', '0.00', '0.00', '0.00', '0.00'),
(464, '0.00', '0.00', '0.00', '0.00', '0.00'),
(465, '0.00', '0.00', '0.00', '0.00', '0.00'),
(466, '0.00', '0.00', '0.00', '0.00', '0.00'),
(467, '0.00', '0.00', '0.00', '0.00', '0.00'),
(468, '0.00', '0.00', '0.00', '0.00', '0.00'),
(469, '0.00', '0.00', '0.00', '0.00', '0.00'),
(470, '0.00', '0.00', '0.00', '0.00', '0.00'),
(471, '0.00', '0.00', '0.00', '0.00', '0.00'),
(472, '0.00', '0.00', '0.00', '0.00', '0.00'),
(473, '0.00', '0.00', '0.00', '0.00', '0.00'),
(474, '0.00', '0.00', '0.00', '0.00', '0.00'),
(475, '0.00', '0.00', '0.00', '0.00', '0.00'),
(476, '0.00', '0.00', '0.00', '0.00', '0.00'),
(477, '0.00', '0.00', '0.00', '0.00', '0.00'),
(478, '0.00', '0.00', '0.00', '0.00', '0.00'),
(479, '0.00', '0.00', '0.00', '0.00', '0.00'),
(480, '0.00', '0.00', '0.00', '0.00', '0.00'),
(481, '0.00', '0.00', '0.00', '0.00', '0.00'),
(482, '0.00', '0.00', '0.00', '0.00', '0.00'),
(483, '0.00', '0.00', '0.00', '0.00', '0.00'),
(484, '0.00', '0.00', '0.00', '0.00', '0.00'),
(485, '0.00', '0.00', '0.00', '0.00', '0.00'),
(486, '0.00', '0.00', '0.00', '0.00', '0.00'),
(487, '0.00', '0.00', '0.00', '0.00', '0.00'),
(488, '0.00', '0.00', '0.00', '0.00', '0.00'),
(489, '0.00', '0.00', '0.00', '0.00', '0.00'),
(490, '0.00', '0.00', '0.00', '0.00', '0.00'),
(491, '0.00', '0.00', '0.00', '0.00', '0.00'),
(492, '0.00', '0.00', '0.00', '0.00', '0.00'),
(493, '0.00', '0.00', '0.00', '0.00', '0.00'),
(494, '0.00', '0.00', '0.00', '0.00', '0.00'),
(495, '0.00', '0.00', '0.00', '0.00', '0.00'),
(496, '0.00', '0.00', '0.00', '0.00', '0.00'),
(497, '0.00', '0.00', '0.00', '0.00', '0.00'),
(498, '0.00', '0.00', '0.00', '0.00', '0.00'),
(499, '0.00', '0.00', '0.00', '0.00', '0.00'),
(500, '0.00', '0.00', '0.00', '0.00', '0.00'),
(501, '0.00', '0.00', '0.00', '0.00', '0.00'),
(502, '0.00', '0.00', '0.00', '0.00', '0.00'),
(503, '0.00', '0.00', '0.00', '0.00', '0.00'),
(504, '0.00', '0.00', '0.00', '0.00', '0.00'),
(505, '0.00', '0.00', '0.00', '0.00', '0.00'),
(506, '0.00', '0.00', '0.00', '0.00', '0.00'),
(507, '0.00', '0.00', '0.00', '0.00', '0.00'),
(508, '0.00', '0.00', '0.00', '0.00', '0.00'),
(509, '0.00', '0.00', '0.00', '0.00', '0.00'),
(510, '0.00', '0.00', '0.00', '0.00', '0.00'),
(511, '0.00', '0.00', '0.00', '0.00', '0.00'),
(512, '0.00', '0.00', '0.00', '0.00', '0.00'),
(513, '0.00', '0.00', '0.00', '0.00', '0.00'),
(514, '0.00', '0.00', '0.00', '0.00', '0.00'),
(515, '0.00', '0.00', '0.00', '0.00', '0.00'),
(516, '0.00', '0.00', '0.00', '0.00', '0.00'),
(517, '0.00', '0.00', '0.00', '0.00', '0.00'),
(518, '0.00', '0.00', '0.00', '0.00', '0.00'),
(519, '0.00', '0.00', '0.00', '0.00', '0.00'),
(520, '0.00', '0.00', '0.00', '0.00', '0.00'),
(521, '0.00', '0.00', '0.00', '0.00', '0.00'),
(522, '0.00', '0.00', '0.00', '0.00', '0.00'),
(523, '0.00', '0.00', '0.00', '0.00', '0.00'),
(524, '0.00', '0.00', '0.00', '0.00', '0.00'),
(525, '0.00', '0.00', '0.00', '0.00', '0.00'),
(526, '0.00', '0.00', '0.00', '0.00', '0.00'),
(527, '0.00', '0.00', '0.00', '0.00', '0.00'),
(528, '0.00', '0.00', '0.00', '0.00', '0.00'),
(529, '0.00', '0.00', '0.00', '0.00', '0.00'),
(530, '0.00', '0.00', '0.00', '0.00', '0.00'),
(531, '0.00', '0.00', '0.00', '0.00', '0.00'),
(532, '0.00', '0.00', '0.00', '0.00', '0.00'),
(533, '0.00', '0.00', '0.00', '0.00', '0.00'),
(534, '0.00', '0.00', '0.00', '0.00', '0.00'),
(535, '0.00', '0.00', '0.00', '0.00', '0.00'),
(536, '0.00', '0.00', '0.00', '0.00', '0.00'),
(537, '0.00', '0.00', '0.00', '0.00', '0.00'),
(538, '0.00', '0.00', '0.00', '0.00', '0.00'),
(539, '0.00', '0.00', '0.00', '0.00', '0.00'),
(540, '0.00', '0.00', '0.00', '0.00', '0.00'),
(541, '0.00', '0.00', '0.00', '0.00', '0.00'),
(542, '0.00', '0.00', '0.00', '0.00', '0.00'),
(543, '0.00', '0.00', '0.00', '0.00', '0.00'),
(544, '0.00', '0.00', '0.00', '0.00', '0.00'),
(545, '0.00', '0.00', '0.00', '0.00', '0.00'),
(546, '0.00', '0.00', '0.00', '0.00', '0.00'),
(547, '0.00', '0.00', '0.00', '0.00', '0.00'),
(548, '0.00', '0.00', '0.00', '0.00', '0.00'),
(549, '0.00', '0.00', '0.00', '0.00', '0.00'),
(550, '0.00', '0.00', '0.00', '0.00', '0.00'),
(551, '0.00', '0.00', '0.00', '0.00', '0.00'),
(552, '0.00', '0.00', '0.00', '0.00', '0.00'),
(553, '0.00', '0.00', '0.00', '0.00', '0.00'),
(554, '0.00', '0.00', '0.00', '0.00', '0.00'),
(555, '0.00', '0.00', '0.00', '0.00', '0.00'),
(556, '0.00', '0.00', '0.00', '0.00', '0.00');



--
-- Triggers `nota`
--
DELIMITER $$
CREATE TRIGGER `trgg_TotalNotas` BEFORE UPDATE ON `nota`
 FOR EACH ROW BEGIN
  SET @total = 0;
  SET @total = @total + NEW.trabajo_cotidiano;
  SET @total = @total + NEW.asistencia;
  SET @total = @total + NEW.pruebas;
  SET @total = @total + NEW.tareas;
    IF @total >= 100 THEN
		SET NEW.total = 100;
	ELSE
		SET NEW.total = @total;
    END IF;
  END
$$
DELIMITER ;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nota_constante`
--

CREATE TABLE `nota_constante` (
  `idnota_constante` int(11) NOT NULL,
  `nombre` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trabajo_cotidiano` decimal(8,2) DEFAULT NULL,
  `pruebas` decimal(8,2) DEFAULT NULL,
  `tareas` decimal(8,2) DEFAULT NULL,
  `asistencia` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `nota_constante`
--

INSERT INTO `nota_constante` (`idnota_constante`, `nombre`, `trabajo_cotidiano`, `pruebas`, `tareas`, `asistencia`) VALUES
(1, 'Basica Primer Ciclo', '60.00', '20.00', '10.00', '10.00'),
(2, 'Basica segundo ciclo', '50.00', '30.00', '10.00', '10.00'),
(3, 'Especial primer ciclo', '65.00', '15.00', '10.00', '10.00'),
(4, 'Especial segundo ciclo', '55.00', '25.00', '10.00', '10.00'),
(5, 'Religion', '70.00', '0.00', '20.00', '10.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `idPersona` int(11) NOT NULL,
  `cedula` varchar(45) CHARACTER SET utf8 NOT NULL,
  `nombre` varchar(45) CHARACTER SET utf8 NOT NULL,
  `apellido1` varchar(45) CHARACTER SET utf8 NOT NULL,
  `apellido2` varchar(45) CHARACTER SET utf8 NOT NULL,
  `sexo` varchar(20) CHARACTER SET utf8 NOT NULL,
  `direccion` varchar(100) CHARACTER SET utf8 NOT NULL,
  `telefono` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `telefono_secundario` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `email` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `idNacionalidad` int(11) NOT NULL,
  `disponible` tinyint(1) NOT NULL DEFAULT '1',
  `nota_medica` varchar(650) COLLATE utf8mb4_unicode_ci DEFAULT 'Ninguna'
) ENGINE=InnoDB AVG_ROW_LENGTH=195 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idPersona`, `cedula`, `nombre`, `apellido1`, `apellido2`, `sexo`, `direccion`, `telefono`, `telefono_secundario`, `email`, `idNacionalidad`, `disponible`, `nota_medica`) VALUES
(1, '1', 'Julian', 'Perez', 'Fernandez', 'Masculino', 'Heredia', '8', NULL, '@vegeto', 1, 0, 'Ninguno'),
(10, '3085254', 'JUAN JOSE', 'AVALOS', 'PORA', 'masculino', 'ALSJUELA', '1', NULL, NULL, 1, 1, 'Ninguno'),
(11, '12059826', 'Luisa', 'Montero', 'Chacon', 'Femenino', 'Aserri', NULL, NULL, NULL, 1, 1, 'Ninguno'),
(12, '5649111', 'Miguel', 'Orozco', 'Sanchez', 'Masculino', 'Tarbaca', NULL, NULL, NULL, 1, 1, 'Ninguno'),
(13, '45524685', 'Fernanda', 'Rodriguez', 'Morera', 'Femenino', 'Desamparados', NULL, NULL, NULL, 1, 1, 'Ninguno'),
(14, '305454685', 'Esteban', 'Jimenez', 'Ferrer', 'Masculino', 'Aserri', NULL, NULL, NULL, 2, 1, 'Ninguno'),
(15, '638268557', 'Pablo', 'Hernandez', 'Flores', 'Masculino', 'Aserri', NULL, NULL, NULL, 1, 1, 'Ninguno'),
(38, '307680159', 'Marco', 'Chinchila', 'Brenes ', 'Masculino', 'Desamparados', '5465657', NULL, 'mchinchilla@mail.com', 1, 1, 'Ninguno'),
(39, '107680159', 'Carlos', 'Alfaro', 'Gonzales', 'Masculino', 'Heredia', '1111', NULL, 'asd@gmail.com', 1, 1, 'Ninguno'),
(41, '507680129', 'Marta Francisco', 'Chinchilla', '.Saborio', 'Femenino', 'San Antonio de Desamparados', '24456767', NULL, 'mSaborio@gmail.com', 1, 1, 'Ninguno'),
(44, '305080238', 'Francisco', 'Flores', 'Chacon', 'Masculino', 'De la escuela publica de Aserri 150 mts al sur', '60439934', NULL, 'julian4nite@gmail.com', 1, 1, 'Ninguno'),
(69, '207680159', 'Oscar', 'Eduardo', 'Soto', 'Masculino', 'Alajuela, Atenas, Costa Rica', '63103970', NULL, 'oscarsoto0407ss97@gmail.com', 1, 0, 'Ninguno'),
(75, '5', 'Ileana Patricia', 'Soto', 'Leon', 'Femenino', 'Alajuela , Atenas', '12', NULL, 'oscarsosato0407sa97@gmail.com', 1, 1, 'Ninguno'),
(78, '1704', 'Prueba', 'Pruebs', 'Test', 'Masculino', 'ASD', '54544323', NULL, 'oscasasasrsoto0407sa97@gmail.com', 1, 1, 'Ninguno'),
(79, '9904', 'Prueba', 'Prueba', 'Prueba', 'Femenino', 'Atenas\r\nCosta Rica', '63103970', NULL, 'oscarsoto04097ssss@gmail.com', 1, 1, 'Ninguno'),
(80, '208040404', 'Martin', 'Soto', 'Saborio', 'Masculino', 'Alajuela', NULL, NULL, NULL, 1, 0, 'Ninguno'),
(81, '777', 'Julian', 'Perez ', 'Fernandez', 'Masculino', 'Heredia', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(82, '6765', 'Nombre', 'Ap1', 'Ap2', 'Masculino', 'Alajuela', NULL, NULL, NULL, 1, 1, 'Nota'),
(83, '001', 'Pablo', 'Arroyo', 'Fonseca', 'Masculino', 'Nadie le importa', '123456789', NULL, 'p@gmail.com', 1, 1, 'Ninguno'),
(85, '002', 'Pablo', 'Arroyo', 'Fonseca', 'Masculino', 'Nadie le importa', '123456789', NULL, 'p2@gmail.com', 1, 1, 'Ninguno'),
(86, '003', '003', '003', '003', '003', '003', '003', NULL, '003@gmail.com', 1, 1, 'Ninguno'),
(87, '004', '004', '004', '004', '004', '004', '004', NULL, '004@gmail.com', 1, 1, 'Ninguno'),
(89, '004.5', '004', '004', '004', '004', '004', '004', NULL, '004.5@gmail.com', 1, 1, 'Ninguno'),
(91, '005', '004', '004', '004', '004', '004', '004', NULL, '005@gmail.com', 1, 1, 'Ninguno'),
(92, '007', '007', '007', '007', '007', '007', '007', NULL, '007@gmail.com', 1, 1, 'Ninguno'),
(93, '008', '008', '008', '008', '008', '008', '008', NULL, '008@gmail.com', 1, 1, 'Ninguno'),
(94, '009', '009', '009', '009', '009', '009', '009', NULL, '009@gmail.com', 1, 1, 'Ninguno'),
(95, '010', '010', '010', '010', '010', '010', '010', NULL, '010@gmail.com', 1, 1, 'Ninguno'),
(96, '11', '11', '11', '11', '11', '11', '11', NULL, '11', 1, 1, 'Ninguno'),
(97, '12', '12', '12', '12', '12', '12', '12', NULL, '12', 1, 1, 'Ninguno'),
(98, '13', '13', '13', '13', '13', '13', '13', NULL, '13', 1, 1, 'Ninguno'),
(99, '14', '14', '14', '14', '14', '14', '14', NULL, '14', 1, 1, 'Ninguno'),
(100, '15', '15', '15', '15', '15', '15', '15', NULL, '15', 1, 1, 'Ninguno'),
(101, '2000', 'AAA', 'AAA', 'AAA', 'AAA', 'AAA', 'AAA', NULL, 'AAA', 1, 1, 'Ninguno'),
(102, '123212', 'OscarSL', 'Soto', '...Leon1', 'Masculino', 'Alajuela', '24432321', NULL, 'osotoppp@email.net', 1, 1, 'Ninguno'),
(103, '2000', 'Nombre', 'Apellido1', 'Apellido2', 'Masculino', 'Direccion', 'Tel', NULL, 'Correo', 1, 1, 'Ninguno'),
(105, '00001', 'Nombre', '1 Ap', '2 Ap', 'Masculino', 'Alajuela Atenas', '234', NULL, 'email', 1, 1, 'Ninguno'),
(107, '2001', 'AAA', 'AAA', 'AAA', 'Masculino', 'AAAA', 'AAA', NULL, 'email1', 1, 1, 'Ninguno'),
(109, '2002', 'OSCAR', 'LEON', 'LEON', 'Masculino', 'Atenas\r\nCosta Rica', '63103970', NULL, 'oscarsoto0407pp97@gmail.com', 1, 1, 'Ninguno'),
(113, '20012', '200912', '200912', '20012', '20012', '20012', '20012', NULL, 'mailto', 1, 1, 'Ninguno'),
(115, '2001112', '200912', '200912', '20012', '20012', '20012', '20012', NULL, 'mailzzaszto', 1, 0, 'Ninguno'),
(117, '2345', 'OSCAR', 'LEON', 'LEON', 'Femenino', 'Atenas\r\nCosta Rica', '63103970', NULL, '1111', 1, 1, 'Ninguno'),
(119, '4001', 'OSCAR', 'LEON', 'LEON', 'Masculino', 'Atenas\r\nCosta Rica', '63103970', NULL, 'beca', 1, 1, 'Ninguno'),
(121, '4003', 'OSCAR', 'LEON', 'LEON', 'Masculino', 'Atenas\r\nCosta Rica', '63103970', NULL, 'emailto.com', 1, 1, 'Ninguno'),
(123, '4007', 'OSCAR', 'LEON', 'LEON', 'Masculino', 'Atenas\r\nCosta Rica', '63103970', NULL, '4007', 1, 1, 'Ninguno'),
(125, '4009', 'OSCAR', 'LEON', 'LEON', 'Femenino', 'Atenas\r\nCosta Rica', '63103970', NULL, '4009', 1, 1, 'Ninguno'),
(127, '4011', 'OSCAR', 'LEON', 'LEON', 'Masculino', 'Atenas\r\nCosta Rica', '63103970', NULL, '4011', 1, 1, 'Ninguno'),
(129, '4013', 'OSCAR', 'LEON', 'LEON', 'Masculino', 'Atenas\r\nCosta Rica', '63103970', NULL, '4013', 1, 1, 'Ninguno'),
(131, '4016', 'OSCAR', 'LEON', 'LEON', 'Masculino', 'Atenas\r\nCosta Rica', '63103970', NULL, '4016', 1, 1, 'Ninguno'),
(133, '5001', 'Mario', 'Oreamuno', 'Zapata', 'Masculino', 'Alajuela', NULL, NULL, NULL, 1, 1, 'No'),
(134, '5005', 'OSCAR', 'LEON', 'LEON', 'Masculino', 'Atenas\r\nCosta Rica', NULL, NULL, NULL, 1, 1, 'xd'),
(136, '50010', 'OSCAR', 'LEON', 'LEON', 'Masculino', 'Atenas\r\nCosta Rica', NULL, NULL, NULL, 1, 1, 'Ileano'),
(138, '9001', 'Mauro', 'Fran', 'Gutt', 'Masculino', 'Atenas\r\nCosta Rica', NULL, NULL, NULL, 2, 1, 'Alcohol'),
(139, '9001', 'Mauro', 'Fran', 'Gutt', 'Masculino', 'Atenas\r\nCosta Rica', NULL, NULL, NULL, 2, 1, 'Alcohol'),
(140, '9002', 'Patricio', 'Leon', 'Ramirez', 'Masculino', 'Heredia', NULL, NULL, NULL, 1, 1, 'Alcohol'),
(141, '9002', 'Patricio', 'Leon', 'Ramirez', 'Masculino', 'Heredia', NULL, NULL, NULL, 1, 1, 'Alcohol'),
(142, '8001', 'Alejandra', 'Camacho', '.Camacho', 'Femenino', 'Heredia', '25466789', '25467876', 'oscarsotoa0407s97@gmail.com', 1, 1, 'Ninguno'),
(144, '8002', 'Dagoberto', 'Jiménez', 'Arias', 'Masculino', 'Heredia', '2446 6380', '2446 6380', 'mail;po', 1, 1, 'Ninguno'),
(146, 'Prueba', 'Ejemplo', 'Test', 'xd', 'Masc', 'Alajuela', NULL, NULL, NULL, 1, 1, 'Nada'),
(147, '6701', 'Juliano', 'Le pica', 'el ano', 'Masculino', 'Heredia', NULL, NULL, NULL, 1, 1, 'Gonorrea'),
(148, '6701', 'Juliano', 'Le pica', 'el ano', 'Masculino', 'Heredia', NULL, NULL, NULL, 1, 1, 'Gonorrea'),
(149, '9876', 'Alumno de Quinto', 'Ap1', 'Ap2', 'Masculino', 'Heredia', NULL, NULL, NULL, 1, 1, '1'),
(150, '7615', 'Alumno 2', 'Ap', 'Ap', 'Masculino', 'Dir', NULL, NULL, NULL, 1, 1, 'Med'),
(174, '207655430', 'Ramiro', 'Alfonso', 'Alfonsa', 'Masculino', 'Alajuela', NULL, NULL, NULL, 1, 1, '1'),
(175, '101', 'Eduardo', 'Piedra', 'Duarte', 'Masculino', 'Atenas\r\nCosta Rica', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(176, '101', 'Eduardo', 'Piedra', 'Duarte', 'Masculino', 'Atenas\r\nCosta Rica', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(177, '1001', 'Laura Moscoa', 'Chinchilla', 'Arias', 'Masculino', 'Heredia', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(178, '1001', 'Laura Moscoa', 'Chinchilla', 'Arias', 'Masculino', 'Heredia', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(179, '1002', 'Gabriela', 'Guillen', 'Guillen', 'Femenino', 'Heredia Centro, 150 metros este', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(180, '1002', 'Gabriela', 'Guillen', 'Guillen', 'Femenino', 'Heredia Centro, 150 metros este', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(181, '2001', 'Gabriel', 'Artavia', 'Guillen', 'Masculino', 'Heredia', '25465443', '25468781', NULL, 1, 1, 'Ninguna'),
(182, '2001', 'Gabriel', 'Artavia', 'Guillen', 'Masculino', 'Heredia', '25465443', '25468781', NULL, 1, 1, 'Ninguna'),
(183, '2001', 'Encargado de Prueba', 'Ap1', 'Ap 2', 'Masculino', 'Alajuela', '2', '2', NULL, 1, 1, 'Ninguna'),
(184, '20010', 'Encargado de Prueba', 'Ap1', '....................Ap 2', 'Masculino', 'Alajuela', '24', '90', NULL, 1, 1, 'Ninguna'),
(185, '781', 'Encargado 2', 'Apellido 1', '..................Apellido2', 'Masculino', 'Alajuela', '63108787', '80', NULL, 1, 1, 'Ninguna'),
(186, '781', 'Encargado 2', 'Apellido 1', '..................Apellido2', 'Masculino', 'Alajuela', '63108787', '80', NULL, 1, 1, 'Ninguna'),
(187, '4001', 'Alumno de 4to', 'Apellido 1', 'Apellido 2', 'Masculino', 'San Pedro', NULL, NULL, NULL, 1, 1, ''),
(188, '4001', 'Alumno de 4to', 'Apellido 1', 'Apellido 2', 'Masculino', 'San Pedro', NULL, NULL, NULL, 1, 1, ''),
(189, '541200', 'Alumno de 4to', 'Ap', 'AP', 'Masculino', 'Alajuela', NULL, NULL, NULL, 1, 1, 'Medica'),
(190, '541200', 'Alumno de 4to', 'Ap', 'AP', 'Masculino', 'Alajuela', NULL, NULL, NULL, 1, 1, 'Medica'),
(191, '98700', 'Mario', 'Vindas', '.Solis', 'Masculino', 'Heredia Centro', '25465710', '88932322', NULL, 1, 1, 'Ninguna'),
(192, '98700', 'Mario', 'Vindas', '.Solis', 'Masculino', 'Heredia Centro', '25465710', '88932322', NULL, 1, 1, 'Ninguna'),
(193, '3001', 'Maria', 'Pepa', 'Solorzano', 'Femenino', 'Alajuela, 150 metros este del Parque', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(194, '3001', 'Maria', 'Pepa', 'Solorzano', 'Femenino', 'Alajuela, 150 metros este del Parque', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(195, '3002', 'Jose', 'Maria', 'Figueres', 'Olsen', 'San Jose', NULL, NULL, NULL, 1, 1, 'No'),
(196, '3003', 'Javaad', 'Meneses', 'Pellejo', 'Masculino', 'Heredia', NULL, NULL, NULL, 1, 1, 'Med'),
(197, '3003', 'Javaad', 'Meneses', 'Pellejo', 'Masculino', 'Heredia', NULL, NULL, NULL, 1, 1, 'Med'),
(198, '3004', 'Alexis', 'Moya', 'Oreamuno', 'Masculino', 'Prueba', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(199, '3004', 'Alexis', 'Moya', 'Oreamuno', 'Masculino', 'Prueba', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(200, '3005', 'Alumno 3005', 'Apeliido 1', 'Apellido 2', 'Masculino', 'Atenas', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(201, '3005', 'Alumno 3005', 'Apeliido 1', 'Apellido 2', 'Masculino', 'Atenas', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(202, '3006', 'Alumno 3006', 'Apellido 1', 'Apellido 2', 'Masculino', 'Heredia', NULL, NULL, NULL, 1, 1, '1'),
(203, '8008', '8008', '8008', '8008', 'Masculino', '8008', NULL, NULL, NULL, 1, 1, '8008'),
(204, '8009', '8009', '8009', '8009', 'Masculino', '8009', '8009', '8009', NULL, 1, 1, 'Ninguna'),
(209, '4901', 'Oscar Eduardo', 'Soto', 'León', 'Masculino', 'Alajuela, Atenas Costa Rica', '24466380', NULL, '88923834', 1, 1, 'Ninguna'),
(211, '8899', 'Oscar Eduardo', 'Soto', 'León', 'Masculino', 'Alajuela', '88923239', NULL, 'oscarsoto040797@gmail.com', 1, 1, 'Ninguna'),
(213, '8898', 'Elvin', 'Martinez', '.Saborio', 'Masculino', 'Alajuela', '24467676', NULL, 'elsoto58@gmail.com', 1, 1, 'Ninguna'),
(215, '8144', 'Elvin', 'Ramirez', 'Jimenez', 'Masculino', 'Alajuela Atenas Costa Rica', '22334455', NULL, 'elsoto57@gmail.com', 1, 1, 'Ninguna'),
(217, '6192', 'Perestroika', 'Glasnot', '.Artavia', 'Masculino', 'Alajuela', '12343212', NULL, 'ileanassl30@gmail.com', 1, 1, 'Ninguna'),
(219, '9156', 'Fernanda', 'Lopez', '.Porras', 'Masculino', 'Alajuela', '9999999', NULL, 'natalielopez08ss0597@gmail.com', 1, 1, 'Ninguna'),
(221, '7854', 'Gabriel', 'Villalobos', '.Ramirez', 'Masculino', 'Alajuela', '2345432', NULL, 'natalielopezaa080597@gmail.com', 1, 1, 'Ninguna'),
(225, '98764521', 'test', 'test', 'test', 'Masculino', 'test', 'test', NULL, 'natalielopez080597@gmail.com', 1, 1, 'Ninguna');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesor`
--

CREATE TABLE `profesor` (
  `idprofesor` int(11) NOT NULL,
  `Persona_idPersona` int(11) NOT NULL,
  `tipo` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `profesor`
--

INSERT INTO `profesor` (`idprofesor`, `Persona_idPersona`, `tipo`) VALUES
(1, 1, 0),
(6, 38, 0),
(7, 39, 0),
(8, 41, 0),
(9, 44, 0),
(20, 69, 0),
(23, 75, 0),
(25, 78, 0),
(26, 79, 0),
(27, 83, 1),
(28, 85, 1),
(29, 86, 1),
(30, 87, 0),
(31, 89, 0),
(32, 91, 0),
(33, 92, 0),
(34, 93, 0),
(35, 94, 0),
(36, 95, 0),
(37, 96, 0),
(38, 97, 0),
(39, 98, 0),
(40, 99, 0),
(41, 100, 0),
(42, 101, 1),
(43, 102, 0),
(44, 105, 1),
(45, 107, 1),
(46, 109, 1),
(47, 113, 1),
(48, 115, 1),
(49, 117, 1),
(50, 119, 1),
(51, 121, 1),
(52, 123, 5),
(53, 125, 5),
(54, 127, 1),
(55, 129, 1),
(56, 131, 0),
(57, 142, 0),
(58, 144, 1),
(60, 209, 0),
(61, 211, 0),
(62, 213, 1),
(63, 215, 1),
(64, 217, 0),
(65, 219, 1),
(66, 221, 1),
(67, 225, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesor_materia_grado`
--

CREATE TABLE `profesor_materia_grado` (
  `profesor_idprofesor` int(11) NOT NULL,
  `materia_idmateria` int(11) NOT NULL,
  `id_grado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `profesor_materia_grado`
--

INSERT INTO `profesor_materia_grado` (`profesor_idprofesor`, `materia_idmateria`, `id_grado`) VALUES
(28, 5, 1),
(29, 5, 2),
(29, 5, 3),
(29, 5, 4),
(29, 5, 5),
(29, 5, 6),
(33, 6, 1),
(33, 7, 1),
(33, 8, 1),
(34, 6, 1),
(34, 7, 1),
(34, 8, 1),
(35, 6, 1),
(35, 7, 1),
(35, 8, 1),
(36, 6, 1),
(36, 7, 1),
(36, 8, 1),
(37, 6, 1),
(37, 7, 1),
(37, 8, 1),
(38, 6, 1),
(38, 7, 1),
(38, 8, 1),
(38, 9, 1),
(38, 10, 1),
(38, 11, 1),
(39, 6, 1),
(39, 7, 1),
(39, 8, 1),
(40, 6, 1),
(40, 7, 1),
(40, 8, 1),
(40, 11, 1),
(41, 6, 3),
(41, 7, 3),
(41, 8, 3),
(41, 11, 3),
(43, 6, 1),
(43, 7, 1),
(43, 8, 1),
(43, 11, 1),
(48, 5, 2),
(48, 5, 3),
(48, 5, 4),
(48, 5, 5),
(48, 5, 6),
(49, 5, 2),
(49, 5, 3),
(49, 5, 4),
(49, 5, 5),
(49, 5, 6),
(50, 5, 2),
(50, 5, 3),
(50, 5, 4),
(50, 5, 5),
(50, 5, 6),
(51, 5, 2),
(51, 5, 3),
(51, 5, 4),
(51, 5, 5),
(51, 5, 6),
(52, 5, 2),
(52, 5, 3),
(52, 5, 4),
(52, 5, 5),
(52, 5, 6),
(53, 5, 2),
(53, 5, 3),
(53, 5, 4),
(53, 5, 5),
(53, 5, 6),
(54, 5, 2),
(54, 5, 3),
(54, 5, 4),
(54, 5, 5),
(54, 5, 6),
(55, 9, 2),
(55, 9, 3),
(55, 9, 4),
(55, 9, 5),
(55, 9, 6),
(56, 6, 2),
(56, 7, 2),
(56, 8, 2),
(56, 11, 2),
(57, 6, 5),
(57, 7, 5),
(57, 8, 5),
(57, 11, 5),
(58, 9, 2),
(58, 9, 3),
(58, 9, 4),
(58, 9, 5),
(58, 9, 6),
(60, 6, 1),
(60, 7, 1),
(60, 8, 1),
(60, 11, 1),
(61, 6, 2),
(61, 7, 2),
(61, 8, 2),
(61, 11, 2),
(62, 5, 2),
(62, 5, 3),
(62, 5, 4),
(62, 5, 5),
(62, 5, 6),
(63, 5, 2),
(63, 5, 3),
(63, 5, 4),
(63, 5, 5),
(63, 5, 6),
(64, 6, 1),
(64, 7, 1),
(64, 8, 1),
(64, 11, 1),
(65, 5, 2),
(65, 5, 3),
(65, 5, 4),
(65, 5, 5),
(65, 5, 6),
(66, 5, 2),
(66, 5, 3),
(66, 5, 4),
(66, 5, 5),
(66, 5, 6),
(67, 9, 2),
(67, 9, 3),
(67, 9, 4),
(67, 9, 5),
(67, 9, 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `puesto`
--

CREATE TABLE `puesto` (
  `idPuesto` int(11) NOT NULL,
  `nombrePuesto` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `descrpcionPuesto` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `puesto`
--

INSERT INTO `puesto` (`idPuesto`, `nombrePuesto`, `descrpcionPuesto`) VALUES
(1, 'Conserje', 'Encargado de la limpieza de la institucion y mucho mas'),
(2, 'Guardia', 'Seguridad II'),
(3, 'Psicologa', 'Encargada de tratar con personal y niños');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `IDROL` int(11) NOT NULL,
  `tiporol` varchar(45) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`IDROL`, `tiporol`) VALUES
(1, 'Profesor'),
(2, 'Director');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_materia`
--

CREATE TABLE `tipo_materia` (
  `idTipo` int(11) NOT NULL,
  `tipo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_materia`
--

INSERT INTO `tipo_materia` (`idTipo`, `tipo`) VALUES
(1, 'Basica'),
(2, 'Idioma'),
(3, 'Religion'),
(4, 'Especial');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idUsuario` int(11) NOT NULL,
  `idPersona` int(11) DEFAULT NULL,
  `idRol` int(11) DEFAULT NULL,
  `password` varchar(150) CHARACTER SET utf8 DEFAULT NULL,
  `cambio` tinyint(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `idPersona`, `idRol`, `password`, `cambio`) VALUES
(7, 75, 1, '$2y$09$9TL7z6JBchfWwnnp1afXEOFOTW.NeHNBMNXZ2khiIFMY/ItUVkrY2', 0),
(9, 78, 2, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 0),
(10, 79, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 0),
(11, 83, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(12, 85, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(13, 86, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(14, 87, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(15, 89, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(16, 91, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(17, 92, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(18, 93, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(19, 94, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(20, 95, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(21, 96, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(22, 97, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(23, 98, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(24, 99, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 0),
(25, 100, 2, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 0),
(26, 101, 1, '11', 1),
(27, 102, 1, '1', 1),
(28, 105, 1, 'Seleccionar Grado', 1),
(29, 107, 1, '1', 1),
(30, 109, 1, 'Seleccionar Grado', 1),
(31, 113, 1, '20012', 1),
(32, 115, 1, '20012', 1),
(33, 117, 1, '1', 1),
(34, 119, 1, '1', 1),
(35, 121, 1, '1', 1),
(36, 123, 1, '1', 1),
(37, 125, 1, '1', 1),
(38, 127, 1, '$2y$09$dFdKgjRGA0cMjTtzZO8n6u4WMKjg0AE4/Em.l8LcMqn84Eef/ZgbK', 1),
(39, 129, 1, '$2y$09$.6d6wEIn25Rq9NkBksni8ulCWncH07jHj3yPLCrCHo2qtNQWuzOKG', 1),
(40, 131, 1, '$2y$09$RZzexNQ0PwGnUyMShz1fYeVccAJed4h31ei29hyPCV7/64Q/fT5fS', 1),
(41, 142, 1, '$2y$09$l6TdXxei2cTql4u4RueXPOgMr3lV70H3AUJXtRw2v63V/z7Y9d07y', 0),
(42, 144, 2, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 0),
(44, 209, 1, '$2y$09$lpj.ZsYDnUGVCmNG9kdCO.BMdAg1d41OYAcT2GLH1bn24kZGd2j92', 1),
(45, 211, 1, '$2y$09$lo96K5GCHDQ7zeaccKKdzuQUNxU5AUEWGb1sils6G0Pw34wBGye3G', 1),
(46, 213, 1, '$2y$09$Q4O8Op5Cz21CqmD.yxITee/5HhVCOcXSntIRT.D3CTioqV8wqDpBW', 1),
(47, 215, 1, '$2y$09$7Tp72WQZu5/DaNl24kg63.cAymd5HI4AVoI35aQefLY3ShcsS79DS', 1),
(48, 217, 1, '$2y$09$FJu/cGeE0Ly94cotqI/k/OvAUA3Vj40.J93x4UHhQ/1MfxzorMLXW', 1),
(49, 219, 1, '$2y$09$1h54n0Gfi0EaYf3ZrZTmw.l6zRz50IWxazYxhJeYk5PVjtwGywgcW', 1),
(50, 221, 1, '$2y$09$UMkO3DZM1u6MBu7wTofAmeF8JkSTVg8Nis3KDEfqlz6I81R/9c4KK', 1),
(51, 225, 1, '$2y$09$9zfLLAv9Xgi5fhOc7t6e2uIl9AcexkRNZdKTSE99g1ui.ds68MAY.', 1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vbeca`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vbeca` (
`cedula` varchar(45)
,`nombre` varchar(45)
,`apellidos` varchar(91)
,`descripcion_beca` varchar(500)
,`monto_beca` varchar(45)
,`estado` tinyint(1)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vdirector`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vdirector` (
`CEDULA` varchar(45)
,`NOMBRE` varchar(45)
,`APELLIDOS` varchar(91)
,`SEXO` varchar(20)
,`DIRECCION` varchar(100)
,`TELEFONO` varchar(45)
,`EMAIL` varchar(45)
,`PAIS` varchar(45)
,`DISPONIBLE` tinyint(1)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_alumno`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_alumno` (
`cedula` varchar(45)
,`nombre` varchar(45)
,`apellido1` varchar(45)
,`apellido2` varchar(45)
,`sexo` varchar(20)
,`pais` varchar(45)
,`nombreGrado` varchar(45)
,`annio` int(11)
,`direccion` varchar(100)
,`nota_medica` varchar(650)
,`disponible` tinyint(1)
,`idgrado` int(11)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_alumno_encargado`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_alumno_encargado` (
`cedula` varchar(45)
,`idalumno` int(11)
,`nombre` varchar(137)
,`idGrado` int(11)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_asistencia`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_asistencia` (
`cedula` varchar(45)
,`nombre` varchar(45)
,`apellido1` varchar(45)
,`apellido2` varchar(45)
,`nombreGrado` varchar(45)
,`ESTADO` tinyint(1)
,`NOTA` varchar(100)
,`FECHA` date
,`AUSENCIA` tinyint(1)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vista_empleado`
--

CREATE TABLE `vista_empleado` (
  `cedula` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apellido1` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apellido2` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sexo` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pais` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombrePuesto` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disponible` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_encargado`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_encargado` (
`cedula` varchar(45)
,`nombre` varchar(45)
,`apellido1` varchar(45)
,`apellido2` varchar(45)
,`telefono` varchar(45)
,`telefono_secundario` varchar(45)
,`direccion` varchar(100)
,`sexo` varchar(20)
,`pais` varchar(45)
,`disponible` tinyint(1)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_materia`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_materia` (
`idmateria` int(11)
,`nombre` varchar(45)
,`tipo` varchar(100)
,`estado` tinyint(1)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_nota`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_nota` (
`CONCAT(p.nombre,' ',p.apellido1,' ',p.apellido2)` varchar(137)
,`nombre` varchar(45)
,`asistencia` decimal(8,2)
,`pruebas` decimal(8,2)
,`tareas` decimal(8,2)
,`trabajo_cotidiano` decimal(8,2)
,`trimestre` int(11)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_notas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_notas` (
`cedula` varchar(45)
,`nombre` varchar(45)
,`apellido1` varchar(45)
,`apellido2` varchar(45)
,`materia` varchar(45)
,`nombreGrado` varchar(45)
,`trabajo_cotidiano` decimal(8,2)
,`pruebas` decimal(8,2)
,`tareas` decimal(8,2)
,`asistencia` decimal(8,2)
,`total` decimal(8,2)
,`trimestre` int(11)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_profesor`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vista_profesor` (
`CEDULA` varchar(45)
,`NOMBRE` varchar(45)
,`APELLIDO1` varchar(45)
,`APELLIDO2` varchar(45)
,`SEXO` varchar(20)
,`DIRECCION` varchar(100)
,`TELEFONO` varchar(45)
,`EMAIL` varchar(45)
,`PAIS` varchar(45)
,`DISPONIBLE` tinyint(1)
,`nombreGrado` varchar(45)
,`annio` int(11)
,`tipo` tinyint(1)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `mostrar_encargado`
--
DROP TABLE IF EXISTS `mostrar_encargado`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mostrar_encargado`  AS  select `p2`.`cedula` AS `cedula_e`,`p`.`cedula` AS `cedula`,concat(`p`.`nombre`,' ',`p`.`apellido1`,' ',`p`.`apellido2`) AS `nombre`,`p`.`telefono` AS `telefono`,`p`.`telefono_secundario` AS `telefono_secundario`,`p`.`direccion` AS `direccion` from ((((`persona` `p` join `alumno` `a`) join `alumno_encargado` `ae`) join `encargado` `e`) join `persona` `p2`) where ((`p2`.`idPersona` = `a`.`Persona_idPersona`) and (`p`.`idPersona` = `e`.`Persona_idPersona`) and (`a`.`idalumno` = `ae`.`ID_ALUMNO`) and (`e`.`idencargado` = `ae`.`ID_ENCARGADO`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vbeca`
--
DROP TABLE IF EXISTS `vbeca`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vbeca`  AS  select `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,concat(`p`.`apellido1`,' ',`p`.`apellido2`) AS `apellidos`,`b`.`descripcion_beca` AS `descripcion_beca`,`b`.`monto_beca` AS `monto_beca`,`b`.`estado` AS `estado` from ((`persona` `p` join `alumno` `a`) join `beca` `b`) where ((`p`.`idPersona` = `a`.`Persona_idPersona`) and (`a`.`idalumno` = `b`.`idAlumno`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vdirector`
--
DROP TABLE IF EXISTS `vdirector`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vdirector`  AS  select `pe`.`cedula` AS `CEDULA`,`pe`.`nombre` AS `NOMBRE`,concat(`pe`.`apellido1`,' ',`pe`.`apellido2`) AS `APELLIDOS`,`pe`.`sexo` AS `SEXO`,`pe`.`direccion` AS `DIRECCION`,`pe`.`telefono` AS `TELEFONO`,`pe`.`email` AS `EMAIL`,`n`.`pais` AS `PAIS`,`pe`.`disponible` AS `DISPONIBLE` from ((`director` `pr` join `persona` `pe`) join `nacionalidad` `n`) where ((`pe`.`idPersona` = `pr`.`idDirector`) and (`n`.`idNacionalidad` = `pe`.`idNacionalidad`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_alumno`
--
DROP TABLE IF EXISTS `vista_alumno`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_alumno`  AS  select `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,`p`.`apellido1` AS `apellido1`,`p`.`apellido2` AS `apellido2`,`p`.`sexo` AS `sexo`,`n`.`pais` AS `pais`,`g`.`nombreGrado` AS `nombreGrado`,`g`.`annio` AS `annio`,`p`.`direccion` AS `direccion`,`p`.`nota_medica` AS `nota_medica`,`p`.`disponible` AS `disponible`,`g`.`idgrado` AS `idgrado` from ((((`persona` `p` join `alumno` `a`) join `grado_estudiante_nota` `ga`) join `nacionalidad` `n`) join `grado` `g`) where ((`a`.`Persona_idPersona` = `p`.`idPersona`) and (`ga`.`idEstudiante` = `a`.`idalumno`) and (`p`.`idNacionalidad` = `n`.`idNacionalidad`) and (`ga`.`idGrado` = `g`.`idgrado`)) group by `p`.`cedula` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_alumno_encargado`
--
DROP TABLE IF EXISTS `vista_alumno_encargado`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_alumno_encargado`  AS  select `p2`.`cedula` AS `cedula`,`a`.`idalumno` AS `idalumno`,concat(`p`.`nombre`,' ',`p`.`apellido1`,' ',`p`.`apellido2`) AS `nombre`,`gen`.`idGrado` AS `idGrado` from (((((`persona` `p` join `alumno` `a`) join `grado_estudiante_nota` `gen`) join `alumno_encargado` `ae`) join `persona` `p2`) join `encargado` `e`) where ((`p`.`idPersona` = `a`.`Persona_idPersona`) and (`a`.`idalumno` = `gen`.`idEstudiante`) and (`ae`.`ID_ENCARGADO` = `e`.`idencargado`) and (`ae`.`ID_ALUMNO` = `a`.`idalumno`) and (`e`.`Persona_idPersona` = `p2`.`idPersona`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_asistencia`
--
DROP TABLE IF EXISTS `vista_asistencia`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_asistencia`  AS  select `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,`p`.`apellido1` AS `apellido1`,`p`.`apellido2` AS `apellido2`,`g`.`nombreGrado` AS `nombreGrado`,`a`.`ESTADO` AS `ESTADO`,`a`.`NOTA` AS `NOTA`,`a`.`FECHA` AS `FECHA`,`a`.`AUSENCIA` AS `AUSENCIA` from ((((`grado` `g` join `grado_estudiante_nota` `gan`) join `asistencia` `a`) join `persona` `p`) join `alumno` `al`) where ((`p`.`idPersona` = `al`.`Persona_idPersona`) and (`al`.`idalumno` = `gan`.`idEstudiante`) and (`gan`.`idGrado` = `g`.`idgrado`) and (`gan`.`idEstudiante` = `a`.`IDALUMNO`) and (`g`.`idgrado` = `a`.`IDGRADO`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_encargado`
--
DROP TABLE IF EXISTS `vista_encargado`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_encargado`  AS  select `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,`p`.`apellido1` AS `apellido1`,`p`.`apellido2` AS `apellido2`,`p`.`telefono` AS `telefono`,`p`.`telefono_secundario` AS `telefono_secundario`,`p`.`direccion` AS `direccion`,`p`.`sexo` AS `sexo`,`n`.`pais` AS `pais`,`p`.`disponible` AS `disponible` from ((`persona` `p` join `encargado` `e`) join `nacionalidad` `n`) where ((`p`.`idPersona` = `e`.`Persona_idPersona`) and (`p`.`idNacionalidad` = `n`.`idNacionalidad`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_materia`
--
DROP TABLE IF EXISTS `vista_materia`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_materia`  AS  select `m`.`idmateria` AS `idmateria`,`m`.`nombre` AS `nombre`,`t`.`tipo` AS `tipo`,`m`.`estado` AS `estado` from (`materia` `m` join `tipo_materia` `t`) where (`m`.`idTipoMateria` = `t`.`idTipo`) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_nota`
--
DROP TABLE IF EXISTS `vista_nota`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_nota`  AS  select concat(`p`.`nombre`,' ',`p`.`apellido1`,' ',`p`.`apellido2`) AS `CONCAT(p.nombre,' ',p.apellido1,' ',p.apellido2)`,`m`.`nombre` AS `nombre`,`n`.`asistencia` AS `asistencia`,`n`.`pruebas` AS `pruebas`,`n`.`tareas` AS `tareas`,`n`.`trabajo_cotidiano` AS `trabajo_cotidiano`,`gdn`.`trimestre` AS `trimestre` from ((((`grado_estudiante_nota` `gdn` join `alumno` `a`) join `persona` `p`) join `materia` `m`) join `nota` `n`) where ((`a`.`Persona_idPersona` = `p`.`idPersona`) and (`a`.`idalumno` = `gdn`.`idEstudiante`) and (`gdn`.`idNota` = `n`.`idnota`)) group by `m`.`idmateria` ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_notas`
--
DROP TABLE IF EXISTS `vista_notas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_notas`  AS  select `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,`p`.`apellido1` AS `apellido1`,`p`.`apellido2` AS `apellido2`,`m`.`nombre` AS `materia`,`g`.`nombreGrado` AS `nombreGrado`,`n`.`trabajo_cotidiano` AS `trabajo_cotidiano`,`n`.`pruebas` AS `pruebas`,`n`.`tareas` AS `tareas`,`n`.`asistencia` AS `asistencia`,`n`.`total` AS `total`,`gan`.`trimestre` AS `trimestre` from (((((`persona` `p` join `materia` `m`) join `grado_estudiante_nota` `gan`) join `grado` `g`) join `nota` `n`) join `alumno` `a`) where ((`p`.`idPersona` = `a`.`Persona_idPersona`) and (`a`.`idalumno` = `gan`.`idEstudiante`) and (`gan`.`idGrado` = `g`.`idgrado`) and (`m`.`idmateria` = `gan`.`idMateria`) and (`gan`.`idNota` = `n`.`idnota`) and (`p`.`disponible` <> 0)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_profesor`
--
DROP TABLE IF EXISTS `vista_profesor`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_profesor`  AS  select `p`.`cedula` AS `CEDULA`,`p`.`nombre` AS `NOMBRE`,`p`.`apellido1` AS `APELLIDO1`,`p`.`apellido2` AS `APELLIDO2`,`p`.`sexo` AS `SEXO`,`p`.`direccion` AS `DIRECCION`,`p`.`telefono` AS `TELEFONO`,`p`.`email` AS `EMAIL`,`n`.`pais` AS `PAIS`,`p`.`disponible` AS `DISPONIBLE`,`g`.`nombreGrado` AS `nombreGrado`,`g`.`annio` AS `annio`,`pe`.`tipo` AS `tipo` from ((((`persona` `p` join `profesor` `pe`) join `nacionalidad` `n`) join `grado` `g`) join `profesor_materia_grado` `pg`) where ((`p`.`idPersona` = `pe`.`Persona_idPersona`) and (`pe`.`idprofesor` = `pg`.`profesor_idprofesor`) and (`g`.`idgrado` = `pg`.`id_grado`) and (`p`.`idNacionalidad` = `n`.`idNacionalidad`)) ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD PRIMARY KEY (`idalumno`,`Persona_idPersona`),
  ADD UNIQUE KEY `idalumno_UNIQUE` (`idalumno`),
  ADD KEY `fk_alumno_Persona1_idx` (`Persona_idPersona`);

--
-- Indices de la tabla `alumno_encargado`
--
ALTER TABLE `alumno_encargado`
  ADD PRIMARY KEY (`ID_ALUMNO`,`ID_ENCARGADO`),
  ADD KEY `ID_ENCARGADO` (`ID_ENCARGADO`);

--
-- Indices de la tabla `asistencia`
--
ALTER TABLE `asistencia`
  ADD PRIMARY KEY (`IDASISTENCIA`),
  ADD KEY `FK_ASISTENCIA_ALUMNO` (`IDALUMNO`),
  ADD KEY `FK_ASISTENCIA_GRADO` (`IDGRADO`),
  ADD KEY `FK_ASISTENCIA_PROFESOR` (`idProfesor`);

--
-- Indices de la tabla `beca`
--
ALTER TABLE `beca`
  ADD PRIMARY KEY (`idbeca`),
  ADD KEY `fk_beca_alumno_idx` (`idAlumno`);

--
-- Indices de la tabla `director`
--
ALTER TABLE `director`
  ADD PRIMARY KEY (`idDirector`,`Persona_idPersona`),
  ADD UNIQUE KEY `iddirector_UNIQUE` (`idDirector`),
  ADD KEY `fk_director_Persona1_idx` (`Persona_idPersona`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`idEmpleado`),
  ADD KEY `FK_EMPLEADO_PUESTO` (`idPuesto`),
  ADD KEY `FK_EMPLEADO_PERSONA` (`idPersona`);

--
-- Indices de la tabla `encargado`
--
ALTER TABLE `encargado`
  ADD PRIMARY KEY (`idencargado`,`Persona_idPersona`),
  ADD UNIQUE KEY `idencargado_UNIQUE` (`idencargado`),
  ADD KEY `fk_encargado_Persona1_idx` (`Persona_idPersona`);

--
-- Indices de la tabla `grado`
--
ALTER TABLE `grado`
  ADD PRIMARY KEY (`idgrado`);

--
-- Indices de la tabla `grado_estudiante_nota`
--
ALTER TABLE `grado_estudiante_nota`
  ADD PRIMARY KEY (`idGrado`,`idMateria`,`idNota`,`idEstudiante`),
  ADD KEY `fk_nota_idx1` (`idNota`),
  ADD KEY `fk_alumno_idx1` (`idEstudiante`),
  ADD KEY `fk_materia_idx1` (`idMateria`);

--
-- Indices de la tabla `historico_usuarios`
--
ALTER TABLE `historico_usuarios`
  ADD PRIMARY KEY (`idHistorico`);

--
-- Indices de la tabla `materia`
--
ALTER TABLE `materia`
  ADD PRIMARY KEY (`idmateria`),
  ADD KEY `FK_MATERIA_TIPOMATERIA` (`idTipoMateria`);

--
-- Indices de la tabla `nacionalidad`
--
ALTER TABLE `nacionalidad`
  ADD PRIMARY KEY (`idNacionalidad`),
  ADD UNIQUE KEY `idNacionalidad_UNIQUE` (`idNacionalidad`),
  ADD UNIQUE KEY `pais_UNIQUE` (`pais`);

--
-- Indices de la tabla `nota`
--
ALTER TABLE `nota`
  ADD PRIMARY KEY (`idnota`);

--
-- Indices de la tabla `nota_constante`
--
ALTER TABLE `nota_constante`
  ADD PRIMARY KEY (`idnota_constante`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idPersona`),
  ADD UNIQUE KEY `idPersona_UNIQUE` (`idPersona`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD KEY `idNacionalidad_idx` (`idNacionalidad`);

--
-- Indices de la tabla `profesor`
--
ALTER TABLE `profesor`
  ADD PRIMARY KEY (`idprofesor`,`Persona_idPersona`),
  ADD UNIQUE KEY `idprofesor_UNIQUE` (`idprofesor`),
  ADD KEY `fk_profesor_Persona1_idx` (`Persona_idPersona`) USING BTREE;

--
-- Indices de la tabla `profesor_materia_grado`
--
ALTER TABLE `profesor_materia_grado`
  ADD PRIMARY KEY (`profesor_idprofesor`,`materia_idmateria`,`id_grado`),
  ADD KEY `fk_profesor_has_materia_materia1_idx` (`materia_idmateria`),
  ADD KEY `fk_profesor_has_materia_profesor1_idx` (`profesor_idprofesor`),
  ADD KEY `fk_profesor_materiagrado_idx` (`id_grado`);

--
-- Indices de la tabla `puesto`
--
ALTER TABLE `puesto`
  ADD PRIMARY KEY (`idPuesto`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`IDROL`);

--
-- Indices de la tabla `tipo_materia`
--
ALTER TABLE `tipo_materia`
  ADD PRIMARY KEY (`idTipo`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idUsuario`),
  ADD KEY `fk_persona_usuario` (`idPersona`),
  ADD KEY `fk_rol_usuario` (`idRol`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alumno`
--
ALTER TABLE `alumno`
  MODIFY `idalumno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `asistencia`
--
ALTER TABLE `asistencia`
  MODIFY `IDASISTENCIA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=170;

--
-- AUTO_INCREMENT de la tabla `beca`
--
ALTER TABLE `beca`
  MODIFY `idbeca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `director`
--
ALTER TABLE `director`
  MODIFY `idDirector` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `idEmpleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `encargado`
--
ALTER TABLE `encargado`
  MODIFY `idencargado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `grado`
--
ALTER TABLE `grado`
  MODIFY `idgrado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `historico_usuarios`
--
ALTER TABLE `historico_usuarios`
  MODIFY `idHistorico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `materia`
--
ALTER TABLE `materia`
  MODIFY `idmateria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `nacionalidad`
--
ALTER TABLE `nacionalidad`
  MODIFY `idNacionalidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `nota`
--
ALTER TABLE `nota`
  MODIFY `idnota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=557;

--
-- AUTO_INCREMENT de la tabla `nota_constante`
--
ALTER TABLE `nota_constante`
  MODIFY `idnota_constante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idPersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=227;

--
-- AUTO_INCREMENT de la tabla `profesor`
--
ALTER TABLE `profesor`
  MODIFY `idprofesor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT de la tabla `puesto`
--
ALTER TABLE `puesto`
  MODIFY `idPuesto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `IDROL` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipo_materia`
--
ALTER TABLE `tipo_materia`
  MODIFY `idTipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD CONSTRAINT `fk_alumno_persona` FOREIGN KEY (`Persona_idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `alumno_encargado`
--
ALTER TABLE `alumno_encargado`
  ADD CONSTRAINT `alumno_encargado_ibfk_1` FOREIGN KEY (`ID_ALUMNO`) REFERENCES `alumno` (`idalumno`),
  ADD CONSTRAINT `alumno_encargado_ibfk_2` FOREIGN KEY (`ID_ENCARGADO`) REFERENCES `encargado` (`idencargado`);

--
-- Filtros para la tabla `asistencia`
--
ALTER TABLE `asistencia`
  ADD CONSTRAINT `FK_ASISTENCIA_ALUMNO` FOREIGN KEY (`IDALUMNO`) REFERENCES `alumno` (`idalumno`),
  ADD CONSTRAINT `FK_ASISTENCIA_GRADO` FOREIGN KEY (`IDGRADO`) REFERENCES `grado` (`idgrado`),
  ADD CONSTRAINT `FK_ASISTENCIA_PROFESOR` FOREIGN KEY (`idProfesor`) REFERENCES `profesor` (`idprofesor`);

--
-- Filtros para la tabla `beca`
--
ALTER TABLE `beca`
  ADD CONSTRAINT `fk_beca_alumno` FOREIGN KEY (`idAlumno`) REFERENCES `alumno` (`idalumno`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `director`
--
ALTER TABLE `director`
  ADD CONSTRAINT `fk_director_Persona1` FOREIGN KEY (`Persona_idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `FK_EMPLEADO_PERSONA` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`),
  ADD CONSTRAINT `FK_EMPLEADO_PUESTO` FOREIGN KEY (`idPuesto`) REFERENCES `puesto` (`idPuesto`);

--
-- Filtros para la tabla `encargado`
--
ALTER TABLE `encargado`
  ADD CONSTRAINT `fk_encargado_Persona1` FOREIGN KEY (`Persona_idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `grado_estudiante_nota`
--
ALTER TABLE `grado_estudiante_nota`
  ADD CONSTRAINT `fk_alumno_materia_grado_nota` FOREIGN KEY (`idEstudiante`) REFERENCES `alumno` (`idalumno`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_grado_materia_alumno_nota` FOREIGN KEY (`idGrado`) REFERENCES `grado` (`idgrado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_materia_grado_alumno_nota` FOREIGN KEY (`idMateria`) REFERENCES `materia` (`idmateria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_nota_estudiante_materia_grado` FOREIGN KEY (`idNota`) REFERENCES `nota` (`idnota`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `materia`
--
ALTER TABLE `materia`
  ADD CONSTRAINT `FK_MATERIA_TIPOMATERIA` FOREIGN KEY (`idTipoMateria`) REFERENCES `tipo_materia` (`idTipo`);

--
-- Filtros para la tabla `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `idNacionalidad` FOREIGN KEY (`idNacionalidad`) REFERENCES `nacionalidad` (`idNacionalidad`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `profesor`
--
ALTER TABLE `profesor`
  ADD CONSTRAINT `fk_profesor_Persona1` FOREIGN KEY (`Persona_idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `profesor_materia_grado`
--
ALTER TABLE `profesor_materia_grado`
  ADD CONSTRAINT `fk_profesor_has_materia_materia1` FOREIGN KEY (`materia_idmateria`) REFERENCES `materia` (`idmateria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_profesor_has_materia_profesor1` FOREIGN KEY (`profesor_idprofesor`) REFERENCES `profesor` (`idprofesor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_profesor_materiagrado` FOREIGN KEY (`id_grado`) REFERENCES `grado` (`idgrado`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_persona_usuario` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`),
  ADD CONSTRAINT `fk_rol_usuario` FOREIGN KEY (`idRol`) REFERENCES `rol` (`IDROL`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 13, 2018 at 06:49 AM
-- Server version: 10.1.30-MariaDB
-- PHP Version: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `escuela`
--
CREATE DATABASE IF NOT EXISTS `escuela` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `escuela`;

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActivaBeca` (IN `VCED` VARCHAR(20))  BEGIN
	SELECT idPersona
    FROM persona
    WHERE cedula = VCED LIMIT 1
    INTO @idP;
    SELECT idAlumno
    FROM alumno
    WHERE Persona_idPersona = @idP
    INTO @idA;
    UPDATE beca
    SET estado = 1
    WHERE idAlumno = @idA;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizaAsistencia` (IN `VJUST` TINYINT, IN `VNOTA` VARCHAR(100), IN `VCED` VARCHAR(20), IN `VFECHA` DATE)  BEGIN
	SELECT idPersona
    FROM persona
    WHERE cedula = VCED LIMIT 1
    INTO @idP;
    SELECT idAlumno
    FROM alumno
    WHERE Persona_idPersona = @idP
    INTO @idA;
   	UPDATE asistencia SET
	AUSENCIA = VJUST,
	NOTA = VNOTA
	WHERE IDALUMNO = @idA and FECHA = VFECHA;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizaBeca` (IN `VDESC` VARCHAR(500), IN `VMON` VARCHAR(40), IN `VCED` VARCHAR(20))  BEGIN
	SELECT idPersona
    FROM persona
    WHERE cedula = VCED LIMIT 1
    INTO @idP;
    SELECT idAlumno
    FROM alumno
    WHERE Persona_idPersona = @idP
    INTO @idA;
    UPDATE beca
    SET descripcion_beca = VDESC,
    monto_beca = VMON
    WHERE idAlumno = @idA;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizarEmpleado` (IN `CED` VARCHAR(20), IN `NOM` VARCHAR(35), IN `APE1` VARCHAR(35), IN `APE2` VARCHAR(35), IN `SEX` VARCHAR(20), IN `DIRECC` VARCHAR(50), IN `TEL` VARCHAR(25), IN `NAC` INT, IN `PUE` INT)  BEGIN

 UPDATE persona SET
 NOMBRE = NOM,
 APELLIDO1=APE1,
 APELLIDO2=APE2,
 SEXO=SEX,
 DIRECCION =DIRECC,
 TELEFONO=TEL,
 idNacionalidad=NAC
 WHERE CEDULA = CED LIMIT 1;

 SELECT idPersona FROM persona WHERE CEDULA = CED INTO @id ;

UPDATE empleado SET
idPuesto = PUE
WHERE idPersona = @id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_DesactivaBeca` (IN `VCED` VARCHAR(20))  BEGIN
	SELECT idPersona
    FROM persona
    WHERE cedula = VCED LIMIT 1
    INTO @idP;
    SELECT idAlumno
    FROM alumno
    WHERE Persona_idPersona = @idP
    INTO @idA;
    UPDATE beca
    SET estado = 0
    WHERE idAlumno = @idA;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_desactivarUsuario` (IN `VCED` VARCHAR(100))  NO SQL
BEGIN

UPDATE persona set disponible ='0' where cedula = VCED;

 SELECT idPersona
 FROM persona
 WHERE cedula = VCED LIMIT 1 
 INTO @id;
 
 DELETE FROM usuario where idPersona = @id;
 

        
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertaAlumno` (IN `VCED` VARCHAR(20), IN `VNOM` VARCHAR(40), IN `VAPE1` VARCHAR(40), IN `VAPE2` VARCHAR(40), IN `VSEX` VARCHAR(20), IN `VDIR` VARCHAR(50), IN `VNAC` INT, IN `VNOT` VARCHAR(650), IN `VGRA` INT)  BEGIN
 INSERT INTO persona( cedula, nombre, apellido1, apellido2, sexo, direccion,idNacionalidad,nota_medica)
 VALUES(VCED,VNOM,VAPE1,VAPE2,VSEX,VDIR,VNAC,VNOT);

 SELECT idPersona
 FROM persona
 WHERE cedula = VCED
 INTO @id;

 INSERT INTO alumno(Persona_idPersona)VALUES(@id);

 SELECT idalumno
 FROM alumno
 WHERE persona_idPersona = @id LIMIT 1
 INTO @id_alumno;

 SELECT ciclo
 into @vciclo
 from grado
 where idgrado=VGRA;

SELECT MIN(idmateria), MAX(idmateria)
INTO @min,@max
FROM materia;

WHILE @min <= @max DO
SET @tri =1;
WHILE @tri <= 3 DO
INSERT INTO `nota` (`idnota`, `trabajo_cotidiano`, `asistencia`, `tareas`, `pruebas`) VALUES (NULL, '0.00', '0.00', '0.00', '0.00');

SELECT idnota
into @idNota
FROM nota
ORDER BY idnota
DESC LIMIT 1;

INSERT INTO grado_estudiante_nota(idGrado,idMateria,idNota,idEstudiante,trimestre,aprobado) values (VGRA,@min,@idNota,@id_alumno,@tri,0);
SET @tri = @tri +1;
END WHILE;

SET @min=@min+1;
END WHILE;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertaAsistencia` (IN `VESTADO` TINYINT, IN `VNOTA` VARCHAR(150), IN `VCED` VARCHAR(30), IN `VFECHA` DATE, IN `VIDGR` INT, IN `VID` INT)  BEGIN
    SELECT idPersona
    FROM persona
    WHERE cedula = VCED COLLATE utf8mb4_unicode_ci LIMIT 1
    INTO @id;
    SELECT idProfesor
    from profesor
    WHERE Persona_idPersona = VID LIMIT 1
    INTO @idPr;
    SELECT idAlumno
    FROM alumno
    WHERE Persona_idPersona = @id  COLLATE utf8mb4_unicode_ci
    INTO @idA;
    INSERT INTO asistencia(ESTADO,NOTA,IDALUMNO,FECHA,IDGRADO,idProfesor)
	VALUES(VESTADO,VNOTA,@idA,VFECHA,VIDGR,@idPr);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertaBeca` (IN `VCED` VARCHAR(50) COLLATE utf8mb4_unicode_ci, IN `VDES` VARCHAR(500) COLLATE utf8mb4_unicode_ci, IN `VMON` VARCHAR(45) COLLATE utf8mb4_unicode_ci)  BEGIN
    SELECT idPersona
    FROM persona
    WHERE cedula = VCED  COLLATE utf8mb4_unicode_ci
    INTO @id;
    SELECT idAlumno
    FROM alumno
    WHERE Persona_idPersona = @id  COLLATE utf8mb4_unicode_ci
    INTO @idA;
    INSERT INTO BECA(descripcion_beca,monto_beca,idAlumno)
    VALUES(VDES,VMON,@idA);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertaEncargado` (IN `VCED` VARCHAR(45), IN `VNOM` VARCHAR(45), IN `VAP1` VARCHAR(45), IN `VAP2` VARCHAR(45), IN `VSEXO` VARCHAR(45), IN `VDIR` VARCHAR(100), IN `VTEL` VARCHAR(45), IN `VTEL2` VARCHAR(45), IN `VNAC` VARCHAR(45))  BEGIN
 INSERT INTO persona( cedula, nombre, apellido1, apellido2, sexo, direccion,telefono,telefono_secundario,idNacionalidad)
 VALUES(VCED,VNOM,VAP1,VAP2,VSEXO,VDIR,VTEL,VTEL2,VNAC);
 SELECT idPersona
 FROM persona
 WHERE cedula = VCED LIMIT 1
 into @id;


 INSERT INTO encargado(Persona_idPersona)VALUES(@id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertaNotas` (IN `VCED` VARCHAR(45), IN `VIDMAT` VARCHAR(45), IN `VIDGR` INT, IN `VCOT` DECIMAL, IN `VPRU` DECIMAL, IN `VTAREA` DECIMAL, IN `VASIS` DECIMAL, IN `VTRI` INT)  BEGIN

SELECT p.idPersona
FROM persona p
WHERE p.cedula = VCED and p.disponible != 0 LIMIT 1
INTO @idPer;

SELECT a.idalumno
FROM alumno a
WHERE a.Persona_idPersona = @idPer
INTO @idAlumno;

SELECT gan.idNota
FROM grado_estudiante_nota gan
WHERE gan.idGrado = VIDGR AND gan.idMateria = VIDMAT AND gan.idEstudiante = @idAlumno AND gan.trimestre = VTRI
INTO @idNota;

UPDATE nota
SET trabajo_cotidiano = VCOT,
pruebas = VPRU,
tareas = VTAREA,
asistencia = VASIS
WHERE idnota = @idNota;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertaProfesor` (IN `VCED` VARCHAR(45), IN `VNOM` VARCHAR(45), IN `VAP1` VARCHAR(45), IN `VAP2` VARCHAR(45), IN `VSEXO` VARCHAR(20), IN `VDIR` VARCHAR(100), IN `VTEL` VARCHAR(45), IN `VEMAIL` VARCHAR(45), IN `VNAC` INT, IN `VGRADO` INT, IN `VPASS` VARCHAR(80), IN `VMAT` INT, IN `VTIPO` INT)  BEGIN
 INSERT INTO persona( cedula, nombre, apellido1, apellido2, sexo, direccion,telefono,email,idNacionalidad)
 VALUES(VCED,VNOM,VAP1,VAP2,VSEXO,VDIR,VTEL,VEMAIL,VNAC);

 SELECT idPersona
 FROM persona
 WHERE cedula = VCED LIMIT 1
 INTO @id;


 INSERT INTO profesor(Persona_idPersona,tipo)VALUES(@id,VTIPO);


 SELECT idprofesor
 FROM profesor
 WHERE Persona_idPersona = @id LIMIT 1
 INTO @idP;

 INSERT INTO usuario(idPersona,idRol,password,cambio)
 VALUES (@id,1,VPASS,1);

IF VTIPO !=0 THEN
SELECT MIN(idGrado), MAX(idGrado)
INTO @min,@max
FROM grado
WHERE LOWER(nombreGrado) NOT LIKE '%primero%'and LOWER(nombreGrado) NOT LIKE '%1%';
WHILE @min <= @max DO
    INSERT INTO profesor_materia_grado(profesor_idprofesor,materia_idmateria,id_grado)VALUES(@idP,VMAT,@min);
    SET @min=@min+1;
END WHILE;
ELSE
	SELECT MIN(mat.idmateria), MAX(mat.idmateria)
    INTO @minTipo,@maxTipo
    FROM materia mat;

    WHILE @minTipo <= @maxTipo DO
    	SELECT ma.idmateria
        INTO @idMa
        FROM materia ma, tipo_materia ti
        WHERE LOWER(ti.tipo) LIKE '%basica%' AND ma.idTipoMateria = ti.idTipo AND ma.idmateria = @minTipo;
       IF @idMa IS NOT NULL THEN
        INSERT INTO profesor_materia_grado(profesor_idprofesor,materia_idmateria,id_grado)VALUES(@idP,@idMa,VGRADO);
        SET @idMa = NULL;
        END IF;
    	SET @minTipo=@minTipo+1;

    END WHILE;
END IF;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarEmpleado` (IN `CED` VARCHAR(20), IN `NOM` VARCHAR(35), IN `APE1` VARCHAR(35), IN `APE2` VARCHAR(35), IN `SEX` VARCHAR(20), IN `DIRECC` VARCHAR(50), IN `TEL` VARCHAR(25), IN `NAC` INT, IN `PUE` INT)  BEGIN

 INSERT INTO persona (CEDULA,NOMBRE,APELLIDO1,APELLIDO2,SEXO,DIRECCION,TELEFONO,idNacionalidad) VALUES(CED,NOM,APE1,APE2,SEX,DIRECC,TEL,NAC);

 SELECT idPersona FROM persona WHERE CEDULA = CED LIMIT 1 INTO @id ;

 INSERT INTO empleado(idPersona,idPuesto) VALUES(@id,PUE);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Login` (OUT `pass` VARCHAR(150), IN `ced` VARCHAR(25), OUT `id` INT, OUT `rol` VARCHAR(50), OUT `nombre` VARCHAR(50), OUT `ocambio` INT, OUT `ogrupo` VARCHAR(80), OUT `idgrado` INT, OUT `oemail` VARCHAR(60), OUT `ogrado` VARCHAR(50), OUT `idtipo` INT, OUT `tipoPro` INT)  BEGIN
select u.password,p.idPersona, r.tiporol ,CONCAT(p.nombre,' ',CONCAT(p.apellido1,' ',p.apellido2)) as nombre,u.cambio ,concat(gr.nombreGrado,' ',gr.annio) as grado,gr.idGrado,p.email,gr.nombreGrado,ti.idTipo,pro.tipo
into pass,id,rol,nombre,ocambio,ogrupo,idgrado,oemail,ogrado,idtipo,tipoPro
from usuario u, persona p , rol r ,profesor_materia_grado pmg,profesor pro,grado gr,tipo_materia ti, materia ma
where gr.idGrado = pmg.id_grado and pro.idProfesor = pmg.profesor_idprofesor and  u.idRol = r.IDROL and p.idPersona = u.idPersona and pro.Persona_idPersona = p.idPersona and p.cedula=ced and pmg.materia_idmateria = ma.idmateria and ma.idTipoMateria = ti.idTipo LIMIT 1;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ModificarProfesor` (IN `VCED` VARCHAR(40), IN `VNOM` VARCHAR(40), IN `VAP1` VARCHAR(40), IN `VAP2` VARCHAR(40), IN `VEXO` VARCHAR(24), IN `VDIR` VARCHAR(100), IN `VTEL` VARCHAR(50), IN `VEMAIL` VARCHAR(50), IN `VNAC` INT, IN `VANNIO` INT, IN `VGRADO` INT)  NO SQL
BEGIN
UPDATE persona SET
nombre=VNOM,
apellido1=VAP1,
apellido2=VAP2,
sexo=VSEXO,
direccion=VDIR,
telefono=VTEL,
email=VEMAIL,
idNacionalidad=VNAC
WHERE cedula = VCED LIMIT 1;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `alumno`
--

CREATE TABLE `alumno` (
  `idalumno` int(11) NOT NULL,
  `Persona_idPersona` int(11) NOT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=630 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `alumno`
--

INSERT INTO `alumno` (`idalumno`, `Persona_idPersona`) VALUES
(1, 11),
(2, 12),
(3, 13),
(4, 15),
(5, 80),
(6, 81),
(7, 82),
(8, 133),
(9, 134),
(10, 136),
(11, 138),
(12, 140),
(13, 146),
(14, 147),
(15, 149),
(16, 150),
(27, 174),
(28, 175),
(29, 177),
(30, 179),
(31, 189),
(32, 193),
(33, 195),
(34, 196),
(35, 198),
(36, 200),
(37, 202),
(38, 203),
(39, 227),
(40, 228),
(41, 229);

-- --------------------------------------------------------

--
-- Table structure for table `alumno_encargado`
--

CREATE TABLE `alumno_encargado` (
  `ID_ALUMNO` int(11) NOT NULL,
  `ID_ENCARGADO` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `alumno_encargado`
--

INSERT INTO `alumno_encargado` (`ID_ALUMNO`, `ID_ENCARGADO`) VALUES
(16, 2),
(16, 3),
(28, 1),
(29, 1),
(34, 4);

-- --------------------------------------------------------

--
-- Table structure for table `asistencia`
--

CREATE TABLE `asistencia` (
  `IDASISTENCIA` int(11) NOT NULL,
  `ESTADO` tinyint(1) DEFAULT NULL,
  `NOTA` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `IDALUMNO` int(11) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  `IDGRADO` int(11) NOT NULL,
  `AUSENCIA` tinyint(1) DEFAULT NULL,
  `idProfesor` int(11) DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=512 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `asistencia`
--

INSERT INTO `asistencia` (`IDASISTENCIA`, `ESTADO`, `NOTA`, `IDALUMNO`, `FECHA`, `IDGRADO`, `AUSENCIA`, `idProfesor`) VALUES
(48, 1, 'No se ingresaron comentarios.', 5, '2018-10-21', 1, NULL, NULL),
(49, 0, '1', 3, '2018-10-21', 1, NULL, NULL),
(50, 1, 'No se ingresaron comentarios.', 6, '2018-10-21', 1, NULL, NULL),
(51, 0, '5', 7, '2018-10-21', 1, NULL, NULL),
(52, 0, '3', 1, '2018-10-21', 1, NULL, NULL),
(58, 1, 'No se ingresaron comentarios.', 7, '2018-10-22', 1, NULL, NULL),
(59, 1, 'No se ingresaron comentarios.', 6, '2018-10-22', 1, NULL, NULL),
(60, 1, 'No se ingresaron comentarios.', 5, '2018-10-22', 1, NULL, NULL),
(61, 1, 'No se ingresaron comentarios.', 1, '2018-10-22', 1, NULL, NULL),
(62, 1, 'No se ingresaron comentarios.', 3, '2018-10-22', 1, NULL, NULL),
(63, 1, 'No se ingresaron comentarios.', 1, '2018-10-22', 1, NULL, NULL),
(64, 1, 'No se ingresaron comentarios.', 3, '2018-10-22', 1, NULL, NULL),
(65, 0, 'Porque es gay', 5, '2018-10-22', 1, NULL, NULL),
(66, 0, 'Porque es muy guapo', 6, '2018-10-22', 1, NULL, NULL),
(67, 1, 'No se ingresaron comentarios.', 7, '2018-10-22', 1, NULL, NULL),
(68, 0, 'No se ingresaron comentarios.', 3, '2018-10-22', 1, NULL, NULL),
(69, 1, 'No se ingresaron comentarios.', 6, '2018-10-22', 1, NULL, NULL),
(70, 0, 'No se ingresaron comentarios.', 5, '2018-10-22', 1, NULL, NULL),
(71, 1, 'No se ingresaron comentarios.', 7, '2018-10-22', 1, NULL, NULL),
(72, 1, 'No se ingresaron comentarios.', 1, '2018-10-22', 1, NULL, NULL),
(155, 1, 'No se ingresaron comentarios.', 1, '2018-10-26', 1, NULL, NULL),
(156, 0, 'Por fea', 3, '2018-10-26', 1, 1, NULL),
(157, 1, 'No se ingresaron comentarios.', 6, '2018-10-26', 1, NULL, NULL),
(158, 0, 'Enfermo y playo', 5, '2018-10-26', 1, 1, NULL),
(159, 0, 'No se ingresaron comentarios.', 7, '2018-10-26', 1, 0, NULL),
(160, 1, 'No se ingresaron comentarios.', 1, '2018-10-27', 1, NULL, NULL),
(161, 1, 'No se ingresaron comentarios.', 3, '2018-10-27', 1, NULL, NULL),
(162, 1, 'No se ingresaron comentarios.', 6, '2018-10-27', 1, NULL, NULL),
(163, 1, 'No se ingresaron comentarios.', 7, '2018-10-27', 1, NULL, NULL),
(164, 1, 'No se ingresaron comentarios.', 5, '2018-10-27', 1, NULL, NULL),
(165, 0, 'No se ingresaron comentarios.', 1, '2018-10-28', 1, 1, NULL),
(166, 0, 'No quizo venir', 3, '2018-10-28', 1, 1, NULL),
(167, 1, 'No se ingresaron comentarios.', 6, '2018-10-28', 1, NULL, NULL),
(168, 0, 'No se ingresaron comentarios.', 5, '2018-10-28', 1, 1, NULL),
(169, 0, 'No se ingresaron comentarios.', 7, '2018-10-28', 1, 0, NULL),
(223, 1, 'No se ingresaron comentarios.', 29, '2018-11-12', 5, NULL, 57),
(224, 1, 'No se ingresaron comentarios.', 28, '2018-11-12', 5, NULL, 57),
(225, 0, 'No se ingresaron comentarios.', 30, '2018-11-12', 5, 0, 57),
(226, 0, 'No se ingresaron comentarios.', 27, '2018-11-12', 5, 0, 57),
(227, 0, 'No se ingresaron comentarios.', 32, '2018-11-12', 5, 0, 57),
(228, 0, 'No se ingresaron comentarios.', 33, '2018-11-12', 5, 0, 57),
(229, 1, 'No se ingresaron comentarios.', 34, '2018-11-12', 5, NULL, 57),
(230, 1, 'No se ingresaron comentarios.', 35, '2018-11-12', 5, NULL, 57),
(231, 1, 'No se ingresaron comentarios.', 36, '2018-11-12', 5, NULL, 57),
(232, 1, 'No se ingresaron comentarios.', 37, '2018-11-12', 5, NULL, 57),
(233, 0, 'Tuvo que ir al hospital', 40, '2018-11-12', 5, 1, 57),
(234, 1, 'No se ingresaron comentarios.', 41, '2018-11-12', 5, NULL, 57),
(235, 0, 'No se ingresaron comentarios.', 39, '2018-11-12', 5, 0, 57),
(236, 1, 'No se ingresaron comentarios.', 16, '2018-11-12', 5, NULL, 57),
(237, 1, 'No se ingresaron comentarios.', 38, '2018-11-12', 5, NULL, 57),
(238, 1, 'No se ingresaron comentarios.', 15, '2018-11-12', 5, NULL, 57);

--
-- Triggers `asistencia`
--
DELIMITER $$
CREATE TRIGGER `trgg_ausencia` BEFORE INSERT ON `asistencia` FOR EACH ROW BEGIN
           IF NEW.ESTADO = 0 THEN
               SET NEW.AUSENCIA = 0;
           END IF;
       END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `beca`
--

CREATE TABLE `beca` (
  `idbeca` int(11) NOT NULL,
  `descripcion_beca` varchar(500) CHARACTER SET utf8 NOT NULL,
  `monto_beca` varchar(45) CHARACTER SET utf8 NOT NULL,
  `idAlumno` int(11) NOT NULL,
  `estado` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `beca`
--

INSERT INTO `beca` (`idbeca`, `descripcion_beca`, `monto_beca`, `idAlumno`, `estado`) VALUES
(1, 'Motivo de la beca es privado y no puede ser revelado', '55000', 2, 1),
(2, 'Motivo personal', '35000', 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `director`
--

CREATE TABLE `director` (
  `idDirector` int(11) NOT NULL,
  `Persona_idPersona` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `empleado`
--

CREATE TABLE `empleado` (
  `idEmpleado` int(11) NOT NULL,
  `idPersona` int(11) NOT NULL,
  `idPuesto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `empleado`
--

INSERT INTO `empleado` (`idEmpleado`, `idPersona`, `idPuesto`) VALUES
(1, 10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `encargado`
--

CREATE TABLE `encargado` (
  `idencargado` int(11) NOT NULL,
  `Persona_idPersona` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `encargado`
--

INSERT INTO `encargado` (`idencargado`, `Persona_idPersona`) VALUES
(1, 184),
(2, 185),
(3, 191),
(4, 204);

-- --------------------------------------------------------

--
-- Table structure for table `grado`
--

CREATE TABLE `grado` (
  `idgrado` int(11) NOT NULL,
  `nombreGrado` varchar(45) CHARACTER SET utf8 NOT NULL,
  `annio` int(11) NOT NULL,
  `ciclo` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB AVG_ROW_LENGTH=1820 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `grado`
--

INSERT INTO `grado` (`idgrado`, `nombreGrado`, `annio`, `ciclo`) VALUES
(1, 'Primero', 2018, 3),
(2, 'Segundo', 2018, 0),
(3, 'Tercero', 2018, 1),
(4, 'Cuarto', 2018, 1),
(5, 'Quinto', 2018, 0),
(6, 'Sexto', 2018, 1);

-- --------------------------------------------------------

--
-- Table structure for table `grado_estudiante_nota`
--

CREATE TABLE `grado_estudiante_nota` (
  `idGrado` int(11) NOT NULL,
  `idMateria` int(11) NOT NULL,
  `idNota` int(11) NOT NULL,
  `idEstudiante` int(11) NOT NULL,
  `trimestre` int(11) DEFAULT NULL,
  `aprobado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `grado_estudiante_nota`
--

INSERT INTO `grado_estudiante_nota` (`idGrado`, `idMateria`, `idNota`, `idEstudiante`, `trimestre`, `aprobado`) VALUES
(1, 5, 2, 8, 1, 0),
(1, 5, 9, 9, 1, 0),
(1, 5, 16, 10, 1, 0),
(1, 5, 23, 11, 1, 0),
(1, 5, 30, 12, 1, 0),
(1, 6, 3, 8, 1, 0),
(1, 6, 10, 9, 1, 0),
(1, 6, 17, 10, 1, 0),
(1, 6, 24, 11, 1, 0),
(1, 6, 31, 12, 1, 0),
(1, 7, 4, 8, 1, 0),
(1, 7, 11, 9, 1, 0),
(1, 7, 18, 10, 1, 0),
(1, 7, 25, 11, 1, 0),
(1, 7, 32, 12, 1, 0),
(1, 8, 5, 8, 1, 0),
(1, 8, 12, 9, 1, 0),
(1, 8, 19, 10, 1, 0),
(1, 8, 26, 11, 1, 0),
(1, 8, 33, 12, 1, 0),
(1, 9, 6, 8, 1, 0),
(1, 9, 13, 9, 1, 0),
(1, 9, 20, 10, 1, 0),
(1, 9, 27, 11, 1, 0),
(1, 9, 34, 12, 1, 0),
(1, 10, 7, 8, 1, 0),
(1, 10, 14, 9, 1, 0),
(1, 10, 21, 10, 1, 0),
(1, 10, 28, 11, 1, 0),
(1, 10, 35, 12, 1, 0),
(1, 11, 8, 8, 1, 0),
(1, 11, 15, 9, 1, 0),
(1, 11, 22, 10, 1, 0),
(1, 11, 29, 11, 1, 0),
(1, 11, 36, 12, 1, 0),
(2, 5, 37, 13, 1, 0),
(2, 6, 38, 13, 1, 0),
(2, 7, 39, 13, 1, 0),
(2, 8, 40, 13, 1, 0),
(2, 9, 41, 13, 1, 0),
(2, 10, 42, 13, 1, 0),
(2, 11, 43, 13, 1, 0),
(3, 5, 44, 14, 1, 0),
(3, 6, 45, 14, 1, 0),
(3, 7, 46, 14, 1, 0),
(3, 8, 47, 14, 1, 0),
(3, 9, 48, 14, 1, 0),
(3, 10, 49, 14, 1, 0),
(3, 11, 50, 14, 1, 0),
(4, 5, 389, 31, 1, 0),
(4, 5, 390, 31, 2, 0),
(4, 5, 391, 31, 3, 0),
(4, 6, 392, 31, 1, 0),
(4, 6, 393, 31, 2, 0),
(4, 6, 394, 31, 3, 0),
(4, 7, 395, 31, 1, 0),
(4, 7, 396, 31, 2, 0),
(4, 7, 397, 31, 3, 0),
(4, 8, 398, 31, 1, 0),
(4, 8, 399, 31, 2, 0),
(4, 8, 400, 31, 3, 0),
(4, 9, 401, 31, 1, 0),
(4, 9, 402, 31, 2, 0),
(4, 9, 403, 31, 3, 0),
(4, 10, 404, 31, 1, 0),
(4, 10, 405, 31, 2, 0),
(4, 10, 406, 31, 3, 0),
(4, 11, 407, 31, 1, 0),
(4, 11, 408, 31, 2, 0),
(4, 11, 409, 31, 3, 0),
(5, 5, 51, 15, 1, 0),
(5, 5, 58, 16, 1, 0),
(5, 5, 305, 27, 1, 0),
(5, 5, 306, 27, 2, 0),
(5, 5, 307, 27, 3, 0),
(5, 5, 326, 28, 1, 0),
(5, 5, 327, 28, 2, 0),
(5, 5, 328, 28, 3, 0),
(5, 5, 347, 29, 1, 0),
(5, 5, 348, 29, 2, 0),
(5, 5, 349, 29, 3, 0),
(5, 5, 368, 30, 1, 0),
(5, 5, 369, 30, 2, 0),
(5, 5, 370, 30, 3, 0),
(5, 5, 410, 32, 1, 0),
(5, 5, 411, 32, 2, 0),
(5, 5, 412, 32, 3, 0),
(5, 5, 431, 33, 1, 0),
(5, 5, 432, 33, 2, 0),
(5, 5, 433, 33, 3, 0),
(5, 5, 452, 34, 1, 0),
(5, 5, 453, 34, 2, 0),
(5, 5, 454, 34, 3, 0),
(5, 5, 473, 35, 1, 0),
(5, 5, 474, 35, 2, 0),
(5, 5, 475, 35, 3, 0),
(5, 5, 494, 36, 1, 0),
(5, 5, 495, 36, 2, 0),
(5, 5, 496, 36, 3, 0),
(5, 5, 515, 37, 1, 0),
(5, 5, 516, 37, 2, 0),
(5, 5, 517, 37, 3, 0),
(5, 5, 536, 38, 1, 0),
(5, 5, 537, 38, 2, 0),
(5, 5, 538, 38, 3, 0),
(5, 5, 557, 39, 1, 0),
(5, 5, 558, 39, 2, 0),
(5, 5, 559, 39, 3, 0),
(5, 5, 578, 40, 1, 0),
(5, 5, 579, 40, 2, 0),
(5, 5, 580, 40, 3, 0),
(5, 5, 599, 41, 1, 0),
(5, 5, 600, 41, 2, 0),
(5, 5, 601, 41, 3, 0),
(5, 6, 52, 15, 1, 0),
(5, 6, 59, 16, 1, 0),
(5, 6, 308, 27, 1, 0),
(5, 6, 309, 27, 2, 0),
(5, 6, 310, 27, 3, 0),
(5, 6, 329, 28, 1, 0),
(5, 6, 330, 28, 2, 0),
(5, 6, 331, 28, 3, 0),
(5, 6, 350, 29, 1, 0),
(5, 6, 351, 29, 2, 0),
(5, 6, 352, 29, 3, 0),
(5, 6, 371, 30, 1, 0),
(5, 6, 372, 30, 2, 0),
(5, 6, 373, 30, 3, 0),
(5, 6, 413, 32, 1, 0),
(5, 6, 414, 32, 2, 0),
(5, 6, 415, 32, 3, 0),
(5, 6, 434, 33, 1, 0),
(5, 6, 435, 33, 2, 0),
(5, 6, 436, 33, 3, 0),
(5, 6, 455, 34, 1, 0),
(5, 6, 456, 34, 2, 0),
(5, 6, 457, 34, 3, 0),
(5, 6, 476, 35, 1, 0),
(5, 6, 477, 35, 2, 0),
(5, 6, 478, 35, 3, 0),
(5, 6, 497, 36, 1, 0),
(5, 6, 498, 36, 2, 0),
(5, 6, 499, 36, 3, 0),
(5, 6, 518, 37, 1, 0),
(5, 6, 519, 37, 2, 0),
(5, 6, 520, 37, 3, 0),
(5, 6, 539, 38, 1, 0),
(5, 6, 540, 38, 2, 0),
(5, 6, 541, 38, 3, 0),
(5, 6, 560, 39, 1, 0),
(5, 6, 561, 39, 2, 0),
(5, 6, 562, 39, 3, 0),
(5, 6, 581, 40, 1, 0),
(5, 6, 582, 40, 2, 0),
(5, 6, 583, 40, 3, 0),
(5, 6, 602, 41, 1, 0),
(5, 6, 603, 41, 2, 0),
(5, 6, 604, 41, 3, 0),
(5, 7, 53, 15, 1, 0),
(5, 7, 60, 16, 1, 0),
(5, 7, 311, 27, 1, 0),
(5, 7, 312, 27, 2, 0),
(5, 7, 313, 27, 3, 0),
(5, 7, 332, 28, 1, 0),
(5, 7, 333, 28, 2, 0),
(5, 7, 334, 28, 3, 0),
(5, 7, 353, 29, 1, 0),
(5, 7, 354, 29, 2, 0),
(5, 7, 355, 29, 3, 0),
(5, 7, 374, 30, 1, 0),
(5, 7, 375, 30, 2, 0),
(5, 7, 376, 30, 3, 0),
(5, 7, 416, 32, 1, 0),
(5, 7, 417, 32, 2, 0),
(5, 7, 418, 32, 3, 0),
(5, 7, 437, 33, 1, 0),
(5, 7, 438, 33, 2, 0),
(5, 7, 439, 33, 3, 0),
(5, 7, 458, 34, 1, 0),
(5, 7, 459, 34, 2, 0),
(5, 7, 460, 34, 3, 0),
(5, 7, 479, 35, 1, 0),
(5, 7, 480, 35, 2, 0),
(5, 7, 481, 35, 3, 0),
(5, 7, 500, 36, 1, 0),
(5, 7, 501, 36, 2, 0),
(5, 7, 502, 36, 3, 0),
(5, 7, 521, 37, 1, 0),
(5, 7, 522, 37, 2, 0),
(5, 7, 523, 37, 3, 0),
(5, 7, 542, 38, 1, 0),
(5, 7, 543, 38, 2, 0),
(5, 7, 544, 38, 3, 0),
(5, 7, 563, 39, 1, 0),
(5, 7, 564, 39, 2, 0),
(5, 7, 565, 39, 3, 0),
(5, 7, 584, 40, 1, 0),
(5, 7, 585, 40, 2, 0),
(5, 7, 586, 40, 3, 0),
(5, 7, 605, 41, 1, 0),
(5, 7, 606, 41, 2, 0),
(5, 7, 607, 41, 3, 0),
(5, 8, 54, 15, 1, 0),
(5, 8, 61, 16, 1, 0),
(5, 8, 314, 27, 1, 0),
(5, 8, 315, 27, 2, 0),
(5, 8, 316, 27, 3, 0),
(5, 8, 335, 28, 1, 0),
(5, 8, 336, 28, 2, 0),
(5, 8, 337, 28, 3, 0),
(5, 8, 356, 29, 1, 0),
(5, 8, 357, 29, 2, 0),
(5, 8, 358, 29, 3, 0),
(5, 8, 377, 30, 1, 0),
(5, 8, 378, 30, 2, 0),
(5, 8, 379, 30, 3, 0),
(5, 8, 419, 32, 1, 0),
(5, 8, 420, 32, 2, 0),
(5, 8, 421, 32, 3, 0),
(5, 8, 440, 33, 1, 0),
(5, 8, 441, 33, 2, 0),
(5, 8, 442, 33, 3, 0),
(5, 8, 461, 34, 1, 0),
(5, 8, 462, 34, 2, 0),
(5, 8, 463, 34, 3, 0),
(5, 8, 482, 35, 1, 0),
(5, 8, 483, 35, 2, 0),
(5, 8, 484, 35, 3, 0),
(5, 8, 503, 36, 1, 0),
(5, 8, 504, 36, 2, 0),
(5, 8, 505, 36, 3, 0),
(5, 8, 524, 37, 1, 0),
(5, 8, 525, 37, 2, 0),
(5, 8, 526, 37, 3, 0),
(5, 8, 545, 38, 1, 0),
(5, 8, 546, 38, 2, 0),
(5, 8, 547, 38, 3, 0),
(5, 8, 566, 39, 1, 0),
(5, 8, 567, 39, 2, 0),
(5, 8, 568, 39, 3, 0),
(5, 8, 587, 40, 1, 0),
(5, 8, 588, 40, 2, 0),
(5, 8, 589, 40, 3, 0),
(5, 8, 608, 41, 1, 0),
(5, 8, 609, 41, 2, 0),
(5, 8, 610, 41, 3, 0),
(5, 9, 55, 15, 1, 0),
(5, 9, 62, 16, 1, 0),
(5, 9, 317, 27, 1, 0),
(5, 9, 318, 27, 2, 0),
(5, 9, 319, 27, 3, 0),
(5, 9, 338, 28, 1, 0),
(5, 9, 339, 28, 2, 0),
(5, 9, 340, 28, 3, 0),
(5, 9, 359, 29, 1, 0),
(5, 9, 360, 29, 2, 0),
(5, 9, 361, 29, 3, 0),
(5, 9, 380, 30, 1, 0),
(5, 9, 381, 30, 2, 0),
(5, 9, 382, 30, 3, 0),
(5, 9, 422, 32, 1, 0),
(5, 9, 423, 32, 2, 0),
(5, 9, 424, 32, 3, 0),
(5, 9, 443, 33, 1, 0),
(5, 9, 444, 33, 2, 0),
(5, 9, 445, 33, 3, 0),
(5, 9, 464, 34, 1, 0),
(5, 9, 465, 34, 2, 0),
(5, 9, 466, 34, 3, 0),
(5, 9, 485, 35, 1, 0),
(5, 9, 486, 35, 2, 0),
(5, 9, 487, 35, 3, 0),
(5, 9, 506, 36, 1, 0),
(5, 9, 507, 36, 2, 0),
(5, 9, 508, 36, 3, 0),
(5, 9, 527, 37, 1, 0),
(5, 9, 528, 37, 2, 0),
(5, 9, 529, 37, 3, 0),
(5, 9, 548, 38, 1, 0),
(5, 9, 549, 38, 2, 0),
(5, 9, 550, 38, 3, 0),
(5, 9, 569, 39, 1, 0),
(5, 9, 570, 39, 2, 0),
(5, 9, 571, 39, 3, 0),
(5, 9, 590, 40, 1, 0),
(5, 9, 591, 40, 2, 0),
(5, 9, 592, 40, 3, 0),
(5, 9, 611, 41, 1, 0),
(5, 9, 612, 41, 2, 0),
(5, 9, 613, 41, 3, 0),
(5, 10, 56, 15, 1, 0),
(5, 10, 63, 16, 1, 0),
(5, 10, 320, 27, 1, 0),
(5, 10, 321, 27, 2, 0),
(5, 10, 322, 27, 3, 0),
(5, 10, 341, 28, 1, 0),
(5, 10, 342, 28, 2, 0),
(5, 10, 343, 28, 3, 0),
(5, 10, 362, 29, 1, 0),
(5, 10, 363, 29, 2, 0),
(5, 10, 364, 29, 3, 0),
(5, 10, 383, 30, 1, 0),
(5, 10, 384, 30, 2, 0),
(5, 10, 385, 30, 3, 0),
(5, 10, 425, 32, 1, 0),
(5, 10, 426, 32, 2, 0),
(5, 10, 427, 32, 3, 0),
(5, 10, 446, 33, 1, 0),
(5, 10, 447, 33, 2, 0),
(5, 10, 448, 33, 3, 0),
(5, 10, 467, 34, 1, 0),
(5, 10, 468, 34, 2, 0),
(5, 10, 469, 34, 3, 0),
(5, 10, 488, 35, 1, 0),
(5, 10, 489, 35, 2, 0),
(5, 10, 490, 35, 3, 0),
(5, 10, 509, 36, 1, 0),
(5, 10, 510, 36, 2, 0),
(5, 10, 511, 36, 3, 0),
(5, 10, 530, 37, 1, 0),
(5, 10, 531, 37, 2, 0),
(5, 10, 532, 37, 3, 0),
(5, 10, 551, 38, 1, 0),
(5, 10, 552, 38, 2, 0),
(5, 10, 553, 38, 3, 0),
(5, 10, 572, 39, 1, 0),
(5, 10, 573, 39, 2, 0),
(5, 10, 574, 39, 3, 0),
(5, 10, 593, 40, 1, 0),
(5, 10, 594, 40, 2, 0),
(5, 10, 595, 40, 3, 0),
(5, 10, 614, 41, 1, 0),
(5, 10, 615, 41, 2, 0),
(5, 10, 616, 41, 3, 0),
(5, 11, 57, 15, 1, 0),
(5, 11, 64, 16, 1, 0),
(5, 11, 323, 27, 1, 0),
(5, 11, 324, 27, 2, 0),
(5, 11, 325, 27, 3, 0),
(5, 11, 344, 28, 1, 0),
(5, 11, 345, 28, 2, 0),
(5, 11, 346, 28, 3, 0),
(5, 11, 365, 29, 1, 0),
(5, 11, 366, 29, 2, 0),
(5, 11, 367, 29, 3, 0),
(5, 11, 386, 30, 1, 0),
(5, 11, 387, 30, 2, 0),
(5, 11, 388, 30, 3, 0),
(5, 11, 428, 32, 1, 0),
(5, 11, 429, 32, 2, 0),
(5, 11, 430, 32, 3, 0),
(5, 11, 449, 33, 1, 0),
(5, 11, 450, 33, 2, 0),
(5, 11, 451, 33, 3, 0),
(5, 11, 470, 34, 1, 0),
(5, 11, 471, 34, 2, 0),
(5, 11, 472, 34, 3, 0),
(5, 11, 491, 35, 1, 0),
(5, 11, 492, 35, 2, 0),
(5, 11, 493, 35, 3, 0),
(5, 11, 512, 36, 1, 0),
(5, 11, 513, 36, 2, 0),
(5, 11, 514, 36, 3, 0),
(5, 11, 533, 37, 1, 0),
(5, 11, 534, 37, 2, 0),
(5, 11, 535, 37, 3, 0),
(5, 11, 554, 38, 1, 0),
(5, 11, 555, 38, 2, 0),
(5, 11, 556, 38, 3, 0),
(5, 11, 575, 39, 1, 0),
(5, 11, 576, 39, 2, 0),
(5, 11, 577, 39, 3, 0),
(5, 11, 596, 40, 1, 0),
(5, 11, 597, 40, 2, 0),
(5, 11, 598, 40, 3, 0),
(5, 11, 617, 41, 1, 0),
(5, 11, 618, 41, 2, 0),
(5, 11, 619, 41, 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `historico_usuarios`
--

CREATE TABLE `historico_usuarios` (
  `idHistorico` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pass` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `historico_usuarios`
--

INSERT INTO `historico_usuarios` (`idHistorico`, `idUsuario`, `email`, `pass`, `fecha`) VALUES
(1, 40, 'osoto@gmail.com', '123', '2018-11-09'),
(2, 41, 'oscarsoto040797@gmail.com', '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', '2018-11-10'),
(3, 41, 'oscarsoto040797@gmail.com', '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMn', '2018-11-10'),
(4, 41, 'oscarsoto040797@gmail.com', '$2y$09$6xz5BYSFzFgdMVW.fORJeu3TM6G4vsAg6nGeFi10yiSvimCpk6GGq', '2018-11-10'),
(5, 41, 'oscarsoto040797@gmail.com', '$2y$09$FevSbjbrNDF/BJwH88i9neXSbgSwyvaHXJ9S9IuqhTK1J519qey6O', '2018-11-10'),
(6, 41, 'oscarsoto040797@gmail.com', '$2y$09$ccL9oKrlm2D9.QgGyfPbiOckjaDzcS.rkugkLl8nk8rHLAnYCCrBO', '2018-11-10'),
(7, 41, 'oscarsoto040797@gmail.com', '$2y$09$OhDt/gDghRt0hAFjgTKwuurEx3uWhll3F/SavO6Wx5VyLuiGUZtTy', '2018-11-10'),
(8, 41, 'oscarsoto040797@gmail.com', '$2y$09$tgzzlGdLJZELTYU1lwzfV.FTMkc459HO.MRwO5UVPsRjMejhtckaS', '2018-11-10'),
(9, 41, 'oscarsoto040797@gmail.com', '$2y$09$5R7xpLY/Beu71VipmZFs7.eFijD30zEx4XJCbQ6SCaqppdE4BYabm', '2018-11-10'),
(10, 41, 'oscarsoto040797@gmail.com', '$2y$09$luizeMfMr/67CVM5obXaV.TL5WuGaa3qrbmU6eueR5MuUbDGPqP/2', '2018-11-10'),
(11, 45, 'oscarsoto040797@gmail.com', '$2y$09$3.qUDCGulnpjBy7CCoTzou2WN07QDQyFJTUSIAX6.hgRqeJIv/WkC', '2018-11-12');

-- --------------------------------------------------------

--
-- Table structure for table `materia`
--

CREATE TABLE `materia` (
  `idmateria` int(11) NOT NULL,
  `nombre` varchar(45) CHARACTER SET latin1 NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `idTipoMateria` int(11) DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=2048 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `materia`
--

INSERT INTO `materia` (`idmateria`, `nombre`, `estado`, `idTipoMateria`) VALUES
(5, 'Ingles', 1, 2),
(6, 'Español', 1, 1),
(7, 'Ciencias', 1, 1),
(8, 'Matematicas', 1, 1),
(9, 'Religion', 1, 3),
(10, 'Educacion Musical', 1, 4),
(11, 'Estudios Sociales', 1, 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `mostrar_encargado`
-- (See below for the actual view)
--
CREATE TABLE `mostrar_encargado` (
`cedula_e` varchar(45)
,`cedula` varchar(45)
,`nombre` varchar(137)
,`telefono` varchar(45)
,`telefono_secundario` varchar(45)
,`direccion` varchar(100)
);

-- --------------------------------------------------------

--
-- Table structure for table `nacionalidad`
--

CREATE TABLE `nacionalidad` (
  `idNacionalidad` int(11) NOT NULL,
  `pais` varchar(45) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nacionalidad`
--

INSERT INTO `nacionalidad` (`idNacionalidad`, `pais`) VALUES
(1, 'Costa Rica'),
(2, 'Nicaragua');

-- --------------------------------------------------------

--
-- Table structure for table `nota`
--

CREATE TABLE `nota` (
  `idnota` int(11) NOT NULL,
  `trabajo_cotidiano` decimal(8,2) DEFAULT '0.00',
  `asistencia` decimal(8,2) DEFAULT '0.00',
  `tareas` decimal(8,2) DEFAULT '0.00',
  `pruebas` decimal(8,2) DEFAULT '0.00',
  `total` decimal(8,2) DEFAULT '0.00'
) ENGINE=InnoDB AVG_ROW_LENGTH=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nota`
--

INSERT INTO `nota` (`idnota`, `trabajo_cotidiano`, `asistencia`, `tareas`, `pruebas`, `total`) VALUES
(1, '0.00', '0.00', '0.00', '0.00', '0.00'),
(2, '0.00', '0.00', '0.00', '0.00', '0.00'),
(3, '0.00', '0.00', '0.00', '0.00', '0.00'),
(4, '0.00', '0.00', '0.00', '0.00', '0.00'),
(5, '0.00', '0.00', '0.00', '0.00', '0.00'),
(6, '0.00', '0.00', '0.00', '0.00', '0.00'),
(7, '0.00', '0.00', '0.00', '0.00', '0.00'),
(8, '0.00', '0.00', '0.00', '0.00', '0.00'),
(9, '0.00', '0.00', '0.00', '0.00', '0.00'),
(10, '0.00', '0.00', '0.00', '0.00', '0.00'),
(11, '0.00', '0.00', '0.00', '0.00', '0.00'),
(12, '0.00', '0.00', '0.00', '0.00', '0.00'),
(13, '0.00', '0.00', '0.00', '0.00', '0.00'),
(14, '0.00', '0.00', '0.00', '0.00', '0.00'),
(15, '0.00', '0.00', '0.00', '0.00', '0.00'),
(16, '0.00', '0.00', '0.00', '0.00', '0.00'),
(17, '0.00', '0.00', '0.00', '0.00', '0.00'),
(18, '0.00', '0.00', '0.00', '0.00', '0.00'),
(19, '0.00', '0.00', '0.00', '0.00', '0.00'),
(20, '0.00', '0.00', '0.00', '0.00', '0.00'),
(21, '0.00', '0.00', '0.00', '0.00', '0.00'),
(22, '0.00', '0.00', '0.00', '0.00', '0.00'),
(23, '0.00', '0.00', '0.00', '0.00', '0.00'),
(24, '0.00', '0.00', '0.00', '0.00', '0.00'),
(25, '0.00', '0.00', '0.00', '0.00', '0.00'),
(26, '0.00', '0.00', '0.00', '0.00', '0.00'),
(27, '0.00', '0.00', '0.00', '0.00', '0.00'),
(28, '0.00', '0.00', '0.00', '0.00', '0.00'),
(29, '0.00', '0.00', '0.00', '0.00', '0.00'),
(30, '0.00', '0.00', '0.00', '0.00', '0.00'),
(31, '0.00', '0.00', '0.00', '0.00', '0.00'),
(32, '0.00', '0.00', '0.00', '0.00', '0.00'),
(33, '0.00', '0.00', '0.00', '0.00', '0.00'),
(34, '0.00', '0.00', '0.00', '0.00', '0.00'),
(35, '0.00', '0.00', '0.00', '0.00', '0.00'),
(36, '0.00', '0.00', '0.00', '0.00', '0.00'),
(37, '0.00', '0.00', '0.00', '0.00', '0.00'),
(38, '0.00', '0.00', '0.00', '0.00', '0.00'),
(39, '0.00', '0.00', '0.00', '0.00', '0.00'),
(40, '0.00', '0.00', '0.00', '0.00', '0.00'),
(41, '0.00', '0.00', '0.00', '0.00', '0.00'),
(42, '0.00', '0.00', '0.00', '0.00', '0.00'),
(43, '0.00', '0.00', '0.00', '0.00', '0.00'),
(44, '0.00', '0.00', '0.00', '0.00', '0.00'),
(45, '0.00', '0.00', '0.00', '0.00', '0.00'),
(46, '0.00', '0.00', '0.00', '0.00', '0.00'),
(47, '0.00', '0.00', '0.00', '0.00', '0.00'),
(48, '0.00', '0.00', '0.00', '0.00', '0.00'),
(49, '0.00', '0.00', '0.00', '0.00', '0.00'),
(50, '0.00', '0.00', '0.00', '0.00', '0.00'),
(51, '0.00', '0.00', '0.00', '0.00', '0.00'),
(52, '6.00', '0.00', '0.00', '0.00', '0.00'),
(53, '0.00', '0.00', '0.00', '0.00', '0.00'),
(54, '0.00', '0.00', '0.00', '0.00', '0.00'),
(55, '0.00', '0.00', '0.00', '0.00', '0.00'),
(56, '0.00', '0.00', '0.00', '0.00', '0.00'),
(57, '0.00', '0.00', '0.00', '0.00', '0.00'),
(58, '0.00', '0.00', '0.00', '0.00', '0.00'),
(59, '5.00', '0.00', '0.00', '0.00', '0.00'),
(60, '0.00', '0.00', '0.00', '0.00', '0.00'),
(61, '0.00', '0.00', '0.00', '0.00', '0.00'),
(62, '5.00', '5.00', '1.00', '15.00', '0.00'),
(63, '0.00', '0.00', '0.00', '0.00', '0.00'),
(64, '0.00', '0.00', '0.00', '0.00', '0.00'),
(305, '0.00', '0.00', '0.00', '0.00', '0.00'),
(306, '0.00', '0.00', '0.00', '0.00', '0.00'),
(307, '0.00', '0.00', '0.00', '0.00', '0.00'),
(308, '10.00', '0.00', '0.00', '0.00', '0.00'),
(309, '0.00', '0.00', '0.00', '0.00', '0.00'),
(310, '0.00', '0.00', '0.00', '0.00', '0.00'),
(311, '0.00', '0.00', '0.00', '0.00', '0.00'),
(312, '0.00', '0.00', '0.00', '0.00', '0.00'),
(313, '0.00', '0.00', '0.00', '0.00', '0.00'),
(314, '0.00', '0.00', '0.00', '0.00', '0.00'),
(315, '0.00', '0.00', '0.00', '0.00', '0.00'),
(316, '0.00', '0.00', '0.00', '0.00', '0.00'),
(317, '0.00', '0.00', '0.00', '0.00', '0.00'),
(318, '0.00', '0.00', '0.00', '0.00', '0.00'),
(319, '0.00', '0.00', '0.00', '0.00', '0.00'),
(320, '0.00', '0.00', '0.00', '0.00', '0.00'),
(321, '0.00', '0.00', '0.00', '0.00', '0.00'),
(322, '0.00', '0.00', '0.00', '0.00', '0.00'),
(323, '0.00', '0.00', '0.00', '0.00', '0.00'),
(324, '0.00', '0.00', '0.00', '0.00', '0.00'),
(325, '0.00', '0.00', '0.00', '0.00', '0.00'),
(326, '0.00', '0.00', '0.00', '0.00', '0.00'),
(327, '0.00', '0.00', '0.00', '0.00', '0.00'),
(328, '0.00', '0.00', '0.00', '0.00', '0.00'),
(329, '7.00', '0.00', '0.00', '0.00', '0.00'),
(330, '0.00', '0.00', '0.00', '0.00', '0.00'),
(331, '0.00', '0.00', '0.00', '0.00', '0.00'),
(332, '0.00', '0.00', '0.00', '0.00', '0.00'),
(333, '0.00', '0.00', '0.00', '0.00', '0.00'),
(334, '0.00', '0.00', '0.00', '0.00', '0.00'),
(335, '0.00', '0.00', '0.00', '0.00', '0.00'),
(336, '0.00', '0.00', '0.00', '0.00', '0.00'),
(337, '0.00', '0.00', '0.00', '0.00', '0.00'),
(338, '0.00', '0.00', '0.00', '0.00', '0.00'),
(339, '0.00', '0.00', '0.00', '0.00', '0.00'),
(340, '0.00', '0.00', '0.00', '0.00', '0.00'),
(341, '0.00', '0.00', '0.00', '0.00', '0.00'),
(342, '0.00', '0.00', '0.00', '0.00', '0.00'),
(343, '0.00', '0.00', '0.00', '0.00', '0.00'),
(344, '0.00', '0.00', '0.00', '0.00', '0.00'),
(345, '0.00', '0.00', '0.00', '0.00', '0.00'),
(346, '0.00', '0.00', '0.00', '0.00', '0.00'),
(347, '0.00', '0.00', '0.00', '0.00', '0.00'),
(348, '0.00', '0.00', '0.00', '0.00', '0.00'),
(349, '0.00', '0.00', '0.00', '0.00', '0.00'),
(350, '0.00', '0.00', '0.00', '0.00', '0.00'),
(351, '0.00', '0.00', '0.00', '0.00', '0.00'),
(352, '0.00', '0.00', '0.00', '0.00', '0.00'),
(353, '0.00', '0.00', '0.00', '0.00', '0.00'),
(354, '0.00', '0.00', '0.00', '0.00', '0.00'),
(355, '0.00', '0.00', '0.00', '0.00', '0.00'),
(356, '0.00', '0.00', '0.00', '0.00', '0.00'),
(357, '0.00', '0.00', '0.00', '0.00', '0.00'),
(358, '0.00', '0.00', '0.00', '0.00', '0.00'),
(359, '0.00', '0.00', '0.00', '0.00', '0.00'),
(360, '0.00', '0.00', '0.00', '0.00', '0.00'),
(361, '0.00', '0.00', '0.00', '0.00', '0.00'),
(362, '0.00', '0.00', '0.00', '0.00', '0.00'),
(363, '0.00', '0.00', '0.00', '0.00', '0.00'),
(364, '0.00', '0.00', '0.00', '0.00', '0.00'),
(365, '0.00', '0.00', '0.00', '0.00', '0.00'),
(366, '0.00', '0.00', '0.00', '0.00', '0.00'),
(367, '0.00', '0.00', '0.00', '0.00', '0.00'),
(368, '0.00', '0.00', '0.00', '0.00', '0.00'),
(369, '0.00', '0.00', '0.00', '0.00', '0.00'),
(370, '0.00', '0.00', '0.00', '0.00', '0.00'),
(371, '0.00', '0.00', '0.00', '0.00', '0.00'),
(372, '0.00', '0.00', '0.00', '0.00', '0.00'),
(373, '0.00', '0.00', '0.00', '0.00', '0.00'),
(374, '0.00', '0.00', '0.00', '0.00', '0.00'),
(375, '0.00', '0.00', '0.00', '0.00', '0.00'),
(376, '0.00', '0.00', '0.00', '0.00', '0.00'),
(377, '0.00', '0.00', '0.00', '0.00', '0.00'),
(378, '0.00', '0.00', '0.00', '0.00', '0.00'),
(379, '0.00', '0.00', '0.00', '0.00', '0.00'),
(380, '0.00', '0.00', '0.00', '0.00', '0.00'),
(381, '0.00', '0.00', '0.00', '0.00', '0.00'),
(382, '0.00', '0.00', '0.00', '0.00', '0.00'),
(383, '0.00', '0.00', '0.00', '0.00', '0.00'),
(384, '0.00', '0.00', '0.00', '0.00', '0.00'),
(385, '0.00', '0.00', '0.00', '0.00', '0.00'),
(386, '0.00', '0.00', '0.00', '0.00', '0.00'),
(387, '0.00', '0.00', '0.00', '0.00', '0.00'),
(388, '0.00', '0.00', '0.00', '0.00', '0.00'),
(389, '0.00', '0.00', '0.00', '0.00', '0.00'),
(390, '0.00', '0.00', '0.00', '0.00', '0.00'),
(391, '0.00', '0.00', '0.00', '0.00', '0.00'),
(392, '0.00', '0.00', '0.00', '0.00', '0.00'),
(393, '0.00', '0.00', '0.00', '0.00', '0.00'),
(394, '0.00', '0.00', '0.00', '0.00', '0.00'),
(395, '0.00', '0.00', '0.00', '0.00', '0.00'),
(396, '0.00', '0.00', '0.00', '0.00', '0.00'),
(397, '0.00', '0.00', '0.00', '0.00', '0.00'),
(398, '0.00', '0.00', '0.00', '0.00', '0.00'),
(399, '0.00', '0.00', '0.00', '0.00', '0.00'),
(400, '0.00', '0.00', '0.00', '0.00', '0.00'),
(401, '0.00', '0.00', '0.00', '0.00', '0.00'),
(402, '0.00', '0.00', '0.00', '0.00', '0.00'),
(403, '0.00', '0.00', '0.00', '0.00', '0.00'),
(404, '0.00', '0.00', '0.00', '0.00', '0.00'),
(405, '0.00', '0.00', '0.00', '0.00', '0.00'),
(406, '0.00', '0.00', '0.00', '0.00', '0.00'),
(407, '0.00', '0.00', '0.00', '0.00', '0.00'),
(408, '0.00', '0.00', '0.00', '0.00', '0.00'),
(409, '0.00', '0.00', '0.00', '0.00', '0.00'),
(410, '0.00', '0.00', '0.00', '0.00', '0.00'),
(411, '0.00', '0.00', '0.00', '0.00', '0.00'),
(412, '0.00', '0.00', '0.00', '0.00', '0.00'),
(413, '0.00', '0.00', '0.00', '0.00', '0.00'),
(414, '0.00', '0.00', '0.00', '0.00', '0.00'),
(415, '0.00', '0.00', '0.00', '0.00', '0.00'),
(416, '0.00', '0.00', '0.00', '0.00', '0.00'),
(417, '0.00', '0.00', '0.00', '0.00', '0.00'),
(418, '0.00', '0.00', '0.00', '0.00', '0.00'),
(419, '0.00', '0.00', '0.00', '0.00', '0.00'),
(420, '0.00', '0.00', '0.00', '0.00', '0.00'),
(421, '0.00', '0.00', '0.00', '0.00', '0.00'),
(422, '0.00', '0.00', '0.00', '0.00', '0.00'),
(423, '0.00', '0.00', '0.00', '0.00', '0.00'),
(424, '0.00', '0.00', '0.00', '0.00', '0.00'),
(425, '0.00', '0.00', '0.00', '0.00', '0.00'),
(426, '0.00', '0.00', '0.00', '0.00', '0.00'),
(427, '0.00', '0.00', '0.00', '0.00', '0.00'),
(428, '0.00', '0.00', '0.00', '0.00', '0.00'),
(429, '0.00', '0.00', '0.00', '0.00', '0.00'),
(430, '0.00', '0.00', '0.00', '0.00', '0.00'),
(431, '0.00', '0.00', '0.00', '0.00', '0.00'),
(432, '0.00', '0.00', '0.00', '0.00', '0.00'),
(433, '0.00', '0.00', '0.00', '0.00', '0.00'),
(434, '0.00', '0.00', '0.00', '0.00', '0.00'),
(435, '0.00', '0.00', '0.00', '0.00', '0.00'),
(436, '0.00', '0.00', '0.00', '0.00', '0.00'),
(437, '0.00', '0.00', '0.00', '0.00', '0.00'),
(438, '0.00', '0.00', '0.00', '0.00', '0.00'),
(439, '0.00', '0.00', '0.00', '0.00', '0.00'),
(440, '0.00', '0.00', '0.00', '0.00', '0.00'),
(441, '0.00', '0.00', '0.00', '0.00', '0.00'),
(442, '0.00', '0.00', '0.00', '0.00', '0.00'),
(443, '0.00', '0.00', '0.00', '0.00', '0.00'),
(444, '0.00', '0.00', '0.00', '0.00', '0.00'),
(445, '0.00', '0.00', '0.00', '0.00', '0.00'),
(446, '0.00', '0.00', '0.00', '0.00', '0.00'),
(447, '0.00', '0.00', '0.00', '0.00', '0.00'),
(448, '0.00', '0.00', '0.00', '0.00', '0.00'),
(449, '0.00', '0.00', '0.00', '0.00', '0.00'),
(450, '0.00', '0.00', '0.00', '0.00', '0.00'),
(451, '0.00', '0.00', '0.00', '0.00', '0.00'),
(452, '0.00', '0.00', '0.00', '0.00', '0.00'),
(453, '0.00', '0.00', '0.00', '0.00', '0.00'),
(454, '0.00', '0.00', '0.00', '0.00', '0.00'),
(455, '0.00', '0.00', '0.00', '0.00', '0.00'),
(456, '0.00', '0.00', '0.00', '0.00', '0.00'),
(457, '0.00', '0.00', '0.00', '0.00', '0.00'),
(458, '0.00', '0.00', '0.00', '0.00', '0.00'),
(459, '0.00', '0.00', '0.00', '0.00', '0.00'),
(460, '0.00', '0.00', '0.00', '0.00', '0.00'),
(461, '0.00', '0.00', '0.00', '0.00', '0.00'),
(462, '0.00', '0.00', '0.00', '0.00', '0.00'),
(463, '0.00', '0.00', '0.00', '0.00', '0.00'),
(464, '0.00', '0.00', '0.00', '0.00', '0.00'),
(465, '0.00', '0.00', '0.00', '0.00', '0.00'),
(466, '0.00', '0.00', '0.00', '0.00', '0.00'),
(467, '0.00', '0.00', '0.00', '0.00', '0.00'),
(468, '0.00', '0.00', '0.00', '0.00', '0.00'),
(469, '0.00', '0.00', '0.00', '0.00', '0.00'),
(470, '0.00', '0.00', '0.00', '0.00', '0.00'),
(471, '0.00', '0.00', '0.00', '0.00', '0.00'),
(472, '0.00', '0.00', '0.00', '0.00', '0.00'),
(473, '0.00', '0.00', '0.00', '0.00', '0.00'),
(474, '0.00', '0.00', '0.00', '0.00', '0.00'),
(475, '0.00', '0.00', '0.00', '0.00', '0.00'),
(476, '0.00', '0.00', '0.00', '0.00', '0.00'),
(477, '0.00', '0.00', '0.00', '0.00', '0.00'),
(478, '0.00', '0.00', '0.00', '0.00', '0.00'),
(479, '0.00', '0.00', '0.00', '0.00', '0.00'),
(480, '0.00', '0.00', '0.00', '0.00', '0.00'),
(481, '0.00', '0.00', '0.00', '0.00', '0.00'),
(482, '0.00', '0.00', '0.00', '0.00', '0.00'),
(483, '0.00', '0.00', '0.00', '0.00', '0.00'),
(484, '0.00', '0.00', '0.00', '0.00', '0.00'),
(485, '0.00', '0.00', '0.00', '0.00', '0.00'),
(486, '0.00', '0.00', '0.00', '0.00', '0.00'),
(487, '0.00', '0.00', '0.00', '0.00', '0.00'),
(488, '0.00', '0.00', '0.00', '0.00', '0.00'),
(489, '0.00', '0.00', '0.00', '0.00', '0.00'),
(490, '0.00', '0.00', '0.00', '0.00', '0.00'),
(491, '0.00', '0.00', '0.00', '0.00', '0.00'),
(492, '0.00', '0.00', '0.00', '0.00', '0.00'),
(493, '0.00', '0.00', '0.00', '0.00', '0.00'),
(494, '0.00', '0.00', '0.00', '0.00', '0.00'),
(495, '0.00', '0.00', '0.00', '0.00', '0.00'),
(496, '0.00', '0.00', '0.00', '0.00', '0.00'),
(497, '0.00', '0.00', '0.00', '0.00', '0.00'),
(498, '0.00', '0.00', '0.00', '0.00', '0.00'),
(499, '0.00', '0.00', '0.00', '0.00', '0.00'),
(500, '0.00', '0.00', '0.00', '0.00', '0.00'),
(501, '0.00', '0.00', '0.00', '0.00', '0.00'),
(502, '0.00', '0.00', '0.00', '0.00', '0.00'),
(503, '0.00', '0.00', '0.00', '0.00', '0.00'),
(504, '0.00', '0.00', '0.00', '0.00', '0.00'),
(505, '0.00', '0.00', '0.00', '0.00', '0.00'),
(506, '0.00', '0.00', '0.00', '0.00', '0.00'),
(507, '0.00', '0.00', '0.00', '0.00', '0.00'),
(508, '0.00', '0.00', '0.00', '0.00', '0.00'),
(509, '0.00', '0.00', '0.00', '0.00', '0.00'),
(510, '0.00', '0.00', '0.00', '0.00', '0.00'),
(511, '0.00', '0.00', '0.00', '0.00', '0.00'),
(512, '0.00', '0.00', '0.00', '0.00', '0.00'),
(513, '0.00', '0.00', '0.00', '0.00', '0.00'),
(514, '0.00', '0.00', '0.00', '0.00', '0.00'),
(515, '0.00', '0.00', '0.00', '0.00', '0.00'),
(516, '0.00', '0.00', '0.00', '0.00', '0.00'),
(517, '0.00', '0.00', '0.00', '0.00', '0.00'),
(518, '0.00', '0.00', '0.00', '0.00', '0.00'),
(519, '0.00', '0.00', '0.00', '0.00', '0.00'),
(520, '0.00', '0.00', '0.00', '0.00', '0.00'),
(521, '0.00', '0.00', '0.00', '0.00', '0.00'),
(522, '0.00', '0.00', '0.00', '0.00', '0.00'),
(523, '0.00', '0.00', '0.00', '0.00', '0.00'),
(524, '0.00', '0.00', '0.00', '0.00', '0.00'),
(525, '0.00', '0.00', '0.00', '0.00', '0.00'),
(526, '0.00', '0.00', '0.00', '0.00', '0.00'),
(527, '0.00', '0.00', '0.00', '0.00', '0.00'),
(528, '0.00', '0.00', '0.00', '0.00', '0.00'),
(529, '0.00', '0.00', '0.00', '0.00', '0.00'),
(530, '0.00', '0.00', '0.00', '0.00', '0.00'),
(531, '0.00', '0.00', '0.00', '0.00', '0.00'),
(532, '0.00', '0.00', '0.00', '0.00', '0.00'),
(533, '0.00', '0.00', '0.00', '0.00', '0.00'),
(534, '0.00', '0.00', '0.00', '0.00', '0.00'),
(535, '0.00', '0.00', '0.00', '0.00', '0.00'),
(536, '0.00', '0.00', '0.00', '0.00', '0.00'),
(537, '0.00', '0.00', '0.00', '0.00', '0.00'),
(538, '0.00', '0.00', '0.00', '0.00', '0.00'),
(539, '0.00', '0.00', '0.00', '0.00', '0.00'),
(540, '0.00', '0.00', '0.00', '0.00', '0.00'),
(541, '0.00', '0.00', '0.00', '0.00', '0.00'),
(542, '0.00', '0.00', '0.00', '0.00', '0.00'),
(543, '0.00', '0.00', '0.00', '0.00', '0.00'),
(544, '0.00', '0.00', '0.00', '0.00', '0.00'),
(545, '0.00', '0.00', '0.00', '0.00', '0.00'),
(546, '0.00', '0.00', '0.00', '0.00', '0.00'),
(547, '0.00', '0.00', '0.00', '0.00', '0.00'),
(548, '0.00', '0.00', '0.00', '0.00', '0.00'),
(549, '0.00', '0.00', '0.00', '0.00', '0.00'),
(550, '0.00', '0.00', '0.00', '0.00', '0.00'),
(551, '0.00', '0.00', '0.00', '0.00', '0.00'),
(552, '0.00', '0.00', '0.00', '0.00', '0.00'),
(553, '0.00', '0.00', '0.00', '0.00', '0.00'),
(554, '0.00', '0.00', '0.00', '0.00', '0.00'),
(555, '0.00', '0.00', '0.00', '0.00', '0.00'),
(556, '0.00', '0.00', '0.00', '0.00', '0.00'),
(557, '0.00', '0.00', '0.00', '0.00', '0.00'),
(558, '0.00', '0.00', '0.00', '0.00', '0.00'),
(559, '0.00', '0.00', '0.00', '0.00', '0.00'),
(560, '0.00', '0.00', '0.00', '0.00', '0.00'),
(561, '0.00', '0.00', '0.00', '0.00', '0.00'),
(562, '0.00', '0.00', '0.00', '0.00', '0.00'),
(563, '0.00', '0.00', '0.00', '0.00', '0.00'),
(564, '0.00', '0.00', '0.00', '0.00', '0.00'),
(565, '0.00', '0.00', '0.00', '0.00', '0.00'),
(566, '0.00', '0.00', '0.00', '0.00', '0.00'),
(567, '0.00', '0.00', '0.00', '0.00', '0.00'),
(568, '0.00', '0.00', '0.00', '0.00', '0.00'),
(569, '0.00', '0.00', '0.00', '0.00', '0.00'),
(570, '0.00', '0.00', '0.00', '0.00', '0.00'),
(571, '0.00', '0.00', '0.00', '0.00', '0.00'),
(572, '0.00', '0.00', '0.00', '0.00', '0.00'),
(573, '0.00', '0.00', '0.00', '0.00', '0.00'),
(574, '0.00', '0.00', '0.00', '0.00', '0.00'),
(575, '0.00', '0.00', '0.00', '0.00', '0.00'),
(576, '0.00', '0.00', '0.00', '0.00', '0.00'),
(577, '0.00', '0.00', '0.00', '0.00', '0.00'),
(578, '0.00', '0.00', '0.00', '0.00', '0.00'),
(579, '0.00', '0.00', '0.00', '0.00', '0.00'),
(580, '0.00', '0.00', '0.00', '0.00', '0.00'),
(581, '0.00', '0.00', '0.00', '0.00', '0.00'),
(582, '0.00', '0.00', '0.00', '0.00', '0.00'),
(583, '0.00', '0.00', '0.00', '0.00', '0.00'),
(584, '0.00', '0.00', '0.00', '0.00', '0.00'),
(585, '0.00', '0.00', '0.00', '0.00', '0.00'),
(586, '0.00', '0.00', '0.00', '0.00', '0.00'),
(587, '0.00', '0.00', '0.00', '0.00', '0.00'),
(588, '0.00', '0.00', '0.00', '0.00', '0.00'),
(589, '0.00', '0.00', '0.00', '0.00', '0.00'),
(590, '0.00', '0.00', '0.00', '0.00', '0.00'),
(591, '0.00', '0.00', '0.00', '0.00', '0.00'),
(592, '0.00', '0.00', '0.00', '0.00', '0.00'),
(593, '0.00', '0.00', '0.00', '0.00', '0.00'),
(594, '0.00', '0.00', '0.00', '0.00', '0.00'),
(595, '0.00', '0.00', '0.00', '0.00', '0.00'),
(596, '0.00', '0.00', '0.00', '0.00', '0.00'),
(597, '0.00', '0.00', '0.00', '0.00', '0.00'),
(598, '0.00', '0.00', '0.00', '0.00', '0.00'),
(599, '0.00', '0.00', '0.00', '0.00', '0.00'),
(600, '0.00', '0.00', '0.00', '0.00', '0.00'),
(601, '0.00', '0.00', '0.00', '0.00', '0.00'),
(602, '0.00', '0.00', '0.00', '0.00', '0.00'),
(603, '0.00', '0.00', '0.00', '0.00', '0.00'),
(604, '0.00', '0.00', '0.00', '0.00', '0.00'),
(605, '0.00', '0.00', '0.00', '0.00', '0.00'),
(606, '0.00', '0.00', '0.00', '0.00', '0.00'),
(607, '0.00', '0.00', '0.00', '0.00', '0.00'),
(608, '0.00', '0.00', '0.00', '0.00', '0.00'),
(609, '0.00', '0.00', '0.00', '0.00', '0.00'),
(610, '0.00', '0.00', '0.00', '0.00', '0.00'),
(611, '0.00', '0.00', '0.00', '0.00', '0.00'),
(612, '0.00', '0.00', '0.00', '0.00', '0.00'),
(613, '0.00', '0.00', '0.00', '0.00', '0.00'),
(614, '0.00', '0.00', '0.00', '0.00', '0.00'),
(615, '0.00', '0.00', '0.00', '0.00', '0.00'),
(616, '0.00', '0.00', '0.00', '0.00', '0.00'),
(617, '0.00', '0.00', '0.00', '0.00', '0.00'),
(618, '0.00', '0.00', '0.00', '0.00', '0.00'),
(619, '0.00', '0.00', '0.00', '0.00', '0.00');

--
-- Triggers `nota`
--
DELIMITER $$
CREATE TRIGGER `trgg_TotalNotas` BEFORE UPDATE ON `nota` FOR EACH ROW BEGIN
  SET @total = 0;
  SET @total = @total + NEW.trabajo_cotidiano;
  SET @total = @total + NEW.asistencia;
  SET @total = @total + NEW.pruebas;
  SET @total = @total + NEW.tareas;
    IF @total >= 100 THEN
		SET NEW.total = 100;
	ELSE
		SET NEW.total = @total;
    END IF;
  END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `nota_constante`
--

CREATE TABLE `nota_constante` (
  `idnota_constante` int(11) NOT NULL,
  `nombre` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trabajo_cotidiano` decimal(8,2) DEFAULT NULL,
  `pruebas` decimal(8,2) DEFAULT NULL,
  `tareas` decimal(8,2) DEFAULT NULL,
  `asistencia` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `nota_constante`
--

INSERT INTO `nota_constante` (`idnota_constante`, `nombre`, `trabajo_cotidiano`, `pruebas`, `tareas`, `asistencia`) VALUES
(1, 'Basica Primer Ciclo', '60.00', '20.00', '10.00', '10.00'),
(2, 'Basica segundo ciclo', '50.00', '30.00', '10.00', '10.00'),
(3, 'Especial primer ciclo', '65.00', '15.00', '10.00', '10.00'),
(4, 'Especial segundo ciclo', '55.00', '25.00', '10.00', '10.00'),
(5, 'Religion', '70.00', '0.00', '20.00', '10.00');

-- --------------------------------------------------------

--
-- Table structure for table `persona`
--

CREATE TABLE `persona` (
  `idPersona` int(11) NOT NULL,
  `cedula` varchar(45) CHARACTER SET utf8 NOT NULL,
  `nombre` varchar(45) CHARACTER SET utf8 NOT NULL,
  `apellido1` varchar(45) CHARACTER SET utf8 NOT NULL,
  `apellido2` varchar(45) CHARACTER SET utf8 NOT NULL,
  `sexo` varchar(20) CHARACTER SET utf8 NOT NULL,
  `direccion` varchar(100) CHARACTER SET utf8 NOT NULL,
  `telefono` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `telefono_secundario` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `email` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `idNacionalidad` int(11) NOT NULL,
  `disponible` tinyint(1) NOT NULL DEFAULT '1',
  `nota_medica` varchar(650) COLLATE utf8mb4_unicode_ci DEFAULT 'Ninguna'
) ENGINE=InnoDB AVG_ROW_LENGTH=195 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `persona`
--

INSERT INTO `persona` (`idPersona`, `cedula`, `nombre`, `apellido1`, `apellido2`, `sexo`, `direccion`, `telefono`, `telefono_secundario`, `email`, `idNacionalidad`, `disponible`, `nota_medica`) VALUES
(1, '1', 'Julian', 'Perez', 'Fernandez', 'Masculino', 'Heredia', '8', NULL, '@vegeto', 1, 0, 'Ninguno'),
(10, '3085254', 'JUAN JOSE', 'AVALOS', 'PORA', 'masculino', 'ALSJUELA', '1', NULL, NULL, 1, 1, 'Ninguno'),
(11, '12059826', 'Luisa', 'Montero', 'Chacon', 'Femenino', 'Aserri', NULL, NULL, NULL, 1, 1, 'Ninguno'),
(12, '5649111', 'Miguel', 'Orozco', 'Sanchez', 'Masculino', 'Tarbaca', NULL, NULL, NULL, 1, 1, 'Ninguno'),
(13, '45524685', 'Fernanda', 'Rodriguez', 'Morera', 'Femenino', 'Desamparados', NULL, NULL, NULL, 1, 1, 'Ninguno'),
(14, '305454685', 'Esteban', 'Jimenez', 'Ferrer', 'Masculino', 'Aserri', NULL, NULL, NULL, 2, 1, 'Ninguno'),
(15, '638268557', 'Pablo', 'Hernandez', 'Flores', 'Masculino', 'Aserri', NULL, NULL, NULL, 1, 1, 'Ninguno'),
(38, '307680159', 'Marco', 'Chinchila', 'Brenes ', 'Masculino', 'Desamparados', '5465657', NULL, 'mchinchilla@mail.com', 1, 1, 'Ninguno'),
(39, '107680159', 'Carlos', 'Alfaro', 'Gonzales', 'Masculino', 'Heredia', '1111', NULL, 'asd@gmail.com', 1, 1, 'Ninguno'),
(41, '507680129', 'Marta Francisco', 'Chinchilla', '.Saborio', 'Femenino', 'San Antonio de Desamparados', '24456767', NULL, 'mSaborio@gmail.com', 1, 1, 'Ninguno'),
(44, '305080238', 'Francisco', 'Flores', 'Chacon', 'Masculino', 'De la escuela publica de Aserri 150 mts al sur', '60439934', NULL, 'julian4nite@gmail.com', 1, 1, 'Ninguno'),
(69, '207680159', 'Oscar', 'Eduardo', 'Soto', 'Masculino', 'Alajuela, Atenas, Costa Rica', '63103970', NULL, 'oscarsoto0407ss97@gmail.com', 1, 0, 'Ninguno'),
(75, '5', 'Ileana Patricia', 'Soto', 'Leon', 'Femenino', 'Alajuela , Atenas', '12', NULL, 'oscarsosato0407sa97@gmail.com', 1, 1, 'Ninguno'),
(78, '1704', 'Prueba', 'Pruebs', 'Test', 'Masculino', 'ASD', '54544323', NULL, 'oscasasasrsoto0407sa97@gmail.com', 1, 1, 'Ninguno'),
(79, '9904', 'Prueba', 'Prueba', 'Prueba', 'Femenino', 'Atenas\r\nCosta Rica', '63103970', NULL, 'oscarsoto04097ssss@gmail.com', 1, 1, 'Ninguno'),
(80, '208040404', 'Martin', 'Soto', 'Saborio', 'Masculino', 'Alajuela', NULL, NULL, NULL, 1, 0, 'Ninguno'),
(81, '777', 'Julian', 'Perez ', 'Fernandez', 'Masculino', 'Heredia', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(82, '6765', 'Nombre', 'Ap1', 'Ap2', 'Masculino', 'Alajuela', NULL, NULL, NULL, 1, 1, 'Nota'),
(83, '001', 'Pablo', 'Arroyo', 'Fonseca', 'Masculino', 'Nadie le importa', '123456789', NULL, 'p@gmail.com', 1, 1, 'Ninguno'),
(85, '002', 'Pablo', 'Arroyo', 'Fonseca', 'Masculino', 'Nadie le importa', '123456789', NULL, 'p2@gmail.com', 1, 1, 'Ninguno'),
(86, '003', '003', '003', '003', '003', '003', '003', NULL, '003@gmail.com', 1, 1, 'Ninguno'),
(87, '004', '004', '004', '004', '004', '004', '004', NULL, '004@gmail.com', 1, 1, 'Ninguno'),
(89, '004.5', '004', '004', '004', '004', '004', '004', NULL, '004.5@gmail.com', 1, 1, 'Ninguno'),
(91, '005', '004', '004', '004', '004', '004', '004', NULL, '005@gmail.com', 1, 1, 'Ninguno'),
(92, '007', '007', '007', '007', '007', '007', '007', NULL, '007@gmail.com', 1, 1, 'Ninguno'),
(93, '008', '008', '008', '008', '008', '008', '008', NULL, '008@gmail.com', 1, 1, 'Ninguno'),
(94, '009', '009', '009', '009', '009', '009', '009', NULL, '009@gmail.com', 1, 1, 'Ninguno'),
(95, '010', '010', '010', '010', '010', '010', '010', NULL, '010@gmail.com', 1, 1, 'Ninguno'),
(96, '11', '11', '11', '11', '11', '11', '11', NULL, '11', 1, 1, 'Ninguno'),
(97, '12', '12', '12', '12', '12', '12', '12', NULL, '12', 1, 1, 'Ninguno'),
(98, '13', '13', '13', '13', '13', '13', '13', NULL, '13', 1, 1, 'Ninguno'),
(99, '14', '14', '14', '14', '14', '14', '14', NULL, '14', 1, 1, 'Ninguno'),
(100, '15', '15', '15', '15', '15', '15', '15', NULL, '15', 1, 1, 'Ninguno'),
(101, '2000', 'AAA', 'AAA', 'AAA', 'AAA', 'AAA', 'AAA', NULL, 'AAA', 1, 1, 'Ninguno'),
(102, '123212', 'OscarSL', 'Soto', '...Leon1', 'Masculino', 'Alajuela', '24432321', NULL, 'osotoppp@email.net', 1, 1, 'Ninguno'),
(103, '2000', 'Nombre', 'Apellido1', 'Apellido2', 'Masculino', 'Direccion', 'Tel', NULL, 'Correo', 1, 1, 'Ninguno'),
(105, '00001', 'Nombre', '1 Ap', '2 Ap', 'Masculino', 'Alajuela Atenas', '234', NULL, 'email', 1, 1, 'Ninguno'),
(107, '2001', 'AAA', 'AAA', 'AAA', 'Masculino', 'AAAA', 'AAA', NULL, 'email1', 1, 1, 'Ninguno'),
(109, '2002', 'OSCAR', 'LEON', 'LEON', 'Masculino', 'Atenas\r\nCosta Rica', '63103970', NULL, 'oscarsoto0407pp97@gmail.com', 1, 1, 'Ninguno'),
(113, '20012', '200912', '200912', '20012', '20012', '20012', '20012', NULL, 'mailto', 1, 1, 'Ninguno'),
(115, '2001112', '200912', '200912', '20012', '20012', '20012', '20012', NULL, 'mailzzaszto', 1, 0, 'Ninguno'),
(117, '2345', 'OSCAR', 'LEON', 'LEON', 'Femenino', 'Atenas\r\nCosta Rica', '63103970', NULL, '1111', 1, 1, 'Ninguno'),
(119, '4001', 'OSCAR', 'LEON', 'LEON', 'Masculino', 'Atenas\r\nCosta Rica', '63103970', NULL, 'beca', 1, 1, 'Ninguno'),
(121, '4003', 'OSCAR', 'LEON', 'LEON', 'Masculino', 'Atenas\r\nCosta Rica', '63103970', NULL, 'emailto.com', 1, 1, 'Ninguno'),
(123, '4007', 'OSCAR', 'LEON', 'LEON', 'Masculino', 'Atenas\r\nCosta Rica', '63103970', NULL, '4007', 1, 1, 'Ninguno'),
(125, '4009', 'OSCAR', 'LEON', 'LEON', 'Femenino', 'Atenas\r\nCosta Rica', '63103970', NULL, '4009', 1, 1, 'Ninguno'),
(127, '4011', 'OSCAR', 'LEON', 'LEON', 'Masculino', 'Atenas\r\nCosta Rica', '63103970', NULL, '4011', 1, 1, 'Ninguno'),
(129, '4013', 'OSCAR', 'LEON', 'LEON', 'Masculino', 'Atenas\r\nCosta Rica', '63103970', NULL, '4013', 1, 1, 'Ninguno'),
(131, '4016', 'OSCAR', 'LEON', 'LEON', 'Masculino', 'Atenas\r\nCosta Rica', '63103970', NULL, '4016', 1, 1, 'Ninguno'),
(133, '5001', 'Mario', 'Oreamuno', 'Zapata', 'Masculino', 'Alajuela', NULL, NULL, NULL, 1, 1, 'No'),
(134, '5005', 'OSCAR', 'LEON', 'LEON', 'Masculino', 'Atenas\r\nCosta Rica', NULL, NULL, NULL, 1, 1, 'xd'),
(136, '50010', 'OSCAR', 'LEON', 'LEON', 'Masculino', 'Atenas\r\nCosta Rica', NULL, NULL, NULL, 1, 1, 'Ileano'),
(138, '9001', 'Mauro', 'Fran', 'Gutt', 'Masculino', 'Atenas\r\nCosta Rica', NULL, NULL, NULL, 2, 1, 'Alcohol'),
(139, '9001', 'Mauro', 'Fran', 'Gutt', 'Masculino', 'Atenas\r\nCosta Rica', NULL, NULL, NULL, 2, 1, 'Alcohol'),
(140, '9002', 'Patricio', 'Leon', 'Ramirez', 'Masculino', 'Heredia', NULL, NULL, NULL, 1, 1, 'Alcohol'),
(141, '9002', 'Patricio', 'Leon', 'Ramirez', 'Masculino', 'Heredia', NULL, NULL, NULL, 1, 1, 'Alcohol'),
(142, '8001', 'Alejandra', 'Camacho', '.Camacho', 'Femenino', 'Heredia', '25466789', '25467876', 'oscarsotoa0407s97@gmail.com', 1, 1, 'Ninguno'),
(144, '8002', 'Dagoberto', 'Jiménez', 'Arias', 'Masculino', 'Heredia', '2446 6380', '2446 6380', 'mail;po', 1, 1, 'Ninguno'),
(146, 'Prueba', 'Ejemplo', 'Test', 'xd', 'Masc', 'Alajuela', NULL, NULL, NULL, 1, 1, 'Nada'),
(147, '6701', 'Juliano', 'Le pica', 'el ano', 'Masculino', 'Heredia', NULL, NULL, NULL, 1, 1, 'Gonorrea'),
(148, '6701', 'Juliano', 'Le pica', 'el ano', 'Masculino', 'Heredia', NULL, NULL, NULL, 1, 1, 'Gonorrea'),
(149, '9876', 'Alumno de Quinto', 'Ap1', 'Ap2', 'Masculino', 'Heredia', NULL, NULL, NULL, 1, 1, '1'),
(150, '7615', 'Alumno 2', 'Ap', 'Ap', 'Masculino', 'Dir', NULL, NULL, NULL, 1, 1, 'Med'),
(174, '207655430', 'Ramiro', 'Alfonso', 'Alfonsa', 'Masculino', 'Alajuela', NULL, NULL, NULL, 1, 1, '1'),
(175, '101', 'Eduardo', 'Piedra', 'Duarte', 'Masculino', 'Atenas\r\nCosta Rica', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(176, '101', 'Eduardo', 'Piedra', 'Duarte', 'Masculino', 'Atenas\r\nCosta Rica', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(177, '1001', 'Laura Moscoa', 'Chinchilla', 'Arias', 'Masculino', 'Heredia', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(178, '1001', 'Laura Moscoa', 'Chinchilla', 'Arias', 'Masculino', 'Heredia', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(179, '1002', 'Gabriela', 'Guillen', 'Guillen', 'Femenino', 'Heredia Centro, 150 metros este', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(180, '1002', 'Gabriela', 'Guillen', 'Guillen', 'Femenino', 'Heredia Centro, 150 metros este', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(181, '2001', 'Gabriel', 'Artavia', 'Guillen', 'Masculino', 'Heredia', '25465443', '25468781', NULL, 1, 1, 'Ninguna'),
(182, '2001', 'Gabriel', 'Artavia', 'Guillen', 'Masculino', 'Heredia', '25465443', '25468781', NULL, 1, 1, 'Ninguna'),
(183, '2001', 'Encargado de Prueba', 'Ap1', 'Ap 2', 'Masculino', 'Alajuela', '2', '2', NULL, 1, 1, 'Ninguna'),
(184, '20010', 'Encargado de Prueba', 'Ap1', '....................Ap 2', 'Masculino', 'Alajuela', '24', '90', NULL, 1, 1, 'Ninguna'),
(185, '781', 'Encargado 2', 'Apellido 1', '..................Apellido2', 'Masculino', 'Alajuela', '63108787', '80', NULL, 1, 1, 'Ninguna'),
(186, '781', 'Encargado 2', 'Apellido 1', '..................Apellido2', 'Masculino', 'Alajuela', '63108787', '80', NULL, 1, 1, 'Ninguna'),
(187, '4001', 'Alumno de 4to', 'Apellido 1', 'Apellido 2', 'Masculino', 'San Pedro', NULL, NULL, NULL, 1, 1, ''),
(188, '4001', 'Alumno de 4to', 'Apellido 1', 'Apellido 2', 'Masculino', 'San Pedro', NULL, NULL, NULL, 1, 1, ''),
(189, '541200', 'Alumno de 4to', 'Ap', 'AP', 'Masculino', 'Alajuela', NULL, NULL, NULL, 1, 1, 'Medica'),
(190, '541200', 'Alumno de 4to', 'Ap', 'AP', 'Masculino', 'Alajuela', NULL, NULL, NULL, 1, 1, 'Medica'),
(191, '98700', 'Mario', 'Vindas', '.Solis', 'Masculino', 'Heredia Centro', '25465710', '88932322', NULL, 1, 1, 'Ninguna'),
(192, '98700', 'Mario', 'Vindas', '.Solis', 'Masculino', 'Heredia Centro', '25465710', '88932322', NULL, 1, 1, 'Ninguna'),
(193, '3001', 'Maria', 'Pepa', 'Solorzano', 'Femenino', 'Alajuela, 150 metros este del Parque', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(194, '3001', 'Maria', 'Pepa', 'Solorzano', 'Femenino', 'Alajuela, 150 metros este del Parque', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(195, '3002', 'Jose', 'Maria', 'Figueres', 'Olsen', 'San Jose', NULL, NULL, NULL, 1, 1, 'No'),
(196, '3003', 'Javaad', 'Meneses', 'Pellejo', 'Masculino', 'Heredia', NULL, NULL, NULL, 1, 1, 'Med'),
(197, '3003', 'Javaad', 'Meneses', 'Pellejo', 'Masculino', 'Heredia', NULL, NULL, NULL, 1, 1, 'Med'),
(198, '3004', 'Alexis', 'Moya', 'Oreamuno', 'Masculino', 'Prueba', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(199, '3004', 'Alexis', 'Moya', 'Oreamuno', 'Masculino', 'Prueba', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(200, '3005', 'Alumno 3005', 'Apeliido 1', 'Apellido 2', 'Masculino', 'Atenas', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(201, '3005', 'Alumno 3005', 'Apeliido 1', 'Apellido 2', 'Masculino', 'Atenas', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(202, '3006', 'Alumno 3006', 'Apellido 1', 'Apellido 2', 'Masculino', 'Heredia', NULL, NULL, NULL, 1, 1, '1'),
(203, '8008', '8008', '8008', '8008', 'Masculino', '8008', NULL, NULL, NULL, 1, 1, '8008'),
(204, '8009', '8009', '8009', '8009', 'Masculino', '8009', '8009', '8009', NULL, 1, 1, 'Ninguna'),
(209, '4901', 'Oscar Eduardo', 'Soto', 'León', 'Masculino', 'Alajuela, Atenas Costa Rica', '24466380', NULL, '88923834', 1, 1, 'Ninguna'),
(211, '8899', 'Oscar Eduardo', 'Soto', 'León', 'Masculino', 'Alajuela', '88923239', NULL, 'oscarsoto040797@gmail.com', 1, 1, 'Ninguna'),
(213, '8898', 'Elvin', 'Martinez', '.Saborio', 'Masculino', 'Alajuela', '24467676', NULL, 'elsoto58@gmail.com', 1, 1, 'Ninguna'),
(215, '8144', 'Elvin', 'Ramirez', 'Jimenez', 'Masculino', 'Alajuela Atenas Costa Rica', '22334455', NULL, 'elsoto57@gmail.com', 1, 1, 'Ninguna'),
(217, '6192', 'Perestroika', 'Glasnot', '.Artavia', 'Masculino', 'Alajuela', '12343212', NULL, 'ileanassl30@gmail.com', 1, 1, 'Ninguna'),
(219, '9156', 'Fernanda', 'Lopez', '.Porras', 'Masculino', 'Alajuela', '9999999', NULL, 'natalielopez08ss0597@gmail.com', 1, 1, 'Ninguna'),
(221, '7854', 'Gabriel', 'Villalobos', '.Ramirez', 'Masculino', 'Alajuela', '2345432', NULL, 'natalielopezaa080597@gmail.com', 1, 1, 'Ninguna'),
(225, '98764521', 'test', 'test', 'test', 'Masculino', 'test', 'test', NULL, 'natalielopez080597@gmail.com', 1, 1, 'Ninguna'),
(227, '753951258', 'MIRIFLUFLA', 'MARAFUFA', 'MEREFULA', 'Masculino', 'TARBACA', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(228, '654123789', 'MARTALOMETA', 'LOCARELA', 'CURALENDA', 'Femenino', 'SUIZA', NULL, NULL, NULL, 2, 1, 'HIPO'),
(229, '654321789', 'LUISDANALETO', 'LISBANO', 'CEPILLO', 'Masculino', 'ALEMANIA', NULL, NULL, NULL, 1, 1, 'ASMA');

-- --------------------------------------------------------

--
-- Table structure for table `profesor`
--

CREATE TABLE `profesor` (
  `idprofesor` int(11) NOT NULL,
  `Persona_idPersona` int(11) NOT NULL,
  `tipo` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `profesor`
--

INSERT INTO `profesor` (`idprofesor`, `Persona_idPersona`, `tipo`) VALUES
(1, 1, 0),
(6, 38, 0),
(7, 39, 0),
(8, 41, 0),
(9, 44, 0),
(20, 69, 0),
(23, 75, 0),
(25, 78, 0),
(26, 79, 0),
(27, 83, 1),
(28, 85, 1),
(29, 86, 1),
(30, 87, 0),
(31, 89, 0),
(32, 91, 0),
(33, 92, 0),
(34, 93, 0),
(35, 94, 0),
(36, 95, 0),
(37, 96, 0),
(38, 97, 0),
(39, 98, 0),
(40, 99, 0),
(41, 100, 0),
(42, 101, 1),
(43, 102, 0),
(44, 105, 1),
(45, 107, 1),
(46, 109, 1),
(47, 113, 1),
(48, 115, 1),
(49, 117, 1),
(50, 119, 1),
(51, 121, 1),
(52, 123, 5),
(53, 125, 5),
(54, 127, 1),
(55, 129, 1),
(56, 131, 0),
(57, 142, 0),
(58, 144, 1),
(60, 209, 0),
(61, 211, 0),
(62, 213, 1),
(63, 215, 1),
(64, 217, 0),
(65, 219, 1),
(66, 221, 1),
(67, 225, 1);

-- --------------------------------------------------------

--
-- Table structure for table `profesor_materia_grado`
--

CREATE TABLE `profesor_materia_grado` (
  `profesor_idprofesor` int(11) NOT NULL,
  `materia_idmateria` int(11) NOT NULL,
  `id_grado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `profesor_materia_grado`
--

INSERT INTO `profesor_materia_grado` (`profesor_idprofesor`, `materia_idmateria`, `id_grado`) VALUES
(28, 5, 1),
(29, 5, 2),
(29, 5, 3),
(29, 5, 4),
(29, 5, 5),
(29, 5, 6),
(33, 6, 1),
(33, 7, 1),
(33, 8, 1),
(34, 6, 1),
(34, 7, 1),
(34, 8, 1),
(35, 6, 1),
(35, 7, 1),
(35, 8, 1),
(36, 6, 1),
(36, 7, 1),
(36, 8, 1),
(37, 6, 1),
(37, 7, 1),
(37, 8, 1),
(38, 6, 1),
(38, 7, 1),
(38, 8, 1),
(38, 9, 1),
(38, 10, 1),
(38, 11, 1),
(39, 6, 1),
(39, 7, 1),
(39, 8, 1),
(40, 6, 1),
(40, 7, 1),
(40, 8, 1),
(40, 11, 1),
(41, 6, 3),
(41, 7, 3),
(41, 8, 3),
(41, 11, 3),
(43, 6, 1),
(43, 7, 1),
(43, 8, 1),
(43, 11, 1),
(48, 5, 2),
(48, 5, 3),
(48, 5, 4),
(48, 5, 5),
(48, 5, 6),
(49, 5, 2),
(49, 5, 3),
(49, 5, 4),
(49, 5, 5),
(49, 5, 6),
(50, 5, 2),
(50, 5, 3),
(50, 5, 4),
(50, 5, 5),
(50, 5, 6),
(51, 5, 2),
(51, 5, 3),
(51, 5, 4),
(51, 5, 5),
(51, 5, 6),
(52, 5, 2),
(52, 5, 3),
(52, 5, 4),
(52, 5, 5),
(52, 5, 6),
(53, 5, 2),
(53, 5, 3),
(53, 5, 4),
(53, 5, 5),
(53, 5, 6),
(54, 5, 2),
(54, 5, 3),
(54, 5, 4),
(54, 5, 5),
(54, 5, 6),
(55, 9, 2),
(55, 9, 3),
(55, 9, 4),
(55, 9, 5),
(55, 9, 6),
(56, 6, 2),
(56, 7, 2),
(56, 8, 2),
(56, 11, 2),
(57, 6, 5),
(57, 7, 5),
(57, 8, 5),
(57, 11, 5),
(58, 9, 2),
(58, 9, 3),
(58, 9, 4),
(58, 9, 5),
(58, 9, 6),
(60, 6, 1),
(60, 7, 1),
(60, 8, 1),
(60, 11, 1),
(61, 6, 2),
(61, 7, 2),
(61, 8, 2),
(61, 11, 2),
(62, 5, 2),
(62, 5, 3),
(62, 5, 4),
(62, 5, 5),
(62, 5, 6),
(63, 5, 2),
(63, 5, 3),
(63, 5, 4),
(63, 5, 5),
(63, 5, 6),
(64, 6, 1),
(64, 7, 1),
(64, 8, 1),
(64, 11, 1),
(65, 5, 2),
(65, 5, 3),
(65, 5, 4),
(65, 5, 5),
(65, 5, 6),
(66, 5, 2),
(66, 5, 3),
(66, 5, 4),
(66, 5, 5),
(66, 5, 6),
(67, 9, 2),
(67, 9, 3),
(67, 9, 4),
(67, 9, 5),
(67, 9, 6);

-- --------------------------------------------------------

--
-- Table structure for table `puesto`
--

CREATE TABLE `puesto` (
  `idPuesto` int(11) NOT NULL,
  `nombrePuesto` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `descrpcionPuesto` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `puesto`
--

INSERT INTO `puesto` (`idPuesto`, `nombrePuesto`, `descrpcionPuesto`) VALUES
(1, 'Conserje', 'Encargado de la limpieza de la institucion y mucho mas'),
(2, 'Guardia', 'Seguridad II'),
(3, 'Psicologa', 'Encargada de tratar con personal y niños');

-- --------------------------------------------------------

--
-- Table structure for table `rol`
--

CREATE TABLE `rol` (
  `IDROL` int(11) NOT NULL,
  `tiporol` varchar(45) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rol`
--

INSERT INTO `rol` (`IDROL`, `tiporol`) VALUES
(1, 'Profesor'),
(2, 'Director');

-- --------------------------------------------------------

--
-- Table structure for table `tipo_materia`
--

CREATE TABLE `tipo_materia` (
  `idTipo` int(11) NOT NULL,
  `tipo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tipo_materia`
--

INSERT INTO `tipo_materia` (`idTipo`, `tipo`) VALUES
(1, 'Basica'),
(2, 'Idioma'),
(3, 'Religion'),
(4, 'Especial');

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `idUsuario` int(11) NOT NULL,
  `idPersona` int(11) DEFAULT NULL,
  `idRol` int(11) DEFAULT NULL,
  `password` varchar(150) CHARACTER SET utf8 DEFAULT NULL,
  `cambio` tinyint(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `idPersona`, `idRol`, `password`, `cambio`) VALUES
(7, 75, 1, '$2y$09$9TL7z6JBchfWwnnp1afXEOFOTW.NeHNBMNXZ2khiIFMY/ItUVkrY2', 0),
(9, 78, 2, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 0),
(10, 79, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 0),
(11, 83, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(12, 85, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(13, 86, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(14, 87, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(15, 89, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(16, 91, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(17, 92, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(18, 93, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(19, 94, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(20, 95, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(21, 96, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(22, 97, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(23, 98, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1),
(24, 99, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 0),
(25, 100, 2, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 0),
(26, 101, 1, '11', 1),
(27, 102, 1, '1', 1),
(28, 105, 1, 'Seleccionar Grado', 1),
(29, 107, 1, '1', 1),
(30, 109, 1, 'Seleccionar Grado', 1),
(31, 113, 1, '20012', 1),
(32, 115, 1, '20012', 1),
(33, 117, 1, '1', 1),
(34, 119, 1, '1', 1),
(35, 121, 1, '1', 1),
(36, 123, 1, '1', 1),
(37, 125, 1, '1', 1),
(38, 127, 1, '$2y$09$dFdKgjRGA0cMjTtzZO8n6u4WMKjg0AE4/Em.l8LcMqn84Eef/ZgbK', 1),
(39, 129, 1, '$2y$09$.6d6wEIn25Rq9NkBksni8ulCWncH07jHj3yPLCrCHo2qtNQWuzOKG', 1),
(40, 131, 1, '$2y$09$RZzexNQ0PwGnUyMShz1fYeVccAJed4h31ei29hyPCV7/64Q/fT5fS', 1),
(41, 142, 1, '$2y$09$l6TdXxei2cTql4u4RueXPOgMr3lV70H3AUJXtRw2v63V/z7Y9d07y', 0),
(42, 144, 2, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 0),
(44, 209, 1, '$2y$09$lpj.ZsYDnUGVCmNG9kdCO.BMdAg1d41OYAcT2GLH1bn24kZGd2j92', 1),
(45, 211, 1, '$2y$09$lo96K5GCHDQ7zeaccKKdzuQUNxU5AUEWGb1sils6G0Pw34wBGye3G', 1),
(46, 213, 1, '$2y$09$Q4O8Op5Cz21CqmD.yxITee/5HhVCOcXSntIRT.D3CTioqV8wqDpBW', 1),
(47, 215, 1, '$2y$09$7Tp72WQZu5/DaNl24kg63.cAymd5HI4AVoI35aQefLY3ShcsS79DS', 1),
(48, 217, 1, '$2y$09$FJu/cGeE0Ly94cotqI/k/OvAUA3Vj40.J93x4UHhQ/1MfxzorMLXW', 1),
(49, 219, 1, '$2y$09$1h54n0Gfi0EaYf3ZrZTmw.l6zRz50IWxazYxhJeYk5PVjtwGywgcW', 1),
(50, 221, 1, '$2y$09$UMkO3DZM1u6MBu7wTofAmeF8JkSTVg8Nis3KDEfqlz6I81R/9c4KK', 1),
(51, 225, 1, '$2y$09$9zfLLAv9Xgi5fhOc7t6e2uIl9AcexkRNZdKTSE99g1ui.ds68MAY.', 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vbeca`
-- (See below for the actual view)
--
CREATE TABLE `vbeca` (
`cedula` varchar(45)
,`nombre` varchar(45)
,`apellidos` varchar(91)
,`descripcion_beca` varchar(500)
,`monto_beca` varchar(45)
,`estado` tinyint(1)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vdirector`
-- (See below for the actual view)
--
CREATE TABLE `vdirector` (
`CEDULA` varchar(45)
,`NOMBRE` varchar(45)
,`APELLIDOS` varchar(91)
,`SEXO` varchar(20)
,`DIRECCION` varchar(100)
,`TELEFONO` varchar(45)
,`EMAIL` varchar(45)
,`PAIS` varchar(45)
,`DISPONIBLE` tinyint(1)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vista_alumno`
-- (See below for the actual view)
--
CREATE TABLE `vista_alumno` (
`cedula` varchar(45)
,`nombre` varchar(45)
,`apellido1` varchar(45)
,`apellido2` varchar(45)
,`sexo` varchar(20)
,`pais` varchar(45)
,`nombreGrado` varchar(45)
,`annio` int(11)
,`direccion` varchar(100)
,`nota_medica` varchar(650)
,`disponible` tinyint(1)
,`idgrado` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vista_alumno_encargado`
-- (See below for the actual view)
--
CREATE TABLE `vista_alumno_encargado` (
`cedula` varchar(45)
,`idalumno` int(11)
,`nombre` varchar(137)
,`idGrado` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vista_asistencia`
-- (See below for the actual view)
--
CREATE TABLE `vista_asistencia` (
`cedula` varchar(45)
,`nombre` varchar(45)
,`apellido1` varchar(45)
,`apellido2` varchar(45)
,`nombreGrado` varchar(45)
,`ESTADO` tinyint(1)
,`NOTA` varchar(100)
,`FECHA` date
,`AUSENCIA` tinyint(1)
);

-- --------------------------------------------------------

--
-- Table structure for table `vista_empleado`
--

CREATE TABLE `vista_empleado` (
  `cedula` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombre` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apellido1` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `apellido2` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sexo` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `direccion` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `telefono` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pais` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nombrePuesto` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disponible` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `vista_encargado`
-- (See below for the actual view)
--
CREATE TABLE `vista_encargado` (
`cedula` varchar(45)
,`nombre` varchar(45)
,`apellido1` varchar(45)
,`apellido2` varchar(45)
,`telefono` varchar(45)
,`telefono_secundario` varchar(45)
,`direccion` varchar(100)
,`sexo` varchar(20)
,`pais` varchar(45)
,`disponible` tinyint(1)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vista_materia`
-- (See below for the actual view)
--
CREATE TABLE `vista_materia` (
`idmateria` int(11)
,`nombre` varchar(45)
,`tipo` varchar(100)
,`estado` tinyint(1)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vista_nota`
-- (See below for the actual view)
--
CREATE TABLE `vista_nota` (
`CONCAT(p.nombre,' ',p.apellido1,' ',p.apellido2)` varchar(137)
,`nombre` varchar(45)
,`asistencia` decimal(8,2)
,`pruebas` decimal(8,2)
,`tareas` decimal(8,2)
,`trabajo_cotidiano` decimal(8,2)
,`trimestre` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vista_notas`
-- (See below for the actual view)
--
CREATE TABLE `vista_notas` (
`cedula` varchar(45)
,`nombre` varchar(45)
,`apellido1` varchar(45)
,`apellido2` varchar(45)
,`materia` varchar(45)
,`nombreGrado` varchar(45)
,`trabajo_cotidiano` decimal(8,2)
,`pruebas` decimal(8,2)
,`tareas` decimal(8,2)
,`asistencia` decimal(8,2)
,`total` decimal(8,2)
,`trimestre` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `vista_profesor`
-- (See below for the actual view)
--
CREATE TABLE `vista_profesor` (
`CEDULA` varchar(45)
,`NOMBRE` varchar(45)
,`APELLIDO1` varchar(45)
,`APELLIDO2` varchar(45)
,`SEXO` varchar(20)
,`DIRECCION` varchar(100)
,`TELEFONO` varchar(45)
,`EMAIL` varchar(45)
,`PAIS` varchar(45)
,`DISPONIBLE` tinyint(1)
,`nombreGrado` varchar(45)
,`annio` int(11)
,`tipo` tinyint(1)
);

-- --------------------------------------------------------

--
-- Structure for view `mostrar_encargado`
--
DROP TABLE IF EXISTS `mostrar_encargado`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `mostrar_encargado`  AS  select `p2`.`cedula` AS `cedula_e`,`p`.`cedula` AS `cedula`,concat(`p`.`nombre`,' ',`p`.`apellido1`,' ',`p`.`apellido2`) AS `nombre`,`p`.`telefono` AS `telefono`,`p`.`telefono_secundario` AS `telefono_secundario`,`p`.`direccion` AS `direccion` from ((((`persona` `p` join `alumno` `a`) join `alumno_encargado` `ae`) join `encargado` `e`) join `persona` `p2`) where ((`p2`.`idPersona` = `a`.`Persona_idPersona`) and (`p`.`idPersona` = `e`.`Persona_idPersona`) and (`a`.`idalumno` = `ae`.`ID_ALUMNO`) and (`e`.`idencargado` = `ae`.`ID_ENCARGADO`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vbeca`
--
DROP TABLE IF EXISTS `vbeca`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vbeca`  AS  select `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,concat(`p`.`apellido1`,' ',`p`.`apellido2`) AS `apellidos`,`b`.`descripcion_beca` AS `descripcion_beca`,`b`.`monto_beca` AS `monto_beca`,`b`.`estado` AS `estado` from ((`persona` `p` join `alumno` `a`) join `beca` `b`) where ((`p`.`idPersona` = `a`.`Persona_idPersona`) and (`a`.`idalumno` = `b`.`idAlumno`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vdirector`
--
DROP TABLE IF EXISTS `vdirector`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vdirector`  AS  select `pe`.`cedula` AS `CEDULA`,`pe`.`nombre` AS `NOMBRE`,concat(`pe`.`apellido1`,' ',`pe`.`apellido2`) AS `APELLIDOS`,`pe`.`sexo` AS `SEXO`,`pe`.`direccion` AS `DIRECCION`,`pe`.`telefono` AS `TELEFONO`,`pe`.`email` AS `EMAIL`,`n`.`pais` AS `PAIS`,`pe`.`disponible` AS `DISPONIBLE` from ((`director` `pr` join `persona` `pe`) join `nacionalidad` `n`) where ((`pe`.`idPersona` = `pr`.`idDirector`) and (`n`.`idNacionalidad` = `pe`.`idNacionalidad`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vista_alumno`
--
DROP TABLE IF EXISTS `vista_alumno`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_alumno`  AS  select `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,`p`.`apellido1` AS `apellido1`,`p`.`apellido2` AS `apellido2`,`p`.`sexo` AS `sexo`,`n`.`pais` AS `pais`,`g`.`nombreGrado` AS `nombreGrado`,`g`.`annio` AS `annio`,`p`.`direccion` AS `direccion`,`p`.`nota_medica` AS `nota_medica`,`p`.`disponible` AS `disponible`,`g`.`idgrado` AS `idgrado` from ((((`persona` `p` join `alumno` `a`) join `grado_estudiante_nota` `ga`) join `nacionalidad` `n`) join `grado` `g`) where ((`a`.`Persona_idPersona` = `p`.`idPersona`) and (`ga`.`idEstudiante` = `a`.`idalumno`) and (`p`.`idNacionalidad` = `n`.`idNacionalidad`) and (`ga`.`idGrado` = `g`.`idgrado`)) group by `p`.`cedula` ;

-- --------------------------------------------------------

--
-- Structure for view `vista_alumno_encargado`
--
DROP TABLE IF EXISTS `vista_alumno_encargado`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_alumno_encargado`  AS  select `p2`.`cedula` AS `cedula`,`a`.`idalumno` AS `idalumno`,concat(`p`.`nombre`,' ',`p`.`apellido1`,' ',`p`.`apellido2`) AS `nombre`,`gen`.`idGrado` AS `idGrado` from (((((`persona` `p` join `alumno` `a`) join `grado_estudiante_nota` `gen`) join `alumno_encargado` `ae`) join `persona` `p2`) join `encargado` `e`) where ((`p`.`idPersona` = `a`.`Persona_idPersona`) and (`a`.`idalumno` = `gen`.`idEstudiante`) and (`ae`.`ID_ENCARGADO` = `e`.`idencargado`) and (`ae`.`ID_ALUMNO` = `a`.`idalumno`) and (`e`.`Persona_idPersona` = `p2`.`idPersona`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vista_asistencia`
--
DROP TABLE IF EXISTS `vista_asistencia`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_asistencia`  AS  select distinct `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,`p`.`apellido1` AS `apellido1`,`p`.`apellido2` AS `apellido2`,`g`.`nombreGrado` AS `nombreGrado`,`a`.`ESTADO` AS `ESTADO`,`a`.`NOTA` AS `NOTA`,`a`.`FECHA` AS `FECHA`,`a`.`AUSENCIA` AS `AUSENCIA` from ((((`grado` `g` join `grado_estudiante_nota` `gan`) join `asistencia` `a`) join `persona` `p`) join `alumno` `al`) where ((`p`.`idPersona` = `al`.`Persona_idPersona`) and (`al`.`idalumno` = `gan`.`idEstudiante`) and (`gan`.`idGrado` = `g`.`idgrado`) and (`gan`.`idEstudiante` = `a`.`IDALUMNO`) and (`g`.`idgrado` = `a`.`IDGRADO`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vista_encargado`
--
DROP TABLE IF EXISTS `vista_encargado`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_encargado`  AS  select `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,`p`.`apellido1` AS `apellido1`,`p`.`apellido2` AS `apellido2`,`p`.`telefono` AS `telefono`,`p`.`telefono_secundario` AS `telefono_secundario`,`p`.`direccion` AS `direccion`,`p`.`sexo` AS `sexo`,`n`.`pais` AS `pais`,`p`.`disponible` AS `disponible` from ((`persona` `p` join `encargado` `e`) join `nacionalidad` `n`) where ((`p`.`idPersona` = `e`.`Persona_idPersona`) and (`p`.`idNacionalidad` = `n`.`idNacionalidad`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vista_materia`
--
DROP TABLE IF EXISTS `vista_materia`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_materia`  AS  select `m`.`idmateria` AS `idmateria`,`m`.`nombre` AS `nombre`,`t`.`tipo` AS `tipo`,`m`.`estado` AS `estado` from (`materia` `m` join `tipo_materia` `t`) where (`m`.`idTipoMateria` = `t`.`idTipo`) ;

-- --------------------------------------------------------

--
-- Structure for view `vista_nota`
--
DROP TABLE IF EXISTS `vista_nota`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_nota`  AS  select concat(`p`.`nombre`,' ',`p`.`apellido1`,' ',`p`.`apellido2`) AS `CONCAT(p.nombre,' ',p.apellido1,' ',p.apellido2)`,`m`.`nombre` AS `nombre`,`n`.`asistencia` AS `asistencia`,`n`.`pruebas` AS `pruebas`,`n`.`tareas` AS `tareas`,`n`.`trabajo_cotidiano` AS `trabajo_cotidiano`,`gdn`.`trimestre` AS `trimestre` from ((((`grado_estudiante_nota` `gdn` join `alumno` `a`) join `persona` `p`) join `materia` `m`) join `nota` `n`) where ((`a`.`Persona_idPersona` = `p`.`idPersona`) and (`a`.`idalumno` = `gdn`.`idEstudiante`) and (`gdn`.`idNota` = `n`.`idnota`)) group by `m`.`idmateria` ;

-- --------------------------------------------------------

--
-- Structure for view `vista_notas`
--
DROP TABLE IF EXISTS `vista_notas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_notas`  AS  select `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,`p`.`apellido1` AS `apellido1`,`p`.`apellido2` AS `apellido2`,`m`.`nombre` AS `materia`,`g`.`nombreGrado` AS `nombreGrado`,`n`.`trabajo_cotidiano` AS `trabajo_cotidiano`,`n`.`pruebas` AS `pruebas`,`n`.`tareas` AS `tareas`,`n`.`asistencia` AS `asistencia`,`n`.`total` AS `total`,`gan`.`trimestre` AS `trimestre` from (((((`persona` `p` join `materia` `m`) join `grado_estudiante_nota` `gan`) join `grado` `g`) join `nota` `n`) join `alumno` `a`) where ((`p`.`idPersona` = `a`.`Persona_idPersona`) and (`a`.`idalumno` = `gan`.`idEstudiante`) and (`gan`.`idGrado` = `g`.`idgrado`) and (`m`.`idmateria` = `gan`.`idMateria`) and (`gan`.`idNota` = `n`.`idnota`) and (`p`.`disponible` <> 0)) ;

-- --------------------------------------------------------

--
-- Structure for view `vista_profesor`
--
DROP TABLE IF EXISTS `vista_profesor`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_profesor`  AS  select `p`.`cedula` AS `CEDULA`,`p`.`nombre` AS `NOMBRE`,`p`.`apellido1` AS `APELLIDO1`,`p`.`apellido2` AS `APELLIDO2`,`p`.`sexo` AS `SEXO`,`p`.`direccion` AS `DIRECCION`,`p`.`telefono` AS `TELEFONO`,`p`.`email` AS `EMAIL`,`n`.`pais` AS `PAIS`,`p`.`disponible` AS `DISPONIBLE`,`g`.`nombreGrado` AS `nombreGrado`,`g`.`annio` AS `annio`,`pe`.`tipo` AS `tipo` from ((((`persona` `p` join `profesor` `pe`) join `nacionalidad` `n`) join `grado` `g`) join `profesor_materia_grado` `pg`) where ((`p`.`idPersona` = `pe`.`Persona_idPersona`) and (`pe`.`idprofesor` = `pg`.`profesor_idprofesor`) and (`g`.`idgrado` = `pg`.`id_grado`) and (`p`.`idNacionalidad` = `n`.`idNacionalidad`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `alumno`
--
ALTER TABLE `alumno`
  ADD PRIMARY KEY (`idalumno`,`Persona_idPersona`),
  ADD UNIQUE KEY `idalumno_UNIQUE` (`idalumno`),
  ADD KEY `fk_alumno_Persona1_idx` (`Persona_idPersona`);

--
-- Indexes for table `alumno_encargado`
--
ALTER TABLE `alumno_encargado`
  ADD PRIMARY KEY (`ID_ALUMNO`,`ID_ENCARGADO`),
  ADD KEY `ID_ENCARGADO` (`ID_ENCARGADO`);

--
-- Indexes for table `asistencia`
--
ALTER TABLE `asistencia`
  ADD PRIMARY KEY (`IDASISTENCIA`),
  ADD KEY `FK_ASISTENCIA_ALUMNO` (`IDALUMNO`),
  ADD KEY `FK_ASISTENCIA_GRADO` (`IDGRADO`),
  ADD KEY `FK_ASISTENCIA_PROFESOR` (`idProfesor`);

--
-- Indexes for table `beca`
--
ALTER TABLE `beca`
  ADD PRIMARY KEY (`idbeca`),
  ADD KEY `fk_beca_alumno_idx` (`idAlumno`);

--
-- Indexes for table `director`
--
ALTER TABLE `director`
  ADD PRIMARY KEY (`idDirector`,`Persona_idPersona`),
  ADD UNIQUE KEY `iddirector_UNIQUE` (`idDirector`),
  ADD KEY `fk_director_Persona1_idx` (`Persona_idPersona`);

--
-- Indexes for table `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`idEmpleado`),
  ADD KEY `FK_EMPLEADO_PUESTO` (`idPuesto`),
  ADD KEY `FK_EMPLEADO_PERSONA` (`idPersona`);

--
-- Indexes for table `encargado`
--
ALTER TABLE `encargado`
  ADD PRIMARY KEY (`idencargado`,`Persona_idPersona`),
  ADD UNIQUE KEY `idencargado_UNIQUE` (`idencargado`),
  ADD KEY `fk_encargado_Persona1_idx` (`Persona_idPersona`);

--
-- Indexes for table `grado`
--
ALTER TABLE `grado`
  ADD PRIMARY KEY (`idgrado`);

--
-- Indexes for table `grado_estudiante_nota`
--
ALTER TABLE `grado_estudiante_nota`
  ADD PRIMARY KEY (`idGrado`,`idMateria`,`idNota`,`idEstudiante`),
  ADD KEY `fk_nota_idx1` (`idNota`),
  ADD KEY `fk_alumno_idx1` (`idEstudiante`),
  ADD KEY `fk_materia_idx1` (`idMateria`);

--
-- Indexes for table `historico_usuarios`
--
ALTER TABLE `historico_usuarios`
  ADD PRIMARY KEY (`idHistorico`);

--
-- Indexes for table `materia`
--
ALTER TABLE `materia`
  ADD PRIMARY KEY (`idmateria`),
  ADD KEY `FK_MATERIA_TIPOMATERIA` (`idTipoMateria`);

--
-- Indexes for table `nacionalidad`
--
ALTER TABLE `nacionalidad`
  ADD PRIMARY KEY (`idNacionalidad`),
  ADD UNIQUE KEY `idNacionalidad_UNIQUE` (`idNacionalidad`),
  ADD UNIQUE KEY `pais_UNIQUE` (`pais`);

--
-- Indexes for table `nota`
--
ALTER TABLE `nota`
  ADD PRIMARY KEY (`idnota`);

--
-- Indexes for table `nota_constante`
--
ALTER TABLE `nota_constante`
  ADD PRIMARY KEY (`idnota_constante`);

--
-- Indexes for table `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idPersona`),
  ADD UNIQUE KEY `idPersona_UNIQUE` (`idPersona`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD KEY `idNacionalidad_idx` (`idNacionalidad`);

--
-- Indexes for table `profesor`
--
ALTER TABLE `profesor`
  ADD PRIMARY KEY (`idprofesor`,`Persona_idPersona`),
  ADD UNIQUE KEY `idprofesor_UNIQUE` (`idprofesor`),
  ADD KEY `fk_profesor_Persona1_idx` (`Persona_idPersona`) USING BTREE;

--
-- Indexes for table `profesor_materia_grado`
--
ALTER TABLE `profesor_materia_grado`
  ADD PRIMARY KEY (`profesor_idprofesor`,`materia_idmateria`,`id_grado`),
  ADD KEY `fk_profesor_has_materia_materia1_idx` (`materia_idmateria`),
  ADD KEY `fk_profesor_has_materia_profesor1_idx` (`profesor_idprofesor`),
  ADD KEY `fk_profesor_materiagrado_idx` (`id_grado`);

--
-- Indexes for table `puesto`
--
ALTER TABLE `puesto`
  ADD PRIMARY KEY (`idPuesto`);

--
-- Indexes for table `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`IDROL`);

--
-- Indexes for table `tipo_materia`
--
ALTER TABLE `tipo_materia`
  ADD PRIMARY KEY (`idTipo`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idUsuario`),
  ADD KEY `fk_persona_usuario` (`idPersona`),
  ADD KEY `fk_rol_usuario` (`idRol`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `alumno`
--
ALTER TABLE `alumno`
  MODIFY `idalumno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `asistencia`
--
ALTER TABLE `asistencia`
  MODIFY `IDASISTENCIA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=239;

--
-- AUTO_INCREMENT for table `beca`
--
ALTER TABLE `beca`
  MODIFY `idbeca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `director`
--
ALTER TABLE `director`
  MODIFY `idDirector` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `empleado`
--
ALTER TABLE `empleado`
  MODIFY `idEmpleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `encargado`
--
ALTER TABLE `encargado`
  MODIFY `idencargado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `grado`
--
ALTER TABLE `grado`
  MODIFY `idgrado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `historico_usuarios`
--
ALTER TABLE `historico_usuarios`
  MODIFY `idHistorico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `materia`
--
ALTER TABLE `materia`
  MODIFY `idmateria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `nacionalidad`
--
ALTER TABLE `nacionalidad`
  MODIFY `idNacionalidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `nota`
--
ALTER TABLE `nota`
  MODIFY `idnota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=620;

--
-- AUTO_INCREMENT for table `nota_constante`
--
ALTER TABLE `nota_constante`
  MODIFY `idnota_constante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `persona`
--
ALTER TABLE `persona`
  MODIFY `idPersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=230;

--
-- AUTO_INCREMENT for table `profesor`
--
ALTER TABLE `profesor`
  MODIFY `idprofesor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `puesto`
--
ALTER TABLE `puesto`
  MODIFY `idPuesto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `rol`
--
ALTER TABLE `rol`
  MODIFY `IDROL` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tipo_materia`
--
ALTER TABLE `tipo_materia`
  MODIFY `idTipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `alumno`
--
ALTER TABLE `alumno`
  ADD CONSTRAINT `fk_alumno_persona` FOREIGN KEY (`Persona_idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `alumno_encargado`
--
ALTER TABLE `alumno_encargado`
  ADD CONSTRAINT `alumno_encargado_ibfk_1` FOREIGN KEY (`ID_ALUMNO`) REFERENCES `alumno` (`idalumno`),
  ADD CONSTRAINT `alumno_encargado_ibfk_2` FOREIGN KEY (`ID_ENCARGADO`) REFERENCES `encargado` (`idencargado`);

--
-- Constraints for table `asistencia`
--
ALTER TABLE `asistencia`
  ADD CONSTRAINT `FK_ASISTENCIA_ALUMNO` FOREIGN KEY (`IDALUMNO`) REFERENCES `alumno` (`idalumno`),
  ADD CONSTRAINT `FK_ASISTENCIA_GRADO` FOREIGN KEY (`IDGRADO`) REFERENCES `grado` (`idgrado`),
  ADD CONSTRAINT `FK_ASISTENCIA_PROFESOR` FOREIGN KEY (`idProfesor`) REFERENCES `profesor` (`idprofesor`);

--
-- Constraints for table `beca`
--
ALTER TABLE `beca`
  ADD CONSTRAINT `fk_beca_alumno` FOREIGN KEY (`idAlumno`) REFERENCES `alumno` (`idalumno`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `director`
--
ALTER TABLE `director`
  ADD CONSTRAINT `fk_director_Persona1` FOREIGN KEY (`Persona_idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `FK_EMPLEADO_PERSONA` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`),
  ADD CONSTRAINT `FK_EMPLEADO_PUESTO` FOREIGN KEY (`idPuesto`) REFERENCES `puesto` (`idPuesto`);

--
-- Constraints for table `encargado`
--
ALTER TABLE `encargado`
  ADD CONSTRAINT `fk_encargado_Persona1` FOREIGN KEY (`Persona_idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `grado_estudiante_nota`
--
ALTER TABLE `grado_estudiante_nota`
  ADD CONSTRAINT `fk_alumno_materia_grado_nota` FOREIGN KEY (`idEstudiante`) REFERENCES `alumno` (`idalumno`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_grado_materia_alumno_nota` FOREIGN KEY (`idGrado`) REFERENCES `grado` (`idgrado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_materia_grado_alumno_nota` FOREIGN KEY (`idMateria`) REFERENCES `materia` (`idmateria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_nota_estudiante_materia_grado` FOREIGN KEY (`idNota`) REFERENCES `nota` (`idnota`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `materia`
--
ALTER TABLE `materia`
  ADD CONSTRAINT `FK_MATERIA_TIPOMATERIA` FOREIGN KEY (`idTipoMateria`) REFERENCES `tipo_materia` (`idTipo`);

--
-- Constraints for table `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `idNacionalidad` FOREIGN KEY (`idNacionalidad`) REFERENCES `nacionalidad` (`idNacionalidad`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `profesor`
--
ALTER TABLE `profesor`
  ADD CONSTRAINT `fk_profesor_Persona1` FOREIGN KEY (`Persona_idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `profesor_materia_grado`
--
ALTER TABLE `profesor_materia_grado`
  ADD CONSTRAINT `fk_profesor_has_materia_materia1` FOREIGN KEY (`materia_idmateria`) REFERENCES `materia` (`idmateria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_profesor_has_materia_profesor1` FOREIGN KEY (`profesor_idprofesor`) REFERENCES `profesor` (`idprofesor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_profesor_materiagrado` FOREIGN KEY (`id_grado`) REFERENCES `grado` (`idgrado`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_persona_usuario` FOREIGN KEY (`idPersona`) REFERENCES `persona` (`idPersona`),
  ADD CONSTRAINT `fk_rol_usuario` FOREIGN KEY (`idRol`) REFERENCES `rol` (`IDROL`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
