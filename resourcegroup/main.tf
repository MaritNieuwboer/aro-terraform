# Create a resource group if it doesn't exist 
resource "azurerm_resource_group" "aro-rg" {
     name     = var.resource_group_name
     location = var.location
     tags = {
         environment = var.environment
     } 
}

