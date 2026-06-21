<!-- SECCIÓN: MIS POSTULACIONES -->
<section id="seccion-postulaciones" class="vista-seccion">
    <div class="encabezado-seccion"><h2>Mis Postulaciones</h2></div>
        <?php if (empty($mis_postulaciones)): ?>
                <p>No tienes postulaciones activas.</p>
        <?php else: ?>
            <?php foreach ($mis_postulaciones as $postulacion): ?>
                <div class="tarjeta-horizontal">
                    <div class="imagen-tarjeta"><i class="fas fa-briefcase"></i></div>
                    <div class="cuerpo-tarjeta">
                        <h3><?php echo htmlspecialchars($postulacion['puesto']); ?></h3>
                        <p>Postulado el <?php echo date('d M Y', strtotime($postulacion['fecha'])); ?></p>
                        <span class="etiqueta-estado estado-<?php echo $postulacion['estado']; ?>">
                            <?php echo ucfirst($postulacion['estado']); ?>
                        </span>
                    </div>
                    <div class="acciones-tarjeta">
                        <button class="boton-accion" onclick="alert('Abriendo chat...')"><i class="fas fa-comment"></i> Chat</button>
                    </div>
                </div>
            <?php endforeach; ?>   
        <?php endif; ?>                   
</section>
