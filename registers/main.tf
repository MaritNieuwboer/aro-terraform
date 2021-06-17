#Provide registers
resource "azurerm_resource_provider_registration" "provide_aro" {
   name = "Microsoft.RedHatOpenshift" 
}

resource "azurerm_resource_provider_registration" "provide_compute" { 
   name = "Microsoft.Compute"                             
}                                                                 

resource "azurerm_resource_provider_registration" "provide_storage" {
   name = "Microsoft.Storage"
}

resource "azurerm_resource_provider_registration" "provide_authorization" {
   name = "Microsoft.Authorization"
}                                                                    
