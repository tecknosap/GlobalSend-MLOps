variable "name_prefix" {
  description = "Project prefix for resource names"
  type        = string
    default     = "gs"
}

variable "environment" {
  description = "Environment (dev/staging/prod)"
  type        = string
  default = "dev"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "East US"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
variable "subscription_id" {
    description = "Azure Subscription ID"
    type        = string
    default = "45f251e8-d84d-4b8e-ac63-77eef4482127"
  
}
