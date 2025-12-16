resource "azurerm_data_factory_dataset_binary" "ds_bronze" {
  name            = "ds-bronze-${var.project_name}"
  data_factory_id = azurerm_data_factory.adf.id

  linked_service_name = azurerm_data_factory_linked_service_data_lake_storage_gen2.ls_storage.name

  parameters = {
    fileName = "String"
  }

  azure_blob_storage_location {
    container = "bronze"
    path      = "raw"
    filename  = "@dataset().fileName"
  }
}
