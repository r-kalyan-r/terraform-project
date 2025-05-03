output "storage_account_name" {
  value = azurerm_storage_account.storage_account.name
}

output "container_name" {
  value = azurerm_storage_container.container_tfstate.name
}

output "resource_group_name" {
  value = azurerm_storage_account.storage_account.resource_group_name
}