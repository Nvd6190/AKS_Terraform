terraform {
  required_version = ">= 1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.37"        # current at 2025-07-23
    }
  }
}

provider "azurerm" {
  features {} 
  subscription_id = "3593bd93-63f8-4f13-8fec-55ac8abc5f54"                  # keep empty unless you need tweaks
}