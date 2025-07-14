#!/bin/bash

# This script installs the Azure CLI and MySQL client on an Ubuntu VM.

# Get packages needed for the installation process:

# Update the package list and install MySQL client and zip
sudo apt update -y
sudo apt install -y mysql-client

# Install PHP version 8.3 and required extensions
sudo apt install -y zip curl gpg gnupg2 software-properties-common ca-certificates apt-transport-https lsb-release
sudo add-apt-repository ppa:ondrej/php
sudo apt -y install php8.3 php8.3-cli php8.3-fpm php8.3-mysql php8.3-zip php8.3-curl

# The following command installs the Azure CLI on Ubuntu without user interaction.
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo DEBIAN_FRONTEND=noninteractive bash

# Create Tables
mysql -h ${mysql_host} -u ${mysql_user} -p"${mysql_password}" -e "
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL
);
"
mysql -h ${mysql_host} -u ${mysql_user} -p"${mysql_password}" -e "
CREATE TABLE images (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    filename VARCHAR(255) NOT NULL,
    url TEXT NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);
"