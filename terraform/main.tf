resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location

  
}


resource "azurerm_storage_account" "this" {
    name                     = var.storage_account_name
    resource_group_name      = azurerm_resource_group.this.name
    location                 = var.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
    account_kind             = "StorageV2"
    min_tls_version          = "TLS1_2"

  
}

resource "azurerm_storage_container" "this" {
  name                 = var.container_name
  storage_account_name = azurerm_storage_account.this.name
    container_access_type = "private"

}

resource "azurerm_storage_blob" "this" {
    name                   = var.blob_name
    storage_account_name   = azurerm_storage_account.this.name
    storage_container_name = azurerm_storage_container.this.name
    type                   = "Block"
    source                 = "${path.module}/../ml/data/transactions-sample.csv"
  
}