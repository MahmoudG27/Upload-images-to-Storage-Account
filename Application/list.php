<?php
require 'config.php';
if (!is_logged_in()) {
    die("Please <a href='login.php'>login</a> to view your images.");
}

$user_id = current_user_id();
$stmt = $conn->prepare("SELECT filename, url FROM images WHERE user_id = ? ORDER BY uploaded_at DESC");
$stmt->bind_param("i", $user_id);
$stmt->execute();
$result = $stmt->get_result();

echo "<h2>Your Uploaded Images</h2>";
while ($row = $result->fetch_assoc()) {
    echo "<p><a href='{$row['url']}' target='_blank'>{$row['filename']}</a></p>";
}
?>
