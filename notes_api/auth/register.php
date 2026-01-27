<?php
// Mengizinkan akses CORS
require_once '../config/cors.php';

// Koneksi database
require_once '../config/database.php';

// Mengambil data JSON dari body request
$data = json_decode(file_get_contents("php://input"));

// =======================
// VALIDASI DATA INPUT
// =======================
if (
    empty($data->name) ||
    empty($data->email) ||
    empty($data->password)
) {
    echo json_encode([
        "status" => false,
        "message" => "Data tidak lengkap"
    ]);
    exit();
}

// =======================
// VALIDASI FORMAT EMAIL
// =======================
if (!filter_var($data->email, FILTER_VALIDATE_EMAIL)) {
    echo json_encode([
        "status" => false,
        "message" => "Format email tidak valid"
    ]);
    exit();
}

// Membersihkan input
$name  = htmlspecialchars($data->name);
$email = htmlspecialchars($data->email);

// Mengenkripsi password
$password = password_hash($data->password, PASSWORD_DEFAULT);

// =======================
// CEK EMAIL SUDAH TERDAFTAR
// =======================
$check = $conn->prepare("SELECT id FROM users WHERE email = ?");
$check->bind_param("s", $email);
$check->execute();
$check->store_result();

// Jika email sudah ada
if ($check->num_rows > 0) {
    echo json_encode([
        "status" => false,
        "message" => "Email sudah terdaftar"
    ]);
    exit();
}

// =======================
// INSERT DATA USER
// =======================
$stmt = $conn->prepare(
    "INSERT INTO users (name, email, password) VALUES (?, ?, ?)"
);
$stmt->bind_param("sss", $name, $email, $password);

// Response berdasarkan hasil insert
if ($stmt->execute()) {
    echo json_encode([
        "status" => true,
        "message" => "Registrasi berhasil"
    ]);
} else {
    echo json_encode([
        "status" => false,
        "message" => "Registrasi gagal"
    ]);
}
