resource "azurerm_resource_group" "rg-app" {
  name     = var.resource_group_name
  location = var.resource_group_location
}