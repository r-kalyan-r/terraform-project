resource "azurerm_resource_group" "rg_vm_ui" {
    name = var.rg_name
    location = var.location 
}

resource "azurerm_virtual_network" "vnet_vm_ui" {
  name                = var.vnet_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg_vm_ui.location
  resource_group_name = azurerm_resource_group.rg_vm_ui.name
}

resource "azurerm_subnet" "subnet_vm_ui" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg_vm_ui.name
  virtual_network_name = azurerm_virtual_network.vnet_vm_ui.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "ni_vm_ui" {
  name                = var.network_interface_name
  location            = azurerm_resource_group.rg_vm_ui.location
  resource_group_name = azurerm_resource_group.rg_vm_ui.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_vm_ui.id
    private_ip_address_allocation = "Dynamic"
  }
}
