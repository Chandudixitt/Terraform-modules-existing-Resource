resource "azurerm_subnet" "subnet" {
  count                = length(var.subnet_details)
  name                 = var.subnet_details[count.index].name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.subnet_details[count.index].address_prefix]
}

resource "azurerm_route_table" "rt" {
  count                = length(var.route_table_configs)
  name                 = var.route_table_names[count.index]
  location             = var.location
  resource_group_name  = var.resource_group_name

  route {
    name           = "local"
    address_prefix = var.route_table_configs[count.index].route_address_prefixes[1]  
    next_hop_type  = var.route_table_configs[count.index].next_hop_type
  }

  route {
    name           = "local2"
    address_prefix = var.route_table_configs[count.index].route_address_prefixes[2] 
    next_hop_type  = var.route_table_configs[count.index].next_hop_type
  }

  dynamic "route" {
    for_each = count.index == 2 ? [1] : []
    content {
      name           = "internet"
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "Internet"
    }
  }
}

resource "azurerm_subnet_route_table_association" "rt_association" {
  count          = length(azurerm_subnet.subnet)  # Total number of associations needed
  subnet_id      = azurerm_subnet.subnet[count.index].id
  route_table_id = azurerm_route_table.rt[floor(count.index / 2)].id
}


output "subnet_ids" {
  description = "The IDs of the subnets"
  value       = azurerm_subnet.subnet[*].id
}
