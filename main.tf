module "network" {
  source                 = "./modules/Network"
  location               = var.location
  rg_name                = var.rg_name
  vnet_name              = var.vnet_name
  network_interface_name = var.network_interface_name
}

module "vm_ui" {
  source                 = "./modules/VM"
  vm_name                = var.vm_name
  location               = var.location
  rg_name                = var.rg_name
  vnet_name              = var.vnet_name
  network_interface_name = var.network_interface_name
  nic_id                 = module.network.nic_id ## Take the value of the nic_id output from the network module and assign it to the nic_id input variable of the vm module
}
