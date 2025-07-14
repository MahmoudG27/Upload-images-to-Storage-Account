# Generate random value for the login password
resource "random_password" "password" {
  length           = 8
  lower            = true
  min_lower        = 1
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  numeric          = true
  override_special = "_"
  special          = true
  upper            = true
}

resource "azurerm_private_dns_zone" "mysql-dns" {
  name                = "private.mysql.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "link-mysql-dns" {
  name                  = "private-mysql-VnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.mysql-dns.name
  virtual_network_id    = var.virtual_network_id
  resource_group_name   = var.resource_group_name
}

resource "azurerm_mysql_flexible_server" "private-mysql-server" {
  name                   = var.mysql_server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = var.mysql_server_admin_username
  administrator_password = random_password.password.result
  backup_retention_days  = 7
  delegated_subnet_id    = var.MYSQL_subnet_id
  private_dns_zone_id    = azurerm_private_dns_zone.mysql-dns.id
  sku_name               = "GP_Standard_D2ds_v4"
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

  depends_on = [ azurerm_private_dns_zone_virtual_network_link.link-mysql-dns ]
}

resource "azurerm_mysql_flexible_database" "photos" {
  name                = "photos"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.private-mysql-server.name
  charset             = "utf8mb4"
  collation           = "utf8mb4_unicode_ci"
}

resource "azurerm_mysql_flexible_server_configuration" "require_secure_transport" {
  name                = "require_secure_transport"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_flexible_server.private-mysql-server.name
  value               = "OFF"
}

# Create private endpoint for MySQL server
# resource "azurerm_private_endpoint" "default" {
#   name                = "private-endpoint-mysql"
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   subnet_id           = var.DB_subnet_id

#   private_dns_zone_group {
#     name                 = "dns-zone-group1"
#     private_dns_zone_ids = [azurerm_private_dns_zone.mysql-dns.id]
#   }

#   private_service_connection {
#     name                           = "private-serviceconnection1"
#     private_connection_resource_id = azurerm_mysql_flexible_server.private-mysql-server.id
#     subresource_names              = ["mysqlServer"]
#     is_manual_connection           = false
#   }

#   ip_configuration {
#     name               = "custom-endpoint-mysql-ip"
#     private_ip_address = "10.0.2.50"
#   }
# }