SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `Escuela` ;
USE `Escuela` ;

-- -----------------------------------------------------
-- Table `Escuela`.`Rol`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Escuela`.`Nacionalidad` (
  `idNacionalidad` INT NOT NULL AUTO_INCREMENT ,
  `pais` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idNacionalidad`) ,
  UNIQUE INDEX `idNacionalidad_UNIQUE` (`idNacionalidad` ASC) ,
  UNIQUE INDEX `pais_UNIQUE` (`pais` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Escuela`.`Persona`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Escuela`.`Persona` (
  `idPersona` INT NOT NULL AUTO_INCREMENT ,
  `cedula` VARCHAR(45) NOT NULL ,
  `nombre` VARCHAR(45) NOT NULL ,
  `apellido1` VARCHAR(45) NOT NULL ,
  `apellido2` VARCHAR(45) NOT NULL ,
  `sexo` VARCHAR(20) NOT NULL ,
  `direccion` VARCHAR(100) NOT NULL ,
  `telefono` VARCHAR(45) NULL ,
  `telefono_secundario` VARCHAR(45) NULL ,
  `email` VARCHAR(45) NULL ,
  `idNacionalidad` INT NOT NULL ,
  PRIMARY KEY (`idPersona`) ,
  UNIQUE INDEX `idPersona_UNIQUE` (`idPersona` ASC) ,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) ,
  INDEX `idNacionalidad_idx` (`idNacionalidad` ASC) ,
  CONSTRAINT `idNacionalidad`
    FOREIGN KEY (`idNacionalidad` )
    REFERENCES `Escuela`.`Nacionalidad` (`idNacionalidad` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Escuela`.`director`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Escuela`.`director` (
  `idDirector` INT NOT NULL AUTO_INCREMENT,
  `password` VARCHAR(45) NOT NULL ,
  `Persona_idPersona` INT NOT NULL ,
  PRIMARY KEY (`idDirector`, `Persona_idPersona`) ,
  UNIQUE INDEX `iddirector_UNIQUE` (`idDirector` ASC) ,
  INDEX `fk_director_Persona1_idx` (`Persona_idPersona` ASC) ,
  CONSTRAINT `fk_director_Persona1`
    FOREIGN KEY (`Persona_idPersona` )
    REFERENCES `Escuela`.`Persona` (`idPersona` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Escuela`.`profesor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Escuela`.`profesor` (
  `idprofesor` INT NOT NULL AUTO_INCREMENT ,
  `password` VARCHAR(45) NOT NULL ,
  `Persona_idPersona` INT NOT NULL ,
  PRIMARY KEY (`idprofesor`, `Persona_idPersona`) ,
  UNIQUE INDEX `idprofesor_UNIQUE` (`idprofesor` ASC) ,
  INDEX `fk_profesor_Persona1_idx` (`Persona_idPersona` ASC) ,
  CONSTRAINT `fk_profesor_Persona1`
    FOREIGN KEY (`Persona_idPersona` )
    REFERENCES `Escuela`.`Persona` (`idPersona` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Escuela`.`Encargado`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Escuela`.`encargado` (
  `idencargado` INT NOT NULL AUTO_INCREMENT,
  `Persona_idPersona` INT NOT NULL ,
  PRIMARY KEY (`idencargado`, `Persona_idPersona`) ,
  UNIQUE INDEX `idencargado_UNIQUE` (`idencargado` ASC) ,
  INDEX `fk_encargado_Persona1_idx` (`Persona_idPersona` ASC) ,
  CONSTRAINT `fk_encargado_Persona1`
    FOREIGN KEY (`Persona_idPersona` )
    REFERENCES `Escuela`.`Persona` (`idPersona` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `Escuela`.`alumno`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Escuela`.`alumno` (
  `idalumno` INT NOT NULL AUTO_INCREMENT,
  `Persona_idPersona` INT NOT NULL ,
  PRIMARY KEY (`idalumno`, `Persona_idPersona`) ,
  UNIQUE INDEX `idalumno_UNIQUE` (`idalumno` ASC) ,
  INDEX `fk_alumno_Persona1_idx` (`Persona_idPersona` ASC) ,
  CONSTRAINT `fk_alumno_Persona1`
    FOREIGN KEY (`Persona_idPersona` )
    REFERENCES `Escuela`.`Persona` (`idPersona` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Escuela`.`materia`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Escuela`.`materia` (
  `idmateria` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idmateria`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Escuela`.`profesor_materia`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Escuela`.`profesor_materia` (
  `profesor_idprofesor` INT NOT NULL ,
  `materia_idmateria` INT NOT NULL ,
  `annio` DATE NOT NULL ,
  `periodo` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`profesor_idprofesor`, `materia_idmateria`) ,
  INDEX `fk_profesor_has_materia_materia1_idx` (`materia_idmateria` ASC) ,
  INDEX `fk_profesor_has_materia_profesor1_idx` (`profesor_idprofesor` ASC) ,
  CONSTRAINT `fk_profesor_has_materia_profesor1`
    FOREIGN KEY (`profesor_idprofesor` )
    REFERENCES `Escuela`.`profesor` (`idprofesor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profesor_has_materia_materia1`
    FOREIGN KEY (`materia_idmateria` )
    REFERENCES `Escuela`.`materia` (`idmateria` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Escuela`.`alumno_materia`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Escuela`.`alumno_materia` (
  `alumno_idalumno` INT NOT NULL ,
  `materia_idmateria` INT NOT NULL ,
  `trimestre_1` DECIMAL NULL ,
  `trimestre_2` DECIMAL NULL ,
  `trimestre_3` DECIMAL NULL ,
  PRIMARY KEY (`alumno_idalumno`, `materia_idmateria`) ,
  INDEX `fk_alumno_has_materia_materia1_idx` (`materia_idmateria` ASC) ,
  INDEX `fk_alumno_has_materia_alumno1_idx` (`alumno_idalumno` ASC) ,
  CONSTRAINT `fk_alumno_has_materia_alumno1`
    FOREIGN KEY (`alumno_idalumno` )
    REFERENCES `Escuela`.`alumno` (`idalumno` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alumno_has_materia_materia1`
    FOREIGN KEY (`materia_idmateria` )
    REFERENCES `Escuela`.`materia` (`idmateria` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Escuela`.`beca`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Escuela`.`beca` (
  `idbeca` INT NOT NULL AUTO_INCREMENT ,
  `descripcion_beca` VARCHAR(45) NOT NULL ,
  `monto_beca` VARCHAR(45) NOT NULL ,
  `idAlumno` INT NOT NULL ,
  PRIMARY KEY (`idbeca`) ,
  INDEX `fk_beca_alumno_idx` (`idAlumno` ASC) ,
  CONSTRAINT `fk_beca_alumno`
    FOREIGN KEY (`idAlumno` )
    REFERENCES `Escuela`.`alumno` (`idalumno` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Escuela`.`grado`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Escuela`.`grado` (
  `idgrado` INT NOT NULL AUTO_INCREMENT ,
  `nombreGrado` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idgrado`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Escuela`.`grado_alumno`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Escuela`.`grado_alumno` (
  `grado_idgrado` INT NOT NULL ,
  `alumno_idalumno` INT NOT NULL ,
  `annio` DATE NULL ,
  PRIMARY KEY (`grado_idgrado`, `alumno_idalumno`) ,
  INDEX `fk_grado_has_alumno_alumno1_idx` (`alumno_idalumno` ASC) ,
  INDEX `fk_grado_has_alumno_grado1_idx` (`grado_idgrado` ASC) ,
  CONSTRAINT `fk_grado_has_alumno_grado1`
    FOREIGN KEY (`grado_idgrado` )
    REFERENCES `Escuela`.`grado` (`idgrado` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grado_has_alumno_alumno1`
    FOREIGN KEY (`alumno_idalumno` )
    REFERENCES `Escuela`.`alumno` (`idalumno` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `Escuela` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
