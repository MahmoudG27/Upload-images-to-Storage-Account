# This file is part of the Terraform configuration for Azure Virtual Network.
# It defines the subnets within a virtual network.

# Inbound Subnet is the default subnet for NICs like inbound App Service NIC, Jump Box NIC, Storage Account NIC, etc.
resource "azurerm_subnet" "inbound-subnet-app" {
  name                 = var.inbound_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-app.name
  address_prefixes     = var.inbound_subnet_address_space
}

# Outbound Subnet is used for outbound web app traffic.
resource "azurerm_subnet" "outbound-subnet-app" {
  name                 = var.outbound_subnet_app_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-app.name
  address_prefixes     = var.outbound_subnet_app_address_space

  delegation {
    name = "delegation"
    service_delegation {
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action",
      ]
      name = "Microsoft.Web/serverFarms"
    }
  }
}

# MYSQL Database Subnet is used for MySQL database services.
resource "azurerm_subnet" "MYSQL-subnet-app" {
  name                 = var.MYSQL_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-app.name
  address_prefixes     = var.subnet_MYSQL_address_space
  service_endpoints    = ["Microsoft.Storage"]

  delegation {
    name = "delegation"
    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

# PostgreSQL Database Subnet is used for PostgreSQL database services.
resource "azurerm_subnet" "Postgres-subnet-app" {
  name                 = var.Postgres_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet-app.name
  address_prefixes     = var.subnet_Postgres_address_space
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}