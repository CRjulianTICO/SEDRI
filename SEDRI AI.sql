
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema escuela
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema escuela
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `escuela` DEFAULT CHARACTER SET utf8 ;
USE `escuela` ;

-- -----------------------------------------------------
-- Table `escuela`.`nacionalidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuela`.`nacionalidad` (
  `idNacionalidad` INT(11) NOT NULL AUTO_INCREMENT,
  `pais` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idNacionalidad`),
  UNIQUE INDEX `idNacionalidad_UNIQUE` (`idNacionalidad` ASC),
  UNIQUE INDEX `pais_UNIQUE` (`pais` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `escuela`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuela`.`persona` (
  `idPersona` INT(11) NOT NULL AUTO_INCREMENT,
  `cedula` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  `sexo` VARCHAR(20) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(45) NULL DEFAULT NULL,
  `telefono_secundario` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `idNacionalidad` INT(11) NOT NULL,
  `disponible` TINYINT(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idPersona`),
  UNIQUE INDEX `idPersona_UNIQUE` (`idPersona` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `idNacionalidad_idx` (`idNacionalidad` ASC),
  CONSTRAINT `idNacionalidad`
    FOREIGN KEY (`idNacionalidad`)
    REFERENCES `escuela`.`nacionalidad` (`idNacionalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `escuela`.`alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuela`.`alumno` (
  `idalumno` INT(11) NOT NULL AUTO_INCREMENT,
  `Persona_idPersona` INT(11) NOT NULL,
  PRIMARY KEY (`idalumno`, `Persona_idPersona`),
  UNIQUE INDEX `idalumno_UNIQUE` (`idalumno` ASC),
  INDEX `fk_alumno_Persona1_idx` (`Persona_idPersona` ASC),
  CONSTRAINT `fk_alumno_Persona1`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `escuela`.`persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `escuela`.`encargado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuela`.`encargado` (
  `idencargado` INT(11) NOT NULL AUTO_INCREMENT,
  `Persona_idPersona` INT(11) NOT NULL,
  PRIMARY KEY (`idencargado`, `Persona_idPersona`),
  UNIQUE INDEX `idencargado_UNIQUE` (`idencargado` ASC),
  INDEX `fk_encargado_Persona1_idx` (`Persona_idPersona` ASC),
  CONSTRAINT `fk_encargado_Persona1`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `escuela`.`persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `escuela`.`alumno_encargado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuela`.`alumno_encargado` (
  `ID_ALUMNO` INT(11) NOT NULL,
  `ID_ENCARGADO` INT(11) NOT NULL,
  PRIMARY KEY (`ID_ALUMNO`, `ID_ENCARGADO`),
  INDEX `ID_ENCARGADO` (`ID_ENCARGADO` ASC),
  CONSTRAINT `alumno_encargado_ibfk_1`
    FOREIGN KEY (`ID_ALUMNO`)
    REFERENCES `escuela`.`alumno` (`idalumno`),
  CONSTRAINT `alumno_encargado_ibfk_2`
    FOREIGN KEY (`ID_ENCARGADO`)
    REFERENCES `escuela`.`encargado` (`idencargado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `escuela`.`materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuela`.`materia` (
  `idmateria` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idmateria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `escuela`.`alumno_materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuela`.`alumno_materia` (
  `alumno_idalumno` INT(11) NOT NULL,
  `materia_idmateria` INT(11) NOT NULL,
  `trimestre_1` DECIMAL(10,0) NULL DEFAULT NULL,
  `trimestre_2` DECIMAL(10,0) NULL DEFAULT NULL,
  `trimestre_3` DECIMAL(10,0) NULL DEFAULT NULL,
  PRIMARY KEY (`alumno_idalumno`, `materia_idmateria`),
  INDEX `fk_alumno_has_materia_materia1_idx` (`materia_idmateria` ASC),
  INDEX `fk_alumno_has_materia_alumno1_idx` (`alumno_idalumno` ASC),
  CONSTRAINT `fk_alumno_has_materia_alumno1`
    FOREIGN KEY (`alumno_idalumno`)
    REFERENCES `escuela`.`alumno` (`idalumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alumno_has_materia_materia1`
    FOREIGN KEY (`materia_idmateria`)
    REFERENCES `escuela`.`materia` (`idmateria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `escuela`.`beca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuela`.`beca` (
  `idbeca` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcion_beca` VARCHAR(45) NOT NULL,
  `monto_beca` VARCHAR(45) NOT NULL,
  `idAlumno` INT(11) NOT NULL,
  PRIMARY KEY (`idbeca`),
  INDEX `fk_beca_alumno_idx` (`idAlumno` ASC),
  CONSTRAINT `fk_beca_alumno`
    FOREIGN KEY (`idAlumno`)
    REFERENCES `escuela`.`alumno` (`idalumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `escuela`.`director`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuela`.`director` (
  `idDirector` INT(11) NOT NULL AUTO_INCREMENT,
  `Persona_idPersona` INT(11) NOT NULL,
  PRIMARY KEY (`idDirector`, `Persona_idPersona`),
  UNIQUE INDEX `iddirector_UNIQUE` (`idDirector` ASC),
  INDEX `fk_director_Persona1_idx` (`Persona_idPersona` ASC),
  CONSTRAINT `fk_director_Persona1`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `escuela`.`persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `escuela`.`grado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuela`.`grado` (
  `idgrado` INT(11) NOT NULL AUTO_INCREMENT,
  `nombreGrado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idgrado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `escuela`.`grado_alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuela`.`grado_alumno` (
  `grado_idgrado` INT(11) NOT NULL,
  `alumno_idalumno` INT(11) NOT NULL,
  `annio` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`grado_idgrado`, `alumno_idalumno`),
  INDEX `fk_grado_has_alumno_alumno1_idx` (`alumno_idalumno` ASC),
  INDEX `fk_grado_has_alumno_grado1_idx` (`grado_idgrado` ASC),
  CONSTRAINT `fk_grado_has_alumno_alumno1`
    FOREIGN KEY (`alumno_idalumno`)
    REFERENCES `escuela`.`alumno` (`idalumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grado_has_alumno_grado1`
    FOREIGN KEY (`grado_idgrado`)
    REFERENCES `escuela`.`grado` (`idgrado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `escuela`.`notas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuela`.`notas` (
  `idNotas` INT(11) NOT NULL AUTO_INCREMENT,
  `grado` INT(11) NOT NULL,
  `trabajoCotidiano` VARCHAR(45) NULL DEFAULT NULL,
  `asistencia` VARCHAR(45) NULL DEFAULT NULL,
  `tareas` VARCHAR(45) NULL DEFAULT NULL,
  `pruebas` VARCHAR(45) NULL DEFAULT NULL,
  `idAlumno` INT(11) NOT NULL,
  `idMateria` INT(11) NOT NULL,
  PRIMARY KEY (`idNotas`),
  INDEX `fk_grado_notas_idx` (`grado` ASC),
  INDEX `fk_alumno_nota_idx` (`idAlumno` ASC),
  INDEX `fk_materia_nota_idx` (`idMateria` ASC),
  CONSTRAINT `fk_alumno_nota`
    FOREIGN KEY (`idAlumno`)
    REFERENCES `escuela`.`alumno_materia` (`alumno_idalumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grado_notas`
    FOREIGN KEY (`grado`)
    REFERENCES `escuela`.`grado` (`idgrado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_materia_nota`
    FOREIGN KEY (`idMateria`)
    REFERENCES `escuela`.`alumno_materia` (`materia_idmateria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `escuela`.`nota_constante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuela`.`nota_constante` (
  `idnota_constante` INT(11) NOT NULL AUTO_INCREMENT,
  `grado` INT(11) NOT NULL,
  `trabajo_cotidiano` DECIMAL(8,2) NULL DEFAULT NULL,
  `pruebas` DECIMAL(8,2) NULL DEFAULT NULL,
  `tareas` DECIMAL(8,2) NULL DEFAULT NULL,
  `asistencia` DECIMAL(8,2) NULL DEFAULT NULL,
  PRIMARY KEY (`idnota_constante`),
  INDEX `fk_grado_idx` (`grado` ASC),
  CONSTRAINT `fk_grado`
    FOREIGN KEY (`grado`)
    REFERENCES `escuela`.`grado` (`idgrado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `escuela`.`profesor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuela`.`profesor` (
  `idprofesor` INT(11) NOT NULL AUTO_INCREMENT,
  `Persona_idPersona` INT(11) NOT NULL,
  PRIMARY KEY (`idprofesor`, `Persona_idPersona`),
  UNIQUE INDEX `idprofesor_UNIQUE` (`idprofesor` ASC),
  INDEX `fk_profesor_Persona1_idx` (`Persona_idPersona` ASC),
  CONSTRAINT `fk_profesor_Persona1`
    FOREIGN KEY (`Persona_idPersona`)
    REFERENCES `escuela`.`persona` (`idPersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `escuela`.`profesor_materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuela`.`profesor_materia` (
  `profesor_idprofesor` INT(11) NOT NULL,
  `materia_idmateria` INT(11) NOT NULL,
  `annio` DATE NOT NULL,
  `periodo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`profesor_idprofesor`, `materia_idmateria`),
  INDEX `fk_profesor_has_materia_materia1_idx` (`materia_idmateria` ASC),
  INDEX `fk_profesor_has_materia_profesor1_idx` (`profesor_idprofesor` ASC),
  CONSTRAINT `fk_profesor_has_materia_materia1`
    FOREIGN KEY (`materia_idmateria`)
    REFERENCES `escuela`.`materia` (`idmateria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profesor_has_materia_profesor1`
    FOREIGN KEY (`profesor_idprofesor`)
    REFERENCES `escuela`.`profesor` (`idprofesor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `escuela`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuela`.`rol` (
  `IDROL` INT(11) NOT NULL AUTO_INCREMENT,
  `tiporol` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`IDROL`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `escuela`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuela`.`usuario` (
  `idUsuario` INT(11) NOT NULL AUTO_INCREMENT,
  `idPersona` INT(11) NULL DEFAULT NULL,
  `idRol` INT(11) NULL DEFAULT NULL,
  `password` VARCHAR(75) NULL DEFAULT NULL,
  PRIMARY KEY (`idUsuario`),
  INDEX `fk_persona_usuario` (`idPersona` ASC),
  INDEX `fk_rol_usuario` (`idRol` ASC),
  CONSTRAINT `fk_persona_usuario`
    FOREIGN KEY (`idPersona`)
    REFERENCES `escuela`.`persona` (`idPersona`),
  CONSTRAINT `fk_rol_usuario`
    FOREIGN KEY (`idRol`)
    REFERENCES `escuela`.`rol` (`IDROL`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `escuela` ;

-- -----------------------------------------------------
-- Placeholder table for view `escuela`.`vdirector`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuela`.`vdirector` (`CEDULA` INT, `NOMBRE` INT, `APELLIDOS` INT, `SEXO` INT, `DIRECCION` INT, `TELEFONO` INT, `EMAIL` INT, `PAIS` INT, `DISPONIBLE` INT);

-- -----------------------------------------------------
-- Placeholder table for view `escuela`.`vista_alumno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuela`.`vista_alumno` (`cedula` INT, `nombre` INT, `apellido1` INT, `apellido2` INT, `sexo` INT, `direccion` INT, `pais` INT, `disponible` INT);

-- -----------------------------------------------------
-- Placeholder table for view `escuela`.`vprofesor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `escuela`.`vprofesor` (`CEDULA` INT, `NOMBRE` INT, `APELLIDOS` INT, `SEXO` INT, `DIRECCION` INT, `TELEFONO` INT, `EMAIL` INT, `PAIS` INT, `DISPONIBLE` INT);

-- -----------------------------------------------------
-- procedure login
-- -----------------------------------------------------

DELIMITER $$
USE `escuela`$$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `login` (IN `pass` CHAR(20), IN `ced` VARCHAR(25))  BEGIN
select p.idPersona, r.tiporol 
from usuario u, persona p , rol r 
where u.password=pass and p.cedula=ced ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `escuela`.`vdirector`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `escuela`.`vdirector`;
USE `escuela`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vdirector`  AS  select `pe`.`cedula` AS `CEDULA`,`pe`.`nombre` AS `NOMBRE`,concat(`pe`.`apellido1`,' ',`pe`.`apellido2`) AS `APELLIDOS`,`pe`.`sexo` AS `SEXO`,`pe`.`direccion` AS `DIRECCION`,`pe`.`telefono` AS `TELEFONO`,`pe`.`email` AS `EMAIL`,`n`.`pais` AS `PAIS`,`pe`.`disponible` AS `DISPONIBLE` from ((`director` `pr` join `persona` `pe`) join `nacionalidad` `n`) where ((`pe`.`idPersona` = `pr`.`idDirector`) and (`n`.`idNacionalidad` = `pe`.`idNacionalidad`));

-- -----------------------------------------------------
-- View `escuela`.`vista_alumno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `escuela`.`vista_alumno`;
USE `escuela`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_alumno`  AS  select `p`.`cedula` AS `cedula`,`p`.`nombre` AS `nombre`,`p`.`apellido1` AS `apellido1`,`p`.`apellido2` AS `apellido2`,`p`.`sexo` AS `sexo`,`p`.`direccion` AS `direccion`,`n`.`pais` AS `pais`,`p`.`disponible` AS `disponible` from ((`persona` `p` join `alumno` `a`) join `nacionalidad` `n`) where ((`p`.`idPersona` = `a`.`Persona_idPersona`) and (`n`.`idNacionalidad` = `p`.`idNacionalidad`));

-- -----------------------------------------------------
-- View `escuela`.`vprofesor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `escuela`.`vprofesor`;
USE `escuela`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vprofesor`  AS  select `pe`.`cedula` AS `CEDULA`,`pe`.`nombre` AS `NOMBRE`,concat(`pe`.`apellido1`,' ',`pe`.`apellido2`) AS `APELLIDOS`,`pe`.`sexo` AS `SEXO`,`pe`.`direccion` AS `DIRECCION`,`pe`.`telefono` AS `TELEFONO`,`pe`.`email` AS `EMAIL`,`n`.`pais` AS `PAIS`,`pe`.`disponible` AS `DISPONIBLE` from ((`profesor` `pr` join `persona` `pe`) join `nacionalidad` `n`) where ((`pe`.`idPersona` = `pr`.`idprofesor`) and (`n`.`idNacionalidad` = `pe`.`idNacionalidad`));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
