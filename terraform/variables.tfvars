# This file contains the variables for the Azure infrastructure deployment.


# This section defines the variables for the Resource Group
resource_group_name     = "Three-Tiers-APP"
resource_group_location = "Central US"


# This section defines the variables for the virtual network.
vnet_name          = "application-vnet"
vnet_address_space = ["10.0.0.0/16"]

# This section defines the variables for the subnets in the virtual network.
inbound_subnet_app_name           = "default"
inbound_subnet_app_address_space  = ["10.0.0.0/24"]
outbound_subnet_app_name          = "outbound"
outbound_subnet_app_address_space = ["10.0.1.0/24"]
MYSQL_DB_name                     = "MYSQL-subnet"
subnet_MYSQL_address_space        = ["10.0.2.0/24"]
Postgres_DB_name                  = "Postgres-subnet"
subnet_Postgres_address_space     = ["10.0.3.0/24"]

# This section defines the variables for the MySQL server.
mysql_server_name           = "mg-mysql-server-klayytech"
mysql_server_admin_username = "mysqladmin"

# This section defines the variables for the PostgreSQL server.
postgres_server_name           = "mg-postgres-server-klayytech"
postgres_server_admin_username = "psqladmin"

# This section defines the variables for the Storage Account.
storage_account_name = "storageaccountmg"
storage_account_kind = "StorageV2"
storage_account_tier = "Standard"
storage_account_access_tier = "Hot"

# This section defines the environment variables for the App Service.
app_enviroment = "production"
db_name = "photos"