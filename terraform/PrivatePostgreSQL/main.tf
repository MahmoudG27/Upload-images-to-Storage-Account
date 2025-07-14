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

resource "azurerm_private_dns_zone" "postgres-dns" {
  name                = "private-app.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "link-postgres-dns" {
  name                  = "private-postgres-VnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.postgres-dns.name
  virtual_network_id    = var.virtual_network_id
  resource_group_name   = var.resource_group_name
}


resource "azurerm_postgresql_flexible_server" "example" {
  name                          = var.postgres_server_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = "12"
  delegated_subnet_id           = var.Postgres_subnet_id
  private_dns_zone_id           = azurerm_private_dns_zone.postgres-dns.id
  public_network_access_enabled = false
  administrator_login           = var.postgres_server_admin_username
  administrator_password        = random_password.password.result
  zone                          = "1"

  storage_mb   = 32768
  storage_tier = "P4"

  sku_name   = "B_Standard_B1ms"
  depends_on = [ azurerm_private_dns_zone_virtual_network_link.link-postgres-dns ]

}