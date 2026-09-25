#Resource Group Name
output "resource_group_name" {
  description = "Name of the Azure resource group"
  value       = azurerm_resource_group.platform.name
}

#Vnet Name
output "vnet_name" {
  description = "Name of the Azure Virtual Network"
  value       = azurerm_virtual_network.platform.name
}

#Subnet Name
output "subnet_name" {
  description = "Name of the subnet"
  value       = azurerm_subnet.platform.name
}

#Subnet ID
output "subnet_id" {
  description = "ID of the subnet"
  value       = azurerm_subnet.platform.id
}

#NSG Name
output "nsg_name" {
  description = "Name of the Network Security Group"
  value       = azurerm_network_security_group.platform.name
}


#VM name

#Public IP address