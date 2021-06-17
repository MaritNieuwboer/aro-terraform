variable "location" {
  default = "eastus"
  description = "name of the location" 
}

variable "resource_group_name" {
  default = "aro-rg"
  description = "name of the resource group"
}

variable "environment" {
    default = "aro"
    description = "tag" 
}
