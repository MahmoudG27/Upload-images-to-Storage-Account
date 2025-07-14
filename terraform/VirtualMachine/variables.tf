variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "inbound_subnet_id" {
  type = string
}

########################################

# Variables for the MySQL server
variable "db_host" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_user_password" {
  type      = string
}