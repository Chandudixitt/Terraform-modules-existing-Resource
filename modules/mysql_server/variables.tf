variable "mysql_server_name" {
  description = "Name of the MySQL Server"
  type        = string
}

variable "location" {
  description = "location of the resource"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
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

#variable "storage_mb" {
#  description = "Max storage allowed for the MySQL server in MB"
#  type        = number
#  default     = 5120
#}

#variable "subnet_ids" {
#  description = "ID of the subnet where the MySQL Server will be deployed"
#  type        = string
#}


variable "backup_retention_days" {
  description = "backup_retention_days of sql"
  type        = number
}

#variable "auto_grow_enabled" {
#  description = "Boolean value indicating if the storage auto-grow feature is enabled."
#  type        = bool
#  default     = true
#}

variable "geo_redundant_backup_enabled" {
  description = "Boolean value indicating if geo-redundant backup is enabled."
  type        = bool
  default     = false
}
