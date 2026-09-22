resource "azurerm_container_registry" "acr_01" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.rg_01.name
  location            = azurerm_resource_group.rg_01.location
  sku                 = var.acr_sku
  admin_enabled       = false

  tags = var.tags
}

# Permite que el AKS (identidad del kubelet, que es la que usan los nodos
# para hacer pull de imagenes) lea del ACR interno.
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                            = azurerm_container_registry.acr_01.id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.aks_01.kubelet_identity.0.object_id
  skip_service_principal_aad_check = true
}
