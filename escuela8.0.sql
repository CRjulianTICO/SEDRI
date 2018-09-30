-- phpMyAdmin SQL Dump
-- version 4.8.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-09-2018 a las 08:11:35
-- Versión del servidor: 10.1.31-MariaDB
-- Versión de PHP: 7.2.4

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
    WHERE cedula = VCED
    INTO @idP;
    SELECT idAlumno
    FROM alumno
    WHERE Persona_idPersona = @idP
    INTO @idA;
    UPDATE beca
    SET estado = 1
    WHERE idAlumno = @idA;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizaBeca` (IN `VDESC` VARCHAR(500), IN `VMON` VARCHAR(40), IN `VCED` VARCHAR(20))  BEGIN
	SELECT idPersona
    FROM persona
    WHERE cedula = VCED
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
 WHERE CEDULA = CED;
 
 SELECT idPersona FROM persona WHERE CEDULA = CED INTO @id ;
 
UPDATE empleado SET 
idPuesto = PUE
WHERE idPersona = @id;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_DesactivaBeca` (IN `VCED` VARCHAR(20))  BEGIN
	SELECT idPersona
    FROM persona
    WHERE cedula = VCED
    INTO @idP;
    SELECT idAlumno
    FROM alumno
    WHERE Persona_idPersona = @idP
    INTO @idA;
    UPDATE beca
    SET estado = 0
    WHERE idAlumno = @idA;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertaAlumno` (IN `VCED` VARCHAR(20), IN `VNOM` VARCHAR(40), IN `VAPE1` VARCHAR(40), IN `VAPE2` VARCHAR(40), IN `VSEX` VARCHAR(20), IN `VDIR` VARCHAR(50), IN `VNAC` INT, IN `VNOT` VARCHAR(650))  BEGIN
 INSERT INTO persona( cedula, nombre, apellido1, apellido2, sexo, direccion,idNacionalidad,nota_medica)
 VALUES(VCED,VNOM,VAPE1,VAPE2,VSEX,VDIR,VNAC,VNOT);
 
 SELECT idPersona
 FROM persona
 WHERE cedula = VCED
 INTO @id;
 
 INSERT INTO alumno(Persona_idPersona)VALUES(@id);
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertaProfesor` (IN `VCED` VARCHAR(45), IN `VNOM` VARCHAR(45), IN `VAP1` VARCHAR(45), IN `VAP2` VARCHAR(45), IN `VSEXO` VARCHAR(20), IN `VDIR` VARCHAR(100), IN `VTEL` VARCHAR(45), IN `VEMAIL` VARCHAR(45), IN `VNAC` INT, IN `VANNIO` INT, IN `VGRADO` INT, IN `VPASS` VARCHAR(80))  BEGIN
 INSERT INTO persona( cedula, nombre, apellido1, apellido2, sexo, direccion,telefono,email,idNacionalidad)
 VALUES(VCED,VNOM,VAP1,VAP2,VSEXO,VDIR,VTEL,VEMAIL,VNAC);
 
 SELECT idPersona
 FROM persona
 WHERE cedula = VCED
 INTO @id;
 
 INSERT INTO profesor(Persona_idPersona)VALUES(@id);
 
 SELECT idprofesor
 FROM profesor
 WHERE Persona_idPersona = @id
 INTO @idP;
 
 INSERT INTO usuario(idPersona,idRol,password,cambio)
 VALUES (@id,1,VPASS,1);
 
 INSERT INTO profesor_grado(annio,idGrado,idProfesor)VALUES(VANNIO,VGRADO,@idP);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertarEmpleado` (IN `CED` VARCHAR(20), IN `NOM` VARCHAR(35), IN `APE1` VARCHAR(35), IN `APE2` VARCHAR(35), IN `SEX` VARCHAR(20), IN `DIRECC` VARCHAR(50), IN `TEL` VARCHAR(25), IN `NAC` INT, IN `PUE` INT)  BEGIN

 INSERT INTO persona (CEDULA,NOMBRE,APELLIDO1,APELLIDO2,SEXO,DIRECCION,TELEFONO,idNacionalidad) VALUES(CED,NOM,APE1,APE2,SEX,DIRECC,TEL,NAC);
 
 SELECT idPersona FROM persona WHERE CEDULA = CED  INTO @id ;
 
 INSERT INTO empleado(idPersona,idPuesto) VALUES(@id,PUE);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_Login` (OUT `pass` VARCHAR(150), IN `ced` VARCHAR(25), OUT `id` INT, OUT `rol` VARCHAR(50), OUT `nombre` VARCHAR(50))  BEGIN
select u.password,p.idPersona, r.tiporol ,CONCAT(p.nombre,' ',CONCAT(p.apellido1,' ',p.apellido2)) as nombre
into pass,id,rol,nombre
from usuario u, persona p , rol r 
where  p.idPersona = u.idPersona and p.cedula=ced ;
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
WHERE cedula = VCED;
 
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno`
--

CREATE TABLE IF NOT EXISTS `alumno` (
  `idalumno` int(11) NOT NULL AUTO_INCREMENT,
  `Persona_idPersona` int(11) NOT NULL,
  PRIMARY KEY (`idalumno`,`Persona_idPersona`),
  UNIQUE KEY `idalumno_UNIQUE` (`idalumno`),
  KEY `fk_alumno_Persona1_idx` (`Persona_idPersona`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `alumno`
--

INSERT INTO `alumno` (`idalumno`, `Persona_idPersona`) VALUES
(1, 11),
(2, 12),
(3, 13),
(4, 15);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno_encargado`
--

CREATE TABLE IF NOT EXISTS `alumno_encargado` (
  `ID_ALUMNO` int(11) NOT NULL,
  `ID_ENCARGADO` int(11) NOT NULL,
  PRIMARY KEY (`ID_ALUMNO`,`ID_ENCARGADO`),
  KEY `ID_ENCARGADO` (`ID_ENCARGADO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno_materia`
--

CREATE TABLE IF NOT EXISTS `alumno_materia` (
  `alumno_idalumno` int(11) NOT NULL,
  `materia_idmateria` int(11) NOT NULL,
  `trimestre_1` decimal(10,0) DEFAULT NULL,
  `trimestre_2` decimal(10,0) DEFAULT NULL,
  `trimestre_3` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`alumno_idalumno`,`materia_idmateria`),
  KEY `fk_alumno_has_materia_materia1_idx` (`materia_idmateria`),
  KEY `fk_alumno_has_materia_alumno1_idx` (`alumno_idalumno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia`
--

CREATE TABLE IF NOT EXISTS `asistencia` (
  `IDASISTENCIA` int(11) NOT NULL AUTO_INCREMENT,
  `ESTADO` tinyint(1) DEFAULT NULL,
  `NOTA` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `IDALUMNO` int(11) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  PRIMARY KEY (`IDASISTENCIA`),
  KEY `FK_ASISTENCIA_ALUMNO` (`IDALUMNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `beca`
--

CREATE TABLE IF NOT EXISTS `beca` (
  `idbeca` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion_beca` varchar(500) CHARACTER SET utf8 NOT NULL,
  `monto_beca` varchar(45) CHARACTER SET utf8 NOT NULL,
  `idAlumno` int(11) NOT NULL,
  `estado` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`idbeca`),
  KEY `fk_beca_alumno_idx` (`idAlumno`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

CREATE TABLE IF NOT EXISTS `director` (
  `idDirector` int(11) NOT NULL AUTO_INCREMENT,
  `Persona_idPersona` int(11) NOT NULL,
  PRIMARY KEY (`idDirector`,`Persona_idPersona`),
  UNIQUE KEY `iddirector_UNIQUE` (`idDirector`),
  KEY `fk_director_Persona1_idx` (`Persona_idPersona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE IF NOT EXISTS `empleado` (
  `idEmpleado` int(11) NOT NULL AUTO_INCREMENT,
  `idPersona` int(11) NOT NULL,
  `idPuesto` int(11) NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  KEY `FK_EMPLEADO_PUESTO` (`idPuesto`),
  KEY `FK_EMPLEADO_PERSONA` (`idPersona`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`idEmpleado`, `idPersona`, `idPuesto`) VALUES
(1, 10, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `encargado`
--

CREATE TABLE IF NOT EXISTS `encargado` (
  `idencargado` int(11) NOT NULL AUTO_INCREMENT,
  `Persona_idPersona` int(11) NOT NULL,
  PRIMARY KEY (`idencargado`,`Persona_idPersona`),
  UNIQUE KEY `idencargado_UNIQUE` (`idencargado`),
  KEY `fk_encargado_Persona1_idx` (`Persona_idPersona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grado`
--

CREATE TABLE IF NOT EXISTS `grado` (
  `idgrado` int(11) NOT NULL AUTO_INCREMENT,
  `nombreGrado` varchar(45) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`idgrado`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `grado`
--

INSERT INTO `grado` (`idgrado`, `nombreGrado`) VALUES
(1, 'Primeros'),
(2, 'Segundo'),
(3, 'Quinto');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grado_alumno`
--

CREATE TABLE IF NOT EXISTS `grado_alumno` (
  `grado_idgrado` int(11) NOT NULL,
  `alumno_idalumno` int(11) NOT NULL,
  `annio` int(11) DEFAULT NULL,
  PRIMARY KEY (`grado_idgrado`,`alumno_idalumno`),
  KEY `fk_grado_has_alumno_alumno1_idx` (`alumno_idalumno`),
  KEY `fk_grado_has_alumno_grado1_idx` (`grado_idgrado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `grado_alumno`
--

INSERT INTO `grado_alumno` (`grado_idgrado`, `alumno_idalumno`, `annio`) VALUES
(1, 1, 2018),
(1, 3, 2018),
(2, 2, 2018),
(2, 4, 2018);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grado_estudiante_nota`
--

CREATE TABLE IF NOT EXISTS `grado_estudiante_nota` (
  `idGrado` int(11) NOT NULL,
  `idMateria` int(11) NOT NULL,
  `idNota` int(11) NOT NULL,
  `idEstudiante` int(11) NOT NULL,
  `trimestre` int(11) DEFAULT NULL,
  PRIMARY KEY (`idGrado`,`idMateria`,`idNota`,`idEstudiante`),
  KEY `fk_nota_idx1` (`idNota`),
  KEY `fk_alumno_idx1` (`idEstudiante`),
  KEY `fk_materia_idx1` (`idMateria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materia`
--

CREATE TABLE IF NOT EXISTS `materia` (
  `idmateria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) CHARACTER SET latin1 NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idmateria`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `materia`
--

INSERT INTO `materia` (`idmateria`, `nombre`, `estado`) VALUES
(1, 'Ingles', 0),
(3, 'Fisica II', 1),
(4, 'Matematica', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nacionalidad`
--

CREATE TABLE IF NOT EXISTS `nacionalidad` (
  `idNacionalidad` int(11) NOT NULL AUTO_INCREMENT,
  `pais` varchar(45) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`idNacionalidad`),
  UNIQUE KEY `idNacionalidad_UNIQUE` (`idNacionalidad`),
  UNIQUE KEY `pais_UNIQUE` (`pais`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

CREATE TABLE IF NOT EXISTS `nota` (
  `idnota` int(11) NOT NULL AUTO_INCREMENT,
  `trabajo_cotidiano` decimal(8,2) DEFAULT NULL,
  `asistencia` decimal(8,2) DEFAULT NULL,
  `tareas` decimal(8,2) DEFAULT NULL,
  `pruebas` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`idnota`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nota_constante`
--

CREATE TABLE IF NOT EXISTS `nota_constante` (
  `idnota_constante` int(11) NOT NULL AUTO_INCREMENT,
  `grado` int(11) NOT NULL,
  `trabajo_cotidiano` decimal(8,2) DEFAULT NULL,
  `pruebas` decimal(8,2) DEFAULT NULL,
  `tareas` decimal(8,2) DEFAULT NULL,
  `asistencia` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`idnota_constante`),
  KEY `fk_grado_idx` (`grado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE IF NOT EXISTS `persona` (
  `idPersona` int(11) NOT NULL AUTO_INCREMENT,
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
  `nota_medica` varchar(650) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idPersona`),
  UNIQUE KEY `idPersona_UNIQUE` (`idPersona`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `idNacionalidad_idx` (`idNacionalidad`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idPersona`, `cedula`, `nombre`, `apellido1`, `apellido2`, `sexo`, `direccion`, `telefono`, `telefono_secundario`, `email`, `idNacionalidad`, `disponible`, `nota_medica`) VALUES
(1, '1', 'Julian', 'Perez', 'Fernandez', 'Masculino', 'Heredia', '8', NULL, '@vegeto', 1, 0, NULL),
(10, '3085254', 'JUAN JOSE', 'AVALOS', 'PORA', 'masculino', 'ALSJUELA', '1', NULL, NULL, 1, 1, NULL),
(11, '12059826', 'Luisa', 'Montero', 'Chacon', 'Femenino', 'Aserri', NULL, NULL, NULL, 1, 1, NULL),
(12, '5649111', 'Miguel', 'Orozco', 'Sanchez', 'Masculino', 'Tarbaca', NULL, NULL, NULL, 1, 1, NULL),
(13, '45524685', 'Fernanda', 'Rodriguez', 'Morera', 'Femenino', 'Desamparados', NULL, NULL, NULL, 1, 1, NULL),
(14, '305454685', 'Esteban', 'Jimenez', 'Ferrer', 'Masculino', 'Aserri', NULL, NULL, NULL, 2, 1, NULL),
(15, '638268557', 'Pablo', 'Hernandez', 'Flores', 'Masculino', 'Aserri', NULL, NULL, NULL, 1, 1, NULL),
(38, '307680159', 'Marco', 'Chinchila', 'Brenes ', 'Masculino', 'Desamparados', '5465657', NULL, 'mchinchilla@mail.com', 1, 1, NULL),
(39, '107680159', 'Carlos', 'Alfaro', 'Gonzales', 'Masculino', 'Heredia', '1111', NULL, 'asd@gmail.com', 1, 1, NULL),
(41, '507680129', 'Marta Francisco', 'Chinchilla', '.Saborio', 'Femenino', 'San Antonio de Desamparados', '24456767', NULL, 'mSaborio@gmail.com', 1, 1, NULL),
(44, '305080238', 'Francisco', 'Flores', 'Chacon', 'Masculino', 'De la escuela publica de Aserri 150 mts al sur', '60439934', NULL, 'julian4nite@gmail.com', 1, 1, NULL),
(69, '207680159', 'Oscar', 'Eduardo', 'Soto', 'Masculino', 'Alajuela, Atenas, Costa Rica', '63103970', NULL, 'oscarsoto040797@gmail.com', 1, 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesor`
--

CREATE TABLE IF NOT EXISTS `profesor` (
  `idprofesor` int(11) NOT NULL AUTO_INCREMENT,
  `Persona_idPersona` int(11) NOT NULL,
  PRIMARY KEY (`idprofesor`,`Persona_idPersona`),
  UNIQUE KEY `idprofesor_UNIQUE` (`idprofesor`),
  KEY `fk_profesor_Persona1_idx` (`Persona_idPersona`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `profesor`
--

INSERT INTO `profesor` (`idprofesor`, `Persona_idPersona`) VALUES
(1, 1),
(6, 38),
(7, 39),
(8, 41),
(9, 44),
(20, 69);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesor_grado`
--

CREATE TABLE IF NOT EXISTS `profesor_grado` (
  `idProfesor` int(11) NOT NULL,
  `idGrado` int(11) NOT NULL,
  `annio` int(11) NOT NULL,
  PRIMARY KEY (`idProfesor`,`idGrado`),
  KEY `fk_grado_p` (`idGrado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `profesor_grado`
--

INSERT INTO `profesor_grado` (`idProfesor`, `idGrado`, `annio`) VALUES
(1, 1, 2018),
(6, 1, 2018),
(7, 2, 2018),
(8, 1, 2019),
(9, 3, 2018),
(20, 1, 2018);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesor_materia_grado`
--

CREATE TABLE IF NOT EXISTS `profesor_materia_grado` (
  `profesor_idprofesor` int(11) NOT NULL,
  `materia_idmateria` int(11) NOT NULL,
  `id_grado` int(11) NOT NULL,
  PRIMARY KEY (`profesor_idprofesor`,`materia_idmateria`,`id_grado`),
  KEY `fk_profesor_has_materia_materia1_idx` (`materia_idmateria`),
  KEY `fk_profesor_has_materia_profesor1_idx` (`profesor_idprofesor`),
  KEY `fk_profesor_materiagrado_idx` (`id_grado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `puesto`
--

CREATE TABLE IF NOT EXISTS `puesto` (
  `idPuesto` int(11) NOT NULL AUTO_INCREMENT,
  `nombrePuesto` varchar(45) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `descrpcionPuesto` varchar(100) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`idPuesto`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `puesto`
--

INSERT INTO `puesto` (`idPuesto`, `nombrePuesto`, `descrpcionPuesto`) VALUES
(1, 'Conserje', 'Encargado de la limpieza de la institucion y mucho mas'),
(2, 'Guardia', 'Seguridad II');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE IF NOT EXISTS `rol` (
  `IDROL` int(11) NOT NULL AUTO_INCREMENT,
  `tiporol` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`IDROL`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`IDROL`, `tiporol`) VALUES
(1, 'Profesor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `idPersona` int(11) DEFAULT NULL,
  `idRol` int(11) DEFAULT NULL,
  `password` varchar(150) CHARACTER SET utf8 DEFAULT NULL,
  `cambio` tinyint(2) NOT NULL,
  PRIMARY KEY (`idUsuario`),
  KEY `fk_persona_usuario` (`idPersona`),
  KEY `fk_rol_usuario` (`idRol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `idPersona`, `idRol`, `password`, `cambio`) VALUES
(1, 38, 1, '$2y$09$MmyH9eXuU0kyGbfmlNV6ze4d7pBJr.cK0brq4P0R/rBMOG0pFQkh.', 0),
(3, 69, 1, '$2y$09$dqg9Ap70mEybR6mw.JgGluHoZ05B4VHd/ifETXPLgZXhr5OTEC6ES', 1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vbeca`
-- (Véase abajo para la vista actual)
--
CREATE TABLE IF NOT EXISTS `vbeca` (
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
CREATE TABLE IF NOT EXISTS `vdirector` (
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
CREATE TABLE IF NOT EXISTS `vista_alumno` (
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
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_empleado`
-- (Véase abajo para la vista actual)
--
CREATE TABLE IF NOT EXISTS `vista_empleado` (
`cedula` varchar(45)
,`nombre` varchar(45)
,`apellido1` varchar(45)
,`apellido2` varchar(45)
,`sexo` varchar(20)
,`direccion` varchar(100)
,`telefono` varchar(45)
,`pais` varchar(45)
,`nombrePuesto` varchar(45)
,`disponible` tinyint(1)
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vista_profesor`
-- (Véase abajo para la vista actual)
--
CREATE TABLE IF NOT EXISTS `vista_profesor` (
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
);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vprofesor`
-- (Véase abajo para la vista actual)
--
CREATE TABLE IF NOT EXISTS `vprofesor` (
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

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_alumno`  AS  select `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,`p`.`apellido1` AS `apellido1`,`p`.`apellido2` AS `apellido2`,`p`.`sexo` AS `sexo`,`n`.`pais` AS `pais`,`g`.`nombreGrado` AS `nombreGrado`,`ga`.`annio` AS `annio`,`p`.`direccion` AS `direccion`,`p`.`nota_medica` AS `nota_medica` from ((((`alumno` `a` join `persona` `p`) join `nacionalidad` `n`) join `grado` `g`) join `grado_alumno` `ga`) where ((`a`.`Persona_idPersona` = `p`.`idPersona`) and (`p`.`idNacionalidad` = `n`.`idNacionalidad`) and (`a`.`idalumno` = `ga`.`alumno_idalumno`) and (`ga`.`grado_idgrado` = `g`.`idgrado`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_empleado`
--
DROP TABLE IF EXISTS `vista_empleado`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_empleado`  AS  select `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,`p`.`apellido1` AS `apellido1`,`p`.`apellido2` AS `apellido2`,`p`.`sexo` AS `sexo`,`p`.`direccion` AS `direccion`,`p`.`telefono` AS `telefono`,`n`.`pais` AS `pais`,`f`.`nombrePuesto` AS `nombrePuesto`,`p`.`disponible` AS `disponible` from (((`persona` `p` join `empleado` `e`) join `puesto` `f`) join `nacionalidad` `n`) where ((`p`.`idPersona` = `e`.`idPersona`) and (`f`.`idPuesto` = `e`.`idPuesto`) and (`n`.`idNacionalidad` = `p`.`idNacionalidad`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_profesor`
--
DROP TABLE IF EXISTS `vista_profesor`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_profesor`  AS  select `p`.`cedula` AS `CEDULA`,`p`.`nombre` AS `NOMBRE`,`p`.`apellido1` AS `APELLIDO1`,`p`.`apellido2` AS `APELLIDO2`,`p`.`sexo` AS `SEXO`,`p`.`direccion` AS `DIRECCION`,`p`.`telefono` AS `TELEFONO`,`p`.`email` AS `EMAIL`,`n`.`pais` AS `PAIS`,`p`.`disponible` AS `DISPONIBLE`,`g`.`nombreGrado` AS `nombreGrado`,`pg`.`annio` AS `annio` from ((((`persona` `p` join `profesor` `pe`) join `nacionalidad` `n`) join `grado` `g`) join `profesor_grado` `pg`) where ((`p`.`idPersona` = `pe`.`Persona_idPersona`) and (`pe`.`idprofesor` = `pg`.`idProfesor`) and (`g`.`idgrado` = `pg`.`idGrado`) and (`p`.`idNacionalidad` = `n`.`idNacionalidad`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vprofesor`
--
DROP TABLE IF EXISTS `vprofesor`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vprofesor`  AS  select `pe`.`cedula` AS `CEDULA`,`pe`.`nombre` AS `NOMBRE`,concat(`pe`.`apellido1`,' ',`pe`.`apellido2`) AS `APELLIDOS`,`pe`.`sexo` AS `SEXO`,`pe`.`direccion` AS `DIRECCION`,`pe`.`telefono` AS `TELEFONO`,`pe`.`email` AS `EMAIL`,`n`.`pais` AS `PAIS`,`pe`.`disponible` AS `DISPONIBLE` from ((`profesor` `pr` join `persona` `pe`) join `nacionalidad` `n`) where ((`pe`.`idPersona` = `pr`.`idprofesor`) and (`n`.`idNacionalidad` = `pe`.`idNacionalidad`)) ;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD CONSTRAINT `fk_alumno_Persona1` FOREIGN KEY (`Persona_idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `alumno_encargado`
--
ALTER TABLE `alumno_encargado`
  ADD CONSTRAINT `alumno_encargado_ibfk_1` FOREIGN KEY (`ID_ALUMNO`) REFERENCES `alumno` (`idalumno`),
  ADD CONSTRAINT `alumno_encargado_ibfk_2` FOREIGN KEY (`ID_ENCARGADO`) REFERENCES `encargado` (`idencargado`);

--
-- Filtros para la tabla `alumno_materia`
--
ALTER TABLE `alumno_materia`
  ADD CONSTRAINT `fk_alumno_has_materia_alumno1` FOREIGN KEY (`alumno_idalumno`) REFERENCES `alumno` (`idalumno`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_alumno_has_materia_materia1` FOREIGN KEY (`materia_idmateria`) REFERENCES `materia` (`idmateria`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `asistencia`
--
ALTER TABLE `asistencia`
  ADD CONSTRAINT `FK_ASISTENCIA_ALUMNO` FOREIGN KEY (`IDALUMNO`) REFERENCES `alumno` (`idalumno`);

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
-- Filtros para la tabla `grado_alumno`
--
ALTER TABLE `grado_alumno`
  ADD CONSTRAINT `fk_grado_has_alumno_alumno1` FOREIGN KEY (`alumno_idalumno`) REFERENCES `alumno` (`idalumno`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_grado_has_alumno_grado1` FOREIGN KEY (`grado_idgrado`) REFERENCES `grado` (`idgrado`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `grado_estudiante_nota`
--
ALTER TABLE `grado_estudiante_nota`
  ADD CONSTRAINT `fk_alumno_materia_grado_nota` FOREIGN KEY (`idEstudiante`) REFERENCES `alumno` (`idalumno`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_grado_materia_alumno_nota` FOREIGN KEY (`idGrado`) REFERENCES `grado` (`idgrado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_materia_grado_alumno_nota` FOREIGN KEY (`idMateria`) REFERENCES `materia` (`idmateria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_nota_estudiante_materia_grado` FOREIGN KEY (`idNota`) REFERENCES `nota` (`idnota`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `nota_constante`
--
ALTER TABLE `nota_constante`
  ADD CONSTRAINT `fk_grado` FOREIGN KEY (`grado`) REFERENCES `grado` (`idgrado`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
-- Filtros para la tabla `profesor_grado`
--
ALTER TABLE `profesor_grado`
  ADD CONSTRAINT `fk_grado_p` FOREIGN KEY (`idGrado`) REFERENCES `grado` (`idgrado`),
  ADD CONSTRAINT `fk_profesor_p` FOREIGN KEY (`idProfesor`) REFERENCES `profesor` (`idprofesor`);

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