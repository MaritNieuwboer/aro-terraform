#Create virtual network
resource "azurerm_virtual_network" "aro-vn" {
    name                = var.vn_name
    address_space       = ["10.0.0.0/22"]
    location            = var.location
    resource_group_name = var.resource_group_name

    tags = {
        environment = var.environment
    }
}
