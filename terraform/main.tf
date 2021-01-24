terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "rrm86"

    workspaces {
      name = "Agile_ML_Engineer"
    }
  }
}

provider "azurerm" {
  version         = "=2.44.0"
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  features {}
}

data "azurerm_resource_group" "rg" {
  name = "${var.prefix}-rg"
}

resource "azurerm_app_service_plan" "plan" {
  name                = "${var.prefix}-appserviceplan"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true
  sku {
    capacity = 1
    size     = "B1"
    tier     = "Standard"
  }
}

resource "azurerm_app_service" "app" {
  name                = "${var.prefix}-app-service"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  app_service_plan_id = data.azurerm_app_service_plan.plan.id

  site_config {
    linux_fx_version    = "PYTHON|3.7"
    local_mysql_enabled = false
  }

}