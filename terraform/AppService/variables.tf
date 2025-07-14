variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "virtual_network_id" {
  type = string
}

variable "outbound_subnet_id" {
  type = string
}

variable "inbound_subnet_id" {
  type = string
}

##########################################

# Environment Variables of App service:
variable "app_enviroment" {
  type = string
}

variable "db_host" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_user_password" {
  type      = string
}

variable "storage_account_name" {
  type = string
}

variable "storage_container_name" {
  type = string
}

variable "storage_sas_token" {
  type = string
}