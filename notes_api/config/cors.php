<?php
// Mengizinkan akses dari semua origin
header("Access-Control-Allow-Origin: *");

// Metode HTTP yang diizinkan
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");

// Header yang diizinkan
header("Access-Control-Allow-Headers: Content-Type, Authorization");

// Format response JSON
header("Content-Type: application/json");

// Menangani preflight request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}
    