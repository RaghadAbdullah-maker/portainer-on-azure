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

#Crate NIC

#Create VM