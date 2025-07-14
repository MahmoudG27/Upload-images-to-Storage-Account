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
  inbound_subnet_app_name           = var.inbound_subnet_app_name
  inbound_subnet_app_address_space  = var.inbound_subnet_app_address_space
  outbound_subnet_app_name          = var.outbound_subnet_app_name
  outbound_subnet_app_address_space = var.outbound_subnet_app_address_space
  MYSQL_DB_name                     = var.MYSQL_DB_name
  subnet_MYSQL_address_space        = var.subnet_MYSQL_address_space
  Postgres_DB_name                  = var.Postgres_DB_name
  subnet_Postgres_address_space     = var.subnet_Postgres_address_space

}

module "StorageAccount" {
  source = "./StorageAccount"
  resource_group_name         = module.resource_group.resource_group_name
  location                    = module.resource_group.resource_group_location
  virtual_network_id          = module.vnet.virtual_network_id
  inbound_subnet_id           = module.vnet.inbound_subnet_id
  storage_account_name        = var.storage_account_name
  storage_account_access_tier = var.storage_account_access_tier
  storage_account_tier        = var.storage_account_tier
  storage_account_kind        = var.storage_account_kind
}

module "MYSQL" {
  source                      = "./PrivateMYSQL"
  resource_group_name         = module.resource_group.resource_group_name
  location                    = module.resource_group.resource_group_location
  virtual_network_id          = module.vnet.virtual_network_id
  MYSQL_subnet_id             = module.vnet.MYSQL_subnet_id
  mysql_server_name           = var.mysql_server_name
  mysql_server_admin_username = var.mysql_server_admin_username
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
  
  app_enviroment = var.app_enviroment
  db_name = var.db_name
  db_host = module.MYSQL.mysql_fqdn
  db_user = module.MYSQL.mysql_admin_username
  db_user_password = module.MYSQL.mysql_admin_password
  storage_account_name = module.StorageAccount.storage_account_name
  storage_container_name = module.StorageAccount.storage_container_name
  storage_sas_token = module.StorageAccount.sas_url_query_string

  depends_on = [ module.MYSQL, module.StorageAccount ]
}

module "VM" {
  source              = "./VirtualMachine"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  inbound_subnet_id   = module.vnet.inbound_subnet_id

  db_host = module.MYSQL.mysql_fqdn
  db_user = module.MYSQL.mysql_admin_username
  db_user_password = module.MYSQL.mysql_admin_password

  depends_on = [ module.MYSQL ]
}

module "FrontDoor" {
  source               = "./FrontDoor"
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  app_service_hostname = module.APP.app_service_hostname
  app_service_id       = module.APP.app_service_id

  depends_on           = [ module.APP ]
}