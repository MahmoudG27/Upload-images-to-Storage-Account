terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.34.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "3f4307f4-ae2b-4a54-a328-4564262560d1"
  features {}
}