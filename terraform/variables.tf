variable "resource_group_name" {
  description = "Name of the project's resource group"
  type        = string
}

variable "location" {
  description = "Azure region for the project"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Private IP address ranges for the virtual network"
  type        = list(string)
}

variable "subnet_name" {
  description = "Name of the subnet for the platform VM"
  type        = string
}

variable "subnet_address_prefixes" {
  description = "Private IP address ranges for the subnet"
  type        = list(string)
}

variable "nsg_name" {
  description = "Name of the network security group"
  type        = string
}

variable "admin_source_cidrs" {
  description = "Public IP addresses allowed to access SSH and Portainer"
  type        = list(string)

  validation {
    condition = alltrue([
      for cidr in var.admin_source_cidrs :
      can(cidrnetmask(cidr)) && can(regex("/32$", cidr))
    ])

    error_message = "Each admin source must be a valid IP address followed by /32."
  }
}


variable "subscription_id" {
  description = "Azure subscription ID used for deployment"
  type        = string
}

variable "vm_size" {
  description = "Size of the Linux virtual machine"
  type        = string
  default     = "Standard_B2s"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key on the deployment computer"
  type        = string
}