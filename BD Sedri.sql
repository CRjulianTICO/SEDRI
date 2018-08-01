-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 24, 2018 at 09:13 AM
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
CREATE DATABASE IF NOT EXISTS `escuela` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;
USE `escuela`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `login`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `login` (IN `pass` CHAR(20), IN `ced` VARCHAR(25))  BEGIN
select p.idPersona, r.tiporol 
from usuario u, persona p , rol r 
where u.password=pass and p.cedula=ced ;
END$$

DROP PROCEDURE IF EXISTS `sp_InsertaAlumno`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertaAlumno` (IN `CEDULA` VARCHAR(45), IN `NOMBRE` VARCHAR(45), IN `APELLIDO1` VARCHAR(45), IN `APELLIDO2` VARCHAR(45), IN `SEXO` VARCHAR(20), IN `DIRECCION` VARCHAR(100), IN `NACIONALIDAD` INT, IN `DISPONIBILIDAD` BOOLEAN)  BEGIN
DECLARE VID INT;

 INSERT INTO persona( cedula, nombre, apellido1, apellido2, sexo, direccion,idNacionalidad, disponible) 
    VALUES (CEDULA,NOMBRE,APELLIDO1,APELLIDO2,SEXO,DIRECCION,NACIONALIDAD,DISPONIBILIDAD);
    SELECT idPersona INTO VID FROM persona where cedula = CEDULA;
    INSERT INTO alumno(Persona_idPersona)VALUES(VID);
END$$

DROP PROCEDURE IF EXISTS `sp_InsertaProfesor`$$
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
-- Table structure for table `alumno`
--
-- Creation: Jul 24, 2018 at 07:04 AM
--

DROP TABLE IF EXISTS `alumno`;
CREATE TABLE IF NOT EXISTS `alumno` (
  `idalumno` int(11) NOT NULL AUTO_INCREMENT,
  `Persona_idPersona` int(11) NOT NULL,
  PRIMARY KEY (`idalumno`,`Persona_idPersona`),
  UNIQUE KEY `idalumno_UNIQUE` (`idalumno`),
  KEY `fk_alumno_Persona1_idx` (`Persona_idPersona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `alumno`:
--   `Persona_idPersona`
--       `persona` -> `idPersona`
--

-- --------------------------------------------------------

--
-- Table structure for table `alumno_encargado`
--
-- Creation: Jul 24, 2018 at 07:04 AM
--

DROP TABLE IF EXISTS `alumno_encargado`;
CREATE TABLE IF NOT EXISTS `alumno_encargado` (
  `ID_ALUMNO` int(11) NOT NULL,
  `ID_ENCARGADO` int(11) NOT NULL,
  PRIMARY KEY (`ID_ALUMNO`,`ID_ENCARGADO`),
  KEY `ID_ENCARGADO` (`ID_ENCARGADO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `alumno_encargado`:
--   `ID_ALUMNO`
--       `alumno` -> `idalumno`
--   `ID_ENCARGADO`
--       `encargado` -> `idencargado`
--

-- --------------------------------------------------------

--
-- Table structure for table `alumno_materia`
--
-- Creation: Jul 24, 2018 at 07:04 AM
--

DROP TABLE IF EXISTS `alumno_materia`;
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

--
-- RELATIONSHIPS FOR TABLE `alumno_materia`:
--   `alumno_idalumno`
--       `alumno` -> `idalumno`
--   `materia_idmateria`
--       `materia` -> `idmateria`
--

-- --------------------------------------------------------

--
-- Table structure for table `asistencia`
--
-- Creation: Jul 24, 2018 at 07:04 AM
--

DROP TABLE IF EXISTS `asistencia`;
CREATE TABLE IF NOT EXISTS `asistencia` (
  `IDASISTENCIA` int(11) NOT NULL AUTO_INCREMENT,
  `ESTADO` tinyint(1) DEFAULT NULL,
  `NOTA` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `IDALUMNO` int(11) DEFAULT NULL,
  `FECHA` date DEFAULT NULL,
  PRIMARY KEY (`IDASISTENCIA`),
  KEY `FK_ASISTENCIA_ALUMNO` (`IDALUMNO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- RELATIONSHIPS FOR TABLE `asistencia`:
--   `IDALUMNO`
--       `alumno` -> `idalumno`
--

-- --------------------------------------------------------

--
-- Table structure for table `beca`
--
-- Creation: Jul 24, 2018 at 07:04 AM
--

DROP TABLE IF EXISTS `beca`;
CREATE TABLE IF NOT EXISTS `beca` (
  `idbeca` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion_beca` varchar(45) NOT NULL,
  `monto_beca` varchar(45) NOT NULL,
  `idAlumno` int(11) NOT NULL,
  `estado` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`idbeca`),
  KEY `fk_beca_alumno_idx` (`idAlumno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `beca`:
--   `idAlumno`
--       `alumno` -> `idalumno`
--

-- --------------------------------------------------------

--
-- Table structure for table `director`
--
-- Creation: Jul 24, 2018 at 07:04 AM
--

DROP TABLE IF EXISTS `director`;
CREATE TABLE IF NOT EXISTS `director` (
  `idDirector` int(11) NOT NULL AUTO_INCREMENT,
  `Persona_idPersona` int(11) NOT NULL,
  PRIMARY KEY (`idDirector`,`Persona_idPersona`),
  UNIQUE KEY `iddirector_UNIQUE` (`idDirector`),
  KEY `fk_director_Persona1_idx` (`Persona_idPersona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `director`:
--   `Persona_idPersona`
--       `persona` -> `idPersona`
--

-- --------------------------------------------------------

--
-- Table structure for table `empleado`
--
-- Creation: Jul 24, 2018 at 07:10 AM
--

DROP TABLE IF EXISTS `empleado`;
CREATE TABLE IF NOT EXISTS `empleado` (
  `idEmpleado` int(11) NOT NULL AUTO_INCREMENT,
  `idPersona` int(11) NOT NULL,
  `idPuesto` int(11) NOT NULL,
  PRIMARY KEY (`idEmpleado`),
  KEY `FK_EMPLEADO_PUESTO` (`idPuesto`),
  KEY `FK_EMPLEADO_PERSONA` (`idPersona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- RELATIONSHIPS FOR TABLE `empleado`:
--   `idPersona`
--       `persona` -> `idPersona`
--   `idPuesto`
--       `puesto` -> `idPuesto`
--

-- --------------------------------------------------------

--
-- Table structure for table `encargado`
--
-- Creation: Jul 24, 2018 at 07:04 AM
--

DROP TABLE IF EXISTS `encargado`;
CREATE TABLE IF NOT EXISTS `encargado` (
  `idencargado` int(11) NOT NULL AUTO_INCREMENT,
  `Persona_idPersona` int(11) NOT NULL,
  PRIMARY KEY (`idencargado`,`Persona_idPersona`),
  UNIQUE KEY `idencargado_UNIQUE` (`idencargado`),
  KEY `fk_encargado_Persona1_idx` (`Persona_idPersona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `encargado`:
--   `Persona_idPersona`
--       `persona` -> `idPersona`
--

-- --------------------------------------------------------

--
-- Table structure for table `grado`
--
-- Creation: Jul 24, 2018 at 07:04 AM
--

DROP TABLE IF EXISTS `grado`;
CREATE TABLE IF NOT EXISTS `grado` (
  `idgrado` int(11) NOT NULL AUTO_INCREMENT,
  `nombreGrado` varchar(45) NOT NULL,
  PRIMARY KEY (`idgrado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `grado`:
--

-- --------------------------------------------------------

--
-- Table structure for table `grado_alumno`
--
-- Creation: Jul 24, 2018 at 07:04 AM
--

DROP TABLE IF EXISTS `grado_alumno`;
CREATE TABLE IF NOT EXISTS `grado_alumno` (
  `grado_idgrado` int(11) NOT NULL,
  `alumno_idalumno` int(11) NOT NULL,
  `annio` date DEFAULT NULL,
  PRIMARY KEY (`grado_idgrado`,`alumno_idalumno`),
  KEY `fk_grado_has_alumno_alumno1_idx` (`alumno_idalumno`),
  KEY `fk_grado_has_alumno_grado1_idx` (`grado_idgrado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `grado_alumno`:
--   `alumno_idalumno`
--       `alumno` -> `idalumno`
--   `grado_idgrado`
--       `grado` -> `idgrado`
--

-- --------------------------------------------------------

--
-- Table structure for table `grado_estudiante_nota`
--
-- Creation: Jul 24, 2018 at 07:04 AM
--

DROP TABLE IF EXISTS `grado_estudiante_nota`;
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

--
-- RELATIONSHIPS FOR TABLE `grado_estudiante_nota`:
--   `idEstudiante`
--       `alumno` -> `idalumno`
--   `idGrado`
--       `grado` -> `idgrado`
--   `idMateria`
--       `materia` -> `idmateria`
--   `idNota`
--       `nota` -> `idnota`
--

-- --------------------------------------------------------

--
-- Table structure for table `materia`
--
-- Creation: Jul 24, 2018 at 07:04 AM
--

DROP TABLE IF EXISTS `materia`;
CREATE TABLE IF NOT EXISTS `materia` (
  `idmateria` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`idmateria`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- RELATIONSHIPS FOR TABLE `materia`:
--

-- --------------------------------------------------------

--
-- Table structure for table `nacionalidad`
--
-- Creation: Jul 24, 2018 at 07:04 AM
--

DROP TABLE IF EXISTS `nacionalidad`;
CREATE TABLE IF NOT EXISTS `nacionalidad` (
  `idNacionalidad` int(11) NOT NULL AUTO_INCREMENT,
  `pais` varchar(45) NOT NULL,
  PRIMARY KEY (`idNacionalidad`),
  UNIQUE KEY `idNacionalidad_UNIQUE` (`idNacionalidad`),
  UNIQUE KEY `pais_UNIQUE` (`pais`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `nacionalidad`:
--

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
-- Creation: Jul 24, 2018 at 07:04 AM
--

DROP TABLE IF EXISTS `nota`;
CREATE TABLE IF NOT EXISTS `nota` (
  `idnota` int(11) NOT NULL AUTO_INCREMENT,
  `trabajo_cotidiano` decimal(8,2) DEFAULT NULL,
  `asistencia` decimal(8,2) DEFAULT NULL,
  `tareas` decimal(8,2) DEFAULT NULL,
  `pruebas` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`idnota`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- RELATIONSHIPS FOR TABLE `nota`:
--

-- --------------------------------------------------------

--
-- Table structure for table `nota_constante`
--
-- Creation: Jul 24, 2018 at 07:04 AM
--

DROP TABLE IF EXISTS `nota_constante`;
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

--
-- RELATIONSHIPS FOR TABLE `nota_constante`:
--   `grado`
--       `grado` -> `idgrado`
--

-- --------------------------------------------------------

--
-- Table structure for table `persona`
--
-- Creation: Jul 24, 2018 at 07:04 AM
--

DROP TABLE IF EXISTS `persona`;
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
-- RELATIONSHIPS FOR TABLE `persona`:
--   `idNacionalidad`
--       `nacionalidad` -> `idNacionalidad`
--

--
-- Dumping data for table `persona`
--

INSERT INTO `persona` (`idPersona`, `cedula`, `nombre`, `apellido1`, `apellido2`, `sexo`, `direccion`, `telefono`, `telefono_secundario`, `email`, `idNacionalidad`, `disponible`) VALUES
(1, '1', 'Julian', 'Perez', 'Fernandez', 'Masculino', 'Heredia', '8', NULL, '@vegeto', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `profesor`
--
-- Creation: Jul 24, 2018 at 07:04 AM
--

DROP TABLE IF EXISTS `profesor`;
CREATE TABLE IF NOT EXISTS `profesor` (
  `idprofesor` int(11) NOT NULL AUTO_INCREMENT,
  `Persona_idPersona` int(11) NOT NULL,
  PRIMARY KEY (`idprofesor`,`Persona_idPersona`),
  UNIQUE KEY `idprofesor_UNIQUE` (`idprofesor`),
  KEY `fk_profesor_Persona1_idx` (`Persona_idPersona`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `profesor`:
--   `Persona_idPersona`
--       `persona` -> `idPersona`
--

--
-- Dumping data for table `profesor`
--

INSERT INTO `profesor` (`idprofesor`, `Persona_idPersona`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `profesor_materia_grado`
--
-- Creation: Jul 24, 2018 at 07:04 AM
--

DROP TABLE IF EXISTS `profesor_materia_grado`;
CREATE TABLE IF NOT EXISTS `profesor_materia_grado` (
  `profesor_idprofesor` int(11) NOT NULL,
  `materia_idmateria` int(11) NOT NULL,
  `id_grado` int(11) NOT NULL,
  PRIMARY KEY (`profesor_idprofesor`,`materia_idmateria`,`id_grado`),
  KEY `fk_profesor_has_materia_materia1_idx` (`materia_idmateria`),
  KEY `fk_profesor_has_materia_profesor1_idx` (`profesor_idprofesor`),
  KEY `fk_profesor_materiagrado_idx` (`id_grado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `profesor_materia_grado`:
--   `materia_idmateria`
--       `materia` -> `idmateria`
--   `profesor_idprofesor`
--       `profesor` -> `idprofesor`
--   `id_grado`
--       `grado` -> `idgrado`
--

-- --------------------------------------------------------

--
-- Table structure for table `puesto`
--
-- Creation: Jul 24, 2018 at 07:07 AM
--

DROP TABLE IF EXISTS `puesto`;
CREATE TABLE IF NOT EXISTS `puesto` (
  `idPuesto` int(11) NOT NULL AUTO_INCREMENT,
  `nombrePuesto` varchar(45) COLLATE utf8_spanish_ci DEFAULT NULL,
  `descrpcionPuesto` varchar(300) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`idPuesto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- RELATIONSHIPS FOR TABLE `puesto`:
--

-- --------------------------------------------------------

--
-- Table structure for table `rol`
--
-- Creation: Jul 24, 2018 at 07:04 AM
--

DROP TABLE IF EXISTS `rol`;
CREATE TABLE IF NOT EXISTS `rol` (
  `IDROL` int(11) NOT NULL AUTO_INCREMENT,
  `tiporol` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`IDROL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `rol`:
--

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--
-- Creation: Jul 24, 2018 at 07:04 AM
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `idPersona` int(11) DEFAULT NULL,
  `idRol` int(11) DEFAULT NULL,
  `password` varchar(75) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`),
  KEY `fk_persona_usuario` (`idPersona`),
  KEY `fk_rol_usuario` (`idRol`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONSHIPS FOR TABLE `usuario`:
--   `idPersona`
--       `persona` -> `idPersona`
--   `idRol`
--       `rol` -> `IDROL`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `vdirector`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `vdirector`;
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
-- Stand-in structure for view `vista_alumno`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `vista_alumno`;
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
-- Stand-in structure for view `vprofesor`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `vprofesor`;
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
-- Structure for view `vdirector`
--
DROP TABLE IF EXISTS `vdirector`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vdirector`  AS  select `pe`.`cedula` AS `CEDULA`,`pe`.`nombre` AS `NOMBRE`,concat(`pe`.`apellido1`,' ',`pe`.`apellido2`) AS `APELLIDOS`,`pe`.`sexo` AS `SEXO`,`pe`.`direccion` AS `DIRECCION`,`pe`.`telefono` AS `TELEFONO`,`pe`.`email` AS `EMAIL`,`n`.`pais` AS `PAIS`,`pe`.`disponible` AS `DISPONIBLE` from ((`director` `pr` join `persona` `pe`) join `nacionalidad` `n`) where ((`pe`.`idPersona` = `pr`.`idDirector`) and (`n`.`idNacionalidad` = `pe`.`idNacionalidad`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vista_alumno`
--
DROP TABLE IF EXISTS `vista_alumno`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_alumno`  AS  select `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,`p`.`apellido1` AS `apellido1`,`p`.`apellido2` AS `apellido2`,`p`.`sexo` AS `sexo`,`p`.`direccion` AS `direccion`,`n`.`pais` AS `pais`,`p`.`disponible` AS `disponible` from ((`persona` `p` join `alumno` `a`) join `nacionalidad` `n`) where ((`p`.`idPersona` = `a`.`Persona_idPersona`) and (`n`.`idNacionalidad` = `p`.`idNacionalidad`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vprofesor`
--
DROP TABLE IF EXISTS `vprofesor`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vprofesor`  AS  select `pe`.`cedula` AS `CEDULA`,`pe`.`nombre` AS `NOMBRE`,concat(`pe`.`apellido1`,' ',`pe`.`apellido2`) AS `APELLIDOS`,`pe`.`sexo` AS `SEXO`,`pe`.`direccion` AS `DIRECCION`,`pe`.`telefono` AS `TELEFONO`,`pe`.`email` AS `EMAIL`,`n`.`pais` AS `PAIS`,`pe`.`disponible` AS `DISPONIBLE` from ((`profesor` `pr` join `persona` `pe`) join `nacionalidad` `n`) where ((`pe`.`idPersona` = `pr`.`idprofesor`) and (`n`.`idNacionalidad` = `pe`.`idNacionalidad`)) ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `alumno`
--
ALTER TABLE `alumno`
  ADD CONSTRAINT `fk_alumno_Persona1` FOREIGN KEY (`Persona_idPersona`) REFERENCES `persona` (`idPersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `alumno_encargado`
--
ALTER TABLE `alumno_encargado`
  ADD CONSTRAINT `alumno_encargado_ibfk_1` FOREIGN KEY (`ID_ALUMNO`) REFERENCES `alumno` (`idalumno`),
  ADD CONSTRAINT `alumno_encargado_ibfk_2` FOREIGN KEY (`ID_ENCARGADO`) REFERENCES `encargado` (`idencargado`);

--
-- Constraints for table `alumno_materia`
--
ALTER TABLE `alumno_materia`
  ADD CONSTRAINT `fk_alumno_has_materia_alumno1` FOREIGN KEY (`alumno_idalumno`) REFERENCES `alumno` (`idalumno`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_alumno_has_materia_materia1` FOREIGN KEY (`materia_idmateria`) REFERENCES `materia` (`idmateria`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `asistencia`
--
ALTER TABLE `asistencia`
  ADD CONSTRAINT `FK_ASISTENCIA_ALUMNO` FOREIGN KEY (`IDALUMNO`) REFERENCES `alumno` (`idalumno`);

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
-- Constraints for table `grado_alumno`
--
ALTER TABLE `grado_alumno`
  ADD CONSTRAINT `fk_grado_has_alumno_alumno1` FOREIGN KEY (`alumno_idalumno`) REFERENCES `alumno` (`idalumno`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_grado_has_alumno_grado1` FOREIGN KEY (`grado_idgrado`) REFERENCES `grado` (`idgrado`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `grado_estudiante_nota`
--
ALTER TABLE `grado_estudiante_nota`
  ADD CONSTRAINT `fk_alumno_materia_grado_nota` FOREIGN KEY (`idEstudiante`) REFERENCES `alumno` (`idalumno`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_grado_materia_alumno_nota` FOREIGN KEY (`idGrado`) REFERENCES `grado` (`idgrado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_materia_grado_alumno_nota` FOREIGN KEY (`idMateria`) REFERENCES `materia` (`idmateria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_nota_estudiante_materia_grado` FOREIGN KEY (`idNota`) REFERENCES `nota` (`idnota`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `nota_constante`
--
ALTER TABLE `nota_constante`
  ADD CONSTRAINT `fk_grado` FOREIGN KEY (`grado`) REFERENCES `grado` (`idgrado`) ON DELETE NO ACTION ON UPDATE NO ACTION;

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
