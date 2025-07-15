resource "time_sleep" "wait_for_nsg" {
  depends_on      = [azurerm_network_security_group.nsg_jumpbox]
  create_duration = "60s"
}

resource "null_resource" "provision_jumpbox" {

  depends_on = [time_sleep.wait_for_nsg]

  provisioner "local-exec" {
    command     = "Start-Sleep -Seconds 30"
    interpreter = ["PowerShell", "-Command"]
  }

  connection {
    type     = "ssh"
    user     = var.vm_user
    password = random_password.password.result
    host     = azurerm_public_ip.jumpbox-public-ip.ip_address
    timeout  = "2m"
  }

  provisioner "file" {
    content     = data.template_file.vm_script.rendered
    destination = "/home/${var.vm_user}/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/${var.vm_user}/script.sh",
      "/home/${var.vm_user}/script.sh"
    ]
  }
}