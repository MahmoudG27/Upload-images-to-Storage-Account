# This file is part of the Terraform configuration for Azure App Service.
# It defines the resources needed to create a private endpoint for an Azure Linux Web App.

resource "azurerm_private_endpoint" "app-endpoint" {
  name                = var.app_inbound_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.inbound_subnet_id

  private_service_connection {
    name                           = "inbound-nic"
    private_connection_resource_id = azurerm_linux_web_app.mg-app.id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  ip_configuration {
    name               = "custom-endpoint-appservice-ip"
    private_ip_address = "10.0.0.50"
    subresource_name   = "sites"
    member_name        = "sites"
  }

  private_dns_zone_group {
    name                 = "default"
    private_dns_zone_ids = [azurerm_private_dns_zone.app-dns.id]
  }
}