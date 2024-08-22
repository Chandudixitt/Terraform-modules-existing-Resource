variable "public_lb_name" {
  description = "The name of the load balancer"
  type        = string
}

variable "location" {
  description = "The location of the resources"
  type        = string
}

variable "virtual_network_id" {
  description = "The vnet id"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "private_ips" {
  description = "List of VM private IPs to associate with the load balancer"
  type        = list(string)
}

variable "health_probe_name" {
  description = "Name of the health probe"
  type        = string
}

variable "probe_port" {
  description = "Port for the health probe"
  type        = number
}

variable "probe_protocol" {
  description = "Protocol for the health probe"
  type        = string
}

variable "load_balancing_rule_name" {
  description = "Name of the load balancing rule"
  type        = string
}

variable "lb_rule_frontend_port" {
  description = "Frontend port for the load balancing rule"
  type        = number
}

variable "lb_rule_backend_port" {
  description = "Backend port for the load balancing rule"
  type        = number
}

variable "lb_rule_protocol" {
  description = "Protocol for the load balancing rule"
  type        = string
}

variable "tags" {
  description = "Tags for the resources"
  type        = map(any)
}

