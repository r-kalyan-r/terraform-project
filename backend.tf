terraform {
  backend "azurerm" {
    resource_group_name   = "dev_eastus_rg_storage_account_backend"
    storage_account_name  = "tfstate34691"
    container_name        = "tfstate"
    key                   = "dev.terraform.tfstate"
  }
}
