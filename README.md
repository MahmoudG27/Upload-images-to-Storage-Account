# 🚀 Azure Infrastructure + PHP Application Deployment

This project provisions a **secure private infrastructure** on **Microsoft Azure** using **Terraform**, and deploys a lightweight **PHP application** for user registration and image uploads to **Azure Blob Storage**.

---

## 📁 Project Structure

<pre> . ├── terraform/ # Infrastructure-as-Code modules │ ├── main.tf # Terraform root module │ ├── variables.tf # Input variables │ ├── outputs.tf # Output values │ ├── ResourceGroup/ # Azure Resource Group module │ ├── vnet/ # Virtual Network + Subnets │ ├── AppService/ # Private App Service + Plan │ ├── StorageAccount/ # Private Blob Storage module │ ├── privateMYSQL/ # Private MySQL Server module │ ├── FrontDoor.tf # Azure Front Door config │ └── VirtualMachine/ # Jump Host (Ubuntu VM + NSG) │ ├── Application/ # PHP web app │ ├── index.php # Homepage │ ├── register.php # User registration │ ├── upload.php # Image upload │ ├── list.php # View uploaded images │ └── config.php # DB & storage config │ ├── azure-pipelines.yml # Azure DevOps pipeline definition ├── install-azure-devops-agent.sh # Script for self-hosted DevOps agent └── README.md # You are here </pre>


---

## 🌐 Provisioned Azure Infrastructure

Everything under the `/terraform` directory is automatically provisioned, including:

- 🗂️ **Resource Group** – Top-level container for all resources
- 🌐 **Virtual Network (VNet)** – With subnets for the app, DB, and storage
- 🔒 **Private Azure App Service** – Hosts the PHP app, internal only
- 📦 **Private Azure Storage Account** – Blob container for image uploads
- 🛢️ **Private Azure MySQL Server** – Secure backend database
- 🌍 **Azure Front Door** – Secure public access point
- 💻 **Jump Host (Ubuntu VM)** – Admin access with NSG rules

---

## 💻 Application Features

The app is a simple PHP-based image sharing platform with:

- ✅ **User Registration**
- 📷 **Image Upload to Azure Blob Storage**
- 🖼️ **Image Listing Interface**
- 🔐 **Private Backend** (no public DB or storage exposure)

Secrets and credentials are securely managed via environment variables (or optionally with Azure Key Vault).

---

## 🔁 CI/CD with Azure DevOps

**Automated Deployment Pipeline**:

- `azure-pipelines.yml`: Deploys infrastructure and the PHP app
- `install-azure-devops-agent.sh`: Installs a self-hosted agent (Linux VM)

### Deployment Steps

1. **Set Up Self-Hosted Agent**  
   SSH into the Ubuntu Jump Host and run:
   ```bash
   bash install-azure-devops-agent.sh
   ```

2. **Provision Infrastructure**
    ```bash
    cd terraform
    terraform init
    terraform plan
    terraform apply
    ```

3. **Run CI/CD Pipeline**
Trigger the Azure DevOps pipeline to deploy the app.

