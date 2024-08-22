terraform {
  backend "azurerm" {
    resource_group_name   = "PrimeSquare-IAC-Resource-Group"
    storage_account_name  = "primesquareiacdemosa"
    container_name        = "terraform-state-cont"
    key                   = "terraform.tfstate"
    use_msi               = true
    client_id             = "9cd0a1f5-d29f-4b48-bc12-4dfd9df70736"
    access_key            = "eQ+vznhoalz+1KUgJZEDlNxcTnK2xXMPRz6cpqlTRiQWf69+31vUj1ZGGZOEFv1fFYhCiY6YcWss+ASt0Nzx9A=="
  }
}

provider "azurerm" {
  skip_provider_registration = true
  features {}

  subscription_id = var.subscription_id
}

resource "tls_private_key" "sshkey" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content  = tls_private_key.sshkey.private_key_pem
  filename = "${path.module}/private_key.pem" 
}

resource "azurerm_storage_blob" "private_ssh_key" {
  name                   = "private_ssh_key.pem"
  storage_account_name   = var.storage_account
  storage_container_name = var.storage_container
  type                   = "Block"
  source                 = local_file.private_key.filename
}

module "subnet" {
  source               = "./modules/subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  subnet_details       = var.subnet_details
  route_table_names    = var.route_table_names 
  route_table_configs  = var.route_table_configs
  location             = var.location
}

module "nsg" {
  source             = "./modules/nsg"
  location           = var.location
  resource_group_name = var.resource_group_name
  nsg_details        = var.nsg_details
  subnet_ids         = module.subnet.subnet_ids
  
  tags               = var.tags
}

resource "azurerm_availability_set" "avset" {
  count               = length(var.availability_set_details)
  name                = var.availability_set_details[count.index].name
  location            = var.location
  resource_group_name = var.resource_group_name
  managed = true
  platform_fault_domain_count  = var.availability_set_details[count.index].fault_domain_count
  platform_update_domain_count = var.availability_set_details[count.index].update_domain_count
}

module "vm" {
  source               = "./modules/PrimeSquare-azure-vm"
  for_each             = { for idx, vm in var.vm_details : vm.vm_name => vm }
  vm_name              = each.value.vm_name
  vm_details           = var.vm_details
  vm_count             = each.value.vm_count
  vm_size              = each.value.vm_size
  os_disk_size         = each.value.os_disk_size
  username             = each.value.username
  os_image             = each.value.os_image
  location             = var.location
  resource_group_name  = var.resource_group_name
  subnet_ids           = [element(module.subnet.subnet_ids, var.vm_subnet_map[each.key])]
  nic_name             = var.nic_name
  ssh_public_key       = tls_private_key.sshkey.public_key_openssh
#  ssh_private_key      = tls_private_key.sshkey.private_key_pem
  assign_public_ip     = (index(keys(var.vm_details), each.key) == 1)
  availability_set_ids  = azurerm_availability_set.avset[*].id
  vm_to_avset_map      = var.vm_to_avset_map

  tags                 = var.tags
}

data "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  resource_group_name = var.resource_group_name
}

module "public_lb" {
  source              = "./modules/public_lb"
  public_lb_name      = var.public_lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  private_ips         = [
    module.vm["PrimeSquare-IAC-Web-1"].private_ips[0],
    module.vm["PrimeSquare-IAC-Web-2"].private_ips[0]
  ]
  virtual_network_id   = data.azurerm_virtual_network.vnet.id  
  health_probe_name        = var.health_probe_name
  probe_port               = var.probe_port
  probe_protocol           = var.probe_protocol
  load_balancing_rule_name = var.load_balancing_rule_name
  lb_rule_frontend_port    = var.lb_rule_frontend_port
  lb_rule_backend_port     = var.lb_rule_backend_port
  lb_rule_protocol         = var.lb_rule_protocol
  tags                     = var.tags
  
  depends_on = [module.vm]
}

module "internal_lb" {
  source              = "./modules/internal_lb"
  internal_lb_name    = var.internal_lb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_ids           = element(module.subnet.subnet_ids, 0)
  private_ips         = [
    module.vm["PrimeSquare-IAC-App-1"].private_ips[0],
    module.vm["PrimeSquare-IAC-App-2"].private_ips[0]
  ]
  virtual_network_id  = data.azurerm_virtual_network.vnet.id
  health_probe_name        = var.internal_health_probe_name
  probe_port               = var.internal_probe_port
  probe_protocol           = var.internal_probe_protocol
  load_balancing_rule_name = var.internal_load_balancing_rule_name
  lb_rule_frontend_port    = var.internal_lb_rule_frontend_port
  lb_rule_backend_port     = var.internal_lb_rule_backend_port
  lb_rule_protocol         = var.internal_lb_rule_protocol
  tags                     = var.tags
  depends_on = [module.vm]
}

#module "azurerm_mysql_flexible_server" {
#  source               = "./modules/mysql_server"
#  mysql_server_name    = var.mysql_server_name
#  location             = var.location
#  resource_group_name  = var.resource_group_name
#  administrator_login  = var.administrator_login
#  administrator_password = var.administrator_password
#  mysql_version        = var.mysql_version
#  sku_name             = var.sku_name
#  storage_mb           = var.storage_mb
#  backup_retention_days = var.backup_retention_days 
#  subnet_ids            = element(module.subnet.subnet_ids, 6)
#  depends_on = [module.internal_lb, module.public_lb]
#}

resource "azurerm_storage_account" "storage" {
  count                    = 1
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  tags = var.tags
}


resource "azurerm_storage_container" "storage_container" {
  count               = 1
  name                = var.storage_container_name
  storage_account_name = azurerm_storage_account.storage[0].name
  container_access_type = var.container_access_type
}

module "nat_gateway" {
  source              = "./modules/nat"
  location            = var.location
  nat_gateway         = var.nat_gateway
  nat-gateway-pip     = var.nat-gateway-pip
  resource_group_name = var.resource_group_name
  subnet_ids          = module.subnet.subnet_ids
}


