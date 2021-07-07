# aro-terraform
Testing a terraform script to create aro cluster.
First version without pull secret and custom domain. 

Steps:
1. Create storage acount on Azure Portal for tfstate 
2. Authenticate with Service principal (create in Azure) https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret
3. Create local tfvars (put in .gitignore) to use sensitive values or use environment variables (whatever fits best)
4. Terraform init
5. Terraform plan 
6. Terraform apply
