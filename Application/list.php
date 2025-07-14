<?php
require 'config.php';
$result = $conn->query("SELECT filename, url FROM images ORDER BY id DESC");
echo "<h2>Uploaded Images</h2>";
while ($row = $result->fetch_assoc()) {
    echo "<p><a href='{$row['url']}' target='_blank'>{$row['filename']}</a></p>";
}
?>
