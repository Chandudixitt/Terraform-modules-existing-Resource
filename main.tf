terraform {
  backend "azurerm" {
    resource_group_name   = "demosatatergnew"
    storage_account_name  = "demostatesa1234"
    container_name        = "terraform-state-cont"
    key                   = "terraform.tfstate"
    use_msi               = true
    client_id             = "bec1743c-52c4-4fc0-9b37-15f87d3ac7c8"
    access_key            = "Mu6QA+4rXpuRk0tt+zAbk/XMbmowCGcz9sS/JVpBdrjrTCVWgO/eBQvgIwGqd7Ju/Dc8GfoCxr3z+AStfrehyw=="
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

module "subnet" {
  source                = "./modules/subnet"
  resource_group_name   = var.resource_group_name
  virtual_network_name  = var.vnet_name
  subnet_name           = var.subnet_name
  subnet_address_prefix = var.subnet_address_prefix
}

module "public_ip" {
  source                = "./modules/public_ip"
  resource_group_name   = var.resource_group_name
  location              = var.location
  public_ip_name        = var.public_ip_name
  tags                  = var.tags
}

module "network_security_group" {
  source                = "./modules/network_security_group"
  resource_group_name   = var.resource_group_name
  location              = var.location
  nsg_name              = var.nsg_name
  inbound_rules         = var.inbound_rules
  outbound_rules        = var.outbound_rules
  tags                  = var.tags
}

module "network_interface" {
  source                = "./modules/network_interface"
  resource_group_name   = var.resource_group_name
  location              = var.location
  nic_name              = var.nic_name
  subnet_id             = module.subnet.id
  public_ip_id          = module.public_ip.id
  nsg_id                = module.network_security_group.id
  network_interface_id  = module.network_interface.id
  tags                  = var.tags
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

module "virtual_machine" {
  source                = "./modules/virtual_machine"
  resource_group_name   = var.resource_group_name
  location              = var.location
  vm_name               = var.vm_name
  vm_size               = var.vm_size
  admin_username        = var.admin_username
  admin_ssh_key         = tls_private_key.example.public_key_openssh
  subnet_id             = module.subnet.id
  os_disk_name          = var.os_disk_name
  os_disk_size_gb       = var.os_disk_size_gb
  network_interface_id  = module.network_interface.id
  tags                  = var.tags
}

output "tls_private_key" {
  value     = tls_private_key.example.private_key_pem
  sensitive = true
}
