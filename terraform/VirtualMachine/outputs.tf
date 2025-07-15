output "jumpbox_public_ip" {
  value = azurerm_public_ip.jumpbox-public-ip.ip_address
}

output "vm_user_password" {
  value       = random_password.password.result
  sensitive   = true
  description = "VM user password (sensitive)"
}