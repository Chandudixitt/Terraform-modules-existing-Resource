variable "location" {
  description = "Location where the resources will be created"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "subnet_ids" {
  description = "List of Subnet IDs to associate with the NAT Gateway"
  type        = list(string)
}

#variable "public_ip_id" {
#  type        = string
#  description = "Public IP address ID for the NAT Gateway."
#}


variable "nat-gateway-pip" {
  description = "ip of NAT Gateway"
  type        = string
}

variable "nat_gateway" {
  description = "name of NAT Gateway"
  type        = string
}
