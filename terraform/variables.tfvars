# This file contains the variables for the Azure infrastructure deployment.


# This section defines the variables for the Resource Group
resource_group_name     = "Three-Tiers-APP"
resource_group_location = "Central US"


# This section defines the variables for the virtual network.
vnet_name          = "application-vnet"
vnet_address_space = ["10.0.0.0/16"]

# This section defines the variables for the subnets in the virtual network.
inbound_subnet_name               = "default"
inbound_subnetaddress_space       = ["10.0.0.0/24"]
outbound_subnet_app_name          = "outbound"
outbound_subnet_app_address_space = ["10.0.1.0/24"]
MYSQL_DB_name                     = "MYSQL-subnet"
subnet_MYSQL_address_space        = ["10.0.2.0/24"]
Postgres_DB_name                  = "Postgres-subnet"
subnet_Postgres_address_space     = ["10.0.3.0/24"]

# This section defines the variables for the MySQL server.
mysql_server_name           = "mg-mysql-server-klayytech"
mysql_server_admin_username = "mysqladmin"
mysql_sku_name              = "GP_Standard_D2ds_v4"
mysql_database_name         = "photos"
mysql_dns_zone_name         = "privatelink.mysql.database.azure.com"

# This section defines the variables for the PostgreSQL server.
postgres_server_name           = "mg-postgres-server-klayytech"
postgres_server_admin_username = "psqladmin"

# This section defines the variables for the Storage Account.
storage_account_name        = "storageaccountmg"
storage_account_kind        = "StorageV2"
storage_account_tier        = "Standard"
storage_account_access_tier = "Hot"
storage_replication_type    = "LRS"
storage_container_name      = "images"
storage_dns_zone_name       = "privatelink.blob.core.windows.net"
storage_endpoint_name       = "storage-private-endpoint"

# This section defines the environment variables for the App Service.
app_environment          = "production"
db_name                  = "photos"
app_service_plan_name    = "ASP-demo-8fda"
app_service_plan_sku     = "P0v3"
app_service_name         = "demomgklayytech"
app_service_php_version  = "8.3" # Possible values "7.4", "8.0", "8.1", "8.2", "8.3"
app_dns_zone_name        = "privatelink.azurewebsites.net"
app_ibound_endpoint_name = "inbound-APP-endpoint"

# This section defines the variables for the Azure Front Door.
frontdoor_name          = "mgklayytechdemofrontdoor"
frontdoor_endpoint_name = "webapp-origin"
origin_group_name       = "php-origin"
origin_name             = "default-webapp-origin"
route_name              = "route-to-app"

# This section defines the variables for the Virtual Machine.
vm_name             = "jumpbox-machine"
vm_size             = "Standard_F2"
vm_user             = "adminuser"
vm_public_ip_name   = "jumpbox-public-ip"
vm_public_ip_method = "Static" # Options: Static or Dynamic
vm_nic_name         = "jumpbox-nic"