<?php
require_once "../config/cors.php";
include "../config/database.php";

$data = json_decode(file_get_contents("php://input"), true);

$id      = $data['id'] ?? null;
$title   = $data['title'] ?? null;
$content = $data['content'] ?? null;
$image   = $data['image'] ?? null;

// =======================
// VALIDASI DATA
// =======================
if (!$id || !$title || !$content) {
    echo json_encode([
        "success" => false,
        "message" => "Data tidak lengkap"
    ]);
    exit;
}

// =======================
// UPDATE DATA CATATAN
// =======================
$query = "UPDATE notes 
          SET title = ?, content = ?, image = ?
          WHERE id = ?";

$stmt = $conn->prepare($query);
$stmt->bind_param("sssi", $title, $content, $image, $id);

if ($stmt->execute()) {
    echo json_encode([
        "success" => true,
        "message" => "Catatan berhasil diperbarui"
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Gagal memperbarui catatan"
    ]);
}
