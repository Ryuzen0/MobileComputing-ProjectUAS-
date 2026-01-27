<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include "../config/database.php";

$user_id = $_GET['user_id'] ?? null;

if (!$user_id) {
    echo json_encode([]);
    exit;
}

$result = mysqli_query(
    $conn,
    "SELECT * FROM todos WHERE user_id = $user_id ORDER BY id DESC"
);

$todos = [];

while ($row = mysqli_fetch_assoc($result)) {
    $todos[] = $row;
}

echo json_encode($todos);
