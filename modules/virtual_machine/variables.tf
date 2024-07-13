variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location where the resources will be created"
  type        = string
}

variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "admin_username" {
  description = "The admin username for the virtual machine"
  type        = string
}

variable "admin_ssh_key" {
  description = "The SSH public key for the admin user"
  type        = string
}

variable "network_interface_id" {
  description = "The ID of the network interface"
  type        = string
}

variable "os_disk_size_gb" {
  description = "The size of the OS disk in GB"
  type        = number
}

variable "os_disk_name" {
  description = "The size of the OS disk in GB"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
}


