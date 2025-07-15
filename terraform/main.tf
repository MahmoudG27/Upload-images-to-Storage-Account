module "resource_group" {
  source                  = "./ResourceGroup"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
}

module "vnet" {
  source                            = "./Vnet"
  resource_group_name               = module.resource_group.resource_group_name
  location                          = module.resource_group.resource_group_location
  vnet_name                         = var.vnet_name
  vnet_address_space                = var.vnet_address_space
  inbound_subnet_name               = var.inbound_subnet_name
  inbound_subnet_address_space      = var.inbound_subnet_address_space
  outbound_subnet_app_name          = var.outbound_subnet_app_name
  outbound_subnet_app_address_space = var.outbound_subnet_app_address_space
  MYSQL_subnet_name                 = var.mysql_subnet_name
  subnet_MYSQL_address_space        = var.mysql_subnet_address_space
  Postgres_subnet_name              = var.postgres_subnet_name
  subnet_Postgres_address_space     = var.postgres_subnet_address_space
}

module "StorageAccount" {
  source              = "./StorageAccount"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  virtual_network_id  = module.vnet.virtual_network_id
  inbound_subnet_id   = module.vnet.inbound_subnet_id

  storage_account_name        = var.storage_account_name
  storage_account_access_tier = var.storage_account_access_tier
  storage_account_tier        = var.storage_account_tier
  storage_account_kind        = var.storage_account_kind
  storage_replication_type    = var.storage_replication_type
  storage_container_name      = var.storage_container_name
  storage_dns_zone_name       = var.storage_dns_zone_name
  storage_endpoint_name       = var.storage_endpoint_name
}

module "MYSQL" {
  source              = "./PrivateMYSQL"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  virtual_network_id  = module.vnet.virtual_network_id
  MYSQL_subnet_id     = module.vnet.MYSQL_subnet_id

  mysql_server_name           = var.mysql_server_name
  mysql_server_admin_username = var.mysql_server_admin_username
  mysql_sku_name              = var.mysql_sku_name
  mysql_database_name         = var.mysql_database_name
  mysql_dns_zone_name         = var.mysql_dns_zone_name
}

# module "Postgres" {
#   source                         = "./PrivatePostgreSQL"
#   resource_group_name            = module.resource_group.resource_group_name
#   location                       = module.resource_group.resource_group_location
#   virtual_network_id             = module.vnet.virtual_network_id
#   Postgres_subnet_id             = module.vnet.Postgres_subnet_id
#   postgres_server_name           = var.postgres_server_name
#   postgres_server_admin_username = var.postgres_server_admin_username
# }

module "APP" {
  source              = "./AppService"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  virtual_network_id  = module.vnet.virtual_network_id
  outbound_subnet_id  = module.vnet.outbound_subnet_id
  inbound_subnet_id   = module.vnet.inbound_subnet_id

  plan_name                 = var.app_service_plan_name
  plan_sku                  = var.app_service_plan_sku
  app_service_name          = var.app_service_name
  php_version               = var.app_service_php_version
  app_dns_zone_name         = var.app_dns_zone_name
  app_inbound_endpoint_name = var.app_inbound_endpoint_name

  app_environment        = var.app_environment
  db_name                = var.db_name
  db_host                = module.MYSQL.mysql_fqdn
  db_user                = module.MYSQL.mysql_admin_username
  db_user_password       = module.MYSQL.mysql_admin_password
  storage_account_name   = module.StorageAccount.storage_account_name
  storage_container_name = module.StorageAccount.storage_container_name
  storage_sas_token      = module.StorageAccount.sas_url_query_string

  depends_on = [module.MYSQL, module.StorageAccount]
}

module "VM" {
  source              = "./VirtualMachine"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  inbound_subnet_id   = module.vnet.inbound_subnet_id

  db_host          = module.MYSQL.mysql_fqdn
  db_user          = module.MYSQL.mysql_admin_username
  db_user_password = module.MYSQL.mysql_admin_password
  db_name          = module.MYSQL.mysql_database_name

  vm_name             = var.vm_name
  vm_size             = var.vm_size
  vm_user             = var.vm_user
  vm_nic_name         = var.vm_nic_name
  vm_public_ip_name   = var.vm_public_ip_name
  vm_public_ip_method = var.vm_public_ip_method

  depends_on = [module.MYSQL]
}

module "FrontDoor" {
  source               = "./FrontDoor"
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  app_service_hostname = module.APP.app_service_hostname
  app_service_id       = module.APP.app_service_id

  frontdoor_name          = var.frontdoor_name
  frontdoor_endpoint_name = var.frontdoor_endpoint_name
  origin_group_name       = var.origin_group_name
  origin_name             = var.origin_name
  route_name              = var.route_name

  depends_on = [module.APP]
}