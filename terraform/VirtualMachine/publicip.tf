resource "azurerm_public_ip" "jumpbox-public-ip" {
  name                = var.vm_public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.vm_public_ip_method
}