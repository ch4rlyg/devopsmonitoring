variable "location" {
  description = "Azure region where resources are deployed"
  type        = string
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}

variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}

variable "aks_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "aks_dns_prefix" {
  description = "DNS prefix for the AKS cluster"
  type        = string
}

variable "aks_node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 1
}

variable "aks_vm_size" {
  description = "VM size for the default node pool"
  type        = string
  default     = "Standard_B2s"
}

variable "webapp_replicas" {
  description = "Number of replicas for the sample web app"
  type        = number
  default     = 2
}

variable "webapp_image" {
  description = "Repositorio y tag de la imagen dentro del ACR interno (sin el login server), ej. \"webapp:latest\""
  type        = string
  default     = "webapp:latest"
}

variable "acr_name" {
  description = "Nombre del Azure Container Registry (debe ser unico globalmente, solo alfanumerico, 5-50 caracteres)"
  type        = string
}

variable "acr_sku" {
  description = "SKU del Azure Container Registry"
  type        = string
  default     = "Basic"
}

variable "github_identity_name" {
  description = "Nombre de la User Assigned Managed Identity para GitHub Actions (OIDC)"
  type        = string
  default     = "id-github-actions"
}

variable "github_repo_owner" {
  description = "Owner/organizacion del repo de GitHub (ej. usuario o cuenta de org)"
  type        = string
}

variable "github_repo_name" {
  description = "Nombre del repo de GitHub"
  type        = string
}

variable "github_repo_branch" {
  description = "Rama que puede autenticarse via OIDC (subject de la credencial federada)"
  type        = string
  default     = "main"
}

variable "namespace_name" {
  description = "Kubernetes namespace where the sample web app resources are created"
  type        = string
  default     = "webapp"
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}