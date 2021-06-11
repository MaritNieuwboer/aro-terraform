terraform {
  backend "azurerm" {
    resource_group_name	= "cloud-shell-storage-westeurope"
    storage_account_name= "csb100320012bf39e38"
    container_name	= "tfstate"
    key                 = "prod.terraform.tfstate"
  }
}  

provider "azurerm" {
  subscription_id     = var.subscription_id
  client_id           = var.client_id
  client_secret       = var.client_secret
  tenant_id           = var.tenant_id  
  features {}
}

#Provide registers
resource "null_resource" "provide_aro" {
provisioner "local-exec" {
  command = "az provider register -n Microsoft.RedHatOpenShift --wait"
  } 
}

resource "null_resource" "provide_compute" {
provisioner "local-exec" {
   command = "az provider register -n Microsoft.Compute --wait"
  }
}

resource "null_resource" "provide_storage" {
provisioner "local-exec" {
    command = "az provider register -n Microsoft.Storage --wait"
   } 
}

resource "null_resource" "provide_authorization" {
provisioner "local-exec" {
     command = "az provider register -n Microsoft.Authorization --wait"
    } 
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
    enforce_private_link_endpoint_network_policies = true
    depends_on = [azurerm_virtual_network.aro-vn]
}

# Create worker subnet 
resource "azurerm_subnet" "worker-subnet" {
     name                 = var.worker_subnet_name
     resource_group_name  = var.resource_group_name
     virtual_network_name = var.vn_name
     address_prefixes     = ["10.0.2.0/23"]
     service_endpoints    = ["Microsoft.ContainerRegistry"]
     depends_on = [azurerm_subnet.master-subnet] 
}

resource "null_resource" "update_subnet" {
provisioner "local-exec" {
    command = "az network vnet subnet update --name ${var.master_subnet_name} --vnet-name ${var.vn_name} --resource-group ${var.resource_group_name} --service-endpoints Microsoft.ContainerRegistry"
  } 
    depends_on = [azurerm_subnet.worker-subnet, azurerm_subnet.master-subnet] 
}

resource "null_resource" "create_cluster" {
provisioner "local-exec" {
    command = "az aro create --resource-group ${var.resource_group_name} --name ${var.cluster} --vnet ${var.vn_name} --master-subnet ${var.master_subnet_name} --worker-subnet ${var.worker_subnet_name}"
  }
    depends_on = [azurerm_subnet.worker-subnet]
}
