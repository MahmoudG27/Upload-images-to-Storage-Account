resource "azurerm_linux_virtual_machine" "jumpbox-vm" {
  name                            = var.vm_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  size                            = var.vm_size
  admin_username                  = var.vm_user
  admin_password                  = random_password.password.result
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic-jumpbox-vm.id]

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