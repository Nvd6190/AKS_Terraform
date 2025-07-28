############################################################
# Resource Group
############################################################
resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
}

############################################################
# AKS Cluster with System Node Pool
############################################################
resource "azurerm_kubernetes_cluster" "this" {
  name                = var.aks_name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = "${var.aks_name}-dns"

  default_node_pool {
    name       = "systemnp"
    node_count = var.system_node_count
    vm_size    = "Standard_DS2_v2"
    type       = "VirtualMachineScaleSets"
  }

  identity {
    type = "SystemAssigned"
  }
}

############################################################
# Two User Node Pools
############################################################
resource "azurerm_kubernetes_cluster_node_pool" "usernp1" {
  name                  = "usernp1"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = "Standard_DS2_v2"
  node_count            = var.user_node_count
  mode                  = "User"
}

resource "azurerm_kubernetes_cluster_node_pool" "usernp2" {
  name                  = "usernp2"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = "Standard_DS2_v2"
  node_count            = var.user_node_count
  mode                  = "User"
}

############################################################
# Azure Key Vault
############################################################
data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                        = var.keyvault_name
  location                    = azurerm_resource_group.this.location
  resource_group_name         = azurerm_resource_group.this.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  purge_protection_enabled    = true
}

############################################################
# Azure Container Registry (ACR)
############################################################
resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Standard"
  admin_enabled       = true
}
