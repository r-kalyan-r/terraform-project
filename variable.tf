variable "subscription_id" {
  description = "Az subscription id"
  type        = string
}

variable "location" {
  type        = string
  description = "Location where it installs"
}

variable "rg_name" {
  description = "Az Resources group name"
  type        = string
}

variable "vnet_name" {
  description = "Vnet name"
  type        = string
}

variable "network_interface_name" {
  description = "network interface name"
  type        = string
}

variable "vm_name" {
  description = "VM name"
  type        = string
}
