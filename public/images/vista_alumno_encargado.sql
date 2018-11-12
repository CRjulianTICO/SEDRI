-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 11-11-2018 a las 06:20:21
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

-- --------------------------------------------------------

--
-- Estructura para la vista `vista_alumno_encargado`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vista_alumno_encargado`  AS  select `p2`.`cedula` AS `cedula`,`a`.`idalumno` AS `idalumno`,concat(`p`.`nombre`,' ',`p`.`apellido1`,' ',`p`.`apellido2`) AS `nombre`,`gen`.`idGrado` AS `idGrado` from (((((`persona` `p` join `alumno` `a`) join `grado_estudiante_nota` `gen`) join `alumno_encargado` `ae`) join `persona` `p2`) join `encargado` `e`) where ((`p`.`idPersona` = `a`.`Persona_idPersona`) and (`a`.`idalumno` = `gen`.`idEstudiante`) and (`ae`.`ID_ENCARGADO` = `e`.`idencargado`) and (`ae`.`ID_ALUMNO` = `a`.`idalumno`) and (`e`.`Persona_idPersona` = `p2`.`idPersona`)) group by `gen`.`idEstudiante` ;

--
-- VIEW  `vista_alumno_encargado`
-- Datos: Ninguna
--

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
