# This resource creates a Linux Web App in Azure.

resource "azurerm_linux_web_app" "mg-app" {
  name                                     = var.app_service_name
  enabled                                  = true
  ftp_publish_basic_authentication_enabled = false
  https_only                               = true
  location                                 = var.location

  public_network_access_enabled = false
  resource_group_name           = var.resource_group_name
  service_plan_id               = azurerm_service_plan.mg-plan.id
  virtual_network_subnet_id     = var.outbound_subnet_id

  app_settings = {
    "APP_ENV"         = var.app_environment
    "DB_HOST"         = var.db_host
    "DB_NAME"         = var.db_name
    "DB_USER"         = var.db_user
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
      php_version = var.php_version # Possible values "7.4", "8.0", "8.1", "8.2", "8.3"
    }
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.link-app-dns]
}