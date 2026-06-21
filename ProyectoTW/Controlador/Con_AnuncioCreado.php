<?php
require_once __DIR__ . '/../Modelo/Model_AnuncioCreado.php';

class Con_AnuncioCreado {
    private Model_AnuncioCreado $modelo;

    public function __construct() {
        $this->modelo = new Model_AnuncioCreado();
    }

    public function obtenerAnuncios() {
        return $this->modelo->obtenerAnuncios();
    }

    public function obtenerCategorias() {
        return $this->modelo->obtenerCategorias();
    }

    public function procesarPeticion(): void {
        if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
            return;
        }

        // Ruta 1: Eliminar anuncio
        if (isset($_POST['accion']) && $_POST['accion'] === 'eliminar') {
            $id = (int) ($_POST['id'] ?? 0);
            $this->eliminar($id);
            return;
        }

        // Ruta 2: Crear o Actualizar anuncio
        $datos = $this->capturarDatos();

        if (empty($datos['titulo']) || empty($datos['descripcion'])) {
            $this->redirigir('error_campos');
        }

        $id = (int) ($_POST['id'] ?? 0);

        if ($id === 0) {
            $this->guardar($datos);
        } else {
            $this->actualizar($id, $datos);
        }
    }

    private function capturarDatos(): array {
        $mapaEstado = ['activo' => 'Disponible', 'oculto' => 'Cancelado'];
        $estadoForm = $_POST['estado'] ?? 'activo';

        return [
            'titulo'          => trim($_POST['titulo'] ?? ''),
            'descripcion'     => trim($_POST['descripcion'] ?? ''),
            'estado'          => $mapaEstado[$estadoForm] ?? 'Disponible',
            'ubicacion'       => trim($_POST['ubicacion'] ?? ''),
            'pago'            => (float) ($_POST['pago'] ?? 0),
            'modalidad'       => $_POST['modalidad'] ?? 'Presencial',
            'tipo'            => $_POST['tipo'] ?? 'Trabajo',
            'categorias_ids'  => !empty($_POST['categorias_ids'])
                                    ? explode(',', $_POST['categorias_ids'])
                                    : [],
        ];
    }

    private function guardar(array $datos): void {
        try {
            $idAnuncio = $this->modelo->guardarAnuncio(
                $datos['titulo'], $datos['descripcion'], $datos['estado'],
                $datos['ubicacion'], $datos['pago'], $datos['modalidad'], $datos['tipo']
            );
            if ($idAnuncio) {
                $this->modelo->guardarCategoriasAnuncio($idAnuncio, $datos['categorias_ids']);
                $this->redirigir('guardado');
            }
        } catch (Exception $e) {
            error_log('[Con_AnuncioCreado::guardar] ' . $e->getMessage());
            $this->redirigir('error_guardar');
        }
    }

    private function actualizar(int $id, array $datos): void {
        try {
            if ($this->modelo->actualizarAnuncio(
                $id, $datos['titulo'], $datos['descripcion'], $datos['estado'],
                $datos['ubicacion'], $datos['pago'], $datos['modalidad'], $datos['tipo']
            )) {
                $this->modelo->guardarCategoriasAnuncio($id, $datos['categorias_ids']);
                $this->redirigir('actualizado');
            }
        } catch (Exception $e) {
            error_log('[Con_AnuncioCreado::actualizar] ' . $e->getMessage());
            $this->redirigir('error_guardar');
        }
    }

    private function eliminar(int $id): void {
        try {
            $this->modelo->eliminarAnuncio($id);
            $this->redirigir('eliminado');
        } catch (Exception $e) {
            error_log('[Con_AnuncioCreado::eliminar] ' . $e->getMessage());
            $this->redirigir('error_eliminar');
        }
    }

    private function redirigir(string $mensaje): never {
        header("Location: ../Vista/AnunciosCreados.php?mensaje=" . urlencode($mensaje));
        exit();
    }
}

// Ejecutar si viene por POST (peticiones directas del formulario)
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    (new Con_AnuncioCreado())->procesarPeticion();
}
?>
