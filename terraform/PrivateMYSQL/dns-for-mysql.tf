resource "azurerm_private_dns_zone" "mysql-dns" {
  name                = var.mysql_dns_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "link-mysql-dns" {
  name                  = "private-mysql-VnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.mysql-dns.name
  virtual_network_id    = var.virtual_network_id
  resource_group_name   = var.resource_group_name
}