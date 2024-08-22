resource "azurerm_lb" "internal_lb" {
  name                = var.internal_lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "primeSquare_IAC_internal_lb_frontend_ip"
    subnet_id            = var.subnet_ids
    private_ip_address_allocation = "Dynamic"
  }

 tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "internal_backend_pool" {
  name                = "PrimeSquare_IAC_internal_BackendPool"
  loadbalancer_id     = azurerm_lb.internal_lb.id
}

resource "azurerm_lb_backend_address_pool_address" "internal_lb_association" {
  count                   = 2
  name                    = "PrimeSquare_IAC_internal_lb_backend_pool_address-${count.index+1}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.internal_backend_pool.id
  virtual_network_id      = var.virtual_network_id
  ip_address              = var.private_ips[count.index]
  
  depends_on = [
    azurerm_lb.internal_lb,
    azurerm_lb_backend_address_pool.internal_backend_pool
  ]
}

resource "azurerm_lb_probe" "health_probe" {
  name                = var.health_probe_name
  loadbalancer_id     = azurerm_lb.internal_lb.id
  protocol            = var.probe_protocol
  port                = var.probe_port
#  request_path        = "/"

  depends_on = [
    azurerm_lb.internal_lb,
    azurerm_lb_backend_address_pool.internal_backend_pool
  ]
}

resource "azurerm_lb_rule" "load_balancing_rule" {
  name                           = var.load_balancing_rule_name
  loadbalancer_id                = azurerm_lb.internal_lb.id
  protocol                       = var.lb_rule_protocol
  frontend_port                  = var.lb_rule_frontend_port
  backend_port                   = var.lb_rule_backend_port
  frontend_ip_configuration_name = azurerm_lb.internal_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids        = azurerm_lb_backend_address_pool.internal_backend_pool[*].id
  probe_id                       = azurerm_lb_probe.health_probe.id
 
  depends_on = [
    azurerm_lb.internal_lb,
    azurerm_lb_backend_address_pool.internal_backend_pool
  ]
}


output "internal_lb_id" {
  value = azurerm_lb.internal_lb.id
}

output "internal_backend_pool_id" {
  value = azurerm_lb_backend_address_pool.internal_backend_pool.id
}

