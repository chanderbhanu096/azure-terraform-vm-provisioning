resource "azurerm_data_factory_linked_custom_service" "http" {
  name            = "ls-http-${var.project_name}"
  data_factory_id = azurerm_data_factory.adf.id
  type            = "HttpServer"

  type_properties_json = <<JSON
{
    "url": "https://raw.githubusercontent.com/",
    "enableServerCertificateValidation": true,
    "authenticationType": "Anonymous"
}
JSON
}
