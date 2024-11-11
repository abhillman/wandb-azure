terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "random" {}

provider "azurerm" {
  features {}
}

provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.wandb.kube_config.0.host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.wandb.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.wandb.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.wandb.kube_config.0.cluster_ca_certificate)
  }
}

