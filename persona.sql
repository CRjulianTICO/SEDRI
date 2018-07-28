-- phpMyAdmin SQL Dump
-- version 4.8.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 28-07-2018 a las 08:03:32
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `idPersona` int(11) NOT NULL,
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
  `disponible` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idPersona`, `cedula`, `nombre`, `apellido1`, `apellido2`, `sexo`, `direccion`, `telefono`, `telefono_secundario`, `email`, `idNacionalidad`, `disponible`) VALUES
(1, '1', 'Julian', 'Perez', '.Fernandez', 'Masculino', 'Heredia', '8', NULL, 'oscarsoto040797@gmail.com', 1, 1),
(2, '207680159', 'Oscar Mauricio', 'Soto', 'Leon', 'Masculino', 'Atenas\r\nCosta Rica', NULL, NULL, NULL, 1, 1),
(125, '88', '88', '88', '88', '88', '88', '88', NULL, '88', 1, 1),
(126, '100', 'Maestro', 'Apellido', 'Apellido ', 'Masculino', 'Atenas', '63103970', NULL, 'fran12@correo.com', 1, 1),
(127, '87', 'Oscar', 'Soto', 'Leon', 'Masculino', 'Alajuela\n					', 'tel', NULL, 'osoto777@email.com', 1, 1),
(128, '123', 'OSCAR PRUBEA', 'LEON', 'LEON', 'Masculino', 'Atenas\r\nCosta Rica', '63103970', NULL, '', 1, 1),
(197, '313131', '313131', '313131', '313131', '313131', '313131', '313131', NULL, '313131', 1, 1),
(198, '12222', '22222', '2222', '22222', 'Masculino', '122121', '22222', NULL, 'osoto656565', 1, 1),
(200, 'Prueba', 'Nombre de Prueba', 'Prueba 1', 'Prueba 2', 'Masculino', 'Atenas\r\nCosta Rica', 'Telefono de Prueba', NULL, 'Email@Prueba.com', 1, 1),
(202, '208040404', 'Ileana', 'Soto', 'Leon', 'Femenino', 'Ileana xdxdxdxd', '88923834', NULL, 'ileanasl3-@fmail.com', 2, 1),
(203, '300', 'Juliancito', '777', '777', 'Femenino', 'sadasd', '777', NULL, 'julian@gmail.com', 1, 1),
(205, '400', 'Pene', '1', '1', 'Masculino', 'A', 'A', NULL, 'A', 1, 1),
(208, '600', 'Nombre', 'Apellido', 'Apellido', 'Masculino', 'Direccion', 'Telefono', NULL, 'Email', 1, 1),
(211, '700', 'Nombre', 'Apellido', 'Apellido', 'Masculino', 'Direccion', 'Telefono', NULL, 'Emailxddxd', 1, 1),
(212, '800', 'Nombre', 'Apellido', 'Apellido', 'Masculino', 'Direccion', 'Telefono', NULL, 'Emailxddxd800', 1, 1),
(213, '2076800159', 'Oscar Eduardo', 'Soto', 'Leon', 'Masculino', 'Atenas, Alajuela Costa Rica', '25567876', NULL, 'oscarsoto@gmail.com', 1, 1),
(231, '9112', 'Nepe', '1', '1', 'Masculino', 'A', 'A', NULL, 'oscarsotasdaso@gmail.coms', 1, 1),
(232, '010203', '010203', '010203', '010203', 'Masculino', '010203', '010203', NULL, '010203', 1, 1),
(236, '0102', '010203', '010203', '010203', 'Femenino', '010203', '010203', NULL, '01020', 2, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idPersona`),
  ADD UNIQUE KEY `idPersona_UNIQUE` (`idPersona`),
  ADD UNIQUE KEY `cedula` (`cedula`),
  ADD UNIQUE KEY `cedula_2` (`cedula`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`),
  ADD KEY `idNacionalidad_idx` (`idNacionalidad`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idPersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=238;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `idNacionalidad` FOREIGN KEY (`idNacionalidad`) REFERENCES `nacionalidad` (`idNacionalidad`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
