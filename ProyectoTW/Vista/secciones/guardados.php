<!-- SECCIÓN: GUARDADOS -->
<section id="seccion-guardados" class="vista-seccion">
    <div class="encabezado-seccion"><h2>Anuncios Guardados</h2></div>
    <div id="lista-anuncios-guardados">
        <?php if (empty($anuncios_favoritos)): ?>
            <p>No tienes anuncios guardados todavía.</p>
        <?php else: ?>
            <?php foreach ($anuncios_favoritos as $fav): ?>
                <div class="tarjeta-horizontal">
                    <div class="imagen-tarjeta"><i class="fas fa-bookmark fa-2x" style="color: var(--purpura-principal);"></i></div>
                    <div class="cuerpo-tarjeta">
                        <h3><?php echo htmlspecialchars($fav['titulo']); ?></h3>
                        <p><?php echo htmlspecialchars($fav['descripcion']); ?></p>
                        <span class="etiqueta-estado estado-<?php echo $fav['estado']; ?>">
                            <?php echo ucfirst($fav['estado']); ?>
                        </span>
                        <?php if (!empty($fav['categorias_nombres'])): ?>
                            <div style="margin-top: 8px; display: flex; gap: 5px; flex-wrap: wrap;">
                                <?php foreach (explode(',', $fav['categorias_nombres']) as $cat_nom): ?>
                                    <span class="etiqueta-estado estado-info" style="font-size: 0.7rem; padding: 2px 8px;">
                                        <?php echo htmlspecialchars($cat_nom); ?>
                                    </span>
                                <?php endforeach; ?>
                            </div>
                        <?php endif; ?>
                    </div>
                </div>
            <?php endforeach; ?>
        <?php endif; ?>
    </div>
</section>
