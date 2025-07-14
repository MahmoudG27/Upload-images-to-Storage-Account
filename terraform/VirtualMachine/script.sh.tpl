#!/bin/bash

# This script installs the Azure CLI and MySQL client on an Ubuntu VM.

# Get packages needed for the installation process:
sudo apt update -y
sudo apt install mysql-client zip -y

# The following command installs the Azure CLI on Ubuntu without user interaction.
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo DEBIAN_FRONTEND=noninteractive bash

# Create MySQL database and table
mysql -h ${mysql_host} -u ${mysql_user} -p"${mysql_password}" -e "
CREATE DATABASE IF NOT EXISTS photos;
USE photos;
CREATE TABLE IF NOT EXISTS images (
  id INT AUTO_INCREMENT PRIMARY KEY,
  filename VARCHAR(255),
  url TEXT,
  uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
"