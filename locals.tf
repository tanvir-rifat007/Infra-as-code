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



    "fem-eci-aws-network2" = {
  description         = "Automation for AWS network resources2."
  execution_mode      = "remote"
  project_id          = module.project["fem-eci-project"].id
  vcs_repo_identifier = "${var.github_organization_name}/Infra-as-code-aws-network2"

  variables = [
    {
      category = "terraform"
      hcl      = true
      key      = "availability_zones"
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
      value    = "fem-eci2"
    },
    {
      category = "terraform"
      hcl      = true
      key      = "bastion_ingress"
      value    = jsonencode(["103.216.57.190/16"]) 
    }
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



     
"fem-eci-aws-cluster-prod2" = {
  description         = "Automation for AWS cluster resources2."
  execution_mode      = "remote"
  project_id          = module.project["fem-eci-project"].id
  vcs_repo_identifier = "${var.github_organization_name}/Infra-as-code-aws-cluster2"

  depends_on = ["fem-eci-aws-network2"]

  variables = [
    {
      category = "terraform"
      key      = "name"
      value    = "fem-eci-tanvirrifat2"
    },
    {
      category = "terraform"
      hcl      = true
      key      = "vpc_id"
      value    =  data.tfe_outputs.network.vpc_id
    },
    {
      category = "terraform"
      hcl      = true
      key      = "subnets"
      value    = [data.tfe_outputs.network.private_subnets]
    },
    {
      category = "terraform"
      hcl      = true
      key      = "security_groups"
      value    = [data.tfe_outputs.network.private_security_group]
    },
    {
      category = "terraform"
      hcl      = true
      key      = "capacity_providers"
      value    = jsonencode({
        on_demand = {
          instance_type = "t3.medium"
          market_type   = "on-demand"
        }
        spot = {
          instance_type = "t3.medium"
          market_type   = "spot"
        }
      })
    }
  ]
}



     "fem-eci-product-service-prod" = {
      description         = "Automation for product service resources."
      execution_mode      = "remote"
      project_id          = module.project["fem-eci-project"].id
      vcs_repo_identifier = "${var.github_organization_name}/Infra-as-code-terraform-product-service"

      variables = [
        {
          category = "terraform"
          key      = "cluster_name"
          value    = "fem-eci-tanvirrifat-prod"
        },
        {
          category = "terraform"
          key      = "environment"
          value    = "prod"
        },
      ]
    }

    
  }
}