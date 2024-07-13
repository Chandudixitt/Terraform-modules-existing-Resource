#
resource "azurerm_network_security_group" "main" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "inbound" {
  count = length(var.inbound_rules)

  name                        = var.inbound_rules[count.index].name
  priority                    = var.inbound_rules[count.index].priority
  direction                   = var.inbound_rules[count.index].direction
  access                      = var.inbound_rules[count.index].access
  protocol                    = var.inbound_rules[count.index].protocol
  source_port_range           = var.inbound_rules[count.index].source_port_range
  destination_port_range      = var.inbound_rules[count.index].destination_port_range
  source_address_prefix       = var.inbound_rules[count.index].source_address_prefix
  destination_address_prefix  = var.inbound_rules[count.index].destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.main.name
}

resource "azurerm_network_security_rule" "outbound" {
  count = length(var.outbound_rules)

  name                        = var.outbound_rules[count.index].name
  priority                    = var.outbound_rules[count.index].priority
  direction                   = var.outbound_rules[count.index].direction
  access                      = var.outbound_rules[count.index].access
  protocol                    = var.outbound_rules[count.index].protocol
  source_port_range           = var.outbound_rules[count.index].source_port_range
  destination_port_range      = var.outbound_rules[count.index].destination_port_range
  source_address_prefix       = var.outbound_rules[count.index].source_address_prefix
  destination_address_prefix  = var.outbound_rules[count.index].destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.main.name
}

