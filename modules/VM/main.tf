resource "azurerm_linux_virtual_machine" "vm_ui" {
  name                = var.vm_name
  resource_group_name = var.rg_name
  location            = var.location
  size                = "Standard_B2s"
  admin_username      = "azureuser"
  network_interface_ids = [
    var.nic_id
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/azure/azure_vm_key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

## Auto Shutdown config

resource "azurerm_dev_test_global_vm_shutdown_schedule" "vm_ui_shutdown" {
  virtual_machine_id = azurerm_linux_virtual_machine.vm_ui.id
  location           = var.location
  enabled            = true

  daily_recurrence_time = "1900" # 7:00 PM (24-hour format)
  timezone              = "India Standard Time"

  notification_settings {
    enabled         = false
    time_in_minutes = "60"
    webhook_url     = null
  }
}

## Run scripts after boot up

resource "azurerm_virtual_machine_extension" "nginx_install" {
  name                 = "nginx-install"
  virtual_machine_id   = azurerm_linux_virtual_machine.vm_ui.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
      "commandToExecute": "sudo apt-get update && sudo apt-get install -y nginx && sudo systemctl enable nginx && sudo systemctl start nginx"
    }
SETTINGS
}