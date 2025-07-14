output "mysql_password" {
  value     = module.MYSQL.mysql_admin_password
  sensitive   = true
  description = "MySQL admin password (sensitive)"
}

output "sas_url_query_string" {
  value = module.StorageAccount.sas_url_query_string
  sensitive = true
  description = "SAS URL query string for the storage account"
}


# output "postgres_admin_password" {
#   value     = module.postgres_server.postgres_admin_password
#   sensitive = true
# }