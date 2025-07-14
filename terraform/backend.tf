# terraform {
#   backend "azurerm" {
#     resource_group_name  = "state"
#     storage_account_name = "tfstatefil"
#     container_name       = "tfstate"
#     key                  = "terraform.tfstate"
#   }
# }