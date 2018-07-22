-- phpMyAdmin SQL Dump
-- version 4.8.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-07-2018 a las 05:58:47
-- Versión del servidor: 10.1.33-MariaDB
-- Versión de PHP: 7.2.6

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
CREATE DATABASE IF NOT EXISTS `escuela` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;
USE `escuela`;

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `login` (IN `pass` CHAR(20), IN `ced` VARCHAR(25))  BEGIN
select p.idPersona, r.tiporol 
from usuario u, persona p , rol r 
where u.password=pass and p.cedula=ced ;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertaAlumno` (IN `CEDULA` VARCHAR(45), IN `NOMBRE` VARCHAR(45), IN `APELLIDO1` VARCHAR(45), IN `APELLIDO2` VARCHAR(45), IN `SEXO` VARCHAR(20), IN `DIRECCION` VARCHAR(100), IN `NACIONALIDAD` INT, IN `DISPONIBILIDAD` BOOLEAN)  BEGIN
DECLARE VID INT;

 INSERT INTO persona( cedula, nombre, apellido1, apellido2, sexo, direccion,idNacionalidad, disponible) 
    VALUES (CEDULA,NOMBRE,APELLIDO1,APELLIDO2,SEXO,DIRECCION,NACIONALIDAD,DISPONIBILIDAD);
    SELECT idPersona INTO VID FROM persona where cedula = CEDULA;
    INSERT INTO alumno(Persona_idPersona)VALUES(VID);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertaProfesor` (IN `CEDULA` VARCHAR(45), IN `NOMBRE` VARCHAR(45), IN `APELLIDO1` VARCHAR(45), IN `APELLIDO2` VARCHAR(45), IN `SEXO` VARCHAR(20), IN `DIRECCION` VARCHAR(100), IN `TELEFONO` VARCHAR(45), IN `EMAIL` VARCHAR(45), IN `NACIONALIDAD` INT, IN `DISPONIBILIDAD` BOOLEAN)  BEGIN
DECLARE VID INT;

 INSERT INTO persona( cedula, nombre, apellido1, apellido2, sexo, direccion, telefono, email, idNacionalidad, disponible) 
    VALUES (CEDULA,NOMBRE,APELLIDO1,APELLIDO2,SEXO,DIRECCION,TELEFONO,EMAIL,NACIONALIDAD,DISPONIBILIDAD);
    SELECT idPersona INTO VID FROM persona where cedula = CEDULA;
    INSERT INTO profesor(Persona_idPersona)VALUES(VID);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno_encargado`
--

CREATE TABLE IF NOT EXISTS `alumno_encargado` (
  `ID_ALUMNO` int(11) NOT NULL,
  `ID_ENCARGADO` int(11) NOT NULL,
  PRIMARY KEY (`ID_ALUMNO`,`ID_ENCARGADO`),
  KEY `ID_ENCARGADO` (`ID_ENCARGADO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia`
--

CREATE TABLE IF NOT EXISTS `asistencia` (
  `IDASISTENCIA` int(11) NOT NULL AUTO_INCREMENT,
  `ESTADO` tinyint(1) DEFAULT NULL,
  `NOTA` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `IDALUMNO` int(11) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  PRIMARY KEY (`IDASISTENCIA`),
  KEY `FK_ASISTENCIA_ALUMNO` (`IDALUMNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `beca`
--

CREATE TABLE IF NOT EXISTS `beca` (
  `idbeca` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion_beca` varchar(45) NOT NULL,
  `monto_beca` varchar(45) NOT NULL,
  `idAlumno` int(11) NOT NULL,
  PRIMARY KEY (`idbeca`),
  KEY `fk_beca_alumno_idx` (`idAlumno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grado`
--

CREATE TABLE IF NOT EXISTS `grado` (
  `idgrado` int(11) NOT NULL AUTO_INCREMENT,
  `nombreGrado` varchar(45) NOT NULL,
  PRIMARY KEY (`idgrado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `grado_alumno`
--

CREATE TABLE IF NOT EXISTS `grado_alumno` (
  `grado_idgrado` int(11) NOT NULL,
  `alumno_idalumno` int(11) NOT NULL,
  `annio` date DEFAULT NULL,
  PRIMARY KEY (`grado_idgrado`,`alumno_idalumno`),
  KEY `fk_grado_has_alumno_alumno1_idx` (`alumno_idalumno`),
  KEY `fk_grado_has_alumno_grado1_idx` (`grado_idgrado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materia`
--

CREATE TABLE IF NOT EXISTS `materia` (
  `idmateria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`idmateria`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `nacionalidad`
--

CREATE TABLE IF NOT EXISTS `nacionalidad` (
  `idNacionalidad` int(11) NOT NULL AUTO_INCREMENT,
  `pais` varchar(45) NOT NULL,
  PRIMARY KEY (`idNacionalidad`),
  UNIQUE KEY `idNacionalidad_UNIQUE` (`idNacionalidad`),
  UNIQUE KEY `pais_UNIQUE` (`pais`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE IF NOT EXISTS `persona` (
  `idPersona` int(11) NOT NULL AUTO_INCREMENT,
  `cedula` varchar(45) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `apellido1` varchar(45) NOT NULL,
  `apellido2` varchar(45) NOT NULL,
  `sexo` varchar(20) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `telefono_secundario` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `idNacionalidad` int(11) NOT NULL,
  `disponible` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idPersona`),
  UNIQUE KEY `idPersona_UNIQUE` (`idPersona`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  KEY `idNacionalidad_idx` (`idNacionalidad`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idPersona`, `cedula`, `nombre`, `apellido1`, `apellido2`, `sexo`, `direccion`, `telefono`, `telefono_secundario`, `email`, `idNacionalidad`, `disponible`) VALUES
(1, '1', 'Julian', 'Perez', 'Fernandez', 'Masculino', 'Heredia', '8', NULL, '@vegeto', 1, 0);

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `profesor`
--

INSERT INTO `profesor` (`idprofesor`, `Persona_idPersona`) VALUES
(1, 1);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE IF NOT EXISTS `rol` (
  `IDROL` int(11) NOT NULL AUTO_INCREMENT,
  `tiporol` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`IDROL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `idPersona` int(11) DEFAULT NULL,
  `idRol` int(11) DEFAULT NULL,
  `password` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`),
  KEY `fk_persona_usuario` (`idPersona`),
  KEY `fk_rol_usuario` (`idRol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
,`direccion` varchar(100)
,`pais` varchar(45)
,`disponible` tinyint(1)
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
-- Estructura para la vista `vdirector`
--
DROP TABLE IF EXISTS `vdirector`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vdirector`  AS  select `pe`.`cedula` AS `CEDULA`,`pe`.`nombre` AS `NOMBRE`,concat(`pe`.`apellido1`,' ',`pe`.`apellido2`) AS `APELLIDOS`,`pe`.`sexo` AS `SEXO`,`pe`.`direccion` AS `DIRECCION`,`pe`.`telefono` AS `TELEFONO`,`pe`.`email` AS `EMAIL`,`n`.`pais` AS `PAIS`,`pe`.`disponible` AS `DISPONIBLE` from ((`director` `pr` join `persona` `pe`) join `nacionalidad` `n`) where ((`pe`.`idPersona` = `pr`.`idDirector`) and (`n`.`idNacionalidad` = `pe`.`idNacionalidad`)) ;

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_alumno`
--
DROP TABLE IF EXISTS `vista_alumno`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_alumno`  AS  select `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,`p`.`apellido1` AS `apellido1`,`p`.`apellido2` AS `apellido2`,`p`.`sexo` AS `sexo`,`p`.`direccion` AS `direccion`,`n`.`pais` AS `pais`,`p`.`disponible` AS `disponible` from ((`persona` `p` join `alumno` `a`) join `nacionalidad` `n`) where ((`p`.`idPersona` = `a`.`Persona_idPersona`) and (`n`.`idNacionalidad` = `p`.`idNacionalidad`)) ;

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
