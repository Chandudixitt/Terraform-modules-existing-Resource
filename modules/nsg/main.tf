resource "azurerm_network_security_group" "nsg" {
  count               = length(var.nsg_details)
  name                = var.nsg_details[count.index].name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.nsg_details[count.index].inbound_rules
    content {
      name                        = security_rule.value.name
      priority                    = security_rule.value.priority
      direction                   = security_rule.value.direction
      access                      = security_rule.value.access
      protocol                    = security_rule.value.protocol
      source_port_range           = security_rule.value.source_port_range
      destination_port_range      = security_rule.value.destination_port_range
      source_address_prefix       = security_rule.value.source_address_prefix
      destination_address_prefix  = security_rule.value.destination_address_prefix
    }
  }

  dynamic "security_rule" {
    for_each = var.nsg_details[count.index].outbound_rules
    content {
      name                        = security_rule.value.name
      priority                    = security_rule.value.priority
      direction                   = security_rule.value.direction
      access                      = security_rule.value.access
      protocol                    = security_rule.value.protocol
      source_port_range           = security_rule.value.source_port_range
      destination_port_range      = security_rule.value.destination_port_range
      source_address_prefix       = security_rule.value.source_address_prefix
      destination_address_prefix  = security_rule.value.destination_address_prefix
    }
  }

 tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  count                      = length(var.subnet_ids)
  subnet_id                  = var.subnet_ids[count.index]
  network_security_group_id  = azurerm_network_security_group.nsg[count.index < 2 ? 0 : (count.index < 4 ? 1 : (count.index < 6 ? 2 : 1))].id 
}

output "nsg_ids" {
  description = "The IDs of the created NSGs"
  value       = azurerm_network_security_group.nsg[*].id
}

