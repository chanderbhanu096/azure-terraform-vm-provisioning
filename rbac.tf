# Role-Based Access Control
# Get current tenant info (sometimes useful later)
data "azurerm_client_config" "current" {}

# Give ADF permission to read/write blobs in the storage account
# Basically giving permission to ADF to read/write blobs in the storage account
resource "azurerm_role_assignment" "adf_storage" {
  scope                = azurerm_storage_account.datalake.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_data_factory.adf.identity[0].principal_id
}
