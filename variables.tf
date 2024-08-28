variable "subscription_id" {
  description = "The name of the subscription id"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "virtual_network_name" {
  description = "The names of the vnet"
  type        = string
}

#variable "subnet_ids" {
#  description = "The ID of the subnet"
#  type        = list(string)
#}

variable "route_table_configs" {
  description = "Configuration for each route table, including address prefixes and next hop types."
  type = list(object({
    route_address_prefixes = list(string)
    next_hop_type          = string
  }))
}

variable "availability_set_details" {
  description = "Details of the availability sets"
  type = list(object({
    name = string
    fault_domain_count    = number
    update_domain_count   = number
  }))
}

variable "nic_name" {
  description = "The name of the nic"
  type        = string
}

variable "storage_account" {
  description = "storage account name"
  type        = string
}

variable "storage_container" {
  description = "storage container name"
  type        = string
}

variable "os_disk_storage_account_type" {
  description = "(Optional) Specifies the storage account type of the os disk of the virtual machine"
  default     = "Standard_LRS"
  type        = string
}

variable "vm_details" {
  type = map(object({
    vm_count    = number
    vm_name     = string
    vm_size     = string
    disk_type   = string
    os_disk_size = number
    username    = string
    os_image    = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  }))
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
      destination_port_ranges = list(any)
      source_address_prefixes = list(any)
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

variable "public_lb_name" {
  description = "The name of the load balancer"
  type        = string
}

variable "tags" {
  type        = map(any)
  description = "Tags for the resources"
}

variable "internal_lb_name" {
  description = "The name of the internal-private load balancer"
  type        = string
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

variable "internal_health_probe_name" {
  description = "Name of the health probe for the internal LB"
  type        = string
}

variable "internal_probe_port" {
  description = "Port for the health probe"
  type        = number
}

variable "internal_probe_protocol" {
  description = "Protocol for the health probe"
  type        = string
}

variable "internal_load_balancing_rule_name" {
  description = "Name of the load balancing rule for the internal LB"
  type        = string
}

variable "internal_lb_rule_frontend_port" {
  description = "Frontend port for the load balancing rule"
  type        = number
}

variable "internal_lb_rule_backend_port" {
  description = "Backend port for the load balancing rule"
  type        = number
}

variable "internal_lb_rule_protocol" {
  description = "Protocol for the load balancing rule"
  type        = string
}

variable "mysql_server_name" {
  description = "Name of the MySQL Server"
  type        = string
}

variable "administrator_login" {
  description = "Admin username for MySQL server"
  type        = string
}

variable "administrator_password" {
  description = "Admin password for MySQL server"
  type        = string
  sensitive   = true
}

variable "mysql_version" {
  description = "Version of MySQL"
  type        = string
  default     = "8.0.21"
}

variable "sku_name" {
  description = "SKU for the MySQL server"
  type        = string
  default     = "GP_Standard_D4ads_v5"
}

variable "storage_mb" {
  description = "Max storage allowed for the MySQL server in MB"
  type        = number
  default     = 5120
}

variable "backup_retention_days" {
  description = "backup_retention_days of sql"
  type        = number
}

variable "vm_to_avset_map" {
  description = "Map of VM names to availability set indices"
  type        = map(number)
  default     = {
    "PrimeSquare-IAC-Web-1"  = 0
    "PrimeSquare-IAC-Web-2"  = 0
    "PrimeSquare-IAC-App-1"  = 1
    "PrimeSquare-IAC-App-2"  = 1
    "PrimeSquare-IAC-Kafka-1"  = 2
    "PrimeSquare-IAC-Kafka-2"  = 2
    "PrimeSquare-IAC-ZK-1"  = 2
    "PrimeSquare-IAC-ZK-2"  = 2
    "PrimeSquare-IAC-ZK-3"  = 2
  }
}

variable "vm_subnet_map" {
  description = "Mapping of VM names to subnet indexes"
  type = map(number)
  default = {
    "PrimeSquare-IAC-App-1" = 0  
    "PrimeSquare-IAC-App-2" = 1 
    "PrimeSquare-IAC-Kafka-1" = 2  
    "PrimeSquare-IAC-Kafka-2" = 3  
    "PrimeSquare-IAC-Web-1" = 4  
    "PrimeSquare-IAC-Web-2" = 5 
    "PrimeSquare-IAC-ZK-1" = 2  
    "PrimeSquare-IAC-ZK-2" = 2  
    "PrimeSquare-IAC-ZK-3" = 3 
  }
}

variable "storage_account_name" {
  type = string
}

variable "account_tier" {
  type = string
}

variable "account_replication_type" {
  type = string
}

variable "storage_container_name" {
  type = string
}

variable "container_access_type" {
  type    = string
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

variable "nat-gateway-pip" {
  description = "ip of NAT Gateway"
  type        = string
}

variable "nat_gateway" {
  description = "name of NAT Gateway"
  type        = string
}

#variable "ssh_private_key" {
#  description = "ssh private key of VMs"
#  type        = string
#}


