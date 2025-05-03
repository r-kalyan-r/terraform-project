resource "azurerm_resource_group" "example" {
  name     = var.rg_name
  location = var.location
}
resource "azurerm_storage_account" "storage_account" {
  name                     = "tfstate${random_integer.unique.result}"
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container_tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.storage_account.id
  container_access_type = "private"
}

resource "random_integer" "unique" {
  min = 10000
  max = 99999
}
