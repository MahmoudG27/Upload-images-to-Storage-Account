data "azurerm_storage_account_sas" "sas-token" {
  connection_string = azurerm_storage_account.storage-account.primary_connection_string
  https_only        = false
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