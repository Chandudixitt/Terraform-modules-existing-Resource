#
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location where the resources will be created"
  type        = string
}

variable "nic_name" {
  description = "The name of the network interface"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
}

variable "public_ip_id" {
  description = "The ID of the public IP"
  type        = string
}

variable "nsg_id" {
  description = "The ID of the network security group"
  type        = string
}

variable "network_interface_id" {
  description = "The ID of the network interface"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
}

