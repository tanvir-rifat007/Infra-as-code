locals {
  project = {
    "fem-eci-project" = {
      description = "Example description of project"
    }
  }

  workspace = {
    "fem-eci-tfe" = {
      description    = "Example automation workspace for Terraform Cloud resources."
      execution_mode = "remote"
      project_id     = module.project["fem-eci-project"].id
      vcs_repo_identifier = "${var.github_organization_name}/Infra-as-code"

    }

  
      "fem-eci-github" = {

              description    = "Example automation workspace for Creating github repo."
      execution_mode = "remote"
      project_id     = module.project["fem-eci-project"].id
      vcs_repo_identifier = "${var.github_organization_name}/Infra-as-code-github"

      }

      "fem-eci-aws-network" = {
      description         = "Automation for AWS network resources."
      execution_mode      = "remote"
      project_id          = module.project["fem-eci-project"].id
      vcs_repo_identifier = "${var.github_organization_name}/Infra-as-code-aws-network"

      variables = [
        {
          category = "terraform"
          hcl      = true
          key      = "azs"
          value    = jsonencode(["us-west-2a", "us-west-2b"])
        },
        {
          category = "terraform"
          key      = "cidr"
          value    = "10.0.0.0/16"
        },
        {
          category = "terraform"
          key      = "name"
          value    = "fem-eci"
        },
      ]
    }

    "fem-eci-aws-cluster-prod" = {
      description         = "Automation for AWS cluster resources."
      execution_mode      = "remote"
      project_id          = module.project["fem-eci-project"].id
      vcs_repo_identifier = "${var.github_organization_name}/Infra-as-code-aws-cluster"

      variables = [
        {
          category = "terraform"
          key      = "domain"
          value    = "altf4.dev"
        },
        {
          category = "terraform"
          key      = "environment"
          value    = "prod"
        },
        {
          category = "terraform"
          key      = "name"
          value    = "fem-eci-tanvirrifat"
        },
        {
          category = "terraform"
          key      = "vpc_name"
          value    = "fem-eci"
        },
      ]
    }

    
  }
}