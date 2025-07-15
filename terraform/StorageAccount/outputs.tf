output "storage_account_name" {
  value = azurerm_storage_account.storage-account.name
}

output "storage_container_name" {
  value = azurerm_storage_container.blob1.name
}

output "sas_url_query_string" {
  value     = data.azurerm_storage_account_sas.sas-token.sas
  sensitive = true
}

