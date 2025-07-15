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
variable "inbound_subnet_name" {
  default = "default"
  type    = string
}

variable "inbound_subnet_address_space" {
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

variable "mysql_subnet_name" {
  default     = "MYSQL-subnet"
  description = "MYSQL Database subnet name"
  type        = string
}

variable "mysql_subnet_address_space" {
  default = ["10.0.2.0/24"]
  type    = list(string)
}

variable "postgres_subnet_name" {
  default     = "Postgres-subnet"
  description = "Postgresql Database subnet name"
  type        = string
}

variable "postgres_subnet_address_space" {
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

variable "mysql_sku_name" {
  default     = "GP_Standard_D2ds_v4"
  description = "value for the MySQL server SKU name"
  type        = string
}

variable "mysql_database_name" {
  default = "photos"
}

variable "mysql_dns_zone_name" {
  default     = "privatelink.mysql.database.azure.com"
  description = "value for the MySQL DNS zone name"
  type        = string
}

############################

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
  default     = "storageaccountmg"
  description = "value for the storage account name"
  type        = string
}

variable "storage_account_kind" {
  default     = "StorageV2"
  description = "value for the storage account kind"
  type        = string
}

variable "storage_account_tier" {
  default     = "Standard"
  description = "value for the storage account tier"
  type        = string
}

variable "storage_account_access_tier" {
  default     = "Hot"
  description = "value for the storage account access tier"
  type        = string
}

variable "storage_replication_type" {
  type    = string
  default = "LRS"
}

variable "storage_container_name" {
  type    = string
  default = "images"
}

variable "storage_dns_zone_name" {
  type    = string
  default = "privatelink.blob.core.windows.net"
}

variable "storage_endpoint_name" {
  type    = string
  default = "storage-private-endpoint"
}

######################################################################

# Variables for the App Service

# Environment Variables of App service:
variable "app_environment" {
  type    = string
  default = "production"
}

variable "db_name" {
  type    = string
  default = "photos"
}

variable "app_service_plan_name" {
  type    = string
  default = "ASP-demo-8fda"
}

variable "app_service_plan_sku" {
  type    = string
  default = "P0v3"
}

variable "app_service_name" {
  type    = string
  default = "demomgklayytech"
}

variable "app_service_php_version" {
  type    = string
  default = "8.3"
}

variable "app_dns_zone_name" {
  type    = string
  default = "privatelink.azurewebsites.net"
}

variable "app_ibound_endpoint_name" {
  type    = string
  default = "inbound-APP-endpoint"

}

######################################################################

# Front Door Variables:
variable "frontdoor_name" {
  default     = "mgklayytechdemofrontdoor"
  description = "Name of the Azure Front Door profile"
  type        = string
}

variable "frontdoor_endpoint_name" {
  default     = "webapp-origin"
  description = "Name of the Azure Front Door endpoint"
  type        = string
}

variable "origin_group_name" {
  default     = "php-origin"
  description = "Name of the Azure Front Door origin group"
  type        = string
}

variable "origin_name" {
  default     = "default-webapp-origin"
  description = "Name of the Azure Front Door origin"
  type        = string
}

variable "route_name" {
  default     = "route-to-app"
  description = "Name of the Azure Front Door route"
  type        = string
}

#########################################################

# Variables for the Virtual Machine module:
variable "vm_name" {
  type    = string
  default = "jumpbox-machine"
}

variable "vm_size" {
  type    = string
  default = "Standard_F2"
}

variable "vm_user" {
  type    = string
  default = "adminuser"
}

variable "vm_public_ip_name" {
  type    = string
  default = "jumpbox-public-ip"
}

variable "vm_public_ip_method" {
  type    = string
  default = "Static"
}

variable "vm_nic_name" {
  type    = string
  default = "jumpbox-nic"
}