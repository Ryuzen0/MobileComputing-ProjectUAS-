<?php
require_once "../config/cors.php";
include "../config/database.php";

$data = json_decode(file_get_contents("php://input"), true);

// VALIDATE JSON
if (!$data) {
    echo json_encode([
        "success" => false,
        "message" => "Invalid JSON format"
    ]);
    exit;
}

$id = $data['id'] ?? null;

if (!$id) {
    echo json_encode([
        "success" => false,
        "message" => "Todo ID dibutuhkan"
    ]);
    exit;
}

// DELETE TODO
$stmt = $conn->prepare("DELETE FROM todos WHERE id = ?");
$stmt->bind_param("i", $id);

if ($stmt->execute()) {
    echo json_encode([
        "success" => true,
        "message" => "Hapus ToDo Berhasil"
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Hapus ToDo Gagal"
    ]);
}
