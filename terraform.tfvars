#
subscription_id          = "8137c2f4-3363-4a3b-93f6-c6acd62fbd52"
resource_group_name      = "PrimeSquare-RG-IAC"
location                 = "Central India"
vnet_name                = "PrimeSquare-IAC-VNet"
vnet_address_space       = ["10.10.0.0/24"]
subnet_name              = "PrimeSquare-IAC-Subnet"
subnet_address_prefix    = "10.10.0.0/25"
public_ip_name           = "PrimeSquare-IAC-PublicIP"
nsg_name                 = "PrimeSquare-IAC-NSG"
nic_name                 = "PrimeSquare-IAC-NIC"
vm_name                  = "PrimeSquare-IAC-VM"
vm_size                  = "Standard_DS1_v2"
network_interface_id     = "Primesquare-Network-Interface-ID-IAC"
admin_username           = "azureuser"
admin_ssh_key            = "tls_private_key.example.public_key_openssh"
os_disk_name             = "PrimeSquare-IAC-Disk"
os_disk_size_gb          = "32"
tags = {
  environment = "development"
  project     = "PrimeSquare-IAC"
}

inbound_rules = [
  {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "111.93.10.210/32"
    destination_address_prefix = "*"
  },
  {
    name                       = "AllowHTTP"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "111.93.10.210/32"
    destination_address_prefix = "*"
  }
]

outbound_rules = [
  {
    name                       = "AllowAllOut"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]

