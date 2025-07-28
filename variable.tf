variable "aks_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "acr_name" {
  description = "Name of the Azure Container Registry (must be globally unique, 5-50 alphanumeric characters)"
  type        = string
}

variable "keyvault_name" {
  description = "Name of the Azure Key Vault (must be globally unique)"
  type        = string
}

variable "location" {
  description = "Azure region in which to deploy all resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group to create or reuse"
  type        = string
  default     = "rg-aks-platform"
}

variable "system_node_count" {
  description = "Number of nodes in the system (control-plane) node pool"
  type        = number
  default     = 1
}

variable "user_node_count" {
  description = "Number of nodes in each user node pool"
  type        = number
  default     = 1
}
