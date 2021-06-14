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
module "register" {
  source = "./registers"
}

# Create a resource group if it doesn't exist
module "resourcegroup" {
   source = "./resourcegroup" 
   depends_on=[module.register]
} 

# Create virtual network
module "virtualnetwork" {
   source = "./virtualnetwork"
   depends_on = [module.resourcegroup]
}

# Create master subnet, worker subnet and update service endpoint
module "subnets" {
   source = "./subnets"
   depends_on = [module.virtualnetwork]
}

# AZ Aro create 
module "createcluster" {
    source = "./createcluster"
    depends_on = [module.subnets]
}
