<?php
require_once '../config/cors.php';
require_once '../config/database.php';

$data = json_decode(file_get_contents("php://input"), true);

// VALIDATE JSON
if (!$data) {
    echo json_encode([
        "success" => false,
        "message" => "Invalid JSON format"
    ]);
    exit;
}

// GET DATA
$user_id = $data['user_id'] ?? null;
$title   = $data['title'] ?? null;

// VALIDATION
if (!$user_id || !$title) {
    echo json_encode([
        "success" => false,
        "message" => "Data tidak Lengkap"
    ]);
    exit;
}

// INSERT TODO
$stmt = $conn->prepare(
    "INSERT INTO todos (user_id, title) VALUES (?, ?)"
);
$stmt->bind_param("is", $user_id, $title);

if ($stmt->execute()) {
    echo json_encode([
        "success" => true,
        "message" => "Menambah ToDo Berhasil"
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Menambah ToDo Gagal"
    ]);
}
