#Create master subnet
resource "azurerm_subnet" "master-subnet" {
    name                 = var.master_subnet_name
    resource_group_name  = var.resource_group_name
    virtual_network_name = var.vn_name
    address_prefixes     = ["10.0.0.0/23"]
    service_endpoints 	 = ["Microsoft.ContainerRegistry"]
    enforce_private_link_service_network_policies = true 
    enforce_private_link_endpoint_network_policies = true
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
