resource "azurerm_storage_container" "blob1" {
  name                  = var.storage_container_name
  storage_account_id    = azurerm_storage_account.storage-account.id
  container_access_type = "private"
}