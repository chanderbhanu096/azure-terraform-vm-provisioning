resource "azurerm_data_factory_linked_custom_service" "http" {
  name            = "ls_http_${local.adf_safe_project}"
  data_factory_id = azurerm_data_factory.adf.id
  type            = "HttpServer"

  type_properties_json = <<JSON
{
  "url": "https://raw.githubusercontent.com/",
  "authenticationType": "Anonymous"
}
JSON
}
