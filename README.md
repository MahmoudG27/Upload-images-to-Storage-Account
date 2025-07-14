# Azure Image Upload Application with Private Infrastructure

## 📦 Project Overview

This project provisions a secure, private Azure infrastructure using Terraform and deploys an application for uploading images to Azure Storage via an App Service.

All core services — App Service, Storage Account, and MySQL Flexible Server — are private, meaning they are only accessible from within the configured virtual network. A jumpbox VM is provided for internal access, and Azure Front Door is used for secure, public access to the App Service.

---

## 🛠️ Infrastructure Provisioned

Terraform is used to provision the following resources:

### ☁️ Azure Core Resources

| Resource Type               | Details                                              |
|----------------------------|------------------------------------------------------|
| **Resource Group**         | Central resource group for all resources             |
| **Virtual Network (VNet)** | Hub-spoke style VNet with multiple subnets           |
| **Subnets**                | - `default`<br>- `app_subnet` (App Service)<br>- `mysql_subnet` (Delegated to MySQL) |

### 🔐 Private Azure Services

| Resource                        | Description                                         |
|----------------------------------|-----------------------------------------------------|
| **Private App Service**         | Hosts the image uploader app using Private Endpoint |
| **Private Azure Storage Account** | Stores uploaded images securely (Blob Storage)      |
| **Azure MySQL Flexible Server** | Private endpoint MySQL with a DB named `photo`     |
| **Azure Private DNS Zones**     | Ensures private name resolution for services        |

### 🖥️ Compute & Access

| Resource              | Description                                     |
|-----------------------|-------------------------------------------------|
| **Jumpbox VM**        | Ubuntu VM in `default` subnet for internal SSH access |
| **NSG Rules**         | Limits inbound and outbound traffic             |

### 🌐 Access & Routing

| Resource          | Description                                          |
|-------------------|------------------------------------------------------|
| **Azure Front Door** | Provides public, secure access to the App Service |

---

## 🚀 Application Overview

The application is a simple image uploader that:

- Accepts image file uploads from the user
- Stores images in the **private** Azure Blob Storage container
- Optionally stores metadata (e.g., image name, path, timestamp) in **MySQL** (`photo` DB)

> ✅ The application is hosted on **App Service** and only accessible securely through **Azure Front Door**.

---

## 📁 Directory Structure

```text
.
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── networking.tf
│   ├── compute.tf
│   ├── storage.tf
│   ├── app_service.tf
│   ├── mysql.tf
│   └── frontdoor.tf
└── application/
    ├── index.php (or app.py, main.js etc.)
    ├── upload-form.html
    └── storage_upload_logic.php



#Notes:
- Approve the private link of the Front door to the app service from networking in app service blade then, Private endpoints