
variable "resource_group_name" {
    description = "Name of the Resource Group"
    type        = string
    default     = "rg-mlops-demo"
  
}
variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "East US"
}


variable "storage_account_name" {
    description = "Name of the Storage Account (must be globally unique)"
    type        = string
    default     = "mlopsdemostorage"
  
}

variable "container_name" {
    description = "Name of the Storage Container"
    type        = string
    default     = "mlopsdemo"
  
}

variable "blob_name" {
    description = "Name of the Blob in Storage Container"
    type        = string
    default     = "mlopsdemo-blob"
  
}

variable "subscription_id" {
    description = "Azure Subscription ID"
    type        = string
    default = "45f251e8-d84d-4b8e-ac63-77eef4482127"
  
}
