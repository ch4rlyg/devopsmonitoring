location = "East US 2"

tags = {
  Environment = "Dev"
  Department  = "IT"
  Requester   = "jeanmendoza94"
  Project     = "AppWeb"
}

// Resource group
rg_name = "rg-jmendoza-dev-eastus2-001"

// AKS cluster
aks_name       = "aks-jmendoza-dev-eastus2-001"
aks_dns_prefix = "aksjmendozadeveastus2001"
aks_node_count = 1
aks_vm_size    = "Standard_B2s"

// Sample web app
webapp_replicas = 2
webapp_image    = "webapp:latest" // repo:tag dentro del ACR interno

// Azure Container Registry (interno)
acr_name = "acrjmendozaadeveastus2" // debe ser unico globalmente en Azure
acr_sku  = "Basic"

// Identidad para GitHub Actions (OIDC)
github_repo_owner  = "ch4rlyg"
github_repo_name   = "appsazure"
github_repo_branch = "main"

// Subscription ID
subscription_id = "b497fd69-266c-46a9-b55b-8be0cd579667" 