<?php require 'config.php'; ?>
<!DOCTYPE html>
<html>
<head>
    <title>Azure Image Uploader</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="container">
        <h1>Azure Blob Image Uploader</h1>

        <?php if (is_logged_in()): ?>
            <p>Welcome, user #<?= current_user_id() ?> | <a href="logout.php">Logout</a></p>

            <?php if (isset($_GET['upload']) && $_GET['upload'] === 'success'): ?>
                <p class="success">Image uploaded successfully!</p>
            <?php endif; ?>

            <form action="upload.php" method="POST" enctype="multipart/form-data" class="upload-form">
                <input type="file" name="file" required>
                <button type="submit">Upload</button>
            </form>

            <a href="list.php" class="button">View My Images</a>

        <?php else: ?>
            <p><a href="login.php">Login</a> | <a href="register.php">Register</a></p>
        <?php endif; ?>
    </div>
</body>
</html>
