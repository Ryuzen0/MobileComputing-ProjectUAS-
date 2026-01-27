<?php
require_once "../config/cors.php";
include "../config/database.php";

$data = json_decode(file_get_contents("php://input"), true);

$id      = $data['id'] ?? null;
$is_done = $data['is_done'] ?? null;

// VALIDATION
if ($id === null || $is_done === null) {
    echo json_encode([
        "success" => false,
        "message" => "Data tidak lengkap"
    ]);
    exit;
}

// UPDATE TODO
$stmt = $conn->prepare(
    "UPDATE todos SET is_done = ? WHERE id = ?"
);
$stmt->bind_param("ii", $is_done, $id);

if ($stmt->execute()) {
    echo json_encode([
        "success" => true,
        "message" => "Ubah ToDo sudah sukses"
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Ada kesalahan saat mengubah"
    ]);
}
