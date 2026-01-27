<?php
require_once "../config/cors.php";
include "../config/database.php";

$data = json_decode(file_get_contents("php://input"), true);

$id = $data['id'] ?? null;

// =======================
// VALIDASI ID
// =======================
if (!$id) {
    echo json_encode([
        "success" => false,
        "message" => "ID catatan tidak diberikan"
    ]);
    exit;
}

// =======================
// DELETE DATA CATATAN
// =======================
$query = "DELETE FROM notes WHERE id = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param("i", $id);

if ($stmt->execute()) {
    echo json_encode([
        "success" => true,
        "message" => "Catatan berhasil dihapus"
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Gagal menghapus catatan"
    ]);
}
