resource "azurerm_public_ip" "jumpbox-public-ip" {
  name                = "jumpbox-public-ip"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic-jumpbox-vm" {
  name                = "jumpbox-nic"
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

resource "azurerm_linux_virtual_machine" "jumpbox-vm" {
  name                            = "jumpbox-machine"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = "Mahmoud1999@"
  disable_password_authentication = false
  network_interface_ids           = [ azurerm_network_interface.nic-jumpbox-vm.id ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

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