# This file is part of the Terraform configuration for Azure Private DNS.
# It defines the resources needed to create a DNS zone for Azure Storage Account and link it to a virtual network.

resource "azurerm_private_dns_zone" "storage-dns" {
  name                = var.storage_dns_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "link-storage-dns" {
  name                  = "private-storage-VnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.storage-dns.name
  virtual_network_id    = var.virtual_network_id
  resource_group_name   = var.resource_group_name
}