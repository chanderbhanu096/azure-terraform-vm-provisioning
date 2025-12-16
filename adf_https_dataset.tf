resource "azurerm_data_factory_dataset_http" "ds_https_generic" {
  name            = "ls-http-${var.project_name}"
  data_factory_id = azurerm_data_factory.adf.id

  linked_service_name = azurerm_data_factory_linked_custom_service.http.name

  parameters = {
    fileName = "String"
  }

  # ADF dataset JSON behind the scenes uses this parameter.
  # Provider fields vary — if this resource is limited, we can do a custom dataset via JSON.
}
