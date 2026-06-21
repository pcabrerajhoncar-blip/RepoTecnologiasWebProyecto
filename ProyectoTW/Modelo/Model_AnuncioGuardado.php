<?php
require_once __DIR__ . '/../Core/conexion.php';

class Model_AnuncioGuardado {
    private $conn;

    public function __construct() {
        $Database = new DataBase();
        $this->conn = $Database->getConnection();
    }

    public function obtenerAnunciosFavoritos() {
        try {
            $stmt = $this->conn->prepare("
                SELECT a.idAnuncio as id, a.titulo, a.descripcion, a.estado, a.ubicacion, a.pagoReferencia, a.modalidad, a.tipoAnuncio,
                       GROUP_CONCAT(c.nombre ORDER BY c.idCategoria) as categorias_nombres
                FROM anunciosfavoritos f
                JOIN anuncio a ON f.idAnuncio = a.idAnuncio
                LEFT JOIN categoriasanuncio ca ON a.idAnuncio = ca.idAnuncio
                LEFT JOIN categoria c ON ca.idCategoria = c.idCategoria
                WHERE f.idUsuario = 1
                GROUP BY a.idAnuncio
                ORDER BY f.fechaGuardado DESC
            ");
            $stmt->execute();
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            error_log("Error al consultar favoritos: " . $e->getMessage());
            return [];
        }
    }
}
?>
