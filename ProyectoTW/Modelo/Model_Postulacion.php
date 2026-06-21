<?php
require_once __DIR__ . '/../Core/conexion.php';

class Model_Postulacion {
    private $conn;

    public function __construct() {
        $Database = new DataBase();
        $this->conn = $Database->getConnection();
    }

    public function obtenerPostulaciones() {
        try {
            $stmt = $this->conn->prepare("
                SELECT p.idPostulacion, p.estado, p.fecha, a.titulo AS puesto
                FROM postulacion p
                JOIN anuncio a ON p.idAnuncio = a.idAnuncio
                WHERE p.idUsuario = 1
                  AND (p.estado = 'Pendiente' OR p.fecha >= DATE_SUB(NOW(), INTERVAL 3 MONTH))
                ORDER BY p.fecha DESC
            ");
            $stmt->execute();
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            error_log("Error al consultar postulaciones: " . $e->getMessage());
            return [];
        }
    }
}
?>
