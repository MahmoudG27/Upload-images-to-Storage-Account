<?php
function upload_to_blob($localPath, $filename) {
    $account = getenv('STORAGE_ACCOUNT');
    $container = getenv('CONTAINER_NAME');
    $sas = getenv('SAS_TOKEN'); // This should already include the leading "?"

    // Append SAS token as-is, without adding an extra "?"
    $url = "https://$account.blob.core.windows.net/$container/" . rawurlencode($filename) . $sas;

    $fileContent = file_get_contents($localPath);
    if ($fileContent === false) {
        echo "Failed to read file from path: $localPath";
        return false;
    }

    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "PUT");
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HTTPHEADER, ['x-ms-blob-type: BlockBlob']);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $fileContent);

    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($httpCode === 201) {
        return "https://$account.blob.core.windows.net/$container/" . rawurlencode($filename);
    } else {
        echo "Upload failed. HTTP status code: $httpCode\n";
        return false;
    }
}
?>