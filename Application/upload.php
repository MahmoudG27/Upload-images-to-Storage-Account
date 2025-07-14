<?php
require_once('config.php');
require_once('helpers.php');

if (isset($_FILES['file'])) {
    $fileTmpPath = $_FILES['file']['tmp_name'];
    $fileName = basename($_FILES['file']['name']);

    $uploadSuccess = upload_to_blob($fileTmpPath, $fileName); // Fixed function name

    if ($uploadSuccess) {
        header("Location: /?upload=success"); // Fixed redirect
        exit;
    } else {
        echo "Upload failed!";
    }
} else {
    echo "No file uploaded!";
}
?>