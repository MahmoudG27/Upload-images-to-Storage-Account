variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "virtual_network_id" {
  type = string
}

variable "MYSQL_subnet_id" {
  type = string
}

###################################################################

variable "mysql_server_name" {
  type = string
}

variable "mysql_server_admin_username" {
  type = string
}

variable "mysql_sku_name" {
  type = string
}

variable "mysql_database_name" {
  type = string
}

variable "mysql_dns_zone_name" {
  type = string
}