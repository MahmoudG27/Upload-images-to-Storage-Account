variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "inbound_subnet_app_name" {
  type = string
}

variable "inbound_subnet_app_address_space" {
  type = list(string)
}

variable "outbound_subnet_app_name" {
  type = string
}

variable "outbound_subnet_app_address_space" {
  type = list(string)
}

variable "MYSQL_DB_name" {
  type = string
}

variable "subnet_MYSQL_address_space" {
  type = list(string)
}

variable "Postgres_DB_name" {
  type = string
}

variable "subnet_Postgres_address_space" {
  type = list(string)
}