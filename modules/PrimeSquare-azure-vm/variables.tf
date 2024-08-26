variable "vm_name" {
  description = "The name of the VM"
  type        = string
}

variable "vm_size" {
  description = "The size of the VM"
  type        = string
}

variable "username" {
  description = "The admin username of the VM"
  type        = string
}

variable "os_image" {
  description = "The OS image to use for the VM"
  type        = map(string)
}

variable "location" {
  description = "The location of the resource group"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "subnet_ids" {
  description = "The ID of the subnet"
  type        = list(string)
}

variable "assign_public_ip" {
  type    = bool
  default = false
  description = "A flag to determine if the VM should have a public IP. Only the first two VMs will have a public IP assigned."
}

variable "nic_name" {
  description = "The name of NIC"
  type        = string
}

variable "os_disk_size" {
  description = "The size of the OS disk in GB"
  type        = number
}

variable "ssh_public_key" {
  description = "SSH public key for VMs"
  type        = string
}

#variable "ssh_private_key" {
#  description = "SSH private key for VMs"
#  type        = string
#}

variable "os_disk_storage_account_type" {
  description = "Specifies the storage account type of the os disk of the virtual machine"
  default     = "Standard_LRS"
  type        = string
}

variable "vm_count" {
  description = "count of the VM"
  type        = string
}

variable "vm_details" {
  type = map(object({
    vm_name     = string
    vm_count    = number
    vm_size     = string
    disk_type   = string
    os_disk_size = number
    username    = string
    os_image    = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  }))
}

variable "availability_set_ids" {
  description = "List of availability set IDs"
  type        = list(string)
}

variable "vm_to_avset_map" {
  description = "Map of VM names to availability set indices"
  type        = map(number)
  default     = {
    "PrimeSquare-IAC-App-1"  = 0
    "PrimeSquare-IAC-App-2"  = 0
    "PrimeSquare-IAC-Web-1"  = 1
    "PrimeSquare-IAC-Web-2"  = 1
    "PrimeSquare-IAC-Kafka-1"  = 2
    "PrimeSquare-IAC-Kafka-2"  = 2
    "PrimeSquare-IAC-ZK-1"  = 2
    "PrimeSquare-IAC-ZK-2"  = 2
    "PrimeSquare-IAC-ZK-3"  = 2
  }
}

#variable "nsg_name" {
##  description = "The names of the network security groups"
#  type        = string
#}

variable "tags" {
  description = "Tags for the resources"
  type        = map(any)
}

#variable "nic_ids" {
#  description = "The ID of the NIC"
#  type        = list(string)
#}

#variable "ssh_private_key" {
#  description = "ssh private key of VMs"
#  type        = string
#}

