# # Resource Group info
# variable "resource_group_name" {
#   type        = string
#   # default     = "rg-globalsend"
#   description = "The name of the resource group"
# }

variable "location" {
  type        = string
  default     = "canadacentral"
  description = "Azure region where resources will be deployed"
}

# Deployment environment (e.g., dev, staging)
variable "environment" {
  description = "Deployment environment (dev or staging)."
  type        = string
  default     = "dev"
}
