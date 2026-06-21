<?php
require_once __DIR__ . '/../Modelo/Model_Postulacion.php';

class Con_Postulacion {
    private Model_Postulacion $modelo;

    public function __construct() {
        $this->modelo = new Model_Postulacion();
    }

    public function obtenerPostulaciones() {
        return $this->modelo->obtenerPostulaciones();
    }
}
?>
