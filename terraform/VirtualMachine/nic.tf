resource "azurerm_network_interface" "nic-jumpbox-vm" {
  name                = var.vm_nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.inbound_subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.0.20"
    public_ip_address_id          = azurerm_public_ip.jumpbox-public-ip.id
  }
}