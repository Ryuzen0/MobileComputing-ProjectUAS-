<?php
// Membuat koneksi ke database MySQL
$conn = new mysqli(
    "localhost", // Host database
    "tify9948_tommy",     // Username database
    "tommy2005",   // Password database
    "tify9948_myNotes"      // Nama database
);

// Mengecek koneksi database
if ($conn->connect_error) {
    die("Database error");
}
