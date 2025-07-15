# variables inherit from the root module:

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

###########

# Environment Variables for App service:

variable "app_environment" {
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
  type = string
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

###############################################################

# Module APP variables:

variable "plan_name" {
  type = string
}

variable "plan_sku" {
  type = string
}

variable "app_service_name" {
  type = string
}

variable "php_version" {
  type = string
}

variable "app_dns_zone_name" {
  type = string
}

variable "app_inbound_endpoint_name" {
  type = string
}