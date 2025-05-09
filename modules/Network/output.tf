output "nic_id" {
  value = azurerm_network_interface.ni_vm_ui.id # used in VM module, this value is passed to root main.tf 
}