terraform {
  backend "azurerm" {
    resource_group_name  = "terraform"
    storage_account_name = "terraformstate5546"
    container_name       = "tfstate"
    key                  = "development.terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    azuread = {
      source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {
}
