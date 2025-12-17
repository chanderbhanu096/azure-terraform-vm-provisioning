resource "azurerm_data_factory_pipeline" "pipeline" {
  name            = "pipeline_${local.adf_safe_project}"
  data_factory_id = azurerm_data_factory.adf.id

  parameters = {
    source_url = "String"
    out_file   = "String"
  }

  activities_json = jsonencode([
    {
      name = "copy_HTTP_to_bronze"
      type = "Copy"
      typeProperties = {
        source = {
          type          = "HttpSource"
          requestMethod = "GET"
        }
        sink = { type = "BinarySink" }
      }
      inputs = [
        {
          referenceName = azurerm_data_factory_dataset_http.ds_https_generic.name
          type          = "DatasetReference"
          parameters = {
            fileName = "@pipeline().parameters.source_url"
          }
        }
      ]
      outputs = [
        {
          referenceName = azurerm_data_factory_dataset_binary.ds_bronze.name
          type          = "DatasetReference"
          parameters = {
            fileName = "@pipeline().parameters.out_file"
          }
        }
      ]
    }
  ])
}
