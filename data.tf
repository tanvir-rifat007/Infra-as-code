# data blocks are used to fetch and reference external or existing resources that are not managed by your current Terraform configuration

# Here i fetch the github app installatin id for the terraform cloud 

# and then use this data id in the main.tf in the vcs_repo

data "tfe_github_app_installation" "this" {
  installation_id = var.github_app_installation_id
}


data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    organization = "tanvir-rifat"
    workspaces = {
      name = "fem-fd-service-network"
    }
  }
}


data "terraform_remote_state" "cluster" {
  backend = "remote"

  config = {
    organization = "tanvir-rifat"
    workspaces = {
      name = "fem-fd-service-cluster2"
    }
  }
}

