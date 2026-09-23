data "azurerm_client_config" "current" {}

# Identidad que usara GitHub Actions para autenticarse via OIDC (sin
# passwords/secrets de larga duracion) y poder hacer push de imagenes al ACR.
resource "azurerm_user_assigned_identity" "github_actions" {
  name                = var.github_identity_name
  resource_group_name = azurerm_resource_group.rg_01.name
  location            = azurerm_resource_group.rg_01.location
  tags                = var.tags
}

# Credencial federada: le dice a Azure AD que confie en los tokens OIDC que
# GitHub Actions emite para este repo/rama especifico.
resource "azurerm_federated_identity_credential" "github_actions" {
  name                = "github-${var.github_repo_owner}-${var.github_repo_name}-${var.github_repo_branch}"
  resource_group_name = azurerm_resource_group.rg_01.name
  parent_id           = azurerm_user_assigned_identity.github_actions.id
  audience            = ["api://AzureADTokenExchange"]
  issuer              = "https://token.actions.githubusercontent.com"
  # Formato de subject inmutable (repos creados/renombrados despues del
  # 15-jul-2026): repo:owner@owner_id/repo@repo_id:ref:refs/heads/branch
  subject = "repo:${var.github_repo_owner}@${var.github_repo_owner_id}/${var.github_repo_name}@${var.github_repo_id}:ref:refs/heads/${var.github_repo_branch}"
}

# Permite a la identidad de GitHub Actions hacer push de imagenes al ACR interno.
resource "azurerm_role_assignment" "github_acr_push" {
  scope                = azurerm_container_registry.acr_01.id
  role_definition_name = "AcrPush"
  principal_id         = azurerm_user_assigned_identity.github_actions.principal_id
}
