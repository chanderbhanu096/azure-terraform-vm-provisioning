#ADF is connected to storage account using the managed identity
resource "azurerm_data_factory_linked_service_data_lake_storage_gen2" "ls_storage" {
  name                 = "ls-adls-${var.project_name}"
  data_factory_id      = azurerm_data_factory.adf.id
  url                  = "https://${azurerm_storage_account.datalake.name}.dfs.core.windows.net"
  use_managed_identity = true
}
