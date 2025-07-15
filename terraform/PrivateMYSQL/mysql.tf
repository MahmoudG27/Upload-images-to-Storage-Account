resource "azurerm_mysql_flexible_server" "private-mysql-server" {
  name                   = var.mysql_server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = var.mysql_server_admin_username
  administrator_password = random_password.password.result
  backup_retention_days  = 7
  delegated_subnet_id    = var.MYSQL_subnet_id
  private_dns_zone_id    = azurerm_private_dns_zone.mysql-dns.id
  sku_name               = var.mysql_sku_name
  version                = "8.0.21"

  high_availability {
    mode = "SameZone"
  }
  maintenance_window {
    day_of_week  = 0
    start_hour   = 8
    start_minute = 0
  }
  storage {
    iops    = 360
    size_gb = 20
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.link-mysql-dns]
}

resource "azurerm_mysql_flexible_server_configuration" "require_secure_transport" {
  name                = "require_secure_transport"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.private-mysql-server.name
  value               = "OFF"
}