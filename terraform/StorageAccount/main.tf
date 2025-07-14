# azurerm_private_dns_zone.example:
resource "azurerm_private_dns_zone" "storage-dns" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "link-storage-dns" {
  name                  = "private-storage-VnetZone.com"
  private_dns_zone_name = azurerm_private_dns_zone.storage-dns.name
  virtual_network_id    = var.virtual_network_id
  resource_group_name   = var.resource_group_name
}

# azurerm_private_endpoint.default:
resource "azurerm_private_endpoint" "default" {
    name                          = "storage-private-endpoint"
    location                      = var.location
    resource_group_name           = var.resource_group_name
    subnet_id                     = var.inbound_subnet_id

    private_service_connection {
        name                              = "storage-private-endpoint_cebfc634"
        private_connection_resource_id    = azurerm_storage_account.storage-account.id
        subresource_names                 = [ "blob" ]
        is_manual_connection              = false

    }
    
    ip_configuration {
        name               = "EndPoint-NIC"
        subresource_name   = "blob"
        member_name        = "blob"
        private_ip_address = "10.0.0.60"
    }
    
    private_dns_zone_group {
        name                 = "default"
        private_dns_zone_ids = [ azurerm_private_dns_zone.storage-dns.id ]
    }
}

resource "azurerm_storage_account" "storage-account" {
    name                               = var.storage_account_name
    resource_group_name                = var.resource_group_name
    location                           = var.location
    access_tier                        = var.storage_account_access_tier
    account_kind                       = var.storage_account_kind
    account_replication_type           = "LRS"
    account_tier                       = var.storage_account_tier
    allow_nested_items_to_be_public    = false
    cross_tenant_replication_enabled   = false
    default_to_oauth_authentication    = false
    dns_endpoint_type                  = "Standard"
    https_traffic_only_enabled         = true
    infrastructure_encryption_enabled  = false
    is_hns_enabled                     = false
    large_file_share_enabled           = true
    local_user_enabled                 = true
    min_tls_version                    = "TLS1_2"
    nfsv3_enabled                      = false
    public_network_access_enabled      = false
    queue_encryption_key_type          = "Service"
    sftp_enabled                       = false
    shared_access_key_enabled          = true
    table_encryption_key_type          = "Service"

    blob_properties {
        change_feed_enabled           = false
        last_access_time_enabled      = false
        versioning_enabled            = false

        container_delete_retention_policy {
            days = 7
        }

        delete_retention_policy {
            days                     = 7
            permanent_delete_enabled = false
        }
    }

    share_properties {
        retention_policy {
            days = 7
        }
    }
}

resource "azurerm_storage_container" "blob1" {
  name                  = "webapp-images"
  storage_account_id    = azurerm_storage_account.storage-account.id
  container_access_type = "private"
}

data "azurerm_storage_account_sas" "sas-token" {
  connection_string = azurerm_storage_account.storage-account.primary_connection_string
  https_only        = true
  signed_version    = "2024-11-04" # Use the latest version available

  resource_types {
    service   = true
    container = true
    object    = true
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = timestamp()
  expiry = timeadd(timestamp(), "8760h") # 1 year

  permissions {
    read    = true
    write   = true
    delete  = true
    list    = true
    add     = true
    create  = true
    update  = false
    process = false
    tag     = false
    filter  = false
  }
}