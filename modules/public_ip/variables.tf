variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location where the resources will be created"
  type        = string
}

variable "public_ip_name" {
  description = "The name of the public IP"
  type        = string
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
}

