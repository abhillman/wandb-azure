resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_resource_group" "wandb" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "wandb" {
  name                = "wandb-aks"
  location            = azurerm_resource_group.wandb.location
  resource_group_name = azurerm_resource_group.wandb.name
  dns_prefix          = "wandb"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_storage_account" "wandb" {
  name                     = "wandbstorage${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.wandb.name
  location                 = azurerm_resource_group.wandb.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "helm_release" "wandb" {
  name             = "wandb"
  repository       = "https://wandb.github.io/helm-charts"
  chart            = "wandb"
  namespace        = "wandb"
  create_namespace = true

  set {
    name  = "license"
    value = var.wandb_license
  }
}

