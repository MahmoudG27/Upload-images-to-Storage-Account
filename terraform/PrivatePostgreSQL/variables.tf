variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "virtual_network_id" {
  type = string
}

variable "Postgres_subnet_id" {
  type = string
}

###################################################################

variable "postgres_server_name" {
  type = string
}

variable "postgres_server_admin_username" {
  type = string
}