resource "null_resource" "provision_jumpbox" {
    
  depends_on = [azurerm_linux_virtual_machine.jumpbox-vm]

  provisioner "local-exec" {
    command     = "Start-Sleep -Seconds 30"
    interpreter = ["PowerShell", "-Command"]
  }

  connection {
    type     = "ssh"
    user     = "adminuser"
    password = "Mahmoud1999@"
    host     = azurerm_public_ip.jumpbox-public-ip.ip_address
  }

  provisioner "file" {
    content     = data.template_file.vm_script.rendered
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh"
    ]
  }
}