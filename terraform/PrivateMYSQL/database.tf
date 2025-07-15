resource "azurerm_mysql_flexible_database" "photos" {
  name                = var.mysql_database_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.private-mysql-server.name
  charset             = "utf8mb4"
  collation           = "utf8mb4_unicode_ci"
}