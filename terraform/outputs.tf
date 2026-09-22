output "resource_group_name" {
  value = azurerm_resource_group.rg_01.name
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks_01.name
}

output "get_credentials_command" {
  description = "Command to configure kubectl for this cluster"
  value       = "az aks get-credentials --resource-group ${azurerm_resource_group.rg_01.name} --name ${azurerm_kubernetes_cluster.aks_01.name}"
}

output "webapp_public_ip" {
  description = "Public IP of the sample web app (may take a few minutes to appear)"
  value       = try(kubernetes_service.webapp.status.0.load_balancer.0.ingress.0.ip, "pending")
}

output "acr_name" {
  description = "Pega este valor en el secret ACR_NAME de GitHub"
  value       = azurerm_container_registry.acr_01.name
}

output "acr_login_server" {
  description = "Pega este valor en el secret ACR_LOGIN_SERVER de GitHub"
  value       = azurerm_container_registry.acr_01.login_server
}

output "github_actions_client_id" {
  description = "Pega este valor en el secret AZURE_CLIENT_ID de GitHub"
  value       = azurerm_user_assigned_identity.github_actions.client_id
}

output "github_actions_tenant_id" {
  description = "Pega este valor en el secret AZURE_TENANT_ID de GitHub"
  value       = data.azurerm_client_config.current.tenant_id
}

output "github_actions_subscription_id" {
  description = "Pega este valor en el secret AZURE_SUBSCRIPTION_ID de GitHub"
  value       = var.subscription_id
}
