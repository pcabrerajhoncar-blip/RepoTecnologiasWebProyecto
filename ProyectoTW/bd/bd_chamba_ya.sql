-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 30-04-2026 a las 18:53:42
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_chamba_ya`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `anuncio`
--

CREATE TABLE `anuncio` (
  `idAnuncio` int(10) UNSIGNED NOT NULL,
  `tipoAnuncio` enum('Trabajo','Servicio') NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `ubicacion` varchar(300) DEFAULT NULL,
  `pagoReferencia` decimal(10,2) DEFAULT NULL,
  `modalidad` enum('Presencial','Virtual') DEFAULT NULL,
  `estado` enum('Disponible','En proceso','Finalizado','Cancelado') DEFAULT 'Disponible',
  `fechaPublicacion` datetime DEFAULT current_timestamp(),
  `idUsuario` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `anunciosfavoritos`
--

CREATE TABLE `anunciosfavoritos` (
  `idFavorito` int(10) UNSIGNED NOT NULL,
  `fechaGuardado` datetime DEFAULT current_timestamp(),
  `idUsuario` int(10) UNSIGNED NOT NULL,
  `idAnuncio` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calificacion`
--

CREATE TABLE `calificacion` (
  `idCalificacion` int(10) UNSIGNED NOT NULL,
  `puntaje` tinyint(4) NOT NULL,
  `comentario` text DEFAULT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `idUsuarioCalificado` int(10) UNSIGNED NOT NULL,
  `idUsuarioCalificador` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `idCategoria` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoriasanuncio`
--

CREATE TABLE `categoriasanuncio` (
  `idCategoriasAnuncio` int(10) UNSIGNED NOT NULL,
  `idCategoria` int(10) UNSIGNED NOT NULL,
  `idAnuncio` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `habilidad`
--

CREATE TABLE `habilidad` (
  `idHabilidad` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `categoria` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `postulacion`
--

CREATE TABLE `postulacion` (
  `idPostulacion` int(10) UNSIGNED NOT NULL,
  `estado` enum('Pendiente','Aceptado','Rechazado') DEFAULT 'Pendiente',
  `fecha` datetime DEFAULT current_timestamp(),
  `idAnuncio` int(10) UNSIGNED NOT NULL,
  `idUsuario` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `trabajadoresfavoritos`
--

CREATE TABLE `trabajadoresfavoritos` (
  `idTrabajadorFavorito` int(10) UNSIGNED NOT NULL,
  `fechaGuardado` datetime DEFAULT current_timestamp(),
  `idUsuarioCliente` int(10) UNSIGNED NOT NULL,
  `idUsuarioTrabajador` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `idUsuario` int(10) UNSIGNED NOT NULL,
  `fotoPerfil` varchar(255) DEFAULT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `descripcionPerfil` text DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `correo` varchar(80) NOT NULL,
  `password` varchar(255) NOT NULL,
  `direccionDomicilio` varchar(200) DEFAULT NULL,
  `codigoPostal` varchar(5) DEFAULT NULL,
  `departamento` varchar(50) DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `distrito` varchar(50) DEFAULT NULL,
  `fechaRegistro` datetime DEFAULT current_timestamp(),
  `estado` enum('Activo','Inactivo','Suspendido','Bloqueado') DEFAULT 'Activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuariohabilidad`
--

CREATE TABLE `usuariohabilidad` (
  `idHabilidadUser` int(10) UNSIGNED NOT NULL,
  `idUsuario` int(10) UNSIGNED NOT NULL,
  `idHabilidad` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `anuncio`
--
ALTER TABLE `anuncio`
  ADD PRIMARY KEY (`idAnuncio`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indices de la tabla `anunciosfavoritos`
--
ALTER TABLE `anunciosfavoritos`
  ADD PRIMARY KEY (`idFavorito`),
  ADD UNIQUE KEY `idUsuario` (`idUsuario`,`idAnuncio`),
  ADD KEY `idAnuncio` (`idAnuncio`);

--
-- Indices de la tabla `calificacion`
--
ALTER TABLE `calificacion`
  ADD PRIMARY KEY (`idCalificacion`),
  ADD KEY `idUsuarioCalificado` (`idUsuarioCalificado`),
  ADD KEY `idUsuarioCalificador` (`idUsuarioCalificador`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idCategoria`);

--
-- Indices de la tabla `categoriasanuncio`
--
ALTER TABLE `categoriasanuncio`
  ADD PRIMARY KEY (`idCategoriasAnuncio`),
  ADD UNIQUE KEY `idCategoria` (`idCategoria`,`idAnuncio`),
  ADD KEY `idAnuncio` (`idAnuncio`);

--
-- Indices de la tabla `habilidad`
--
ALTER TABLE `habilidad`
  ADD PRIMARY KEY (`idHabilidad`);

--
-- Indices de la tabla `postulacion`
--
ALTER TABLE `postulacion`
  ADD PRIMARY KEY (`idPostulacion`),
  ADD KEY `idAnuncio` (`idAnuncio`),
  ADD KEY `idUsuario` (`idUsuario`);

--
-- Indices de la tabla `trabajadoresfavoritos`
--
ALTER TABLE `trabajadoresfavoritos`
  ADD PRIMARY KEY (`idTrabajadorFavorito`),
  ADD UNIQUE KEY `idUsuarioCliente` (`idUsuarioCliente`,`idUsuarioTrabajador`),
  ADD KEY `idUsuarioTrabajador` (`idUsuarioTrabajador`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idUsuario`),
  ADD UNIQUE KEY `correo` (`correo`);

--
-- Indices de la tabla `usuariohabilidad`
--
ALTER TABLE `usuariohabilidad`
  ADD PRIMARY KEY (`idHabilidadUser`),
  ADD UNIQUE KEY `idUsuario` (`idUsuario`,`idHabilidad`),
  ADD KEY `idHabilidad` (`idHabilidad`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `anuncio`
--
ALTER TABLE `anuncio`
  MODIFY `idAnuncio` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `anunciosfavoritos`
--
ALTER TABLE `anunciosfavoritos`
  MODIFY `idFavorito` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `calificacion`
--
ALTER TABLE `calificacion`
  MODIFY `idCalificacion` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idCategoria` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `categoriasanuncio`
--
ALTER TABLE `categoriasanuncio`
  MODIFY `idCategoriasAnuncio` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `habilidad`
--
ALTER TABLE `habilidad`
  MODIFY `idHabilidad` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `postulacion`
--
ALTER TABLE `postulacion`
  MODIFY `idPostulacion` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `trabajadoresfavoritos`
--
ALTER TABLE `trabajadoresfavoritos`
  MODIFY `idTrabajadorFavorito` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idUsuario` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuariohabilidad`
--
ALTER TABLE `usuariohabilidad`
  MODIFY `idHabilidadUser` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `anuncio`
--
ALTER TABLE `anuncio`
  ADD CONSTRAINT `anuncio_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `anunciosfavoritos`
--
ALTER TABLE `anunciosfavoritos`
  ADD CONSTRAINT `anunciosfavoritos_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `anunciosfavoritos_ibfk_2` FOREIGN KEY (`idAnuncio`) REFERENCES `anuncio` (`idAnuncio`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `calificacion`
--
ALTER TABLE `calificacion`
  ADD CONSTRAINT `calificacion_ibfk_1` FOREIGN KEY (`idUsuarioCalificado`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `calificacion_ibfk_2` FOREIGN KEY (`idUsuarioCalificador`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `categoriasanuncio`
--
ALTER TABLE `categoriasanuncio`
  ADD CONSTRAINT `categoriasanuncio_ibfk_1` FOREIGN KEY (`idCategoria`) REFERENCES `categoria` (`idCategoria`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `categoriasanuncio_ibfk_2` FOREIGN KEY (`idAnuncio`) REFERENCES `anuncio` (`idAnuncio`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `postulacion`
--
ALTER TABLE `postulacion`
  ADD CONSTRAINT `postulacion_ibfk_1` FOREIGN KEY (`idAnuncio`) REFERENCES `anuncio` (`idAnuncio`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `postulacion_ibfk_2` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `trabajadoresfavoritos`
--
ALTER TABLE `trabajadoresfavoritos`
  ADD CONSTRAINT `trabajadoresfavoritos_ibfk_1` FOREIGN KEY (`idUsuarioCliente`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `trabajadoresfavoritos_ibfk_2` FOREIGN KEY (`idUsuarioTrabajador`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuariohabilidad`
--
ALTER TABLE `usuariohabilidad`
  ADD CONSTRAINT `usuariohabilidad_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usuariohabilidad_ibfk_2` FOREIGN KEY (`idHabilidad`) REFERENCES `habilidad` (`idHabilidad`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
