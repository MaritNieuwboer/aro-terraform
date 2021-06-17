variable "location" {
  default = "eastus"
  description = "name of the location" 
}

variable "resource_group_name" {
  default = "aro-rg"
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

variable "subscription_id" {
    description = "The subscription ID to be used to connect to Azure"
    type = string
}

variable "client_id" {
    description = "The client ID to be used to connect to Azure"
    type = string
}

variable "client_secret" {
    description = "The client secret to be used to connect to Azure"
    type = string
}

variable "tenant_id" {
    description = "The tenant ID to be used to connect to Azure"
    type = string
}
