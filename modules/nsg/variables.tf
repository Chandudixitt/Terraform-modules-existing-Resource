variable "location" {
  description = "The location of the resources"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "nsg_details" {
  type = list(object({
    name          = string
    inbound_rules = list(object({
      name              = string
      priority          = number
      direction         = string
      access            = string
      protocol          = string
      source_port_range = string
      destination_port_range = string
      source_address_prefix = string
      destination_address_prefix = string
    }))
    outbound_rules = list(object({
      name              = string
      priority          = number
      direction         = string
      access            = string
      protocol          = string
      source_port_range = string
      destination_port_range = string
      source_address_prefix = string
      destination_address_prefix = string
    }))
  }))
}

variable "subnet_ids" {
  description = "A list of subnet IDs to associate with NSGs"
  type        = list(string)
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(any)
}

