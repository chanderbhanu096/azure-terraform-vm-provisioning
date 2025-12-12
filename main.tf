terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# 1. Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.project-name}"
  location = var.location # or "northeurope" / "germanywestcentral"

  tags = {
    environment = "demo"
    owner       = "chander"
    project     = var.project-name
  }
}

# 2. Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.project-name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["11.0.0.0/16"]
}

# 3. Subnet  ✅ THIS MUST EXIST
resource "azurerm_subnet" "subnet" {
  name                 = "subnet-${var.admin-username}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["11.0.1.0/24"]
}

# 4. NSG
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.project-name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

# 5. Attach NSG to Subnet
resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# 6. Public IP for VM
resource "azurerm_public_ip" "vm_public_ip" {
  name                = "vm-public-ip-${var.project-name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  allocation_method = "Static"
  sku               = "Standard"
}

# 7. NIC for VM
resource "azurerm_network_interface" "nic" {
  name                = "nic-${var.project-name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id # <--- uses subnet resource
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }
}

# 8. Linux VM
resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm-name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm-size # changed from B1s to avoid SKU issue

  admin_username = var.admin-username

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  admin_ssh_key {
    username   = var.admin-username
    public_key = file("${path.module}/id_rsa_terraform_demo.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  custom_data = filebase64("${path.module}/cloud-init.yaml")
}
