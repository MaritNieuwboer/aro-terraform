variable "location" {
  default = "eastus"
  description = "name of the location" 
}

variable "resource_group_name" {
  default = "aro-rg-marit"
  description = "name of the resource group"
}

variable "cluster" {
  default = "cluster-marit"
  description = "name of the aro cluster"
    }

variable "environment" {
    default = "aro"
    description = "tag" 
}

variable "vn_name" {
    default = "aro-vn"
    description = "name of the virtual network" 
}

variable "master_subnet_name" {
    default = "master-subnet"
    description = "name of the master subnet"
}

variable "worker_subnet_name" {
    default = "worker-subnet"
    description = "name of the worker subnet" 
}

