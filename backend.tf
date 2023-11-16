terraform {
  backend "s3" {
    bucket = "backend-chris-123"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
    workspace_key_prefix = "env" #I am saying am using workspace, isolate workspace. This will maintain individual tfstate in individual workspace in s3 backend folder
    #CODE Source (workspace_key_prefix) >> https://developer.hashicorp.com/terraform/language/settings/backends/s3#:~:text=workspace_key_prefix%20%2D%20(Optional)%20Prefix%20applied
  }
}

# TO CREATE RESOURCES IN ENV to MAINTAIN individual TF STATE FILE IN EACH WORKSPACE
# Before you create resources
# terraform init
# terraform workspace new dev #this will switch you to dev env
# terraform apply 