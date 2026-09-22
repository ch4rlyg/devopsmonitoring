resource "azurerm_kubernetes_cluster" "aks_01" {
  name                = var.aks_name
  location            = azurerm_resource_group.rg_01.location
  resource_group_name = azurerm_resource_group.rg_01.name
  dns_prefix          = var.aks_dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.aks_node_count
    vm_size    = var.aks_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  oidc_issuer_enabled = true

  tags = var.tags
}
