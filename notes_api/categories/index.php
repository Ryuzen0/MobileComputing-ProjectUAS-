<?php
require_once "../config/cors.php";
include "../config/database.php";

$result = $conn->query("SELECT * FROM categories ORDER BY name ASC");

$data = [];
while ($row = $result->fetch_assoc()) {
  $data[] = $row;
}

echo json_encode($data);
