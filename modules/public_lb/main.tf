resource "azurerm_lb" "public_lb" {
  name                = var.public_lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "primeSquare_IAC_public_lb_frontend_ip"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "public_backend_pool" {
  name            = "PrimeSquare_IAC_Public_BackendPool"
  loadbalancer_id = azurerm_lb.public_lb.id
}

resource "azurerm_public_ip" "public_ip" {
  name                = "${var.public_lb_name}-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb_backend_address_pool_address" "public_lb_association" {
#  count                   = 2
  name                    = "PrimeSquare_IAC_public_lb_backend_pool_addess-${count.index+1}"
  count                   = length(var.private_ips)
  backend_address_pool_id = azurerm_lb_backend_address_pool.public_backend_pool.id
  virtual_network_id      = var.virtual_network_id
  ip_address              = var.private_ips[count.index]
# ip_address              = var.private_ips[count.index % length(var.private_ips)]
  
  depends_on = [
    azurerm_lb.public_lb,
    azurerm_lb_backend_address_pool.public_backend_pool
  ]
}

resource "azurerm_lb_probe" "health_probe" {
  name                = var.health_probe_name
  loadbalancer_id     = azurerm_lb.public_lb.id
  protocol            = var.probe_protocol
  port                = var.probe_port
#  request_path = var.probe_protocol == "Http" || var.probe_protocol == "Https" ? "/" : null

  depends_on = [
    azurerm_lb.public_lb,
    azurerm_lb_backend_address_pool.public_backend_pool
  ]
}

resource "azurerm_lb_rule" "load_balancing_rule" {
  name                           = var.load_balancing_rule_name
  loadbalancer_id                = azurerm_lb.public_lb.id
  protocol                       = var.lb_rule_protocol
  frontend_port                  = var.lb_rule_frontend_port
  backend_port                   = var.lb_rule_backend_port
  frontend_ip_configuration_name = azurerm_lb.public_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = azurerm_lb_backend_address_pool.public_backend_pool[*].id
  probe_id                       = azurerm_lb_probe.health_probe.id

  depends_on = [
    azurerm_lb.public_lb,
    azurerm_lb_backend_address_pool.public_backend_pool
  ]
}

output "public_lb_id" {
  value = azurerm_lb.public_lb.id
}

output "public_backend_pool_id" {
  value = azurerm_lb_backend_address_pool.public_backend_pool.id
}

