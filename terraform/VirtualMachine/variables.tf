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
  type = string
}

variable "db_name" {
  type = string
}

############################################

# Variables for VM module:
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