terraform {
   backend "azurerm" {
  } 
}

provider "azurerm" {
  features {}
}

# Create a resource group if it doesn't exist
resource "azurerm_resource_group" "aro-rg" {
    name     = var.resource_group_name
    location = var.location

    tags = {
        environment = var.environment
    }
}

# Create virtual network
resource "azurerm_virtual_network" "aro-vn" {
    name                = var.vn_name
    address_space       = ["10.0.0.0/22"]
    location            = var.location
    resource_group_name = var.resource_group_name

    tags = {
        environment = var.environment
    }
    depends_on = [azurerm_resource_group.aro-rg]
}

# Create master subnet
resource "azurerm_subnet" "master-subnet" {
    name                 = var.master_subnet_name
    resource_group_name  = var.resource_group_name
    virtual_network_name = var.vn_name
    address_prefixes     = ["10.0.0.0/23"]
    service_endpoints 	 = ["Microsoft.ContainerRegistry"]
    depends_on = [azurerm_resource_group.aro-rg, azurerm_virtual_network.aro-vn]
}





