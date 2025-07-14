output "app_service_hostname" {
  value = azurerm_linux_web_app.mg-app.default_hostname
}

output "app_service_id" {
  value = azurerm_linux_web_app.mg-app.id
}