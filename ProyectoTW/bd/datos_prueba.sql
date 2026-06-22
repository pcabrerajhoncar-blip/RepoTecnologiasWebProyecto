SET FOREIGN_KEY_CHECKS = 0; -- Desactivamos temporalmente para evitar conflictos de orden

-- ========================================================
-- 1. TABLA: usuario (10 usuarios apuntando a idDistrito ya existentes)
-- ========================================================
INSERT INTO `usuario` (`idUsuario`, `fotoPerfil`, `nombres`, `apellidos`, `descripcionPerfil`, `telefono`, `correo`, `password`, `direccionDomicilio`, `codigoPostal`, `estado`, `idDistrito`) VALUES
(1, 'juan_perez.png', 'Juan Carlos', 'Pérez Ramos', 'Técnico certificado en redes, soporte de PC y gasfitería. Soluciones rápidas a domicilio.', '945123456', 'juan.perez@email.com', '$2y$10$xyz123abc456hash', 'Av. Sáenz Peña 1420', '14001', 'Activo', 140101), -- Chiclayo
(2, 'user2.png', 'Ana María', 'Delgado Cotrina', 'Administradora de locales comerciales en el centro. Busco técnicos de confianza.', '978456123', 'ana.delgado@email.com', '$2y$10$xyz123abc456hash', 'Calle San Martín 455', '14001', 'Activo', 140101), -- Chiclayo
(3, 'user3.png', 'Marcos Alberto', 'Villalobos Ruiz', 'Propietario de restaurante norteño. Busco soporte técnico e instalaciones.', '963852741', 'marcos.restobar@email.com', '$2y$10$xyz123abc456hash', 'Av. Quiñones 780', '14005', 'Activo', 140112), -- Pimentel
(4, 'user4.png', 'Luis Alberto', 'Castillo Vigo', 'Desarrollador de software experimentado. Busco asistentes técnicos para proyectos.', '951753456', 'luis.dev@email.com', '$2y$10$xyz123abc456hash', 'Av. Chiclayo 120', '14002', 'Activo', 140105), -- José Leonardo Ortiz
(5, 'user5.png', 'Sofía Elena', 'Castro Mendoza', 'Ofrezco servicios de diseño gráfico y community manager.', '987654321', 'sofia.design@email.com', '$2y$10$xyz123abc456hash', 'Calle Elvira García 230', '14001', 'Activo', 140101), -- Chiclayo
(6, 'user6.png', 'Carlos Daniel', 'Palacios Paz', 'Maestro de obra y contratista general en Chiclayo.', '954123987', 'carlos.obra@email.com', '$2y$10$xyz123abc456hash', 'Jr. Trujillo 540', '14001', 'Activo', 140101), -- Chiclayo
(7, 'user7.png', 'Estefany', 'Guevara Díaz', 'Estudiante de administración. Busco profesores particulares y apoyo técnico.', '989786453', 'tefa.admin@email.com', '$2y$10$xyz123abc456hash', 'Av. Luis Gonzales 310', '14001', 'Activo', 140101), -- Chiclayo
(8, 'user8.png', 'Ricardo', 'Ganoza Vega', 'Contador público. Ofrezco asesorías tributarias a microempresas.', '932145678', 'ricardo.cpa@email.com', '$2y$10$xyz123abc456hash', 'Calle Los Pinos 233', '14005', 'Activo', 140112), -- Pimentel
(9, 'user9.png', 'Lucía Fernanda', 'Romero Santisteban', 'Coordinadora de eventos corporativos y ferias locales.', '915926535', 'lucia.events@email.com', '$2y$10$xyz123abc456hash', 'Condominio Los Parques Mz F', '14001', 'Activo', 140106), -- La Victoria
(10, 'user10.png', 'Alejandro', 'Merino Ruiz', 'Propietario de tiendas de tecnología en Las Malvinas.', '953284617', 'alejo.tech@email.com', '$2y$10$xyz123abc456hash', 'Jr. Huánuco 890', '15001', 'Activo', 150101); -- Cercado de Lima

-- ========================================================
-- 2. TABLA: categoria (8 Categorías maestras)
-- ========================================================
INSERT INTO `categoria` (`idCategoria`, `nombre`) VALUES
(1, 'Soporte y Tecnología'),
(2, 'Mantenimiento y Oficios'),
(3, 'Servicios Domésticos'),
(4, 'Diseño y Medios'),
(5, 'Educación y Tutorías'),
(6, 'Construcción y Remodelación'),
(7, 'Legal y Contabilidad'),
(8, 'Eventos y Gastronomía');

-- ========================================================
-- 3. TABLA: habilidad (12 Habilidades específicas)
-- ========================================================
INSERT INTO `habilidad` (`idHabilidad`, `nombre`, `categoria`) VALUES
(1, 'Configuración de Redes y Routers', 'Tecnología'),
(2, 'Mantenimiento de PC y Laptops', 'Tecnología'),
(3, 'Gasfitería y Plomería', 'Mantenimiento'),
(4, 'Instalaciones Eléctricas', 'Mantenimiento'),
(5, 'Desarrollo en PHP y MySQL', 'Tecnología'),
(6, 'Diseño de Logotipos e Identidad', 'Diseño'),
(7, 'Contabilidad Integral y SUNAT', 'Contabilidad'),
(8, 'Pintura y Tarrajeo de Paredes', 'Construcción'),
(9, 'Limpieza profunda de inmuebles', 'Servicios Domésticos'),
(10, 'Repostería Comercial', 'Gastronomía'),
(11, 'Fotografía Profesional', 'Diseño'),
(12, 'Ensamblaje de Computadoras a medida', 'Tecnología');

-- ========================================================
-- 4. TABLA: usuariohabilidad (Asociando habilidades a los usuarios)
-- ========================================================
INSERT INTO `usuariohabilidad` (`idHabilidadUser`, `idUsuario`, `idHabilidad`) VALUES
(1, 1, 1),  -- Juan sabe Redes
(2, 1, 2),  -- Juan sabe Soporte PC
(3, 1, 3),  -- Juan sabe Gasfitería
(4, 1, 12), -- Juan sabe Ensamblaje
(5, 4, 5),  -- Luis sabe PHP
(6, 5, 6),  -- Sofía sabe Diseño
(7, 8, 7),  -- Ricardo sabe Contabilidad
(8, 6, 8);  -- Carlos sabe Pintura

-- ========================================================
-- 5. TABLA: anuncio (15 Anuncios vinculados a idDistrito)
-- ========================================================
INSERT INTO `anuncio` (`idAnuncio`, `tipoAnuncio`, `titulo`, `descripcion`, `direccionEspecifica`, `pagoReferencia`, `modalidad`, `estado`, `idUsuario`, `idDistrito`) VALUES
-- SERVICIOS OFRECIDOS POR JUAN (idUsuario = 1)
(1, 'Servicio', 'Soporte Técnico de Computadoras y Redes', 'Mantenimiento preventivo y correctivo de PCs, eliminación de virus, configuración de routers e instalaciones cableadas.', 'A domicilio en todo Chiclayo y JLO', 50.00, 'Presencial', 'Disponible', 1, 140101),
(2, 'Servicio', 'Servicio de Gasfitería y Desatoro Urgente', 'Reparación de fugas de agua, instalación de grifería, tanques elevados y desatoro de tuberías principales. Atención 24 horas.', 'Atención Chiclayo centro y alrededores', 40.00, 'Presencial', 'Disponible', 1, 140101),
(3, 'Servicio', 'Ensamblaje y Asesoría de Computadoras Gamer/Trabajo', 'Te ayudo a elegir los mejores componentes en el mercado local y armo tu PC optimizando tu presupuesto al máximo.', 'Urb. Primavera / Remoto', 60.00, 'Presencial', 'Disponible', 1, 140112),

-- TRABAJOS PUBLICADOS POR JUAN (idUsuario = 1) BUSCANDO CONTRATAR AYUDANTES
(4, 'Trabajo', 'Busco ayudante para cableado estructurado en oficina', 'Necesito un asistente temporal por dos días para apoyar pasando cables de red y ponchado de jacks en edificio céntrico.', 'Calle Balta 1240, 3er piso', 70.00, 'Presencial', 'En proceso', 1, 140101),
(5, 'Trabajo', 'Necesito diseño de logotipo para mi marca personal', 'Busco diseñador para crear el logo e identidad visual de mis servicios técnicos "Juan Soporte". Enviar portafolio.', 'Trabajo desde casa / Remoto', 120.00, 'Virtual', 'Disponible', 1, NULL),

-- TRABAJOS PUBLICADOS POR OTROS (Donde Juan va a interactuar/postular)
(6, 'Trabajo', 'Urgente: Configuración de red local en Restaurante', 'El sistema de comandas no conecta con la ticketera de cocina. Se requiere técnico de redes para hoy mismo.', 'Av. Quiñones 450 (Ref: Frente al malecón)', 90.00, 'Presencial', 'Disponible', 3, 140112), -- Pimentel
(7, 'Trabajo', 'Mantenimiento de 5 computadoras de oficina', 'Se solicita limpieza física y formateo de 5 PCs en local comercial del centro de Chiclayo. Fines de semana.', 'Calle San Martín 820', 250.00, 'Presencial', 'Disponible', 2, 140101), -- Chiclayo
(8, 'Trabajo', 'Instalación de tuberías para cocina remodelada', 'Se busca gasfitero para instalar puntos de agua fría y caliente en una cocina que acaba de ser tarrajeada.', 'Urb. Santa Victoria - Calle Los Jacarandas', 150.00, 'Presencial', 'Disponible', 6, 140101), -- Chiclayo
(9, 'Trabajo', 'Asistencia para migración de base de datos MySQL', 'Necesito soporte técnico para optimizar un script de base de datos e inserción masiva de registros.', 'Asesoría vía Meet / Zoom', 100.00, 'Virtual', 'Disponible', 4, NULL), -- Virtual sin distrito fijo
(10, 'Trabajo', 'Fotógrafo para inauguración de tienda de tecnología', 'Evento de 4 horas en el centro comercial. Se requiere entrega de fotos editadas en 3 días.', 'CC. Real Plaza Chiclayo - Av. Miguel de Cervantes', 180.00, 'Presencial', 'Disponible', 10, 140101),

-- OTROS SERVICIOS PUBLICADOS POR LA COMUNIDAD (Para favoritos de Juan)
(11, 'Servicio', 'Diseño Gráfico Profesional para Redes Sociales', 'Paquetes mensuales de posts e historias para negocios y emprendimientos.', 'Atención a nivel nacional vía canales digitales', 200.00, 'Virtual', 'Disponible', 5, NULL),
(12, 'Servicio', 'Asesoría SUNAT y Declaración Mensual MYPES', 'Evita multas. Llevo tus libros electrónicos y declaraciones de forma transparente.', 'Consultas virtuales / Lambayeque', 80.00, 'Virtual', 'Disponible', 8, 140301), -- Lambayeque distrito
(13, 'Servicio', 'Pintura residencial y acabados de primera', 'Pintado de fachadas, interiores, empastado y reparación de humedad.', 'Servicio en todo Chiclayo, La Victoria y JLO', 15.00, 'Presencial', 'Disponible', 6, 140106), -- La Victoria
(14, 'Servicio', 'Limpieza profunda por mudanza o post-obra', 'Limpiamos tu casa, departamento o local dejándolo impecable. Incluye desinfección.', 'Coordinación directa a domicilio', 120.00, 'Presencial', 'Disponible', 2, 140101),
(15, 'Servicio', 'Organización integral de catering para eventos', 'Ofrecemos bocaditos norteños, mozos y decoración para reuniones.', 'Despacho desde Urbanización Los Parques', 500.00, 'Presencial', 'Disponible', 9, 140101);

-- ========================================================
-- 6. TABLA: categoriasanuncio (Cruces de Categoría y Anuncio)
-- ========================================================
INSERT INTO `categoriasanuncio` (`idCategoriasAnuncio`, `idCategoria`, `idAnuncio`) VALUES
(1, 1, 1),   -- Anuncio 1 -> Soporte y Tecnología
(2, 2, 2),   -- Anuncio 2 -> Mantenimiento y Oficios
(3, 1, 3),   -- Anuncio 3 -> Soporte y Tecnología
(4, 1, 4),   -- Anuncio 4 -> Soporte y Tecnología
(5, 4, 5),   -- Anuncio 5 -> Diseño y Medios
(6, 1, 6),   -- Anuncio 6 -> Soporte y Tecnología
(7, 1, 7),   -- Anuncio 7 -> Soporte y Tecnología
(8, 2, 8),   -- Anuncio 8 -> Mantenimiento y Oficios
(9, 1, 9),   -- Anuncio 9 -> Soporte y Tecnología
(10, 4, 10), -- Anuncio 10 -> Diseño y Medios
(11, 4, 11), -- Anuncio 11 -> Diseño y Medios
(12, 7, 12), -- Anuncio 12 -> Legal y Contabilidad
(13, 6, 13), -- Anuncio 13 -> Construcción
(14, 3, 14), -- Anuncio 14 -> Servicios Domésticos
(15, 8, 15); -- Anuncio 15 -> Eventos

-- ========================================================
-- 7. TABLA: postulacion (El flujo de postulaciones de Juan)
-- ========================================================
INSERT INTO `postulacion` (`idPostulacion`, `estado`, `idAnuncio`, `idUsuario`) VALUES
-- Usuarios que postulan al trabajo que publicó Juan (Anuncio 4)
(1, 'Aceptado', 4, 6),  -- Carlos (id 6) aceptado por Juan
(2, 'Rechazado', 4, 7), -- Estefany (id 7) rechazada por Juan

-- Juan Carlos (id 1) postulando a las ofertas de trabajo del entorno
(3, 'Pendiente', 6, 1), -- Juan postuló al restaurante de Marcos (Pendiente)
(4, 'Aceptado', 7, 1),  -- Juan postuló al soporte de PCs de Ana (Aceptado)
(5, 'Rechazado', 8, 1), -- Juan postuló al trabajo de Carlos (Rechazado)
(6, 'Pendiente', 9, 1); -- Juan postuló al soporte MySQL de Luis (Pendiente)

-- ========================================================
-- 8. TABLA: calificacion (Reputación de Juan)
-- ========================================================
INSERT INTO `calificacion` (`idCalificacion`, `puntaje`, `comentario`, `idUsuarioCalificado`, `idUsuarioCalificador`) VALUES
(1, 5, 'Excelente técnico de PCs. Formateó las computadoras de la oficina rápido y ordenado. Muy recomendado.', 1, 2), -- Ana califica a Juan
(2, 5, 'Vino a mi local por una emergencia de red y lo solucionó al instante. Muy profesional.', 1, 3),        -- Marcos califica a Juan
(3, 5, 'Excelente ayudante en la obra de cableado. Conoce de herramientas y es muy puntual.', 6, 1),        -- Juan califica a Carlos
(4, 4, 'Buena cliente. Dio las especificaciones claras del soporte y pagó puntual lo acordado.', 2, 1);     -- Juan califica a Ana

-- ========================================================
-- 9. TABLA: anunciosfavoritos (Marcadores de anuncios)
-- ========================================================
INSERT INTO `anunciosfavoritos` (`idFavorito`, `idUsuario`, `idAnuncio`) VALUES
(1, 1, 11), -- Juan guardó el diseño de Sofía
(2, 1, 12), -- Juan guardó la asesoría de Ricardo
(3, 2, 1),  -- Ana guardó el soporte técnico de Juan
(4, 3, 2);  -- Marcos guardó la gasfitería de Juan

-- ========================================================
-- 10. TABLA: trabajadoresfavoritos (Contactos agendados)
-- ========================================================
INSERT INTO `trabajadoresfavoritos` (`idTrabajadorFavorito`, `idUsuarioCliente`, `idUsuarioTrabajador`) VALUES
(1, 2, 1),  -- Ana guardó a Juan
(2, 3, 1),  -- Marcos guardó a Juan
(3, 1, 6);  -- Juan guardó a Carlos

SET FOREIGN_KEY_CHECKS = 1; -- Volvemos a activar las restricciones de seguridad
COMMIT;