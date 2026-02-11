
# provider "azurerm" {
#   features {}
#   subscription_id = var.subscription_id
# }

# data "azurerm_client_config" "current" {}

# resource "random_integer" "suffix" {
#   min = 100
#   max = 999
# }

# # Resource Group
# resource "azurerm_resource_group" "rg" {
#   name     = "rg-${var.name_prefix}-${var.environment}-eus-01"
#   location = var.location
#   tags     = var.tags
# }

# # Key Vault (required by AML)
# resource "azurerm_key_vault" "kv" {
#   name                       = "kv-${var.name_prefix}-${var.environment}-eus-01"
#   resource_group_name        = azurerm_resource_group.rg.name
#   location                   = azurerm_resource_group.rg.location
#   tenant_id                  = data.azurerm_client_config.current.tenant_id
#   sku_name                   = "standard"
#   purge_protection_enabled   = false
#   soft_delete_retention_days = 7
#   tags                       = var.tags
# }

# # Application Insights (required by AML)
# resource "azurerm_application_insights" "ai" {
#   name                = "appi-${var.name_prefix}-${var.environment}-eus-01"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = azurerm_resource_group.rg.location
#   application_type    = "web"
#   tags                = var.tags
# }

# # ---------------------------
# # Storage Account (existing)
# # ---------------------------
# # We reuse your existing Storage Account for AML data
# resource "azurerm_storage_account" "ml_storage" {
#   name                     = substr(lower(replace("st${var.name_prefix}${var.environment}eus01", "-", "")), 0, 24)
#   resource_group_name      = azurerm_resource_group.rg.name
#   location                 = var.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
#   account_kind             = "StorageV2"
#   min_tls_version          = "TLS1_2"
#   tags                     = var.tags
# }

# # ---------------------------
# # Storage Container
# # ---------------------------
# # Container to hold the ZIP package or CSVs
# resource "azurerm_storage_container" "ml_data" {
#   name                  = "data"
#   storage_account_name  = azurerm_storage_account.ml_storage.name
#   container_access_type = "private"
# }

# # ---------------------------
# # Archive the App or Data Directory
# # ---------------------------
# # ZIP the app folder or CSV folder
# data "archive_file" "zip_app" {
#   type        = "zip"
#   source_file = "${path.module}/../ml/data/transactions-sample.csv"
#   output_path = "${path.module}/transactions.zip"
# }

# data "archive_file" "zip_csv" {
#   type        = "zip"
#   source_dir  = "${path.module}/../ml/data"  # folder with CSVs
#   output_path = "${path.module}/transactions.zip"
# }

# # ---------------------------
# # Upload App ZIP
# # ---------------------------
# resource "azurerm_storage_blob" "app_blob" {
#   name                   = "app.zip"
#   storage_account_name   = azurerm_storage_account.ml_storage.name
#   storage_container_name = azurerm_storage_container.ml_data.name
#   type                   = "Block"
#   source                 = data.archive_file.zip_app.output_path
# }

# # ---------------------------
# # Upload CSV ZIP
# # ---------------------------
# resource "azurerm_storage_blob" "csv_blob" {
#   name                   = "transactions.zip"
#   storage_account_name   = azurerm_storage_account.ml_storage.name
#   storage_container_name = azurerm_storage_container.ml_data.name
#   type                   = "Block"
#   source                 = data.archive_file.zip_csv.output_path
# }


# # AML Workspace
# resource "azurerm_machine_learning_workspace" "mlw" {
#   name                    = "mlw-${var.name_prefix}-${var.environment}-eus-${random_integer.suffix.result}"
#   resource_group_name     = azurerm_resource_group.rg.name
#   location                = azurerm_resource_group.rg.location
#   storage_account_id      = azurerm_storage_account.ml_storage.id
#   key_vault_id            = azurerm_key_vault.kv.id
#   application_insights_id = azurerm_application_insights.ai.id
#   sku_name                = "Basic"

#   identity {
#     type = "SystemAssigned"
#   }

#   tags = var.tags
# }

# # AML Compute Cluster (SUPPORTED VM)
# resource "azurerm_machine_learning_compute_cluster" "aml_compute" {
#   name                          = "cc-${var.name_prefix}-${var.environment}-ds2-01"
#   location                      = azurerm_resource_group.rg.location
#   machine_learning_workspace_id = azurerm_machine_learning_workspace.mlw.id
#   vm_size                        = "Standard_DS2_V2"
#   vm_priority                    = "Dedicated"

#   scale_settings {
#     min_node_count = 0
#     max_node_count = 1
#     scale_down_nodes_after_idle_duration = "PT15M"
#   }

#   tags = var.tags
# }



provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

data "azurerm_client_config" "current" {}

resource "random_integer" "suffix" {
  min = 100
  max = 999
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.name_prefix}-${var.environment}-eus-01"
  location = var.location
  tags     = var.tags
}

# Key Vault (required by AML)
resource "azurerm_key_vault" "kv" {
  name                       = "kv-${var.name_prefix}-${var.environment}-eus-01"
  resource_group_name        = azurerm_resource_group.rg.name
  location                   = azurerm_resource_group.rg.location
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = false
  soft_delete_retention_days = 7
  tags                       = var.tags
}

# Application Insights (required by AML)
resource "azurerm_application_insights" "ai" {
  name                = "appi-${var.name_prefix}-${var.environment}-eus-01"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  application_type    = "web"
  tags                = var.tags
}

# Storage Account
resource "azurerm_storage_account" "ml_storage" {
  name                     = substr(lower(replace("st${var.name_prefix}${var.environment}eus01", "-", "")), 0, 24)
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  min_tls_version          = "TLS1_2"
  tags                     = var.tags
}

# Storage Container
resource "azurerm_storage_container" "ml_data" {
  name                  = "data"
  storage_account_name  = azurerm_storage_account.ml_storage.name
  container_access_type = "private"
}

# Archive the App or Data Directory
data "archive_file" "zip_app" {
  type        = "zip"
  source_file = "${path.module}/../ml/data/transactions-sample.csv"
  output_path = "${path.module}/transactions.zip"
}

data "archive_file" "zip_csv" {
  type        = "zip"
  source_dir  = "${path.module}/../ml/data"
  output_path = "${path.module}/transactions.zip"
}

# Upload App ZIP
resource "azurerm_storage_blob" "app_blob" {
  name                   = "app.zip"
  storage_account_name   = azurerm_storage_account.ml_storage.name
  storage_container_name = azurerm_storage_container.ml_data.name
  type                   = "Block"
  source                 = data.archive_file.zip_app.output_path
}

# Upload CSV ZIP
resource "azurerm_storage_blob" "csv_blob" {
  name                   = "transactions.zip"
  storage_account_name   = azurerm_storage_account.ml_storage.name
  storage_container_name = azurerm_storage_container.ml_data.name
  type                   = "Block"
  source                 = data.archive_file.zip_csv.output_path
}

# AML Workspace
resource "azurerm_machine_learning_workspace" "mlw" {
  name                    = "mlw-${var.name_prefix}-${var.environment}-eus-${random_integer.suffix.result}"
  resource_group_name     = azurerm_resource_group.rg.name
  location                = azurerm_resource_group.rg.location
  storage_account_id      = azurerm_storage_account.ml_storage.id
  key_vault_id            = azurerm_key_vault.kv.id
  application_insights_id = azurerm_application_insights.ai.id
  sku_name                = "Basic"

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

# Grant AML Workspace access to Storage
resource "azurerm_role_assignment" "mlw_storage_reader" {
  scope                = azurerm_storage_account.ml_storage.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_machine_learning_workspace.mlw.identity[0].principal_id
}

# AML Compute Cluster
resource "azurerm_machine_learning_compute_cluster" "aml_compute" {
  name                          = "cc-${var.name_prefix}-${var.environment}-ds2-01"
  location                      = azurerm_resource_group.rg.location
  machine_learning_workspace_id = azurerm_machine_learning_workspace.mlw.id
  vm_size                       = "Standard_DS2_V2"
  vm_priority                   = "Dedicated"

  scale_settings {
    min_node_count = 0
    max_node_count = 1
    scale_down_nodes_after_idle_duration = "PT15M"
  }

  tags = var.tags
}
