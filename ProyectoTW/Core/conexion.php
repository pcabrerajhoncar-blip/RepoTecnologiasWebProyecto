<?php

class DataBase {
    private $host = "localhost";
    private $db = "bd_chambea_ya2";
    private $user = "root";
    private $pass = "";
    private $charset = 'utf8mb4';
    public $conn;
     
    public function getConnection() {
        $dsn = "mysql:host=$this->host;dbname=$this->db;charset=$this->charset";

        try {
            $this->conn = new PDO($dsn, $this->user, $this->pass);
            $this->conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (\PDOException $e) {
            die("Error de conexión: " . $e->getMessage());
        }
        return $this->conn;
    }
}
    ?>
