<?php
require_once __DIR__ . '/../Core/conexion.php';

class Model_AnuncioCreado {
    private $conn;

    public function __construct() {
        $Database = new DataBase();
        $this->conn = $Database->getConnection();
    }

    public function guardarAnuncio($titulo, $descripcion, $estado, $ubicacion, $pago, $modalidad, $tipo) {
        try { 
            $sql = "INSERT INTO anuncio (titulo, descripcion, estado, ubicacion, pagoReferencia, modalidad, tipoAnuncio, idUsuario) VALUES (?, ?, ?, ?, ?, ?, ?, 1)";
            $stmt = $this->conn->prepare($sql); 
            if ($stmt->execute([$titulo, $descripcion, $estado, $ubicacion, $pago, $modalidad, $tipo])) {
                return $this->conn->lastInsertId();
            } else {
                throw new Exception("Error al insertar el anuncio");
            }   
        } catch (Exception $e) {
            throw new Exception("Error al guardar: " . $e->getMessage());
        }
    }

    public function actualizarAnuncio($id, $titulo, $descripcion, $estado, $ubicacion, $pago, $modalidad, $tipo) {
        try {
            $sql = "UPDATE anuncio SET titulo=?, descripcion=?, estado=?, ubicacion=?, pagoReferencia=?, modalidad=?, tipoAnuncio=? WHERE idAnuncio=?";
            $stmt = $this->conn->prepare($sql);
            if ($stmt->execute([$titulo, $descripcion, $estado, $ubicacion, $pago, $modalidad, $tipo, $id])) {
                return true;
            } else {
                throw new Exception("Error al actualizar el anuncio");
            }
        } catch (Exception $e) {
            throw new Exception("Error al actualizar: " . $e->getMessage());
        }
    }

    public function eliminarAnuncio($id) {
        try {
            $sql = "DELETE FROM anuncio WHERE idAnuncio = ?";
            $stmt = $this->conn->prepare($sql);
            if ($stmt->execute([$id])) {
                return true;
            } else {
                throw new Exception("Error al eliminar el anuncio");
            }
        } catch (Exception $e) {
            throw new Exception("Error al eliminar: " . $e->getMessage());
        }
    }

    public function obtenerAnuncios() {
        try {
            $stmt = $this->conn->query("
                SELECT a.idAnuncio as id, a.titulo, a.descripcion, a.estado, a.ubicacion, a.pagoReferencia, a.modalidad, a.tipoAnuncio,
                       GROUP_CONCAT(c.idCategoria ORDER BY c.idCategoria) as categorias_ids,
                       GROUP_CONCAT(c.nombre ORDER BY c.idCategoria) as categorias_nombres
                FROM anuncio a
                LEFT JOIN categoriasanuncio ca ON a.idAnuncio = ca.idAnuncio
                LEFT JOIN categoria c ON ca.idCategoria = c.idCategoria
                GROUP BY a.idAnuncio
                ORDER BY a.fechaPublicacion DESC
            ");
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            error_log("Error al consultar anuncios: " . $e->getMessage());
            return [];
        }
    }

    public function guardarCategoriasAnuncio($idAnuncio, $idCategorias) {
        try {
            // Primero, eliminar relaciones previas para evitar duplicados
            $sqlDelete = "DELETE FROM categoriasanuncio WHERE idAnuncio = ?";
            $stmtDelete = $this->conn->prepare($sqlDelete);
            $stmtDelete->execute([$idAnuncio]);

            // Insertar nuevas relaciones
            if (!empty($idCategorias)) {
                $sqlInsert = "INSERT INTO categoriasanuncio (idCategoria, idAnuncio) VALUES (?, ?)";
                $stmtInsert = $this->conn->prepare($sqlInsert);
                foreach ($idCategorias as $idCategoria) {
                    if (!empty($idCategoria)) {
                        $stmtInsert->execute([$idCategoria, $idAnuncio]);
                    }
                }
            }
            return true;
        } catch (Exception $e) {
            error_log("Error al guardar categorías de anuncio: " . $e->getMessage());
            return false;
        }
    }

    public function obtenerCategorias() {
        try {
            $stmt = $this->conn->query("SELECT idCategoria, nombre FROM categoria ORDER BY nombre ASC");
            return $stmt->fetchAll(PDO::FETCH_ASSOC);
        } catch (Exception $e) {
            error_log("Error al consultar categorias: " . $e->getMessage());
            return [];
        }
    }
}
?>
