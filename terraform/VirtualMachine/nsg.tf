resource "azurerm_network_security_group" "nsg_jumpbox" {
  name                = "nsg-jumpbox"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_assoc_jumpbox" {
  network_interface_id      = azurerm_network_interface.nic-jumpbox-vm.id
  network_security_group_id = azurerm_network_security_group.nsg_jumpbox.id
}