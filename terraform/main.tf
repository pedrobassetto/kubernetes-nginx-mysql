# Configure the Azure provider
terraform {
    required_version = ">= 0.14.9"

    required_providers {
        azurerm = {
          source = "hashicorp/azurerm"
          version = ">= 2.26"
        }
    }
}

provider "azurerm" {
    features {}
}

#Create resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-aks"
  location = "eastus"
}

#Create Kubernetes Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-atv4"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aksatv4"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}