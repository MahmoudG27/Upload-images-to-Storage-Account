# This file is part of the Terraform configuration for Azure App Service.
# It defines the resources needed to create an App Service Plan.

resource "azurerm_service_plan" "mg-plan" {
  name                = var.plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = var.plan_sku
  os_type             = "Linux" # Must for this project "PHP"
}