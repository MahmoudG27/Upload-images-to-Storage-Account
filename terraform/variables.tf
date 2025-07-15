# Variables for the Resource Group
variable "resource_group_name" {
  description = "resource group name"
  type        = string
}

variable "resource_group_location" {
  description = "resource group location"
  type        = string
}

########################################################################

# Variables for the virtual network
variable "vnet_name" {
  description = "virtual network name"
  type        = string
}

variable "vnet_address_space" {
  type    = list(string)
}

# Variables for the subnets in the virtual network
variable "inbound_subnet_name" {
  type    = string
}

variable "inbound_subnet_address_space" {
  type    = list(string)
}

variable "outbound_subnet_app_name" {
  description = "Outbound web app subnet name"
  type        = string
}

variable "outbound_subnet_app_address_space" {

  type    = list(string)
}

variable "mysql_subnet_name" {
  description = "MYSQL Database subnet name"
  type        = string
}

variable "mysql_subnet_address_space" {
  type    = list(string)
}

variable "postgres_subnet_name" {
  description = "Postgresql Database subnet name"
  type        = string
}

variable "postgres_subnet_address_space" {
  type    = list(string)
}

########################################################################

# Variables for the MySQL server
variable "mysql_server_name" {
  description = "value for the MySQL server name"
  type        = string
}

variable "mysql_server_admin_username" {
  description = "value for the MySQL server admin username"
  type        = string
}

variable "mysql_sku_name" {
  description = "value for the MySQL server SKU name"
  type        = string
}

variable "mysql_database_name" {
  type = string
}

variable "mysql_dns_zone_name" {
  description = "value for the MySQL DNS zone name"
  type        = string
}

############################

# Variables for the PostgreSQL server
variable "postgres_server_name" {
  description = "value for the PostgreSQL server name"
  type        = string
}

variable "postgres_server_admin_username" {
  description = "value for the PostgreSQL server admin username"
  type        = string
}

########################################################################

# Variables for the Storage Account

variable "storage_account_name" {
  description = "value for the storage account name"
  type        = string
}

variable "storage_account_kind" {
  description = "value for the storage account kind"
  type        = string
}

variable "storage_account_tier" {
  description = "value for the storage account tier"
  type        = string
}

variable "storage_account_access_tier" {
  description = "value for the storage account access tier"
  type        = string
}

variable "storage_replication_type" {
  type    = string
}

variable "storage_container_name" {
  type    = string
}

variable "storage_dns_zone_name" {
  type    = string
}

variable "storage_endpoint_name" {
  type    = string
}

######################################################################

# Variables for the App Service:

variable "app_environment" {
  type    = string
}

variable "db_name" {
  type    = string
}

variable "app_service_plan_name" {
  type    = string
}

variable "app_service_plan_sku" {
  type    = string
}

variable "app_service_name" {
  type    = string
}

variable "app_service_php_version" {
  type    = string
}

variable "app_dns_zone_name" {
  type    = string
}

variable "app_inbound_endpoint_name" {
  type    = string
}

######################################################################

# Front Door Variables:
variable "frontdoor_name" {
  description = "Name of the Azure Front Door profile"
  type        = string
}

variable "frontdoor_endpoint_name" {
  description = "Name of the Azure Front Door endpoint"
  type        = string
}

variable "origin_group_name" {
  description = "Name of the Azure Front Door origin group"
  type        = string
}

variable "origin_name" {
  description = "Name of the Azure Front Door origin"
  type        = string
}

variable "route_name" {
  description = "Name of the Azure Front Door route"
  type        = string
}

#########################################################

# Variables for the Virtual Machine module:
variable "vm_name" {
  type    = string
}

variable "vm_size" {
  type    = string
}

variable "vm_user" {
  type    = string
}

variable "vm_public_ip_name" {
  type    = string
}

variable "vm_public_ip_method" {
  type    = string
}

variable "vm_nic_name" {
  type    = string
}