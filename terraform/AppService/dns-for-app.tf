# This file is part of the Terraform configuration for Azure App Service.
# It defines the resources needed to create a DNS zone for App Service and link it to a virtual network.

resource "azurerm_private_dns_zone" "app-dns" {
  name                = var.app_dns_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "link-app-dns" {
  name                  = "private-app-VnetZone-link"
  private_dns_zone_name = azurerm_private_dns_zone.app-dns.name
  virtual_network_id    = var.virtual_network_id
  resource_group_name   = var.resource_group_name
}