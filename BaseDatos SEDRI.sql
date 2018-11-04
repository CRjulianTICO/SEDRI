-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 04, 2018 at 03:47 AM
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

DELIMITER $$
--
-- Procedures
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_ActualizaAsistencia` (IN `VJUST` TINYINT, IN `VNOTA` VARCHAR(100), IN `VCED` VARCHAR(20), IN `VFECHA` DATE)  BEGIN
	SELECT idPersona
    FROM persona
    WHERE cedula = VCED
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
 WHERE persona_idPersona = @id
 INTO @id_alumno;
 
 
 
 INSERT INTO grado_alumno(grado_idgrado,alumno_idalumno)
 values (VGRA,@id_alumno);
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_InsertaProfesor` (IN `VCED` VARCHAR(45), IN `VNOM` VARCHAR(45), IN `VAP1` VARCHAR(45), IN `VAP2` VARCHAR(45), IN `VSEXO` VARCHAR(20), IN `VDIR` VARCHAR(100), IN `VTEL` VARCHAR(45), IN `VEMAIL` VARCHAR(45), IN `VNAC` INT, IN `VGRADO` INT, IN `VPASS` VARCHAR(80), IN `VMAT` INT, IN `VTIPO` INT)  BEGIN
 INSERT INTO persona( cedula, nombre, apellido1, apellido2, sexo, direccion,telefono,email,idNacionalidad)
 VALUES(VCED,VNOM,VAP1,VAP2,VSEXO,VDIR,VTEL,VEMAIL,VNAC);
 
 SELECT idPersona
 FROM persona
 WHERE cedula = VCED
 INTO @id;
 

 INSERT INTO profesor(Persona_idPersona,tipo)VALUES(@id,VTIPO);

 
 SELECT idprofesor
 FROM profesor
 WHERE Persona_idPersona = @id
 INTO @idP;
 
 INSERT INTO usuario(idPersona,idRol,password,cambio)
 VALUES (@id,1,VPASS,1);
 
IF VTIPO !=0 THEN
SELECT MIN(idGrado), MAX(idGrado)
INTO @min,@max
FROM grado 
WHERE LOWER(nombreGrado) NOT LIKE '%primero%' and NOT LIKE '%1%';
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
 
 SELECT idPersona FROM persona WHERE CEDULA = CED  INTO @id ;
 
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
WHERE cedula = VCED;
 
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `alumno`
--

CREATE TABLE `alumno` (
  `idalumno` int(11) NOT NULL,
  `Persona_idPersona` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(7, 82);

-- --------------------------------------------------------

--
-- Table structure for table `alumno_encargado`
--

CREATE TABLE `alumno_encargado` (
  `ID_ALUMNO` int(11) NOT NULL,
  `ID_ENCARGADO` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `asistencia`
--

INSERT INTO `asistencia` (`IDASISTENCIA`, `ESTADO`, `NOTA`, `IDALUMNO`, `FECHA`, `IDGRADO`, `AUSENCIA`, `idProfesor`) VALUES
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

-- --------------------------------------------------------

--
-- Table structure for table `grado`
--

CREATE TABLE `grado` (
  `idgrado` int(11) NOT NULL,
  `nombreGrado` varchar(45) CHARACTER SET utf8 NOT NULL,
  `annio` int(11) NOT NULL,
  `ciclo` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `grado`
--

INSERT INTO `grado` (`idgrado`, `nombreGrado`, `annio`, `ciclo`) VALUES
(1, 'Primero', 2018, 0),
(2, 'Segundo', 2018, 0),
(3, 'Quinto', 2018, 1),
(4, 'Sexto', 2018, 1),
(5, 'Tercero', 2018, 0),
(6, 'Cuarto', 2018, 1),
(7, 'Primero-A', 2018, 0),
(8, 'Primero-B', 2018, 0),
(9, 'Segundo-B', 2018, 0);

-- --------------------------------------------------------

--
-- Table structure for table `grado_alumno`
--

CREATE TABLE `grado_alumno` (
  `grado_idgrado` int(11) NOT NULL,
  `alumno_idalumno` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `grado_alumno`
--

INSERT INTO `grado_alumno` (`grado_idgrado`, `alumno_idalumno`) VALUES
(1, 1),
(1, 3),
(1, 5),
(1, 6),
(1, 7),
(2, 2),
(2, 4);

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
  `apropado` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `materia`
--

CREATE TABLE `materia` (
  `idmateria` int(11) NOT NULL,
  `nombre` varchar(45) CHARACTER SET latin1 NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `idTipoMateria` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(11, 'Estudios Sociales', 1, 1),
(12, 'Frances', 1, 2);

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
  `trabajo_cotidiano` decimal(8,2) DEFAULT NULL,
  `asistencia` decimal(8,2) DEFAULT NULL,
  `tareas` decimal(8,2) DEFAULT NULL,
  `pruebas` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `nota_constante`
--

CREATE TABLE `nota_constante` (
  `idnota_constante` int(11) NOT NULL,
  `grado` int(11) NOT NULL,
  `trabajo_cotidiano` decimal(8,2) DEFAULT NULL,
  `pruebas` decimal(8,2) DEFAULT NULL,
  `tareas` decimal(8,2) DEFAULT NULL,
  `asistencia` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `nota_medica` varchar(650) COLLATE utf8mb4_unicode_ci DEFAULT 'Ninguno'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(69, '207680159', 'Oscar', 'Eduardo', 'Soto', 'Masculino', 'Alajuela, Atenas, Costa Rica', '63103970', NULL, 'oscarsoto0407ss97@gmail.com', 1, 1, 'Ninguno'),
(75, '5', 'Ileana Patricia', 'Soto', 'Leon', 'Femenino', 'Alajuela , Atenas', '12', NULL, 'oscarsosato0407sa97@gmail.com', 1, 1, 'Ninguno'),
(78, '1704', 'Prueba', 'Pruebs', 'Test', 'Masculino', 'ASD', '54544323', NULL, 'oscasasasrsoto0407sa97@gmail.com', 1, 1, 'Ninguno'),
(79, '9904', 'Prueba', 'Prueba', 'Prueba', 'Femenino', 'Atenas\r\nCosta Rica', '63103970', NULL, 'oscarsoto040797@gmail.com', 1, 1, 'Ninguno'),
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
(101, '16', '16', '16', '16', 'Masculino', '16', '16', NULL, '16@gmail.com', 1, 1, 'Ninguno');

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
(42, 101, 1);

-- --------------------------------------------------------

--
-- Table structure for table `profesor_grado`
--

CREATE TABLE `profesor_grado` (
  `idProfesor` int(11) NOT NULL,
  `idGrado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `profesor_grado`
--

INSERT INTO `profesor_grado` (`idProfesor`, `idGrado`) VALUES
(1, 1),
(6, 1),
(7, 2),
(8, 1),
(9, 3),
(20, 1),
(23, 2),
(25, 1),
(26, 1);

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
(41, 11, 3);

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
(2, 'Guardia', 'Seguridad II');

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
(1, 38, 1, '$2y$09$MmyH9eXuU0kyGbfmlNV6ze4d7pBJr.cK0brq4P0R/rBMOG0pFQkh.', 0),
(3, 69, 1, '$2y$09$VO0k5.zgyQILsqJfrRZy4eSRIm.LCRH/wRh5ZXi1ee/INLX/DgTcW', 1),
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
(24, 99, 2, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 0),
(25, 100, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 0),
(26, 101, 1, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 1);

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
,`idGrado` int(11)
,`direccion` varchar(100)
,`nota_medica` varchar(650)
,`disponible` tinyint(1)
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
-- Stand-in structure for view `vista_empleado`
-- (See below for the actual view)
--
CREATE TABLE `vista_empleado` (
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
);

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

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_alumno`  AS  select `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,`p`.`apellido1` AS `apellido1`,`p`.`apellido2` AS `apellido2`,`p`.`sexo` AS `sexo`,`n`.`pais` AS `pais`,`g`.`nombreGrado` AS `nombreGrado`,`g`.`annio` AS `annio`,`g`.`idgrado` AS `idGrado`,`p`.`direccion` AS `direccion`,`p`.`nota_medica` AS `nota_medica`,`p`.`disponible` AS `disponible` from ((((`alumno` `a` join `persona` `p`) join `nacionalidad` `n`) join `grado` `g`) join `grado_alumno` `ga`) where ((`a`.`Persona_idPersona` = `p`.`idPersona`) and (`p`.`idNacionalidad` = `n`.`idNacionalidad`) and (`a`.`idalumno` = `ga`.`alumno_idalumno`) and (`ga`.`grado_idgrado` = `g`.`idgrado`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vista_asistencia`
--
DROP TABLE IF EXISTS `vista_asistencia`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_asistencia`  AS  select `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,`p`.`apellido1` AS `apellido1`,`p`.`apellido2` AS `apellido2`,`g`.`nombreGrado` AS `nombreGrado`,`ai`.`ESTADO` AS `ESTADO`,`ai`.`NOTA` AS `NOTA`,`ai`.`FECHA` AS `FECHA`,`ai`.`AUSENCIA` AS `AUSENCIA` from (((((`persona` `p` join `alumno` `a`) join `nacionalidad` `n`) join `grado` `g`) join `grado_alumno` `ga`) join `asistencia` `ai`) where ((`a`.`Persona_idPersona` = `p`.`idPersona`) and (`p`.`idNacionalidad` = `n`.`idNacionalidad`) and (`a`.`idalumno` = `ga`.`alumno_idalumno`) and (`ga`.`grado_idgrado` = `g`.`idgrado`) and (`a`.`idalumno` = `ai`.`IDALUMNO`) and (`g`.`idgrado` = `ai`.`IDGRADO`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vista_empleado`
--
DROP TABLE IF EXISTS `vista_empleado`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_empleado`  AS  select `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,`p`.`apellido1` AS `apellido1`,`p`.`apellido2` AS `apellido2`,`p`.`sexo` AS `sexo`,`p`.`direccion` AS `direccion`,`p`.`telefono` AS `telefono`,`n`.`pais` AS `pais`,`f`.`nombrePuesto` AS `nombrePuesto`,`p`.`disponible` AS `disponible` from (((`persona` `p` join `empleado` `e`) join `puesto` `f`) join `nacionalidad` `n`) where ((`p`.`idPersona` = `e`.`idPersona`) and (`f`.`idPuesto` = `e`.`idPuesto`) and (`n`.`idNacionalidad` = `p`.`idNacionalidad`)) ;

-- --------------------------------------------------------

--
-- Structure for view `vista_materia`
--
DROP TABLE IF EXISTS `vista_materia`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_materia`  AS  select `m`.`idmateria` AS `idmateria`,`m`.`nombre` AS `nombre`,`t`.`tipo` AS `tipo`,`m`.`estado` AS `estado` from (`materia` `m` join `tipo_materia` `t`) where (`m`.`idTipoMateria` = `t`.`idTipo`) ;

-- --------------------------------------------------------

--
-- Structure for view `vista_profesor`
--
DROP TABLE IF EXISTS `vista_profesor`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_profesor`  AS  select `p`.`cedula` AS `CEDULA`,`p`.`nombre` AS `NOMBRE`,`p`.`apellido1` AS `APELLIDO1`,`p`.`apellido2` AS `APELLIDO2`,`p`.`sexo` AS `SEXO`,`p`.`direccion` AS `DIRECCION`,`p`.`telefono` AS `TELEFONO`,`p`.`email` AS `EMAIL`,`n`.`pais` AS `PAIS`,`p`.`disponible` AS `DISPONIBLE`,`g`.`nombreGrado` AS `nombreGrado`,`g`.`annio` AS `annio` from ((((`persona` `p` join `profesor` `pe`) join `nacionalidad` `n`) join `grado` `g`) join `profesor_grado` `pg`) where ((`p`.`idPersona` = `pe`.`Persona_idPersona`) and (`pe`.`idprofesor` = `pg`.`idProfesor`) and (`g`.`idgrado` = `pg`.`idGrado`) and (`p`.`idNacionalidad` = `n`.`idNacionalidad`)) ;

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
-- Indexes for table `grado_alumno`
--
ALTER TABLE `grado_alumno`
  ADD PRIMARY KEY (`grado_idgrado`,`alumno_idalumno`),
  ADD KEY `fk_grado_has_alumno_alumno1_idx` (`alumno_idalumno`),
  ADD KEY `fk_grado_has_alumno_grado1_idx` (`grado_idgrado`);

--
-- Indexes for table `grado_estudiante_nota`
--
ALTER TABLE `grado_estudiante_nota`
  ADD PRIMARY KEY (`idGrado`,`idMateria`,`idNota`,`idEstudiante`),
  ADD KEY `fk_nota_idx1` (`idNota`),
  ADD KEY `fk_alumno_idx1` (`idEstudiante`),
  ADD KEY `fk_materia_idx1` (`idMateria`);

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
  ADD PRIMARY KEY (`idnota_constante`),
  ADD KEY `fk_grado_idx` (`grado`);

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
  ADD KEY `fk_profesor_Persona1_idx` (`Persona_idPersona`);

--
-- Indexes for table `profesor_grado`
--
ALTER TABLE `profesor_grado`
  ADD PRIMARY KEY (`idProfesor`,`idGrado`),
  ADD KEY `fk_grado_p` (`idGrado`);

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
  MODIFY `idalumno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `asistencia`
--
ALTER TABLE `asistencia`
  MODIFY `IDASISTENCIA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=170;

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
  MODIFY `idencargado` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `grado`
--
ALTER TABLE `grado`
  MODIFY `idgrado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `materia`
--
ALTER TABLE `materia`
  MODIFY `idmateria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `nacionalidad`
--
ALTER TABLE `nacionalidad`
  MODIFY `idNacionalidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `nota`
--
ALTER TABLE `nota`
  MODIFY `idnota` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `nota_constante`
--
ALTER TABLE `nota_constante`
  MODIFY `idnota_constante` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `persona`
--
ALTER TABLE `persona`
  MODIFY `idPersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `profesor`
--
ALTER TABLE `profesor`
  MODIFY `idprofesor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `puesto`
--
ALTER TABLE `puesto`
  MODIFY `idPuesto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

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
-- Constraints for table `materia`
--
ALTER TABLE `materia`
  ADD CONSTRAINT `FK_MATERIA_TIPOMATERIA` FOREIGN KEY (`idTipoMateria`) REFERENCES `tipo_materia` (`idTipo`);

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
-- Constraints for table `profesor_grado`
--
ALTER TABLE `profesor_grado`
  ADD CONSTRAINT `fk_grado_p` FOREIGN KEY (`idGrado`) REFERENCES `grado` (`idgrado`),
  ADD CONSTRAINT `fk_profesor_p` FOREIGN KEY (`idProfesor`) REFERENCES `profesor` (`idprofesor`);

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
