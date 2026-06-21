-- 1. Insertar un usuario de prueba (necesario para los anuncios)
INSERT INTO `usuario` (`idUsuario`, `nombres`, `apellidos`, `correo`, `password`, `estado`) 
VALUES (1, 'Juan', 'Doe', 'juan@correo.com', '123456', 'Activo');

-- 2. Insertar anuncios de prueba vinculados al usuario 1
INSERT INTO `anuncio` (`tipoAnuncio`, `titulo`, `descripcion`, `ubicacion`, `pagoReferencia`, `modalidad`, `estado`, `idUsuario`) 
VALUES 
('Trabajo', 'Gasfitero para San Juan', 'Se requiere arreglo de tuberías urgente para hoy tarde.', 'San Juan de Lurigancho', 50.00, 'Presencial', 'Disponible', 1),
('Servicio', 'Pintor de fachadas', 'Busco personal con experiencia en alturas para proyecto de 3 días.', 'Chiclayo', 120.00, 'Presencial', 'Disponible', 1);

-- 3. Insertar categorías
INSERT INTO `categoria` (`nombre`) VALUES ('Construcción'), ('Limpieza'), ('Mantenimiento');

-- 4. Vincular anuncios con categorías
INSERT INTO `categoriasanuncio` (`idCategoria`, `idAnuncio`) VALUES (3, 1), (1, 2);

-- 5. Insertar una postulación de prueba
-- El usuario 1 se postula a su propio anuncio (solo para ejemplo visual)
INSERT INTO `postulacion` (`estado`, `idAnuncio`, `idUsuario`) 
VALUES ('Pendiente', 1, 1);

-- 6. Insertar un anuncio favorito de prueba
-- El usuario 1 guarda el anuncio 2 (Pintor de fachadas)
INSERT INTO `anunciosfavoritos` (`idUsuario`, `idAnuncio`)
VALUES (1, 2);