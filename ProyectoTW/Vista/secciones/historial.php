<!-- SECCIÓN: HISTORIAL -->
<section id="seccion-historial" class="vista-seccion">
    <div class="encabezado-seccion"><h2>Historial de Postulaciones</h2></div>
    <p style="margin-bottom: 20px; color: var(--texto-secundario); font-size: 0.9rem;">
        Aquí se muestran las postulaciones aceptadas y rechazadas con más de 3 meses de antigüedad.
    </p>
    <div id="lista-historial">
        <?php if (empty($historial_postulaciones)): ?>
            <p>No tienes postulaciones antiguas en tu historial (más de 3 meses de antigüedad).</p>
        <?php else: ?>
            <?php foreach ($historial_postulaciones as $postulacion): ?>
                <div class="tarjeta-horizontal">
                    <div class="imagen-tarjeta"><i class="fas fa-history" style="color: var(--texto-secundario);"></i></div>
                    <div class="cuerpo-tarjeta">
                        <h3><?php echo htmlspecialchars($postulacion['puesto']); ?></h3>
                        <p>Postulado el <?php echo date('d M Y', strtotime($postulacion['fecha'])); ?></p>
                        <span class="etiqueta-estado estado-<?php echo strtolower($postulacion['estado']); ?>">
                            <?php echo ucfirst($postulacion['estado']); ?>
                        </span>
                    </div>
                </div>
            <?php endforeach; ?>   
        <?php endif; ?>
    </div>
</section>
