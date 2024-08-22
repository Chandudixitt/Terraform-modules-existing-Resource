resource "azurerm_public_ip" "nat_public_ip" {
  name                = var.nat-gateway-pip
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "nat_gateway" {
  name                = var.nat_gateway
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name            = "Standard"

  idle_timeout_in_minutes = 4

  depends_on = [azurerm_public_ip.nat_public_ip]
}

resource "azurerm_nat_gateway_public_ip_association" "main" {
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
  public_ip_address_id = azurerm_public_ip.nat_public_ip.id
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = azurerm_nat_gateway.nat_gateway.id
}

