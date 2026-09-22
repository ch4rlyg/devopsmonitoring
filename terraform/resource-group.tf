resource "azurerm_resource_group" "rg_01" {
  name     = var.rg_name
  location = var.location
  tags     = var.tags
}
