terraform {
  backend "azurerm" {
    resource_group_name  = "cloud-shell-storage-westeurope"
    storage_account_name = "csb100320012bf39e38"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
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
    enforce_private_link_service_network_policies = true 

    depends_on = [azurerm_resource_group.aro-rg, azurerm_virtual_network.aro-vn]
}

# Create worker subnet 
resource "azurerm_subnet" "worker-subnet" {
     name                 = var.worker_subnet_name
     resource_group_name  = var.resource_group_name
     virtual_network_name = var.vn_name
     address_prefixes     = ["10.0.2.0/23"]
 
     depends_on = [azurerm_resource_group.aro-rg, azurerm_virtual_network.aro-vn] 
}

