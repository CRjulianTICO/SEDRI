-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 18, 2018 at 04:22 AM
-- Server version: 10.2.17-MariaDB
-- PHP Version: 7.2.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u729847063_sedri`
--
CREATE DATABASE IF NOT EXISTS `escuela` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `escuela`;

DELIMITER $$
--
-- Procedures
--
CREATE  PROCEDURE `sp_ActivaBeca` (IN `VCED` VARCHAR(20))  BEGIN
	SELECT idPersona
    FROM persona
    WHERE cedula = VCED LIMIT 1
    INTO @idP;
    SELECT idAlumno
    FROM alumno
    WHERE Persona_idPersona = @idP LIMIT 1
    INTO @idA;
    UPDATE beca
    SET estado = 1
    WHERE idAlumno = @idA;
END$$

CREATE  PROCEDURE `sp_ActualizaAsistencia` (IN `VJUST` TINYINT, IN `VNOTA` VARCHAR(100), IN `VCED` VARCHAR(20), IN `VFECHA` DATE)  BEGIN
	SELECT idPersona
    FROM persona
    WHERE cedula = VCED LIMIT 1
    INTO @idP;
    SELECT idAlumno
    FROM alumno
    WHERE Persona_idPersona = @idP LIMIT 1
    INTO @idA;
   	UPDATE asistencia SET
	AUSENCIA = VJUST,
	NOTA = VNOTA
	WHERE IDALUMNO = @idA and FECHA = VFECHA;
END$$

CREATE  PROCEDURE `sp_ActualizaBeca` (IN `VDESC` VARCHAR(500), IN `VMON` VARCHAR(40), IN `VCED` VARCHAR(20))  BEGIN
	SELECT idPersona
    FROM persona
    WHERE cedula = VCED LIMIT 1
    INTO @idP;
    SELECT idAlumno
    FROM alumno
    WHERE Persona_idPersona = @idP LIMIT 1
    INTO @idA;
    UPDATE beca
    SET descripcion_beca = VDESC,
    monto_beca = VMON
    WHERE idAlumno = @idA;
END$$

CREATE  PROCEDURE `sp_ActualizarEmpleado` (IN `CED` VARCHAR(20), IN `NOM` VARCHAR(35), IN `APE1` VARCHAR(35), IN `APE2` VARCHAR(35), IN `SEX` VARCHAR(20), IN `DIRECC` VARCHAR(50), IN `TEL` VARCHAR(25), IN `NAC` INT, IN `PUE` INT)  BEGIN

 UPDATE persona SET
 NOMBRE = NOM,
 APELLIDO1=APE1,
 APELLIDO2=APE2,
 SEXO=SEX,
 DIRECCION =DIRECC,
 TELEFONO=TEL,
 idNacionalidad=NAC
 WHERE CEDULA = CED LIMIT 1;

 SELECT idPersona FROM persona WHERE CEDULA = CED LIMIT 1 INTO @id ;

UPDATE empleado SET
idPuesto = PUE
WHERE idPersona = @id;

END$$

CREATE  PROCEDURE `sp_DesactivaBeca` (IN `VCED` VARCHAR(20))  BEGIN
	SELECT idPersona
    FROM persona
    WHERE cedula = VCED LIMIT 1
    INTO @idP;
    SELECT idAlumno
    FROM alumno
    WHERE Persona_idPersona = @idP LIMIT 1
    INTO @idA;
    UPDATE beca
    SET estado = 0
    WHERE idAlumno = @idA;
END$$

CREATE  PROCEDURE `sp_desactivarUsuario` (IN `VCED` VARCHAR(100))  NO SQL
BEGIN

UPDATE persona set disponible ='0' where cedula = VCED;

 SELECT idPersona
 FROM persona
 WHERE cedula = VCED LIMIT 1 
 INTO @id;
 
 DELETE FROM usuario where idPersona = @id;
 

        
    
END$$

CREATE  PROCEDURE `sp_InsertaAlumno` (IN `VCED` VARCHAR(20), IN `VNOM` VARCHAR(40), IN `VAPE1` VARCHAR(40), IN `VAPE2` VARCHAR(40), IN `VSEX` VARCHAR(20), IN `VDIR` VARCHAR(50), IN `VNAC` INT, IN `VNOT` VARCHAR(650), IN `VGRA` INT)  BEGIN
 INSERT INTO persona( cedula, nombre, apellido1, apellido2, sexo, direccion,idNacionalidad,nota_medica)
 VALUES(VCED,VNOM,VAPE1,VAPE2,VSEX,VDIR,VNAC,VNOT);

 SELECT idPersona
 FROM persona
 WHERE cedula = VCED LIMIT 1
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

CREATE  PROCEDURE `sp_InsertaAsistencia` (IN `VESTADO` TINYINT, IN `VNOTA` VARCHAR(150), IN `VCED` VARCHAR(30), IN `VFECHA` DATE, IN `VIDGR` INT, IN `VID` INT)  BEGIN
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
    WHERE Persona_idPersona = @id  COLLATE utf8mb4_unicode_ci LIMIT 1
    INTO @idA;
    INSERT INTO asistencia(ESTADO,NOTA,IDALUMNO,FECHA,IDGRADO,idProfesor)
	VALUES(VESTADO,VNOTA,@idA,VFECHA,VIDGR,@idPr);
END$$

CREATE  PROCEDURE `sp_InsertaBeca` (IN `VCED` VARCHAR(50), IN `VDES` VARCHAR(500), IN `VMON` VARCHAR(45))  BEGIN
    SELECT idPersona
    FROM persona
    WHERE cedula = VCED  COLLATE utf8mb4_unicode_ci LIMIT 1
    INTO @id;
    SELECT idAlumno
    FROM alumno
    WHERE Persona_idPersona = @id  COLLATE utf8mb4_unicode_ci LIMIT 1
    INTO @idA;
    INSERT INTO beca(descripcion_beca,monto_beca,idAlumno)
    VALUES(VDES,VMON,@idA);
END$$

CREATE  PROCEDURE `sp_InsertaEncargado` (IN `VCED` VARCHAR(45), IN `VNOM` VARCHAR(45), IN `VAP1` VARCHAR(45), IN `VAP2` VARCHAR(45), IN `VSEXO` VARCHAR(45), IN `VDIR` VARCHAR(100), IN `VTEL` VARCHAR(45), IN `VTEL2` VARCHAR(45), IN `VNAC` VARCHAR(45))  BEGIN
 INSERT INTO persona( cedula, nombre, apellido1, apellido2, sexo, direccion,telefono,telefono_secundario,idNacionalidad)
 VALUES(VCED,VNOM,VAP1,VAP2,VSEXO,VDIR,VTEL,VTEL2,VNAC);
 SELECT idPersona
 FROM persona
 WHERE cedula = VCED LIMIT 1
 into @id;


 INSERT INTO encargado(Persona_idPersona)VALUES(@id);
END$$

CREATE  PROCEDURE `sp_InsertaNotas` (IN `VCED` VARCHAR(45), IN `VIDMAT` VARCHAR(45), IN `VIDGR` INT, IN `VCOT` DECIMAL, IN `VPRU` DECIMAL, IN `VTAREA` DECIMAL, IN `VASIS` DECIMAL, IN `VTRI` INT)  BEGIN

SELECT p.idPersona
FROM persona p
WHERE p.cedula = VCED and p.disponible != 0 LIMIT 1
INTO @idPer;

SELECT a.idalumno
FROM alumno a
WHERE a.Persona_idPersona = @idPer LIMIT 1
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

CREATE  PROCEDURE `sp_InsertaProfesor` (IN `VCED` VARCHAR(45), IN `VNOM` VARCHAR(45), IN `VAP1` VARCHAR(45), IN `VAP2` VARCHAR(45), IN `VSEXO` VARCHAR(20), IN `VDIR` VARCHAR(100), IN `VTEL` VARCHAR(45), IN `VEMAIL` VARCHAR(45), IN `VNAC` INT, IN `VGRADO` INT, IN `VPASS` VARCHAR(80), IN `VMAT` INT, IN `VTIPO` INT)  BEGIN
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

CREATE  PROCEDURE `sp_InsertarEmpleado` (IN `CED` VARCHAR(20), IN `NOM` VARCHAR(35), IN `APE1` VARCHAR(35), IN `APE2` VARCHAR(35), IN `SEX` VARCHAR(20), IN `DIRECC` VARCHAR(50), IN `TEL` VARCHAR(25), IN `NAC` INT, IN `PUE` INT)  BEGIN

 INSERT INTO persona (CEDULA,NOMBRE,APELLIDO1,APELLIDO2,SEXO,DIRECCION,TELEFONO,idNacionalidad) VALUES(CED,NOM,APE1,APE2,SEX,DIRECC,TEL,NAC);

 SELECT idPersona FROM persona WHERE CEDULA = CED LIMIT 1 INTO @id ;

 INSERT INTO empleado(idPersona,idPuesto) VALUES(@id,PUE);

END$$

CREATE  PROCEDURE `sp_Login` (OUT `pass` VARCHAR(150), IN `ced` VARCHAR(25), OUT `id` INT, OUT `rol` VARCHAR(50), OUT `nombre` VARCHAR(50), OUT `ocambio` INT, OUT `ogrupo` VARCHAR(80), OUT `idgrado` INT, OUT `oemail` VARCHAR(60), OUT `ogrado` VARCHAR(50), OUT `idtipo` INT, OUT `tipoPro` INT)  BEGIN
select u.password,p.idPersona, r.tiporol ,CONCAT(p.nombre,' ',CONCAT(p.apellido1,' ',p.apellido2)) as nombre,u.cambio ,concat(gr.nombreGrado,' ',gr.annio) as grado,gr.idGrado,p.email,gr.nombreGrado,ti.idTipo,pro.tipo
into pass,id,rol,nombre,ocambio,ogrupo,idgrado,oemail,ogrado,idtipo,tipoPro
from usuario u, persona p , rol r ,profesor_materia_grado pmg,profesor pro,grado gr,tipo_materia ti, materia ma
where gr.idGrado = pmg.id_grado and pro.idProfesor = pmg.profesor_idprofesor and  u.idRol = r.IDROL and p.idPersona = u.idPersona and pro.Persona_idPersona = p.idPersona and p.cedula=ced and pmg.materia_idmateria = ma.idmateria and ma.idTipoMateria = ti.idTipo LIMIT 1;

END$$

CREATE  PROCEDURE `sp_ModificarProfesor` (IN `VCED` VARCHAR(40), IN `VNOM` VARCHAR(40), IN `VAP1` VARCHAR(40), IN `VAP2` VARCHAR(40), IN `VEXO` VARCHAR(24), IN `VDIR` VARCHAR(100), IN `VTEL` VARCHAR(50), IN `VEMAIL` VARCHAR(50), IN `VNAC` INT, IN `VANNIO` INT, IN `VGRADO` INT)  NO SQL
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
(1, 12),
(2, 18),
(3, 19),
(4, 20),
(5, 23),
(6, 24),
(7, 36),
(8, 41),
(9, 48),
(10, 49),
(11, 50);

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
(1, 2),
(2, 1),
(3, 1),
(3, 2),
(4, 1);

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
(1, 0, 'Razón médica', 1, '2018-11-14', 2, 0, 5),
(2, 0, 'Enfermo', 6, '2018-11-14', 1, 1, 2),
(3, 1, 'No se ingresaron comentarios.', 7, '2018-11-14', 2, NULL, 8),
(4, 1, 'No se ingresaron comentarios.', 8, '2018-11-14', 2, NULL, 8),
(5, 1, 'No se ingresaron comentarios.', 2, '2018-11-14', 2, NULL, 8),
(6, 1, 'No se ingresaron comentarios.', 4, '2018-11-14', 2, NULL, 8),
(7, 1, 'No se ingresaron comentarios.', 3, '2018-11-14', 2, NULL, 8),
(8, 1, 'No se ingresaron comentarios.', 5, '2018-11-14', 2, NULL, 8),
(9, 1, 'No se ingresaron comentarios.', 7, '2018-11-27', 2, NULL, 8),
(10, 1, 'No se ingresaron comentarios.', 8, '2018-11-27', 2, NULL, 8),
(11, 1, 'No se ingresaron comentarios.', 3, '2018-11-27', 2, NULL, 8),
(12, 0, 'ron comentarios.', 2, '2018-11-27', 2, 1, 8),
(13, 1, 'No se ingresaron comentarios.', 5, '2018-11-27', 2, NULL, 8),
(14, 1, 'No se ingresaron comentarios.', 4, '2018-11-27', 2, NULL, 8),
(15, 1, 'No se ingresaron comentarios.', 7, '2018-11-28', 2, NULL, 8),
(16, 1, 'No se ingresaron comentarios.', 3, '2018-11-28', 2, NULL, 8),
(17, 1, 'No se ingresaron comentarios.', 8, '2018-11-28', 2, NULL, 8),
(18, 1, 'No se ingresaron comentarios.', 2, '2018-11-28', 2, NULL, 8),
(19, 0, 'No se ingresaron comentarios.', 5, '2018-11-28', 2, 1, 8),
(20, 0, 'enfermo', 4, '2018-11-28', 2, 1, 8),
(21, 1, 'No se ingresaron comentarios.', 7, '2018-11-29', 2, NULL, 8),
(22, 0, 'No se ingresaron comentarios.', 11, '2018-11-29', 2, 0, 8),
(23, 1, 'No se ingresaron comentarios.', 2, '2018-11-29', 2, NULL, 8),
(24, 0, 'fhnjgjgj', 4, '2018-11-29', 2, 0, 8),
(25, 1, 'No se ingresaron comentarios.', 8, '2018-11-29', 2, NULL, 8),
(26, 0, 'No se ingresaron comentarios.', 5, '2018-11-29', 2, 0, 8),
(27, 1, 'No se ingresaron comentarios.', 3, '2018-11-29', 2, NULL, 8),
(28, 1, 'No se ingresaron comentarios.', 7, '2018-12-01', 2, NULL, 8),
(29, 1, 'No se ingresaron comentarios.', 5, '2018-12-01', 2, 1, 8),
(30, 1, 'No se ingresaron comentarios.', 3, '2018-12-01', 2, NULL, 8),
(31, 0, 'Medico', 2, '2018-12-01', 2, 1, 8),
(32, 1, 'No se ingresaron comentarios.', 11, '2018-12-01', 2, NULL, 8),
(33, 1, 'No se ingresaron comentarios.', 4, '2018-12-01', 2, NULL, 8),
(34, 1, 'No se ingresaron comentarios.', 7, '2018-12-01', 2, NULL, 8),
(35, 0, 'No se ingresaron comentarios.', 5, '2018-12-01', 2, 1, 8),
(36, 1, 'No se ingresaron comentarios.', 4, '2018-12-01', 2, NULL, 8),
(37, 1, 'No se ingresaron comentarios.', 2, '2018-12-01', 2, NULL, 8),
(38, 1, 'No se ingresaron comentarios.', 11, '2018-12-01', 2, NULL, 8),
(39, 1, 'No se ingresaron comentarios.', 3, '2018-12-01', 2, NULL, 8),
(40, 0, 'No se ingresaron comentarios.', 5, '2018-12-01', 2, 1, 8),
(41, 1, 'No se ingresaron comentarios.', 7, '2018-12-01', 2, NULL, 8),
(42, 1, 'No se ingresaron comentarios.', 2, '2018-12-01', 2, NULL, 8),
(43, 1, 'No se ingresaron comentarios.', 3, '2018-12-01', 2, NULL, 8),
(44, 1, 'No se ingresaron comentarios.', 4, '2018-12-01', 2, NULL, 8),
(45, 1, 'No se ingresaron comentarios.', 11, '2018-12-01', 2, NULL, 8),
(46, 1, 'No se ingresaron comentarios.', 7, '2018-12-17', 2, NULL, 8),
(47, 0, 'No se ingresaron comentarios.', 5, '2018-12-17', 2, 0, 8),
(48, 0, 'Tenia una cita medica', 11, '2018-12-17', 2, 1, 8),
(49, 1, 'No se ingresaron comentarios.', 3, '2018-12-17', 2, NULL, 8),
(50, 1, 'No se ingresaron comentarios.', 2, '2018-12-17', 2, NULL, 8),
(51, 0, 'Estaba enfermo', 4, '2018-12-17', 2, 1, 8),
(52, 1, 'No se ingresaron comentarios.', 2, '2018-12-17', 2, NULL, 8),
(53, 1, 'No se ingresaron comentarios.', 3, '2018-12-17', 2, NULL, 8),
(54, 1, 'No se ingresaron comentarios.', 7, '2018-12-17', 2, NULL, 8),
(55, 1, 'No se ingresaron comentarios.', 5, '2018-12-17', 2, NULL, 8),
(56, 1, 'No se ingresaron comentarios.', 4, '2018-12-17', 2, NULL, 8),
(57, 1, 'No se ingresaron comentarios.', 11, '2018-12-17', 2, NULL, 8);

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
  `estado` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `beca`
--

INSERT INTO `beca` (`idbeca`, `descripcion_beca`, `monto_beca`, `idAlumno`, `estado`) VALUES
(1, 'Beca del IMAS', '25000', 2, 0);

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
(1, 13, 1),
(2, 25, 2);

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
(1, 21),
(2, 22);

-- --------------------------------------------------------

--
-- Table structure for table `grado`
--

CREATE TABLE `grado` (
  `idgrado` int(11) NOT NULL,
  `nombreGrado` varchar(45) CHARACTER SET utf8 NOT NULL,
  `annio` int(11) NOT NULL,
  `ciclo` tinyint(1) DEFAULT 0
) ENGINE=InnoDB AVG_ROW_LENGTH=1820 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `grado`
--

INSERT INTO `grado` (`idgrado`, `nombreGrado`, `annio`, `ciclo`) VALUES
(1, 'Segundo', 0, 0),
(2, 'Primero', 2018, 0),
(3, 'Tercero', 2018, 1),
(4, 'Cuarto', 2018, 1),
(5, 'Quinto', 2018, 1),
(6, 'Sexto', 2018, 1),
(7, 'Primero A', 2018, 0);

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
(1, 1, 61, 6, 1, 0),
(1, 1, 62, 6, 2, 0),
(1, 1, 63, 6, 3, 0),
(1, 2, 64, 6, 1, 0),
(1, 2, 65, 6, 2, 0),
(1, 2, 66, 6, 3, 0),
(1, 3, 67, 6, 1, 0),
(1, 3, 68, 6, 2, 0),
(1, 3, 69, 6, 3, 0),
(1, 4, 70, 6, 1, 0),
(1, 4, 71, 6, 2, 0),
(1, 4, 72, 6, 3, 0),
(2, 1, 1, 1, 1, 0),
(2, 1, 2, 1, 2, 0),
(2, 1, 3, 1, 3, 0),
(2, 1, 13, 2, 1, 0),
(2, 1, 14, 2, 2, 0),
(2, 1, 15, 2, 3, 0),
(2, 1, 25, 3, 1, 0),
(2, 1, 26, 3, 2, 0),
(2, 1, 27, 3, 3, 0),
(2, 1, 37, 4, 1, 0),
(2, 1, 38, 4, 2, 0),
(2, 1, 39, 4, 3, 0),
(2, 1, 49, 5, 1, 0),
(2, 1, 50, 5, 2, 0),
(2, 1, 51, 5, 3, 0),
(2, 1, 73, 7, 1, 0),
(2, 1, 74, 7, 2, 0),
(2, 1, 75, 7, 3, 0),
(2, 1, 88, 8, 1, 0),
(2, 1, 89, 8, 2, 0),
(2, 1, 90, 8, 3, 0),
(2, 1, 103, 9, 1, 0),
(2, 1, 104, 9, 2, 0),
(2, 1, 105, 9, 3, 0),
(2, 1, 118, 10, 1, 0),
(2, 1, 119, 10, 2, 0),
(2, 1, 120, 10, 3, 0),
(2, 1, 133, 11, 1, 0),
(2, 1, 134, 11, 2, 0),
(2, 1, 135, 11, 3, 0),
(2, 2, 4, 1, 1, 0),
(2, 2, 5, 1, 2, 0),
(2, 2, 6, 1, 3, 0),
(2, 2, 16, 2, 1, 0),
(2, 2, 17, 2, 2, 0),
(2, 2, 18, 2, 3, 0),
(2, 2, 28, 3, 1, 0),
(2, 2, 29, 3, 2, 0),
(2, 2, 30, 3, 3, 0),
(2, 2, 40, 4, 1, 0),
(2, 2, 41, 4, 2, 0),
(2, 2, 42, 4, 3, 0),
(2, 2, 52, 5, 1, 0),
(2, 2, 53, 5, 2, 0),
(2, 2, 54, 5, 3, 0),
(2, 2, 76, 7, 1, 0),
(2, 2, 77, 7, 2, 0),
(2, 2, 78, 7, 3, 0),
(2, 2, 91, 8, 1, 0),
(2, 2, 92, 8, 2, 0),
(2, 2, 93, 8, 3, 0),
(2, 2, 106, 9, 1, 0),
(2, 2, 107, 9, 2, 0),
(2, 2, 108, 9, 3, 0),
(2, 2, 121, 10, 1, 0),
(2, 2, 122, 10, 2, 0),
(2, 2, 123, 10, 3, 0),
(2, 2, 136, 11, 1, 0),
(2, 2, 137, 11, 2, 0),
(2, 2, 138, 11, 3, 0),
(2, 3, 7, 1, 1, 0),
(2, 3, 8, 1, 2, 0),
(2, 3, 9, 1, 3, 0),
(2, 3, 19, 2, 1, 0),
(2, 3, 20, 2, 2, 0),
(2, 3, 21, 2, 3, 0),
(2, 3, 31, 3, 1, 0),
(2, 3, 32, 3, 2, 0),
(2, 3, 33, 3, 3, 0),
(2, 3, 43, 4, 1, 0),
(2, 3, 44, 4, 2, 0),
(2, 3, 45, 4, 3, 0),
(2, 3, 55, 5, 1, 0),
(2, 3, 56, 5, 2, 0),
(2, 3, 57, 5, 3, 0),
(2, 3, 79, 7, 1, 0),
(2, 3, 80, 7, 2, 0),
(2, 3, 81, 7, 3, 0),
(2, 3, 94, 8, 1, 0),
(2, 3, 95, 8, 2, 0),
(2, 3, 96, 8, 3, 0),
(2, 3, 109, 9, 1, 0),
(2, 3, 110, 9, 2, 0),
(2, 3, 111, 9, 3, 0),
(2, 3, 124, 10, 1, 0),
(2, 3, 125, 10, 2, 0),
(2, 3, 126, 10, 3, 0),
(2, 3, 139, 11, 1, 0),
(2, 3, 140, 11, 2, 0),
(2, 3, 141, 11, 3, 0),
(2, 4, 10, 1, 1, 0),
(2, 4, 11, 1, 2, 0),
(2, 4, 12, 1, 3, 0),
(2, 4, 22, 2, 1, 0),
(2, 4, 23, 2, 2, 0),
(2, 4, 24, 2, 3, 0),
(2, 4, 34, 3, 1, 0),
(2, 4, 35, 3, 2, 0),
(2, 4, 36, 3, 3, 0),
(2, 4, 46, 4, 1, 0),
(2, 4, 47, 4, 2, 0),
(2, 4, 48, 4, 3, 0),
(2, 4, 58, 5, 1, 0),
(2, 4, 59, 5, 2, 0),
(2, 4, 60, 5, 3, 0),
(2, 4, 82, 7, 1, 0),
(2, 4, 83, 7, 2, 0),
(2, 4, 84, 7, 3, 0),
(2, 4, 97, 8, 1, 0),
(2, 4, 98, 8, 2, 0),
(2, 4, 99, 8, 3, 0),
(2, 4, 112, 9, 1, 0),
(2, 4, 113, 9, 2, 0),
(2, 4, 114, 9, 3, 0),
(2, 4, 127, 10, 1, 0),
(2, 4, 128, 10, 2, 0),
(2, 4, 129, 10, 3, 0),
(2, 4, 142, 11, 1, 0),
(2, 4, 143, 11, 2, 0),
(2, 4, 144, 11, 3, 0),
(2, 5, 85, 7, 1, 0),
(2, 5, 86, 7, 2, 0),
(2, 5, 87, 7, 3, 0),
(2, 5, 100, 8, 1, 0),
(2, 5, 101, 8, 2, 0),
(2, 5, 102, 8, 3, 0),
(2, 5, 115, 9, 1, 0),
(2, 5, 116, 9, 2, 0),
(2, 5, 117, 9, 3, 0),
(2, 5, 130, 10, 1, 0),
(2, 5, 131, 10, 2, 0),
(2, 5, 132, 10, 3, 0),
(2, 5, 145, 11, 1, 0),
(2, 5, 146, 11, 2, 0),
(2, 5, 147, 11, 3, 0);

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
(1, 6, 'ileanasl30@gmail.com', '$2y$09$pYnoW1pu6jwi43N0BZkEZ.fsV6cH6n0EX9je36Prusuavpr1fMk4e', '2018-11-14'),
(2, 6, 'ileanasl30@gmail.com', '$2y$09$awb2FrrfIxqEp/M62QMCcu1oSVZrXqVm299UVI46lIY/u7vBmHzh2', '2018-11-14'),
(3, 7, 'oscarsoto040797@icloud.com', '$2y$09$Hs2MXpNHhsdo8MLSPd8gC.VEHV9/Ws7ctP2HAqI51518iya1IXeWy', '2018-11-14'),
(4, 13, 'shafiqmora9@gmail.com', '$2y$09$tqvHogOMfhnKasUAYoVZi.TBUI0u0iIcQirRa8TL7Pcl9XVFnIBli', '2018-11-15'),
(5, 11, 'edwinpardo7519@gmail.com', '$2y$09$STK.2NjxC18ctv1GMifGTeji2X0xObS2EGBF.Jtrlb7kqnFQHPtuq', '2018-11-15'),
(6, 15, 'lislaoag01@gmail.com', '$2y$09$Ql8tIEJPyfCR1NNj5tc9QOxIaL4XkIPaXcGs7QiY10jhitncqPh66', '2018-11-15'),
(7, 15, 'lislaoag01@gmail.com', '$2y$09$qv6zBEzDdq5cSfI.0mvWn.m.L67VUsZx8RVMv4VwfVxsyNoGHoJnC', '2018-11-15'),
(8, 17, 'florylr08@gmail.com', '$2y$09$p9C7MMU3Ut0PFcOBoCkZnOCAsEJlF7AK/CiNyRge/kOtWIshmXvbK', '2018-12-02'),
(9, 7, 'oscarsoto040797@icloud.com', '$2y$09$WHCTNsc1SlqYp5kuSdzV2unYKeGfrYEJ.IdSpUiwTDSLN.ptpqxeC', '2018-12-02'),
(10, 7, 'oscarsoto040797@icloud.com', '$2y$09$J57sfT05hUK9GyBd/.xWh.wP06sBGCxAS9Wfo7N8xLgCmztuKrbXG', '2018-12-02');

-- --------------------------------------------------------

--
-- Table structure for table `materia`
--

CREATE TABLE `materia` (
  `idmateria` int(11) NOT NULL,
  `nombre` varchar(45) CHARACTER SET latin1 NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT 1,
  `idTipoMateria` int(11) DEFAULT NULL
) ENGINE=InnoDB AVG_ROW_LENGTH=2048 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `materia`
--

INSERT INTO `materia` (`idmateria`, `nombre`, `estado`, `idTipoMateria`) VALUES
(1, 'Ingles', 1, 2),
(2, 'Religión', 1, 3),
(3, 'Música', 1, 4),
(4, 'Ciencias', 1, 1),
(5, 'Estudios Sociales', 0, 1);

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
  `trabajo_cotidiano` decimal(8,2) DEFAULT 0.00,
  `asistencia` decimal(8,2) DEFAULT 0.00,
  `tareas` decimal(8,2) DEFAULT 0.00,
  `pruebas` decimal(8,2) DEFAULT 0.00,
  `total` decimal(8,2) DEFAULT 0.00
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
(22, '8.00', '10.00', '15.00', '45.00', '78.00'),
(23, '6.00', '10.00', '10.00', '10.00', '36.00'),
(24, '78.00', '7.00', '7.00', '7.00', '99.00'),
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
(52, '0.00', '0.00', '0.00', '0.00', '0.00'),
(53, '0.00', '0.00', '0.00', '0.00', '0.00'),
(54, '0.00', '0.00', '0.00', '0.00', '0.00'),
(55, '0.00', '0.00', '0.00', '0.00', '0.00'),
(56, '0.00', '0.00', '0.00', '0.00', '0.00'),
(57, '0.00', '0.00', '0.00', '0.00', '0.00'),
(58, '0.00', '0.00', '0.00', '0.00', '0.00'),
(59, '0.00', '0.00', '0.00', '0.00', '0.00'),
(60, '0.00', '0.00', '0.00', '0.00', '0.00'),
(61, '0.00', '0.00', '0.00', '0.00', '0.00'),
(62, '0.00', '0.00', '0.00', '0.00', '0.00'),
(63, '0.00', '0.00', '0.00', '0.00', '0.00'),
(64, '0.00', '0.00', '0.00', '0.00', '0.00'),
(65, '0.00', '0.00', '0.00', '0.00', '0.00'),
(66, '0.00', '0.00', '0.00', '0.00', '0.00'),
(67, '20.00', '50.00', '10.00', '5.00', '85.00'),
(68, '10.00', '20.00', '15.00', '28.00', '73.00'),
(69, '0.00', '0.00', '0.00', '0.00', '0.00'),
(70, '0.00', '0.00', '0.00', '0.00', '0.00'),
(71, '0.00', '0.00', '0.00', '0.00', '0.00'),
(72, '0.00', '0.00', '0.00', '0.00', '0.00'),
(73, '0.00', '0.00', '0.00', '0.00', '0.00'),
(74, '0.00', '0.00', '0.00', '0.00', '0.00'),
(75, '0.00', '0.00', '0.00', '0.00', '0.00'),
(76, '0.00', '0.00', '0.00', '0.00', '0.00'),
(77, '0.00', '0.00', '0.00', '0.00', '0.00'),
(78, '0.00', '0.00', '0.00', '0.00', '0.00'),
(79, '0.00', '0.00', '0.00', '0.00', '0.00'),
(80, '0.00', '0.00', '0.00', '0.00', '0.00'),
(81, '0.00', '0.00', '0.00', '0.00', '0.00'),
(82, '10.00', '10.00', '10.00', '50.00', '80.00'),
(83, '0.00', '0.00', '0.00', '0.00', '0.00'),
(84, '0.00', '0.00', '0.00', '0.00', '0.00'),
(85, '0.00', '0.00', '0.00', '0.00', '0.00'),
(86, '0.00', '0.00', '0.00', '0.00', '0.00'),
(87, '0.00', '0.00', '0.00', '0.00', '0.00'),
(88, '0.00', '0.00', '0.00', '0.00', '0.00'),
(89, '0.00', '0.00', '0.00', '0.00', '0.00'),
(90, '0.00', '0.00', '0.00', '0.00', '0.00'),
(91, '0.00', '0.00', '0.00', '0.00', '0.00'),
(92, '0.00', '0.00', '0.00', '0.00', '0.00'),
(93, '0.00', '0.00', '0.00', '0.00', '0.00'),
(94, '0.00', '0.00', '0.00', '0.00', '0.00'),
(95, '0.00', '0.00', '0.00', '0.00', '0.00'),
(96, '0.00', '0.00', '0.00', '0.00', '0.00'),
(97, '7.00', '0.00', '10.00', '110.00', '100.00'),
(98, '0.00', '0.00', '0.00', '0.00', '0.00'),
(99, '0.00', '0.00', '0.00', '0.00', '0.00'),
(100, '0.00', '0.00', '0.00', '0.00', '0.00'),
(101, '0.00', '0.00', '0.00', '0.00', '0.00'),
(102, '0.00', '0.00', '0.00', '0.00', '0.00'),
(103, '0.00', '0.00', '0.00', '0.00', '0.00'),
(104, '0.00', '0.00', '0.00', '0.00', '0.00'),
(105, '0.00', '0.00', '0.00', '0.00', '0.00'),
(106, '0.00', '0.00', '0.00', '0.00', '0.00'),
(107, '0.00', '0.00', '0.00', '0.00', '0.00'),
(108, '0.00', '0.00', '0.00', '0.00', '0.00'),
(109, '0.00', '0.00', '0.00', '0.00', '0.00'),
(110, '0.00', '0.00', '0.00', '0.00', '0.00'),
(111, '0.00', '0.00', '0.00', '0.00', '0.00'),
(112, '0.00', '0.00', '0.00', '0.00', '0.00'),
(113, '0.00', '0.00', '0.00', '0.00', '0.00'),
(114, '0.00', '0.00', '0.00', '0.00', '0.00'),
(115, '0.00', '0.00', '0.00', '0.00', '0.00'),
(116, '0.00', '0.00', '0.00', '0.00', '0.00'),
(117, '0.00', '0.00', '0.00', '0.00', '0.00'),
(118, '0.00', '0.00', '0.00', '0.00', '0.00'),
(119, '0.00', '0.00', '0.00', '0.00', '0.00'),
(120, '0.00', '0.00', '0.00', '0.00', '0.00'),
(121, '0.00', '0.00', '0.00', '0.00', '0.00'),
(122, '0.00', '0.00', '0.00', '0.00', '0.00'),
(123, '0.00', '0.00', '0.00', '0.00', '0.00'),
(124, '0.00', '0.00', '0.00', '0.00', '0.00'),
(125, '0.00', '0.00', '0.00', '0.00', '0.00'),
(126, '0.00', '0.00', '0.00', '0.00', '0.00'),
(127, '0.00', '0.00', '0.00', '0.00', '0.00'),
(128, '0.00', '0.00', '0.00', '0.00', '0.00'),
(129, '0.00', '0.00', '0.00', '0.00', '0.00'),
(130, '0.00', '0.00', '0.00', '0.00', '0.00'),
(131, '0.00', '0.00', '0.00', '0.00', '0.00'),
(132, '0.00', '0.00', '0.00', '0.00', '0.00'),
(133, '0.00', '0.00', '0.00', '0.00', '0.00'),
(134, '0.00', '0.00', '0.00', '0.00', '0.00'),
(135, '0.00', '0.00', '0.00', '0.00', '0.00'),
(136, '0.00', '0.00', '0.00', '0.00', '0.00'),
(137, '0.00', '0.00', '0.00', '0.00', '0.00'),
(138, '0.00', '0.00', '0.00', '0.00', '0.00'),
(139, '0.00', '0.00', '0.00', '0.00', '0.00'),
(140, '0.00', '0.00', '0.00', '0.00', '0.00'),
(141, '0.00', '0.00', '0.00', '0.00', '0.00'),
(142, '0.00', '0.00', '0.00', '0.00', '0.00'),
(143, '0.00', '0.00', '0.00', '0.00', '0.00'),
(144, '0.00', '0.00', '0.00', '0.00', '0.00'),
(145, '0.00', '0.00', '0.00', '0.00', '0.00'),
(146, '0.00', '0.00', '0.00', '0.00', '0.00'),
(147, '0.00', '0.00', '0.00', '0.00', '0.00');

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
  `disponible` tinyint(1) NOT NULL DEFAULT 1,
  `nota_medica` varchar(650) COLLATE utf8mb4_unicode_ci DEFAULT 'Ninguna'
) ENGINE=InnoDB AVG_ROW_LENGTH=195 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `persona`
--

INSERT INTO `persona` (`idPersona`, `cedula`, `nombre`, `apellido1`, `apellido2`, `sexo`, `direccion`, `telefono`, `telefono_secundario`, `email`, `idNacionalidad`, `disponible`, `nota_medica`) VALUES
(1, '123456789', 'Director', 'Director', 'Director', 'Masculino', 'San Jose', '12345678', NULL, 'oscarsoto040797@gmail.com', 1, 0, 'Ninguna'),
(2, '305080238', 'Julian Francisco', 'Perez', 'Fernandez', 'Masculino', 'Santo Tomas de Santo Domingo de Heradia', '60439934', NULL, 'crjuliantico@gmail.com', 1, 1, 'Ninguna'),
(4, '117090190', 'Olman', 'Campos', 'Fallas', 'Masculino', 'San José', '85579419', NULL, 'OlmanCampos07@hotmail.com', 1, 1, 'Ninguna'),
(6, '116960084', 'Yalmer Josué', 'Monge', 'Badilla', 'Masculino', 'San José', '86377734', NULL, 'yalmermonge@gmail.com', 1, 1, 'Ninguna'),
(8, '116560650', 'Kendall Jair', 'Gomez', 'Cervantes', '', 'Desampakistan', '84556568', NULL, 'kjgc72@gmail.com', 1, 0, 'Ninguna'),
(10, '208040404', 'Ileana', 'Soto', 'Leon', 'Femenino', 'Alajuela,Atenas, Costa Rica', '86928190', NULL, 'ileanasl30@gmail.com', 1, 0, 'Ninguna'),
(12, '-120349012', 'Jairo', 'Martinez', 'Grarrijo', 'Masculino', 'San Antonio de escazu', NULL, NULL, NULL, 2, 0, 'Asma'),
(13, '502170089', 'Maria Eugenia', 'Solano', 'Jimenez', 'Masculino', 'Tarbaca', '25465617', NULL, NULL, 1, 1, 'Ninguna'),
(14, '207680159', 'Oscar Eduardo', 'Soto', 'Leon', 'Masculino', 'Alajuela, Atenas, Costa Rica', '63103970', NULL, 'oscarsoto040797@icloud.com', 1, 1, 'Ninguna'),
(16, '207670052', 'Ana', 'Lopez', 'Monge', 'Masculino', 'Alajuela', '89780605', NULL, 'natalielopez080597@gmail.com', 1, 1, 'Ninguna'),
(18, '307680159', 'Gerardo', 'Ortiz', 'Mejia', 'Masculino', 'San Pedro de Montes de Oca', NULL, NULL, NULL, 2, 1, 'Asma'),
(19, '407680159', 'Maria Isabel', 'Mora', 'Gutierrez', 'Femenino', 'Santa Marta , San Pedro', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(20, '507680159', 'Martin Edwin', 'Perez', 'Gonzales', 'Masculino', 'Cartago', NULL, NULL, NULL, 1, 1, 'Alergias constantes'),
(21, '101590768', 'Jose', 'Ortiz', 'Saborio', '', 'Desamparados', '24456787', '89887806', NULL, 1, 1, 'Ninguna'),
(22, '201690768', 'Meilyn Maria', 'Jimenez', 'Solorzano', '', 'San José', '24456787', '89887807', NULL, 1, 0, 'Ninguna'),
(23, '207670051', 'Jaime', 'Muñoz', 'Saborío', 'Masculino', 'Alajuela', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(24, '132798465', 'Maria Angelica', 'Cascante', 'Flores', 'Femenino', 'Santo Domingo de Heredia', NULL, NULL, NULL, 1, 0, 'Padese de Asma'),
(25, '209870987', 'Maria', 'Martinez', 'Solano', 'Femenino', 'San Jose', '24465454', NULL, NULL, 1, 1, 'Ninguna'),
(26, '1000000000', 'Lisbeth', 'Lao', 'Aguilar', 'Masculino', 'Alajuela', '89898787', NULL, 'lislaoag07@gmail.com', 1, 0, 'Ninguna'),
(28, '200000000', 'Lohana', 'Montoya', 'Montoya', 'Femenino', 'San Jose', '89898776', NULL, 'loha.montoya@gmail.com', 1, 0, 'Ninguna'),
(30, '300000000', 'Edwin', 'Pardo', 'Pardo', 'Masculino', 'Direccion', '88888888', NULL, 'edwinpardo7519@gmail.com', 1, 0, 'Ninguna'),
(32, '400000000', 'Isac', 'Alfaro', 'Alfaro', 'Masculino', 'Direccion', '24467676', NULL, 'kevin.lan13598@gmail.com', 1, 0, 'Ninguna'),
(34, '500000000', 'Shafiq', 'Mora', 'Mora', 'Masculino', 'Direccion', '89765423', NULL, 'shafiqmora9@gmail.com', 1, 0, 'Ninguna'),
(36, '100000000', 'Lohana', 'Montoya', 'Ramirez', 'Femenino', 'Cartago', NULL, NULL, NULL, 1, 1, 'Bdjdjdjd'),
(41, '110000000', 'Ana', 'Mora', 'Mora', 'Femenino', 'Tejar', NULL, NULL, NULL, 1, 0, 'Fgc'),
(42, '6000000000', 'Kevin', 'Lam', 'A', 'Masculino', 'San Jose', '60439934', NULL, 'kevin.lam1398@gmail.com', 1, 0, 'Ninguna'),
(44, '800000000', 'Lisbeth', 'Lao', 'Aguilar', 'Femenino', 'San Jose', '60908765', NULL, 'lislaoag01@gmail.com', 1, 0, 'Ninguna'),
(46, '150000000', 'Edwin', 'Pardo', 'Soto', 'Masculino', 'San Jose', '88308752', NULL, 'edwinpardo7517@gmail.com', 1, 0, 'Ninguna'),
(48, '541258963', '234', '234234', '23423', 'Femenino', 'adwa3242342', NULL, NULL, NULL, 1, 0, 'awdaw324'),
(49, '951753852', '12345', '654321', '456789', 'Masculino', 'San Pedro', NULL, NULL, NULL, 1, 0, 'Asmatico'),
(50, '654789321', 'Maikol', 'Quesada', 'Fernandez', 'Masculino', 'Aserri', NULL, NULL, NULL, 1, 1, 'Ninguna'),
(52, '502170052', 'Maria', 'Ramirez', 'Mena', 'Masculino', 'Alajuela', '88927645', NULL, 'florylr08@gmail.com', 1, 1, 'Ninguna');

-- --------------------------------------------------------

--
-- Table structure for table `profesor`
--

CREATE TABLE `profesor` (
  `idprofesor` int(11) NOT NULL,
  `Persona_idPersona` int(11) NOT NULL,
  `tipo` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `profesor`
--

INSERT INTO `profesor` (`idprofesor`, `Persona_idPersona`, `tipo`) VALUES
(1, 1, 0),
(2, 2, 1),
(3, 4, 0),
(4, 6, 0),
(5, 8, 1),
(6, 10, 1),
(7, 14, 1),
(8, 16, 0),
(9, 26, 0),
(10, 28, 0),
(11, 30, 0),
(12, 32, 0),
(13, 34, 0),
(14, 42, 1),
(15, 44, 0),
(16, 46, 0),
(17, 52, 0);

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
(1, 4, 1),
(2, 3, 1),
(3, 4, 2),
(4, 4, 4),
(5, 2, 1),
(5, 2, 2),
(5, 2, 3),
(5, 2, 4),
(5, 2, 5),
(5, 2, 6),
(6, 2, 1),
(6, 2, 2),
(6, 2, 3),
(6, 2, 4),
(6, 2, 5),
(6, 2, 6),
(7, 1, 1),
(7, 1, 2),
(7, 1, 3),
(7, 1, 4),
(7, 1, 5),
(7, 1, 6),
(8, 4, 2),
(9, 4, 2),
(9, 5, 2),
(10, 4, 2),
(10, 5, 2),
(11, 4, 2),
(11, 5, 2),
(12, 4, 4),
(12, 5, 4),
(13, 4, 1),
(13, 5, 1),
(14, 2, 1),
(14, 2, 2),
(14, 2, 3),
(14, 2, 4),
(14, 2, 5),
(14, 2, 6),
(15, 4, 5),
(15, 5, 5),
(16, 4, 1),
(16, 5, 1),
(17, 4, 1),
(17, 5, 1);

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
(1, 'Concerje', 'Encarcago de la limpieza de la institución.'),
(2, 'Guarda', 'Encargado de seguridad'),
(3, 'Secretaria', 'Función administrativa II');

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
(1, 1, 2, '$2y$09$wM2ozn/.RC9QoWiEDLmZ5.SzbjLC4xfD2j0uiROP5zZKQIwJLnkMa', 0),
(2, 2, 1, '$2y$09$yIGVCIC1oi4B73Ftjts1Z.bYjfSGzZuNrDpdGuohfpQTev/HoAlqC', 0),
(3, 4, 1, '$2y$09$by87bc9P6JqVQl6MXE/GXenh3p4jUZpe/KU66MH.OMxZ8bFi1ZvJe', 0),
(4, 6, 1, '$2y$09$fYN6s4H3Uv/beJauWjDsxOm38d7zlkThocoz1RwC0d4KwBxJ843G2', 1),
(7, 14, 1, '$2y$09$04LoZfj5uUHV/26m76ZMDuhhz0imsWXhw0hniYbAIbLHXir6MJhHa', 0),
(8, 16, 1, '$2y$09$CLKIwmkPsiTsGDf/Bdm7E.G0R36f36nMdJz7X1rNS4.kf8lHhkR..', 0),
(17, 52, 1, '$2y$09$LnW.zYsSa0HYXd8y.onVM.eojN8/DaBFFWSTJEJmRwdFsyPixAZse', 1);

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

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `mostrar_encargado`  AS  select `p2`.`cedula` AS `cedula_e`,`p`.`cedula` AS `cedula`,concat(`p`.`nombre`,' ',`p`.`apellido1`,' ',`p`.`apellido2`) AS `nombre`,`p`.`telefono` AS `telefono`,`p`.`telefono_secundario` AS `telefono_secundario`,`p`.`direccion` AS `direccion` from ((((`persona` `p` join `alumno` `a`) join `alumno_encargado` `ae`) join `encargado` `e`) join `persona` `p2`) where `p2`.`idPersona` = `a`.`Persona_idPersona` and `p`.`idPersona` = `e`.`Persona_idPersona` and `a`.`idalumno` = `ae`.`ID_ALUMNO` and `e`.`idencargado` = `ae`.`ID_ENCARGADO` and `p`.`disponible` <> 0 ;

-- --------------------------------------------------------

--
-- Structure for view `vbeca`
--
DROP TABLE IF EXISTS `vbeca`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `vbeca`  AS  select `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,concat(`p`.`apellido1`,' ',`p`.`apellido2`) AS `apellidos`,`b`.`descripcion_beca` AS `descripcion_beca`,`b`.`monto_beca` AS `monto_beca`,`b`.`estado` AS `estado` from ((`persona` `p` join `alumno` `a`) join `beca` `b`) where `p`.`idPersona` = `a`.`Persona_idPersona` and `a`.`idalumno` = `b`.`idAlumno` ;

-- --------------------------------------------------------

--
-- Structure for view `vista_alumno`
--
DROP TABLE IF EXISTS `vista_alumno`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `vista_alumno`  AS  select `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,`p`.`apellido1` AS `apellido1`,`p`.`apellido2` AS `apellido2`,`p`.`sexo` AS `sexo`,`n`.`pais` AS `pais`,`g`.`nombreGrado` AS `nombreGrado`,`g`.`annio` AS `annio`,`p`.`direccion` AS `direccion`,`p`.`nota_medica` AS `nota_medica`,`p`.`disponible` AS `disponible`,`g`.`idgrado` AS `idgrado` from ((((`persona` `p` join `alumno` `a`) join `grado_estudiante_nota` `ga`) join `nacionalidad` `n`) join `grado` `g`) where `a`.`Persona_idPersona` = `p`.`idPersona` and `ga`.`idEstudiante` = `a`.`idalumno` and `p`.`idNacionalidad` = `n`.`idNacionalidad` and `ga`.`idGrado` = `g`.`idgrado` and `p`.`disponible` <> 0 group by `p`.`cedula` ;

-- --------------------------------------------------------

--
-- Structure for view `vista_alumno_encargado`
--
DROP TABLE IF EXISTS `vista_alumno_encargado`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `vista_alumno_encargado`  AS  select `p2`.`cedula` AS `cedula`,`a`.`idalumno` AS `idalumno`,concat(`p`.`nombre`,' ',`p`.`apellido1`,' ',`p`.`apellido2`) AS `nombre`,`gen`.`idGrado` AS `idGrado` from (((((`persona` `p` join `alumno` `a`) join `grado_estudiante_nota` `gen`) join `alumno_encargado` `ae`) join `persona` `p2`) join `encargado` `e`) where `p`.`idPersona` = `a`.`Persona_idPersona` and `a`.`idalumno` = `gen`.`idEstudiante` and `ae`.`ID_ENCARGADO` = `e`.`idencargado` and `ae`.`ID_ALUMNO` = `a`.`idalumno` and `e`.`Persona_idPersona` = `p2`.`idPersona` ;

-- --------------------------------------------------------

--
-- Structure for view `vista_asistencia`
--
DROP TABLE IF EXISTS `vista_asistencia`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `vista_asistencia`  AS  select distinct `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,`p`.`apellido1` AS `apellido1`,`p`.`apellido2` AS `apellido2`,`g`.`nombreGrado` AS `nombreGrado`,`a`.`ESTADO` AS `ESTADO`,`a`.`NOTA` AS `NOTA`,`a`.`FECHA` AS `FECHA`,`a`.`AUSENCIA` AS `AUSENCIA` from ((((`grado` `g` join `grado_estudiante_nota` `gan`) join `asistencia` `a`) join `persona` `p`) join `alumno` `al`) where `p`.`idPersona` = `al`.`Persona_idPersona` and `al`.`idalumno` = `gan`.`idEstudiante` and `gan`.`idGrado` = `g`.`idgrado` and `gan`.`idEstudiante` = `a`.`IDALUMNO` and `g`.`idgrado` = `a`.`IDGRADO` and `p`.`disponible` <> 0 ;

-- --------------------------------------------------------

--
-- Structure for view `vista_empleado`
--
DROP TABLE IF EXISTS `vista_empleado`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `vista_empleado`  AS  select `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,`p`.`apellido1` AS `apellido1`,`p`.`apellido2` AS `apellido2`,`p`.`sexo` AS `sexo`,`p`.`direccion` AS `direccion`,`p`.`telefono` AS `telefono`,`n`.`pais` AS `pais`,`pu`.`nombrePuesto` AS `nombrePuesto`,`p`.`disponible` AS `disponible` from (((`persona` `p` join `empleado` `e`) join `nacionalidad` `n`) join `puesto` `pu`) where `p`.`idPersona` = `e`.`idPersona` and `e`.`idPuesto` = `pu`.`idPuesto` and `n`.`idNacionalidad` = `p`.`idNacionalidad` and `p`.`disponible` <> 0 ;

-- --------------------------------------------------------

--
-- Structure for view `vista_encargado`
--
DROP TABLE IF EXISTS `vista_encargado`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `vista_encargado`  AS  select `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,`p`.`apellido1` AS `apellido1`,`p`.`apellido2` AS `apellido2`,`p`.`telefono` AS `telefono`,`p`.`telefono_secundario` AS `telefono_secundario`,`p`.`direccion` AS `direccion`,`p`.`sexo` AS `sexo`,`n`.`pais` AS `pais`,`p`.`disponible` AS `disponible` from ((`persona` `p` join `encargado` `e`) join `nacionalidad` `n`) where `p`.`idPersona` = `e`.`Persona_idPersona` and `p`.`idNacionalidad` = `n`.`idNacionalidad` and `p`.`disponible` <> 0 ;

-- --------------------------------------------------------

--
-- Structure for view `vista_materia`
--
DROP TABLE IF EXISTS `vista_materia`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `vista_materia`  AS  select `m`.`idmateria` AS `idmateria`,`m`.`nombre` AS `nombre`,`t`.`tipo` AS `tipo`,`m`.`estado` AS `estado` from (`materia` `m` join `tipo_materia` `t`) where `m`.`idTipoMateria` = `t`.`idTipo` ;

-- --------------------------------------------------------

--
-- Structure for view `vista_nota`
--
DROP TABLE IF EXISTS `vista_nota`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `vista_nota`  AS  select concat(`p`.`nombre`,' ',`p`.`apellido1`,' ',`p`.`apellido2`) AS `CONCAT(p.nombre,' ',p.apellido1,' ',p.apellido2)`,`m`.`nombre` AS `nombre`,`n`.`asistencia` AS `asistencia`,`n`.`pruebas` AS `pruebas`,`n`.`tareas` AS `tareas`,`n`.`trabajo_cotidiano` AS `trabajo_cotidiano`,`gdn`.`trimestre` AS `trimestre` from ((((`grado_estudiante_nota` `gdn` join `alumno` `a`) join `persona` `p`) join `materia` `m`) join `nota` `n`) where `a`.`Persona_idPersona` = `p`.`idPersona` and `a`.`idalumno` = `gdn`.`idEstudiante` and `gdn`.`idNota` = `n`.`idnota` group by `m`.`idmateria` ;

-- --------------------------------------------------------

--
-- Structure for view `vista_notas`
--
DROP TABLE IF EXISTS `vista_notas`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `vista_notas`  AS  select `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,`p`.`apellido1` AS `apellido1`,`p`.`apellido2` AS `apellido2`,`m`.`nombre` AS `materia`,`g`.`nombreGrado` AS `nombreGrado`,`n`.`trabajo_cotidiano` AS `trabajo_cotidiano`,`n`.`pruebas` AS `pruebas`,`n`.`tareas` AS `tareas`,`n`.`asistencia` AS `asistencia`,`n`.`total` AS `total`,`gan`.`trimestre` AS `trimestre` from (((((`persona` `p` join `materia` `m`) join `grado_estudiante_nota` `gan`) join `grado` `g`) join `nota` `n`) join `alumno` `a`) where `p`.`idPersona` = `a`.`Persona_idPersona` and `a`.`idalumno` = `gan`.`idEstudiante` and `gan`.`idGrado` = `g`.`idgrado` and `m`.`idmateria` = `gan`.`idMateria` and `gan`.`idNota` = `n`.`idnota` and `p`.`disponible` <> 0 ;

-- --------------------------------------------------------

--
-- Structure for view `vista_profesor`
--
DROP TABLE IF EXISTS `vista_profesor`;

CREATE ALGORITHM=UNDEFINED  SQL SECURITY DEFINER VIEW `vista_profesor`  AS  select `p`.`cedula` AS `CEDULA`,`p`.`nombre` AS `NOMBRE`,`p`.`apellido1` AS `APELLIDO1`,`p`.`apellido2` AS `APELLIDO2`,`p`.`sexo` AS `SEXO`,`p`.`direccion` AS `DIRECCION`,`p`.`telefono` AS `TELEFONO`,`p`.`email` AS `EMAIL`,`n`.`pais` AS `PAIS`,`p`.`disponible` AS `DISPONIBLE`,`g`.`nombreGrado` AS `nombreGrado`,`g`.`annio` AS `annio`,`pe`.`tipo` AS `tipo` from ((((`persona` `p` join `profesor` `pe`) join `nacionalidad` `n`) join `grado` `g`) join `profesor_materia_grado` `pg`) where `p`.`idPersona` = `pe`.`Persona_idPersona` and `pe`.`idprofesor` = `pg`.`profesor_idprofesor` and `g`.`idgrado` = `pg`.`id_grado` and `p`.`idNacionalidad` = `n`.`idNacionalidad` ;

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
  ADD UNIQUE KEY `UNQ_CEDULA` (`cedula`),
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
  MODIFY `idalumno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `asistencia`
--
ALTER TABLE `asistencia`
  MODIFY `IDASISTENCIA` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `beca`
--
ALTER TABLE `beca`
  MODIFY `idbeca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `empleado`
--
ALTER TABLE `empleado`
  MODIFY `idEmpleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `encargado`
--
ALTER TABLE `encargado`
  MODIFY `idencargado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `grado`
--
ALTER TABLE `grado`
  MODIFY `idgrado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `historico_usuarios`
--
ALTER TABLE `historico_usuarios`
  MODIFY `idHistorico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `materia`
--
ALTER TABLE `materia`
  MODIFY `idmateria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `nacionalidad`
--
ALTER TABLE `nacionalidad`
  MODIFY `idNacionalidad` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `nota`
--
ALTER TABLE `nota`
  MODIFY `idnota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=148;

--
-- AUTO_INCREMENT for table `nota_constante`
--
ALTER TABLE `nota_constante`
  MODIFY `idnota_constante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `persona`
--
ALTER TABLE `persona`
  MODIFY `idPersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `profesor`
--
ALTER TABLE `profesor`
  MODIFY `idprofesor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

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
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

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
