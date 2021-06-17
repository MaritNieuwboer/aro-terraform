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
