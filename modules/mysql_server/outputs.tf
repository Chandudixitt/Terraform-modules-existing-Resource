output "mysql_server_fqdn" {
  description = "The fully qualified domain name of the MySQL server"
  value       = azurerm_mysql_flexible_server.this.fqdn
}

output "mysql_server_id" {
  description = "The ID of the MySQL server"
  value       = azurerm_mysql_flexible_server.this.id
}

