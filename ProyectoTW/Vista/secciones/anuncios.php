<!-- SECCIÓN: ANUNCIOS CREADOS -->
<section id="seccion-anuncios" class="vista-seccion activo">
    <button class="boton-crear" onclick="prepararCreacion()"><i class="fas fa-plus"></i> Crear Nuevo Anuncio</button>
    <div class="encabezado-seccion">
        <h2>Anuncios Activos</h2>    
    </div>
    <div id="lista-anuncios">
        <?php if (empty($mis_anuncios)): ?>
            <p>No tienes anuncios creados todavía.</p>
        <?php else: ?>
            <?php foreach ($mis_anuncios as $anuncio): ?>
                <div class="tarjeta-horizontal">
                    <div class="imagen-tarjeta"><i class="fas fa-image fa-2x"></i></div>
                    <div class="cuerpo-tarjeta">
                        <h3><?php echo htmlspecialchars($anuncio['titulo']); ?></h3>
                        <p><?php echo htmlspecialchars($anuncio['descripcion']); ?></p>
                        <?php if (!empty($anuncio['distrito_nombre'])): ?>
                            <p style="font-size: 0.85rem; color: #666; margin-top: 4px; display: flex; align-items: center; gap: 4px;">
                                <i class="fas fa-map-marker-alt" style="color: var(--purpura-principal);"></i> 
                                <?php 
                                    $loc = htmlspecialchars($anuncio['distrito_nombre']);
                                    if (!empty($anuncio['provincia_nombre'])) $loc .= ', ' . htmlspecialchars($anuncio['provincia_nombre']);
                                    if (!empty($anuncio['departamento_nombre'])) $loc .= ' - ' . htmlspecialchars($anuncio['departamento_nombre']);
                                    if (!empty($anuncio['direccionEspecifica'])) $loc .= ' (' . htmlspecialchars($anuncio['direccionEspecifica']) . ')';
                                    echo $loc;
                                ?>
                            </p>
                        <?php endif; ?>
                        <span class="etiqueta-estado estado-<?php echo $anuncio['estado']; ?>">
                            <?php echo ucfirst($anuncio['estado']); ?>
                        </span>
                    </div>
                    <div class="acciones-tarjeta">
                        <button class="boton-accion" title="Editar" onclick="abrirEdicion(this)"
                                data-id="<?php echo $anuncio['id']; ?>"
                                data-titulo="<?php echo htmlspecialchars($anuncio['titulo'], ENT_QUOTES, 'UTF-8'); ?>"
                                data-descripcion="<?php echo htmlspecialchars($anuncio['descripcion'], ENT_QUOTES, 'UTF-8'); ?>"
                                data-estado="<?php echo $anuncio['estado']; ?>"
                                data-departamento_id="<?php echo $anuncio['idDepartamento'] ?? ''; ?>"
                                data-provincia_id="<?php echo $anuncio['idProvincia'] ?? ''; ?>"
                                data-distrito_id="<?php echo $anuncio['idDistrito'] ?? ''; ?>"
                                data-direccion_especifica="<?php echo htmlspecialchars($anuncio['direccionEspecifica'] ?? '', ENT_QUOTES, 'UTF-8'); ?>"
                                data-pago="<?php echo $anuncio['pagoReferencia']; ?>"
                                data-modalidad="<?php echo $anuncio['modalidad']; ?>"
                                data-tipo="<?php echo $anuncio['tipoAnuncio']; ?>"
                                data-categorias_ids="<?php echo htmlspecialchars($anuncio['categorias_ids'] ?? '', ENT_QUOTES, 'UTF-8'); ?>"
                                data-categorias_nombres="<?php echo htmlspecialchars($anuncio['categorias_nombres'] ?? '', ENT_QUOTES, 'UTF-8'); ?>">
                            <i class="fas fa-edit"></i>
                        </button>
                        <form action="../Controlador/Con_AnuncioCreado.php" method="POST" class="form-eliminar">
                            <input type="hidden" name="id" value="<?php echo $anuncio['id']; ?>">
                            <input type="hidden" name="accion" value="eliminar">
                            <button class="boton-accion" type="submit" onclick="return confirm('¿Estás seguro de que quieres eliminar este anuncio?');">
                                <i class="fas fa-trash"></i>
                            </button>
                        </form>
                    </div> 
                </div>
            <?php endforeach; ?>
        <?php endif; ?>
    </div>
</section>
