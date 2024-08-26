resource "azurerm_network_interface" "nic" {
  count               = var.vm_count
  name                = "${var.vm_name}-NIC"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = element(var.subnet_ids, count.index)
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = contains(["PrimeSquare-IAC-Web-1", "PrimeSquare-IAC-Web-2"], var.vm_name) ? azurerm_public_ip.pubip[count.index].id : null
  }
    tags = var.tags
}

resource "azurerm_public_ip" "pubip" {
  count               = contains(["PrimeSquare-IAC-Web-1", "PrimeSquare-IAC-Web-2"], var.vm_name) ? 1 : 0
  name                = "${var.vm_name}-Public-IP"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"

  tags = var.tags
}

resource "azurerm_virtual_machine" "vm" {
  count                = var.vm_count
  name                 = "${var.vm_name}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  availability_set_id   = var.availability_set_ids[var.vm_to_avset_map[var.vm_name]]
  vm_size              = var.vm_size

  delete_os_disk_on_termination = true
  #delete_data_disks_on_termination = true

  storage_os_disk {
    name              = "${var.vm_name}-Os-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.os_disk_storage_account_type
    disk_size_gb      = var.os_disk_size
  }

  storage_image_reference {
    publisher = var.os_image.publisher
    offer     = var.os_image.offer
    sku       = var.os_image.sku
    version   = var.os_image.version
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = var.username
    custom_data = base64encode(<<-EOF
      package_update: true
      packages:
        ${var.vm_name == "PrimeSquare-IAC-App-1" || var.vm_name == "PrimeSquare-IAC-App-2" ? "- openjdk-17-jdk"  : ""}
        ${var.vm_name == "PrimeSquare-IAC-Web-1" || var.vm_name == "PrimeSquare-IAC-Web-2" ? "- apache2" : ""}
      runcmd:
        ${var.vm_name == "PrimeSquare-IAC-Web-1" || var.vm_name == "PrimeSquare-IAC-Web-2" ? "systemctl start apache2" : ""}
    EOF
    )
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.username}/.ssh/authorized_keys"
      key_data = var.ssh_public_key
    }
  }
 
#provisioner "remote-exec" {
#    connection {
#      type        = "ssh"
#      user        = var.username
#      private_key = file(var.ssh_private_key)  # Path to your private key
#      host        = azurerm_network_interface.nic[count.index].private_ip_address
#    }
#
#    inline = [
#      "sudo chmod +x /home/ubuntu/Terraform-avset-code/avset-terra-code-old/script.sh",
#      "sudo bash /home/ubuntu/Terraform-avset-code/avset-terra-code-old/script.sh"
#    ]
#  }

  tags = var.tags
}

output "public_ip_addresses" {
  description = "The public IP addresses of the VMs"
  value       = azurerm_public_ip.pubip[*].ip_address
}

output "private_ips" {
  description = "The private IP addresses of the VMs"
  value = azurerm_network_interface.nic[*].private_ip_address
}

