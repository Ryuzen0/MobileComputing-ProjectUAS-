<?php
// Mengizinkan akses CORS
require_once '../config/cors.php';

// Menangani request OPTIONS (preflight dari browser)
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// Koneksi database
require_once '../config/database.php';

// Mengambil data JSON dari body request
$input = file_get_contents("php://input"); // Membaca input mentah
$data = json_decode($input, true); // Mengubah JSON menjadi array asosiatif

// Mengambil email dan password dari request
$email = $data['email'] ?? null; // Jika tidak ada, isi null
$password = $data['password'] ?? null; 

// Validasi: email dan password wajib diisi
if (!$email || !$password) {
    echo json_encode([
        "success" => false,
        "message" => "Email dan password wajib diisi"
    ]);
    exit;
}

// Query user berdasarkan email
$stmt = $conn->prepare("SELECT * FROM users WHERE email = ?"); // Prepared statement untuk keamanan
$stmt->bind_param("s", $email); // Mengikat parameter email
$stmt->execute(); // Menjalankan query
$user = $stmt->get_result()->fetch_assoc(); // Mengambil hasil sebagai array asosiatif

// Mengecek apakah user ada dan password cocok
if ($user && password_verify($password, $user['password'])) {

    // Generate token sederhana (disarankan JWT untuk production)
    $token = md5($user['id'] . time()); // Token unik berdasarkan user ID dan waktu

    // Menyimpan token ke tabel tokens
    $stmt = $conn->prepare(
        "INSERT INTO tokens (user_id, token) VALUES (?, ?)" // Menyiapkan query INSERT
    );
    $stmt->bind_param("is", $user['id'], $token); // Mengikat parameter
    $stmt->execute(); // Menjalankan query

    // Menghapus password sebelum dikirim ke client
    unset($user['password']);

    // Response login berhasil
    echo json_encode([
        "success" => true,
        "message" => "Login berhasil",
        "token" => $token,
        "user" => $user
    ]);
} else {
    // Response login gagal
    echo json_encode([
        "success" => false,
        "message" => "Email atau password salah"
    ]);
}
