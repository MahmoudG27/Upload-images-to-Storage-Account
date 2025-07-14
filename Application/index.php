<!DOCTYPE html>
<html>
<head>
    <title>Upload Image to Azure Blob</title>
</head>
<body>
    <h2>Upload Image</h2>

    <?php if (isset($_GET['upload']) && $_GET['upload'] === 'success'): ?>
        <p style="color: green;">Image uploaded successfully!</p>
    <?php endif; ?>

    <form action="upload.php" method="POST" enctype="multipart/form-data">
        <input type="file" name="file">
        <button type="submit">Upload</button>
    </form>
</body>
</html>
