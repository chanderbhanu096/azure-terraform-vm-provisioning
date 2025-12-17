resource "azurerm_data_factory_dataset_binary" "ds_bronze" {
  name            = "ds_bronze_${local.adf_safe_project}"
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

# Silver Dataset
resource "azurerm_data_factory_dataset_binary" "ds_silver" {
  name            = "ds_silver_${local.adf_safe_project}"
  data_factory_id = azurerm_data_factory.adf.id

  linked_service_name = azurerm_data_factory_linked_service_data_lake_storage_gen2.ls_storage.name

  parameters = {
    fileName = "String"
  }

  azure_blob_storage_location {
    container = "silver"
    path      = "raw"
    filename  = "@dataset().fileName"
  }
}
