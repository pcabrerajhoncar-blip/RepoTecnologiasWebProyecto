<?php
/**
 * session.php — Gestión centralizada de la sesión de usuario.
 *
 * CÓMO FUNCIONA ACTUALMENTE:
 *   El usuario activo está predefinido como idUsuario = 1 para pruebas.
 *
 * CÓMO INTEGRARLO CON SESIÓN REAL (cuando se implemente el login):
 *   1. Reemplaza la línea define(..., 1) por session_start() + la validación de $_SESSION.
 *   2. El resto del proyecto ya usa obtenerIdUsuarioActivo() y no necesitará cambios.
 */

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

/**
 * Retorna el ID del usuario que ha iniciado sesión.
 * Actualmente devuelve 1 como valor fijo para desarrollo.
 * Cuando se implemente el login, cambiar por: return (int)$_SESSION['idUsuario'];
 *
 * @return int
 */
function obtenerIdUsuarioActivo(): int {
    // ----- MODO DESARROLLO: usuario predefinido -----
    return 1;

    // ----- MODO PRODUCCIÓN (descomentar cuando haya login): -----
    // if (!isset($_SESSION['idUsuario'])) {
    //     header('Location: /login.php');
    //     exit();
    // }
    // return (int) $_SESSION['idUsuario'];
}
?>
