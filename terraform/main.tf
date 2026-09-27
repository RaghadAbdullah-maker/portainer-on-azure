#Create Resource Group
resource "azurerm_resource_group" "platform" {
  name     = var.resource_group_name
  location = var.location
}

#Create Vnet
resource "azurerm_virtual_network" "platform" {
  name                = var.vnet_name
  location            = azurerm_resource_group.platform.location
  resource_group_name = azurerm_resource_group.platform.name
  address_space       = var.vnet_address_space
}

#Create Subnet
resource "azurerm_subnet" "platform" {
  name                            = var.subnet_name
  resource_group_name             = azurerm_resource_group.platform.name
  virtual_network_name            = azurerm_virtual_network.platform.name
  address_prefixes                = var.subnet_address_prefixes
  default_outbound_access_enabled = false
}

#Create NSG
resource "azurerm_network_security_group" "platform" {
  name                = var.nsg_name
  location            = azurerm_resource_group.platform.location
  resource_group_name = azurerm_resource_group.platform.name
}


# Allow SSH access from authorized team members
resource "azurerm_network_security_rule" "ssh" {
  name      = "Allow-SSH"
  priority  = 100
  direction = "Inbound"
  access    = "Allow"
  protocol  = "Tcp"

  source_port_range      = "*"
  destination_port_range = "22"

  source_address_prefixes    = var.admin_source_cidrs
  destination_address_prefix = "*"

  resource_group_name         = azurerm_resource_group.platform.name
  network_security_group_name = azurerm_network_security_group.platform.name
}

# Allow Portainer HTTPS access from authorized team members
resource "azurerm_network_security_rule" "portainer" {
  name      = "Allow-Portainer-HTTPS"
  priority  = 110
  direction = "Inbound"
  access    = "Allow"
  protocol  = "Tcp"

  source_port_range      = "*"
  destination_port_range = "9443"

  source_address_prefixes    = var.admin_source_cidrs
  destination_address_prefix = "*"

  resource_group_name         = azurerm_resource_group.platform.name
  network_security_group_name = azurerm_network_security_group.platform.name
}

# Associate the NSG with the subnet
resource "azurerm_subnet_network_security_group_association" "platform" {
  subnet_id                 = azurerm_subnet.platform.id
  network_security_group_id = azurerm_network_security_group.platform.id
}

#Create Public IP

resource "azurerm_public_ip" "platform" {
  name                = "pip-portainer-lab"
  location            = azurerm_resource_group.platform.location
  resource_group_name = azurerm_resource_group.platform.name
  allocation_method   = "Static"
  sku                 = "Standard"
}



#Create NIC

resource "azurerm_network_interface" "platform" {
  name                = "nic-portainer-lab"
  location            = azurerm_resource_group.platform.location
  resource_group_name = azurerm_resource_group.platform.name

  ip_configuration {
    name                          = "primary"
    subnet_id                     = azurerm_subnet.platform.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.platform.id
  }
}

# Create VM

resource "azurerm_linux_virtual_machine" "platform" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.platform.name
  location            = azurerm_resource_group.platform.location
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.platform.id
  ]

  disable_password_authentication = true

  dynamic "admin_ssh_key" {
    for_each = var.ssh_public_keys

    content {
      username   = var.admin_username
      public_key = admin_ssh_key.value
    }
  }

  os_disk {
    name                 = "disk-portainer-lab"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}