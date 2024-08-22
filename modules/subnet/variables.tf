variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the vnet"
  type        = string
}

#variable "subnet_count" {
#  description = "The number of subnets to create"
#  type        = number
#}

variable "location" {
  description = "The Azure location where resources will be created"
  type        = string
}

variable "subnet_details" {
  type = list(object({
    name            = string
    address_prefix  = string
  }))
}

variable "route_table_names" {
  type = list(string)
}

variable "route_table_configs" {
  description = "Configuration for the route tables"
  type = list(object({
    route_address_prefixes = list(string)
    next_hop_type         = string
    additional_next_hop_type = optional(string)
    additional_address_prefix = optional(string)
  }))
}
