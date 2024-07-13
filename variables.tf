variable "subscription_id" {
  description = "The subscription ID for Azure"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location where the resources will be created"
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space of the virtual network"
  type        = list(string)
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "subnet_address_prefix" {
  description = "The address prefix of the subnet"
  type        = string
}

variable "public_ip_name" {
  description = "The name of the public IP"
  type        = string
}

variable "nsg_name" {
  description = "The name of the Network Security Group"
  type        = string
}

variable "inbound_rules" {
  description = "The inbound security rules"
  type        = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "outbound_rules" {
  description = "The outbound security rules"
  type        = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
}

variable "vm_name" {
  description = "The name of the virtual machine"
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
}

variable "network_interface_id" {
  description = "The name of the network interface id"
  type        = string
}

variable "nic_name" {
  description = "The name of the network interface"
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

variable "os_disk_name" {
  description = "The name of the OS disk"
  type        = string
}

variable "os_disk_size_gb" {
  description = "The size of the OS disk in GB"
  type        = number
}

variable "ssh_key_path" {
  description = "The path to the SSH public key"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
}
