resource "azurerm_mysql_flexible_server" "this" {
  name                = var.mysql_server_name
  location            = var.location
  resource_group_name = var.resource_group_name
#  delegated_subnet_id = var.subnet_ids
  administrator_login          = var.administrator_login
  administrator_password       = var.administrator_password

  sku_name   = var.sku_name
#  storage_mb = var.storage_mb
  version    = var.mysql_version

#  auto_grow_enabled                 = var.auto_grow_enabled
  backup_retention_days             = var.backup_retention_days
  geo_redundant_backup_enabled      = var.geo_redundant_backup_enabled
}
