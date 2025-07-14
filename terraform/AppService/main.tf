# This Terraform configuration creates an Azure App Service Plan and a Linux Web App with Python.
resource "azurerm_service_plan" "mg-plan" {
  location            = var.location
  name                = "ASP-demo-8fda"
  os_type             = "Linux"
  resource_group_name = var.resource_group_name
  sku_name            = "P0v3"
}


# azurerm_linux_web_app.mg-app:
resource "azurerm_linux_web_app" "mg-app" {
  enabled                                  = true
  ftp_publish_basic_authentication_enabled = false
  https_only                               = true
  location                                 = var.location
  name                                     = "demomgklayytech"

  public_network_access_enabled = false
  resource_group_name           = var.resource_group_name
  service_plan_id               = azurerm_service_plan.mg-plan.id
  virtual_network_subnet_id     = var.outbound_subnet_id

  app_settings = {
    "APP_ENV"        = var.app_enviroment
    "DB_HOST"        = var.db_host
    "DB_NAME"        = var.db_name
    "DB_USER"        = var.db_user
    "DB_PASS"         = var.db_user_password
    "STORAGE_ACCOUNT" = var.storage_account_name
    "CONTAINER_NAME"  = var.storage_container_name
    "SAS_TOKEN"       = var.storage_sas_token
  }

  site_config {
    always_on               = true
    ftps_state              = "FtpsOnly"
    load_balancing_mode     = "LeastRequests"
    scm_minimum_tls_version = "1.2"

    application_stack {
      php_version = "8.3"
    }
  }

  depends_on = [ azurerm_private_dns_zone_virtual_network_link.link-app-dns ]

}

resource "azurerm_private_dns_zone" "app-dns" {
  name                = "privatelink.azurewebsites.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "link-app-dns" {
  name                  = "private-app-VnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.app-dns.name
  virtual_network_id    = var.virtual_network_id
  resource_group_name   = var.resource_group_name
}

resource "azurerm_private_endpoint" "demo" {
  name                = "inbound-nic"
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
