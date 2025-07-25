variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "virtual_network_id" {
  type = string
}

variable "inbound_subnet_id" {
  type = string
}

###################################################################

variable "storage_account_name" {
  type = string
}

variable "storage_account_kind" {
  type = string
}

variable "storage_account_tier" {
  type = string
}

variable "storage_account_access_tier" {
  type = string
}

variable "storage_replication_type" {
  type = string
}

variable "storage_container_name" {
  type = string
}

variable "storage_dns_zone_name" {
  type = string
}

variable "storage_endpoint_name" {
  type = string
}