subscription_id     = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
resource_group_name = "PrimeSquare-IAC-Resource-Group"
location            = "Central India"
virtual_network_name = "PrimeSquare-IAC-VNET"

subnet_details = [
  { name = "Private-subnet-2a", address_prefix = "10.2.0.64/27" },
  { name = "Private-subnet-2b", address_prefix = "10.2.0.96/27" },
  { name = "Private-subnet-3a", address_prefix = "10.2.0.128/27" },
  { name = "Private-subnet-3b", address_prefix = "10.2.0.160/27" },
  { name = "Public-subnet-1a", address_prefix = "10.2.0.0/27" },
  { name = "Public-subnet-1b", address_prefix = "10.2.0.32/27" },
  { name = "Private-subnet-4a", address_prefix = "10.2.0.192/27" },
  { name = "Private-subnet-4b", address_prefix = "10.2.0.224/27" }
]

route_table_names = [
  "PrimeSquare-IAC-APP-RT",
  "PrimeSquare-IAC-MSG-RT",
  "PrimeSquare-IAC-WEb-RT-Public",
  "PrimeSquare-IAC-DB-RT"
]

route_table_configs = [
  {
    name          = "PrimeSquare-IAC-APP-RT"
    route_address_prefixes = ["0.0.0.0/0", "10.2.0.64/27", "10.2.0.96/27"]
    next_hop_type = "VnetLocal"
  },
  {
    name          = "PrimeSquare-IAC-MSG-RT"
    route_address_prefixes = ["0.0.0.0/0", "10.2.0.128/27", "10.2.0.160/27"]
    next_hop_type = "VnetLocal"
  },
  {
    name          = "PrimeSquare-IAC-WEb-RT-Public"
    route_address_prefixes = ["0.0.0.0/0", "10.2.0.0/27", "10.2.0.32/27"]
    next_hop_type = "VnetLocal"
  },
  {
    name          = "PrimeSquare-IAC-DB-RT"
    route_address_prefixes = ["0.0.0.0/0", "10.2.0.192/27", "10.2.0.224/27"]
    next_hop_type = "VnetLocal"
  }
]

availability_set_details = [
  { name = "PrimeSquare-IAC-webserver-avset", fault_domain_count = 2, update_domain_count = 5 },
  { name = "PrimeSquare-IAC-appserver-avset", fault_domain_count = 2, update_domain_count = 5 },
  { name = "PrimeSquare-IAC-MSGserver-avset", fault_domain_count = 2, update_domain_count = 5 }
]

nic_name            = "PrimeSquare-IAC-NIC"
#nsg_name            = "PrimeSquare-IAC-NSG"
storage_account     = "primesquareiacdemosa"
storage_container   = "terraform-private-key"

vm_details = {
    "PrimeSquare-IAC-Web-1" = {
      vm_name      = "PrimeSquare-IAC-Web-1"
      vm_count     = 1
      vm_size      = "Standard_DS1_v2"
      disk_type    = "Standard_LRS"
      os_disk_size = 32
      username     = "azureuser"
      os_image = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-LTS"
        version   = "latest"
      }
    },
    "PrimeSquare-IAC-Web-2" = {
      vm_name      = "PrimeSquare-IAC-Web-2"
      vm_count     = 1
      vm_size      = "Standard_DS1_v2"
      disk_type    = "Standard_LRS"
      os_disk_size = 32
      username     = "azureuser"
      os_image = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-LTS"
        version   = "latest"
      }
    },
    "PrimeSquare-IAC-App-1" = {
      vm_name      = "PrimeSquare-IAC-App-1"
      vm_count     = 1
      vm_size      = "Standard_DS1_v2"
      disk_type    = "Standard_LRS"
      os_disk_size = 32
      username     = "azureuser"
      os_image = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-LTS"
        version   = "latest"
      }
    },
    "PrimeSquare-IAC-App-2" = {
      vm_name      = "PrimeSquare-IAC-App-2"
      vm_count     = 1
      vm_size      = "Standard_DS1_v2"
      disk_type    = "Standard_LRS"
      os_disk_size = 32
      username     = "azureuser"
      os_image = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-LTS"
        version   = "latest"
      }
    },
    "PrimeSquare-IAC-Kafka-1" = {
      vm_name      = "PrimeSquare-IAC-Kafka-1"
      vm_count     = 1
      vm_size      = "Standard_DS1_v2"
      disk_type    = "Standard_LRS"
      os_disk_size = 32
      username     = "azureuser"
      os_image = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-LTS"
        version   = "latest"
      }
    },
    "PrimeSquare-IAC-Kafka-2" = {
      vm_name      = "PrimeSquare-IAC-Kafka-2"
      vm_count     = 1
      vm_size      = "Standard_DS1_v2"
      disk_type    = "Standard_LRS"
      os_disk_size = 32
      username     = "azureuser"
      os_image = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-LTS"
        version   = "latest"
      }
    },
    "PrimeSquare-IAC-ZK-1" = {
      vm_name      = "PrimeSquare-IAC-ZK-1"
      vm_count     = 1
      vm_size      = "Standard_DS1_v2"
      disk_type    = "Standard_LRS"
      os_disk_size = 32
      username     = "azureuser"
      os_image = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-LTS"
        version   = "latest"
      }
    },
    "PrimeSquare-IAC-ZK-2" = {
      vm_name      = "PrimeSquare-IAC-ZK-2"
      vm_count     = 1
      vm_size      = "Standard_DS1_v2"
      disk_type    = "Standard_LRS"
      os_disk_size = 32
      username     = "azureuser"
      os_image = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-LTS"
        version   = "latest"
      }
    },
    "PrimeSquare-IAC-ZK-3" = {
      vm_name      = "PrimeSquare-IAC-ZK-3"
      vm_count     = 1
      vm_size      = "Standard_DS1_v2"
      disk_type    = "Standard_LRS"
      os_disk_size = 32
      username     = "azureuser"
      os_image = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-LTS"
        version   = "latest"
      }
    }
}

nsg_details = [
  {
    name          = "PrimeSquare-APP-NSG"
    inbound_rules = [
      {
        name              = "AllowallSsh"
        priority          = 100
        direction         = "Inbound"
        access            = "Allow"
        protocol          = "Tcp"
        source_port_range = "*"
        destination_port_range = "22"
        source_address_prefix = "*"
        destination_address_prefix = "*"
      },
      {
        name                    = "Alloweb1ip"
        priority                = 200
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_port_range       = "3804"
        destination_port_range  = "3804"
        source_address_prefix   = "4.213.165.126/32"
        destination_address_prefix = "*"
      },
      {
        name                    = "Alloweb2ip"
        priority                = 201
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_port_range       = "3804"
        destination_port_range  = "3804"
        source_address_prefix   = "4.213.164.96/32"
        destination_address_prefix = "*"
      },
      {
        name                    = "Alloweblbip"
        priority                = 202
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_port_range       = "3804"
        destination_port_range  = "3804"
        source_address_prefix   = "4.213.166.205/32"
        destination_address_prefix = "*"
      }
    ]
    outbound_rules = [
      {
        name              = "default-outbound"
        priority          = 100
        direction         = "Outbound"
        access            = "Allow"
        protocol          = "*"
        source_port_range = "*"
        destination_port_range = "*"
        source_address_prefix = "*"
        destination_address_prefix = "*"
      }
    ]	
  },
  {
    name          = "PrimeSquare-MSG-NSG"
    inbound_rules = [
      {
        name              = "Allowapp1ip"
        priority          = 200
        direction         = "Inbound"
        access            = "Allow"
        protocol          = "Tcp"
        source_port_range = "3306"
        destination_port_range = "3306"
        source_address_prefix = "10.2.0.68/32"
        destination_address_prefix = "*"
      },
      {
        name                    = "Allowapp2ip"
        priority                = 201
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_port_range       = "3306"
        destination_port_range  = "3306"
        source_address_prefix   = "10.2.0.72/32"
        destination_address_prefix = "*"
      },
      {
        name                    = "Allowapplbip"
        priority                = 202
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_port_range       = "3306"
        destination_port_range  = "3306"
        source_address_prefix   = "4.213.225.29/32"
        destination_address_prefix = "*"
      }
    ]
    outbound_rules = [
      {
        name              = "default-outbound"
        priority          = 100
        direction         = "Outbound"
        access            = "Allow"
        protocol          = "*"
        source_port_range = "*"
        destination_port_range = "*"
        source_address_prefix = "*"
        destination_address_prefix = "*"
      }
    ]
  },
  {
    name          = "PrimeSquare-WEB-NSG"
    inbound_rules = [
      {
        name              = "Allowssh"
        priority          = 300
        direction         = "Inbound"
        access            = "Allow"
        protocol          = "Tcp"
        source_port_range = "*"
        destination_port_range = "22"
        source_address_prefix = "*"
        destination_address_prefix = "*"
      },
      {
        name                    = "Allowhttps"
        priority                = 200
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_port_range       = "443"
        destination_port_range  = "443"
        source_address_prefix   = "*"
        destination_address_prefix = "*"
      }
    ]
    outbound_rules = [
      {
        name              = "default-outbound"
        priority          = 100
        direction         = "Outbound"
        access            = "Allow"
        protocol          = "*"
        source_port_range = "*"
        destination_port_range = "*"
        source_address_prefix = "*"
        destination_address_prefix = "*"
      }
    ]
  },
  {
    name          = "PrimeSquare-DB-NSG"
    inbound_rules = [
      {
        name              = "Allowhttp"
        priority          = 300
        direction         = "Inbound"
        access            = "Allow"
        protocol          = "Tcp"
        source_port_range = "*"
        destination_port_range = "80"
        source_address_prefix = "*"
        destination_address_prefix = "*"
      },
      {
        name                    = "AllowSsh"
        priority                = 200
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_port_range       = "*"
        destination_port_range  = "22"
        source_address_prefix   = "*"
        destination_address_prefix = "*"
      }
    ]
    outbound_rules = [
      {
        name              = "default-outbound"
        priority          = 100
        direction         = "Outbound"
        access            = "Allow"
        protocol          = "*"
        source_port_range = "*"
        destination_port_range = "*"
        source_address_prefix = "*"
        destination_address_prefix = "*"
      }
    ]
  }
]




public_lb_name = "PrimeSquare-IAC-public-web-lb"
health_probe_name        = "PrimeSquare-IAC-public-lb-health-probe"
probe_port               = 443
probe_protocol           = "Tcp"
load_balancing_rule_name = "public-lb-rule"
lb_rule_frontend_port    = 443
lb_rule_backend_port     = 3804
lb_rule_protocol         = "Tcp"


internal_lb_name = "PrimeSquare-IAC-internal-app-lb"
internal_health_probe_name  = "PrimeSquare-IAC-internal-lb-health-probe"
internal_probe_port         = 3306
internal_probe_protocol     = "Tcp"
internal_load_balancing_rule_name = "PrimeSquare-internal-lb-rule"
internal_lb_rule_frontend_port = 3306
internal_lb_rule_backend_port = 3306
internal_lb_rule_protocol   = "Tcp"


mysql_server_name = "primesquareiacmysqlserver"
administrator_login = "useradminprime"
administrator_password = "H@Sh1CoR3!"
backup_retention_days = 7
#geo_redundant_backup_enabled = "flase"

storage_account_name    = "primesquareiacsa"
account_tier            = "Standard"
account_replication_type = "LRS"
storage_container_name = "primesuqare-iac-container"
container_access_type  = "private"

nat-gateway-pip = "Primesquare-IAC-nat-gateway-pip"
nat_gateway = "Primesquare-IAC-nat-gateway"
#ssh_private_key = "/home/ubuntu/Terraform-avset-code/avset-terra-code-old/private_key.pem"

tags = {
  Environment = "Development"
  Project     = "PrimeSquare-IAC"
}
