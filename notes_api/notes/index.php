<?php
header("Access-Control-Allow-Origin: *"); // Mengizinkan akses API dari semua domain
header("Content-Type: application/json"); // Menentukan response berupa JSON

include "../config/database.php"; // Memanggil file koneksi database

$result = mysqli_query($conn, "SELECT * FROM notes ORDER BY id DESC"); 
// Mengambil semua data notes dari database, diurutkan dari ID terbaru

$notes = []; // Menyiapkan array kosong untuk menampung data notes

while ($row = mysqli_fetch_assoc($result)) { 
  // Mengambil data satu per satu dari hasil query
  $notes[] = $row; 
  // Menyimpan setiap data note ke dalam array $notes
}

echo json_encode($notes); 
// Mengirim data notes dalam bentuk JSON ke client
