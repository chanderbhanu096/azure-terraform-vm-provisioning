output "vm_public_ip" {
  description = "Public IP of the VM"
  value       = azurerm_public_ip.vm_public_ip.ip_address
}

output "datalake_account_name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.datalake.name
}

output "datalake_dfs_endpoint" {
  description = "Endpoint of the storage account"
  value       = azurerm_storage_account.datalake.primary_dfs_endpoint
}

output "adf_name" {
  description = "name of the data factory"
  value       = azurerm_data_factory.adf.name
}

output "adf_id" {
  description = "id of the data factory"
  value       = azurerm_data_factory.adf.id
}
