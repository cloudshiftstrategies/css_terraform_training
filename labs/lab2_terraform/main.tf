# main.tf

# Provision resources in Azure
provider "azurerm" {
}

# The string that will be suffixed to our local.prefix
variable "initials" {
  default = ""
}

locals {
  # the prefix that will be on all resources created
  prefix = "tfe_lab_${var.initials}"
}

# create a new resource group
resource "azurerm_resource_group" "main" {
  name     = "${local.prefix}-resources"
  location = "Central US"
}

# create a new vnet
resource "azurerm_virtual_network" "main" {
  name                = "${local.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
}

# create a new subnet
resource "azurerm_subnet" "internal" {
  name                 = "${local.prefix}-sn-internal"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  virtual_network_name = "${azurerm_virtual_network.main.name}"
  address_prefix       = "10.0.2.0/24"
}

# create a new nic
resource "azurerm_network_interface" "main" {
  name                = "${local.prefix}-nic"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"

  ip_configuration {
    name                          = "${local.prefix}-nic-configuration"
    subnet_id                     = "${azurerm_subnet.internal.id}"
    private_ip_address_allocation = "dynamic"
  }
}

# create a new vm
resource "azurerm_virtual_machine" "main" {
  name                  = "${local.prefix}-vm"
  location              = "${azurerm_resource_group.main.location}"
  resource_group_name   = "${azurerm_resource_group.main.name}"
  network_interface_ids = ["${azurerm_network_interface.main.id}"]
  vm_size               = "Standard_DS1_v2"

  # delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true

  # delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  # use the lates ubuntu 18.04
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  # configure the OS disk
  storage_os_disk {
    name              = "${local.prefix}-vm-osdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  # configure os settings
  os_profile {
    computer_name  = "${ replace(local.prefix,"_","") }"
    admin_username = "testadmin"
    admin_password = "Password123!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags {
    environment = "tfe_lab"
  }
}

# print connection info
output "vm_connection_info" {
  value = "ssh testadmin@${azurerm_network_interface.main.private_ip_address}"
}
