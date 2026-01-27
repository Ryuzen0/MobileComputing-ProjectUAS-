<?php
require_once '../config/cors.php';
// Konfigurasi CORS agar API bisa diakses dari aplikasi lain

require_once '../config/database.php';
// Koneksi database

$data = json_decode(file_get_contents("php://input"), true);
// Mengambil data JSON dari body request

// =======================
// VALIDASI JSON
// =======================
if (!$data) {
    echo json_encode([
        "success" => false,
        "message" => "Format JSON tidak valid"
    ]);
    exit;
}

// =======================
// AMBIL DATA INPUT
// =======================
$user_id = $data['user_id'] ?? null;
$title   = $data['title'] ?? null;
$content = $data['content'] ?? null;
$image   = $data['image'] ?? null; // opsional

// =======================
// VALIDASI DATA WAJIB
// =======================
if (!$user_id || !$title || !$content) {
    echo json_encode([
        "success" => false,
        "message" => "Data tidak lengkap"
    ]);
    exit;
}

// =======================
// INSERT DATA CATATAN
// =======================
$stmt = $conn->prepare(
    "INSERT INTO notes (user_id, title, content, image) VALUES (?, ?, ?, ?)"
);

$stmt->bind_param("isss", $user_id, $title, $content, $image);

if ($stmt->execute()) {
    echo json_encode([
        "success" => true,
        "message" => "Catatan berhasil ditambahkan"
    ]);
} else {
    echo json_encode([
        "success" => false,
        "message" => "Gagal menambahkan catatan"
    ]);
}
