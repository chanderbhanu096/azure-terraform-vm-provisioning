resource "azurerm_data_factory_pipeline" "pipeline" {
  name            = "pipeline-${var.project_name}"
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
          type = "HttpSource"
        }
        sink = {
          type = "BinarySink"
        }
      }

      inputs = [
        {
          referenceName = "ds_https_dataset"
          type          = "DatasetReference"
          parameters = {
            sourceUrl = "@pipeline().parameters.source_url"
          }
        }
      ]
      outputs = [
        {
          referenceName = "ds_bronze"
          type          = "DatasetReference"
          parameters = {
            fileName = "@pipeline().parameters.out_file"
          }
        }
      ]
    }
  ])
}
