output "mysql_fqdn" {
  description = "Private DNS name of the MySQL Flexible Server"
  value       = azurerm_mysql_flexible_server.private-mysql-server.fqdn
}

output "mysql_admin_username" {
  value       = azurerm_mysql_flexible_server.private-mysql-server.administrator_login
  description = "MySQL admin username"
}

output "mysql_admin_password" {
  value       = random_password.password.result
  sensitive   = true
  description = "MySQL admin password (sensitive)"
}