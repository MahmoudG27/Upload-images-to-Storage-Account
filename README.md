# Azure Infrastructure + PHP Application Deployment

This project provisions a secure, private infrastructure in **Microsoft Azure** using **Terraform**, and deploys a simple **PHP application** that allows users to register, upload images, and view their images stored in **Azure Storage Account**.

---

## 📁 Project Structure

├── terraform/ # Terraform modules and resources
│ ├── main.tf # Main entry point
│ ├── variables.tf # Variable declarations
│ ├── outputs.tf # Output values
│ ├── ResourceGroup # Azure Resource Group module
│ ├── vnet # Virtual Network with subnets module
│ ├── AppService # Private Azure App Service with plan module
│ ├── StorageAccount # Private Azure Storage Account with container and SAS token module
│ ├── privateMYSQL # Private Azure MySQL Server
│ ├── FrontDoor.tf # Azure Front Door for external access
│ └── VirtualMachine # Ubuntu VM (Jump Host) with NSG
│
├── Application/ # PHP application
│ ├── index.php # Home page
│ ├── register.php # User registration
│ ├── upload.php # Upload images
│ ├── list.php # View images
│ └── config.php # DB and Storage configuration
│
├── azure-pipelines.yml # Azure DevOps CI/CD Pipeline definition
├── install-azure-devops-agent.sh # Script to install self-hosted Azure DevOps Agent (Linux)
└── README.md # You're here


---

## 🌐 Infrastructure Components

Provisioned with Terraform under the `/terraform` directory:

- **Resource Group** – Logical container for all resources.
- **Virtual Network (VNet)** – Includes subnets for app service, storage, database, and VM.
- **Private Azure App Service** – Hosts the PHP app with internal access only.
- **Private Azure Storage Account** – For image uploads (private endpoint configured).
- **Private Azure MySQL Server** – Backend database with private connectivity.
- **Azure Front Door** – Public entry point that routes traffic securely to the app service.
- **Jump Host (Ubuntu VM)** – Secure admin access point into the private network.

---

## 🧑‍💻 PHP Application Features

Located in `/Application`, the app provides:

- ✅ **User Registration**
- 📷 **Image Upload to Azure Storage (Blob)**
- 🖼️ **View Uploaded Images**
- 🔒 Fully Private Backend (Storage, DB, App Service)

All secrets and configuration are managed securely via environment variables or Azure Key Vault (if implemented).

---

## 🚀 CI/CD with Azure DevOps

- `azure-pipelines.yml`: Defines the pipeline for provisioning the infrastructure and deploying the PHP application.
- `install-azure-devops-agent.sh`: Installs the **Azure DevOps self-hosted agent** on a Linux VM (Jump Host or dedicated CI VM).

### Steps:
1. Set up a self-hosted agent using the `install-azure-devops-agent.sh` script.
2. Run the pipeline to deploy infra and app.

---

## 🧰 Prerequisites

Before you begin, ensure you have the following:

- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- Azure Subscription with required permissions
- Azure DevOps organization and project

---

## ⚙️ Getting Started

### 1. Provision Infrastructure

```bash
cd terraform
terraform init
terraform plan
terraform apply

2. Configure DevOps Agent
SSH into your Ubuntu VM (Jump Host) and run:
```bash
bash install-azure-devops-agent.sh

3. Deploy the Application
Trigger the Azure DevOps pipeline using azure-pipelines.yml.

