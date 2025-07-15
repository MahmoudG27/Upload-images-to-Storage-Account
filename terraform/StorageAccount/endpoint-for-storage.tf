# This file is part of the Terraform configuration for Azure Private Endpoint.
# It defines the resources needed to create a private endpoint for Azure Storage Account.

resource "azurerm_private_endpoint" "storage-endpoint" {
  name                = var.storage_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.inbound_subnet_id

  private_service_connection {
    name                           = "storage-private-endpoint_cebfc634"
    private_connection_resource_id = azurerm_storage_account.storage-account.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  ip_configuration {
    name               = "EndPoint-NIC"
    subresource_name   = "blob"
    member_name        = "blob"
    private_ip_address = "10.0.0.60"
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.storage-dns.id]
  }
}