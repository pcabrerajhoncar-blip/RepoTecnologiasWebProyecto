<?php
require_once '../Core/session.php';
require_once '../Controlador/Con_AnuncioCreado.php';
require_once '../Controlador/Con_AnuncioGuardado.php';
require_once '../Controlador/Con_Postulacion.php';
require_once '../Controlador/Con_Historial.php';

$idUsuarioActivo = obtenerIdUsuarioActivo();

$conAnuncio = new Con_AnuncioCreado();
$conGuardado = new Con_AnuncioGuardado();
$conPostulacion = new Con_Postulacion();
$conHistorial = new Con_Historial();

$mis_anuncios = $conAnuncio->obtenerAnuncios();
$categorias = $conAnuncio->obtenerCategorias();
$departamentos = $conAnuncio->obtenerDepartamentos();
$mis_postulaciones = $conPostulacion->obtenerPostulaciones();
$anuncios_favoritos = $conGuardado->obtenerAnunciosFavoritos();
$historial_postulaciones = $conHistorial->obtenerHistorial();
?>

<!DOCTYPE html> 
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chamba Ya </title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="estilos_Anuncios.css">
</head>
<body>

<!-- ESTE HEADER SERA REEMPLAZADO LUEGO -->
<!-- Header de la aplicación -->
    <header class="cabecera">
        <div class="logo"><i class="fas fa-bolt"></i> Chamba Ya</div>
        <nav class="navegacion-superior">
            <a href="#">Inicio</a>
            <a href="#">Explorar</a>
            <a href="#">Mensajes</a>
            <a href="#">Ayuda</a>
        </nav>
        <div class="cabecera-derecha">
            <div class="barra-busqueda">
                <i class="fas fa-search"></i>
                <input type="text" id="busqueda-global" placeholder="Buscar chamba..." oninput="filtrarAnuncios()">
            </div>
            <div class="perfil-usuario">
                <div class="avatar-usuario"><?php echo 'U' . $idUsuarioActivo; ?></div>
                <span>Usuario #<?php echo $idUsuarioActivo; ?></span>
            </div>
        </div>
    </header>
<!-- Fin de header -->

    <div class="contenedor-principal">
        <aside class="barra-lateral">
            <div class="seccion-lateral">
                <h4>Ajustes</h4>
                <div class="item-lateral" onclick="cambiarSeccion('datos', event)"><i class="fas fa-user-circle"></i> Mis Datos</div>
                <div class="item-lateral activo" onclick="cambiarSeccion('anuncios', event)"><i class="fas fa-bullhorn"></i> Anuncios Creados</div>
                <div class="item-lateral" onclick="cambiarSeccion('postulaciones', event)"><i class="fas fa-paper-plane"></i> Mis Postulaciones</div>
                <div class="item-lateral" onclick="cambiarSeccion('guardados', event)"><i class="fas fa-bookmark"></i> Anuncios Guardados</div>
                <div class="item-lateral" onclick="cambiarSeccion('historial', event)"><i class="fas fa-history"></i> Historial</div>
            </div>
            <div class="seccion-lateral">
                <h4>Seguridad</h4>
                <div class="item-lateral" onclick="cambiarSeccion('seguridad', event)"><i class="fas fa-shield-alt"></i> Seguridad</div>
                <div class="item-lateral" onclick="cambiarSeccion('preferencias', event)"><i class="fas fa-cog"></i> Preferencias</div>
            </div>
        </aside>




        <main class="contenido">
            <!-- SECCIONES DE LA APLICACIÓN -->
            <?php include_once 'secciones/anuncios.php'; ?>
            <?php include_once 'secciones/datos.php'; ?>
            <?php include_once 'secciones/guardados.php'; ?>
            <?php include_once 'secciones/postulaciones.php'; ?>
            <?php include_once 'secciones/historial.php'; ?>
            <?php include_once 'secciones/seguridad.php'; ?>
            <?php include_once 'secciones/preferencias.php'; ?>
        </main>
    </div>


    <!-- MODAL: CREAR ANUNCIO -->
    <div id="modal-crear" class="superposicion-modal">
        <div class="contenido-modal">
            <span class="cerrar-modal" onclick="cerrarModal('modal-crear')">&times;</span>
            <h3>Publicar Nueva Chamba</h3>
            <form id="formulario-anuncio" action="../Controlador/Con_AnuncioCreado.php" method="POST">
                <input type="hidden" name="id" id="form-id-anuncio">
                <div class="grupo-formulario">
                    <label>Título del Anuncio</label>
                    <input type="text" name="titulo" id="titulo-chamba" placeholder="Ej: Ayudante de cocina" required>
                </div>
                <div class="grupo-formulario">
                    <label>Descripción detallada</label>
                    <textarea name="descripcion" id="desc-chamba" rows="3" maxlength="200" oninput="actualizarContador(this)"></textarea>
                    <small id="contador-chars" class="contador-derecha">0/200</small>
                </div>
                <div class="fila-formulario">
                    <div class="grupo-formulario">
                        <label>Departamento</label>
                        <select name="departamento_id" id="departamento-chamba">
                            <option value="">Seleccione Departamento</option>
                            <?php foreach ($departamentos as $dep): ?>
                                <option value="<?php echo $dep['idDepartamento']; ?>">
                                    <?php echo htmlspecialchars($dep['nombre']); ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="grupo-formulario">
                        <label>Provincia</label>
                        <select name="provincia_id" id="provincia-chamba" disabled>
                            <option value="">Seleccione Provincia</option>
                        </select>
                    </div>
                </div>
                <div class="fila-formulario">
                    <div class="grupo-formulario">
                        <label>Distrito</label>
                        <select name="distrito_id" id="distrito-chamba" disabled required>
                            <option value="">Seleccione Distrito</option>
                        </select>
                    </div>
                    <div class="grupo-formulario">
                        <label>Dirección Específica</label>
                        <input type="text" name="direccion_especifica" id="direccion-especifica-chamba" placeholder="Ej: Av. Larco 123">
                    </div>
                </div>
                <div class="fila-formulario">
                    <div class="grupo-formulario">
                        <label>Pago Referencial (S/.)</label>
                        <input type="number" name="pago" id="pago-chamba" placeholder="0.00">
                    </div>
                    <div class="grupo-formulario">
                        <label>Modalidad</label>
                        <select name="modalidad" id="modalidad-chamba">
                            <option value="Presencial">Presencial</option>
                            <option value="Virtual">Virtual</option>
                        </select>
                    </div>
                </div>
                <div class="fila-formulario">
                    <div class="grupo-formulario">
                        <label>Tipo de Anuncio</label>
                        <select name="tipo" id="tipo-chamba">
                            <option value="Trabajo">Busco Empleado (Trabajo)</option>
                            <option value="Servicio">Ofrezco mis servicios</option>
                        </select>
                    </div>
                </div>
                <div class="grupo-formulario">
                    <label>Estado</label>
                    <select name="estado" id="estado-chamba">
                        <option value="activo">Activo</option>
                        <option value="oculto">Oculto</option>
                    </select>
                </div>
                <div class="grupo-formulario">
                    <label>Categorías</label>
                    <div class="selector-etiquetas">
                        <?php foreach ($categorias as $cat): ?>
                            <span class="opcion-etiqueta" onclick="agregarEtiqueta('<?php echo htmlspecialchars($cat['nombre'], ENT_QUOTES, 'UTF-8'); ?>', <?php echo $cat['idCategoria']; ?>)">
                                <?php echo htmlspecialchars($cat['nombre']); ?>
                            </span>
                        <?php endforeach; ?>
                    </div>
                    <div id="contenedor-etiquetas" class="selector-etiquetas"></div>
                    <input type="hidden" name="categorias_ids" id="categorias-ids" value="">
                </div>
                <button type="submit" class="boton-crear boton-ancho-total">Publicar Ahora</button>
            </form>
        </div>
    </div>

    <div id="contenedor-notificaciones"></div>
    <script src="script_Anuncios.js?v=<?php echo time(); ?>"></script>
    <?php if (isset($_GET['mensaje'])): ?>
    <script>
        document.addEventListener("DOMContentLoaded", () => {
            let msg = "";
            const m = "<?php echo htmlspecialchars($_GET['mensaje'], ENT_QUOTES, 'UTF-8'); ?>";
            if (m === "guardado") msg = "¡Anuncio publicado con éxito!";
            else if (m === "actualizado") msg = "¡Anuncio actualizado con éxito!";
            else if (m === "eliminado") msg = "¡Anuncio eliminado con éxito!";
            else if (m === "error_campos") msg = "Error: Por favor completa todos los campos obligatorios.";
            else if (m === "error_guardar") msg = "Error: No se pudo guardar el anuncio en la base de datos.";
            else if (m === "error_eliminar") msg = "Error: No se pudo eliminar el anuncio.";
            if (msg) mostrarNotificacion(msg);
        });
    </script>
    <?php endif; ?>
</body>
</html>
