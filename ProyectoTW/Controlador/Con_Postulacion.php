<?php
require_once __DIR__ . '/../Modelo/Model_Postulacion.php';
require_once __DIR__ . '/../Core/session.php';

class Con_Postulacion {
    private Model_Postulacion $modelo;

    public function __construct() {
        $this->modelo = new Model_Postulacion();
    }

    public function obtenerPostulaciones() {
        $idUsuario = obtenerIdUsuarioActivo();
        return $this->modelo->obtenerPostulaciones($idUsuario);
    }
}
?>
