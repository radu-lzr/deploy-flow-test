resource "azurerm_resource_group" "resource_group" {
  location = "northeurope"
  name     = "rg-deployflow-poc"
}

resource "azurerm_service_plan" "service_plan" {
  location            = azurerm_resource_group.resource_group.location
  name                = "asp-deployflow-poc"
  os_type             = "Linux"
  resource_group_name = azurerm_resource_group.resource_group.name
  sku_name            = "B1"
}
