# This file is part of the Terraform configuration for Azure Resource Group.

# It defines the resources needed to create a resource group for the application.
resource "azurerm_resource_group" "rg-app" {
  name     = var.resource_group_name
  location = var.resource_group_location
}