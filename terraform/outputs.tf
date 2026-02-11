output "resource_group_name" {
  description = "Resource Group name"
  value       = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  description = "Storage Account name"
  value       = azurerm_storage_account.ml_storage.name
}

output "aml_workspace_name" {
  description = "Azure ML Workspace name"
  value       = azurerm_machine_learning_workspace.mlw.name
}

output "aml_compute_name" {
  description = "AML Compute Cluster name"
  value       = azurerm_machine_learning_compute_cluster.aml_compute.name
}
