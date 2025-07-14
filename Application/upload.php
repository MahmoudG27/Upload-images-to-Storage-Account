<?php
require_once('config.php');
require_once('helpers.php');

if (!is_logged_in()) {
    die("You must <a href='login.php'>login</a> first.");
}

if (isset($_FILES['file'])) {
    $fileTmpPath = $_FILES['file']['tmp_name'];
    $fileName = basename($_FILES['file']['name']);

    $uploadUrl = upload_to_blob($fileTmpPath, $fileName);

    if ($uploadUrl) {
        $user_id = current_user_id();
        $stmt = $conn->prepare("INSERT INTO images (user_id, filename, url) VALUES (?, ?, ?)");
        $stmt->bind_param("iss", $user_id, $fileName, $uploadUrl);
        $stmt->execute();

        header("Location: index.php?upload=success");
        exit;
    } else {
        echo "Upload failed!";
    }
} else {
    echo "No file uploaded!";
}
?>
