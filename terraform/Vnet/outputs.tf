output "virtual_network_name" {
  value = azurerm_virtual_network.vnet-app.name
}

output "virtual_network_id" {
  value = azurerm_virtual_network.vnet-app.id
}

output "MYSQL_subnet_id" {
  value = azurerm_subnet.MYSQL-subnet-app.id
}

output "Postgres_subnet_id" {
  value = azurerm_subnet.Postgres-subnet-app.id
}

output "outbound_subnet_id" {
  value = azurerm_subnet.outbound-subnet-app.id
}

output "inbound_subnet_id" {
  value = azurerm_subnet.inbound-subnet-app.id
}