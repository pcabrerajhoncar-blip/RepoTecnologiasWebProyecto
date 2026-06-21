<?php
require_once __DIR__ . '/../Modelo/Model_Historial.php';

class Con_Historial {
    private Model_Historial $modelo;

    public function __construct() {
        $this->modelo = new Model_Historial();
    }

    public function obtenerHistorial() {
        return $this->modelo->obtenerHistorialPostulaciones();
    }
}
?>
