provider "azurerm" {
  features {}
}
##

locals {
  docker_image = "${module.acr.login_server}/globalsend-site:v3"
}

########################
# Resource Group
########################
resource "azurerm_resource_group" "rg" {
  name     = "globalsend-${var.environment}-rg"
  location = var.location
}


########################
# ACR Module
########################
module "acr" {
  source              = "./modules/acr"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

########################
# App Service Module
########################
module "app_service" {
source = "./modules/app-service"
acr_id = module.acr.id
resource_group_name = azurerm_resource_group.rg.name
location            = azurerm_resource_group.rg.location
docker_image_name   = local.docker_image

}
