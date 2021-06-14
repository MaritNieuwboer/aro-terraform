resource "null_resource" "create_cluster" {
provisioner "local-exec" {
    command = "az aro create --resource-group ${var.resource_group_name} --name ${var.cluster} --vnet ${var.vn_name} --master-subnet ${var.master_subnet_name} --worker-subnet ${var.worker_subnet_name}"
  }
}
