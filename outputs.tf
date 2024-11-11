output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.wandb.name
}

output "storage_account_name" {
  value = azurerm_storage_account.wandb.name
}

output "resource_group_name" {
  value = azurerm_resource_group.wandb.name
}

