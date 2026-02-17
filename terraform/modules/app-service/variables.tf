# Resource Group info
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region where resources will be deployed"
}

# App Service Plan
variable "plan_name" {
  type        = string
  default     = "plan-globalsend"
  description = "Name of the App Service Plan"
}

variable "plan_tier" {
  type        = string
  default     = "Basic"
  description = "Tier of the App Service Plan (e.g., Basic, Standard)"
}

variable "plan_size" {
  type        = string
  default     = "B1"
  description = "Size of the App Service Plan (e.g., B1, S1)"
}

# Web App
variable "app_name" {
  type        = string
  default     = "app-globalsend"
  description = "Name of the Linux Web App"
}

# Container  ACR
variable "acr_id" {
  type        = string
  description = "The ID of the Azure Container Registry (must be set if using an existing ACR)"
}

variable "acr_login_server" {
  type        = string
  default     = ""
  description = "Login server URL of the Azure Container Registry (set if using existing ACR)"
}

variable "image_name" {
  type        = string
  default     = "globalsend-site"
  description = "Name of the container image to deploy"
}

variable "image_tag" {
  type        = string
  default     = "latest"
  description = "Tag of the container image"
}

variable "container_port" {
  type        = string
  default     = "80"
  description = "Port that the container exposes"
}

variable "docker_image_name" {
  type        = string
  description = "Full docker image path to deploy"
}
