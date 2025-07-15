output "mysql_password" {
  value       = module.MYSQL.mysql_admin_password
  sensitive   = true
  description = "MySQL admin password (sensitive)"
}

output "sas_url_query_string" {
  value       = module.StorageAccount.sas_url_query_string
  sensitive   = true
  description = "SAS URL query string for the storage account"
}

output "jumpbox_public_ip" {
  value       = module.VM.jumpbox_public_ip
  description = "Public IP address of the jumpbox VM"
}

output "vm_user_password" {
  value       = module.VM.vm_user_password
  sensitive   = true
  description = "VM user password (sensitive)"
}


# output "postgres_admin_password" {
#   value     = module.postgres_server.postgres_admin_password
#   sensitive = true
# }