# This file is part of the Terraform configuration for Azure Virtual Network.

# It defines the resources needed to create a virtual network.
resource "azurerm_virtual_network" "vnet-app" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.vnet_address_space
}