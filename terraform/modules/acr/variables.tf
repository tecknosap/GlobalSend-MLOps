variable "acr_name" {
  type        = string
  default     = "acrglobalsend"
  description = "Azure Container Registry name (must be globally unique, 5–50 lowercase alphanumeric characters)"
}


variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "sku" {
  type    = string
  default = "Basic"
}
