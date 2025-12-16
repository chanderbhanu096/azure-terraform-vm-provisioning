resource "azurerm_data_factory" "adf" {
  name                = var.datafactory_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  identity {
    type = "SystemAssigned"
  }
  tags = {
    environment = "demo"
    owner       = "chander"
    project     = var.project_name
    layer       = "datafactory"
  }
}
