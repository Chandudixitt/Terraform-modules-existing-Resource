variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location where the resources will be created"
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

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
}

