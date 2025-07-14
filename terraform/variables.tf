# Variables for the Resource Group
variable "resource_group_name" {
  default     = "Three-Tiers-APP"
  description = "resource group name"
  type        = string
}

variable "resource_group_location" {
  default     = "Central US"
  description = "resource group location"
  type        = string
}

########################################################################

# Variables for the virtual network
variable "vnet_name" {
  default     = "application-vnet"
  description = "virtual network name"
  type        = string
}

variable "vnet_address_space" {
  default = ["10.0.0.0/16"]
  type    = list(string)
}

# Variables for the subnets in the virtual network
variable "inbound_subnet_app_name" {
  default = "default"
  type    = string
}

variable "inbound_subnet_app_address_space" {
  default = ["10.0.0.0/24"]
  type    = list(string)
}

variable "outbound_subnet_app_name" {
  default     = "outbound"
  description = "Outbound web app subnet name"
  type        = string
}

variable "outbound_subnet_app_address_space" {
  default = ["10.0.1.0/24"]
  type    = list(string)
}

variable "MYSQL_DB_name" {
  default     = "MYSQL-subnet"
  description = "MYSQL Database subnet name"
  type        = string
}

variable "subnet_MYSQL_address_space" {
  default = ["10.0.2.0/24"]
  type    = list(string)
}

variable "Postgres_DB_name" {
  default     = "Postgres-subnet"
  description = "Postgresql Database subnet name"
  type        = string
}

variable "subnet_Postgres_address_space" {
  default = ["10.0.3.0/24"]
  type    = list(string)
}

########################################################################

# Variables for the MySQL server
variable "mysql_server_name" {
  default     = "mg-mysql-server-klayytech"
  description = "value for the MySQL server name"
  type        = string
}

variable "mysql_server_admin_username" {
  default     = "mysqladmin"
  description = "value for the MySQL server admin username"
  type        = string
}

# Variables for the PostgreSQL server
variable "postgres_server_name" {
  default     = "mg-postgres-server-klayytech"
  description = "value for the PostgreSQL server name"
  type        = string
}

variable "postgres_server_admin_username" {
  default     = "psqladmin"
  description = "value for the PostgreSQL server admin username"
  type        = string
}

########################################################################

# Variables for the Storage Account

variable "storage_account_name" {
  default = "storageaccountmg"
  description = "value for the storage account name"
  type = string
}

variable "storage_account_kind" {
  default = "StorageV2"
  description = "value for the storage account kind"
  type = string
}

variable "storage_account_tier" {
  default = "Standard"
  description = "value for the storage account tier"
  type = string
}

variable "storage_account_access_tier" {
  default = "Hot"
  description = "value for the storage account access tier"
  type = string
}

######################################################################

# Variables for the App Service

# Environment Variables of App service:
variable "app_enviroment" {
  type = string
  default = "production"
}

variable "db_name" {
  type = string
  default = "photos"
}
