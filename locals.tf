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
      value    = jsonencode(["103.216.57.190/32"]) 
    }
  ]
}


    "fem-fd-service-network" = {
  description         = "Automation for AWS network resources2."
  execution_mode      = "remote"
  project_id          = module.project["fem-eci-project"].id
  vcs_repo_identifier = "${var.github_organization_name}/fem-fd-service-network"

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
      value    = "fem-fd-service-network"
    },
    {
      category = "terraform"
      hcl      = true
      key      = "bastion_ingress"
      value    = jsonencode(["103.216.57.190/32"]) 
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
      key      = "vpc_id"
      value    = data.terraform_remote_state.network.outputs.vpc_id

    },
    {
      category = "terraform"
      hcl      = true
      key      = "subnets"
      value    = jsonencode(data.terraform_remote_state.network.outputs.private_subnets)

    },
    {
      category = "terraform"
      hcl      = true
      key      = "security_groups"
      value    = "[data.terraform_remote_state.network.outputs.private_security_group]"
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



"fem-fd-service-cluster2" = {
  description         = "Automation for AWS cluster resources"
  execution_mode      = "remote"
  project_id          = module.project["fem-eci-project"].id
  vcs_repo_identifier = "${var.github_organization_name}/fem-fd-service-cluster2"

  depends_on = ["fem-fd-service-network"]

  variables = [
    {
      category = "terraform"
      key      = "name"
      value    = "fem-fd-service-cluster2"
    },
    {
      category = "terraform"
      key      = "vpc_id"
      value    = data.terraform_remote_state.network.outputs.vpc_id

    },
    {
      category = "terraform"
      hcl      = true
      key      = "subnets"
      value    = jsonencode(data.terraform_remote_state.network.outputs.private_subnets)

    },
    {
      category = "terraform"
      hcl      = true
      key      = "security_groups"
      value    = jsonencode(data.terraform_remote_state.network.outputs.private_security_group)

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


"fem-fd-service-db2" = {
  description         = "Automation for the fem-fd-service-db Postgres RDS."
  execution_mode      = "remote"
  project_id          = module.project["fem-eci-project"].id
  vcs_repo_identifier = "${var.github_organization_name}/fem-fd-service-db"

  depends_on = ["fem-fd-service-network"]

  variables = [
    {
      category = "terraform"
      key      = "name"
      value    = "fem-fd-service-db2"
    },
    {
      category = "terraform"
      key      = "vpc_name"
      value    = data.terraform_remote_state.network.outputs.vpc_name
    },
    {
      category = "terraform"
      hcl      = true
      key      = "subnets"
      value    = jsonencode(data.terraform_remote_state.network.outputs.private_subnets)
    },
    {
      category = "terraform"
      hcl      = true
      key      = "security_groups"
      value    = jsonencode(data.terraform_remote_state.network.outputs.private_security_group)
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


    "fem-fd-service-product-service" = {
      description         = "Automation for product service resources."
      execution_mode      = "remote"
      project_id          = module.project["fem-eci-project"].id
      vcs_repo_identifier = "${var.github_organization_name}/fem-fd-service-product-service"

      variables = [
        {
          category = "terraform"
          key      = "cluster_name"
          value    = "fem-fd-service-cluster2"
        },
        {
          category = "terraform"
          key      = "name"
          value    = "product-service"
        },
        {
          category = "terraform"
          key      = "capacity_provider"
          value    = "on_demand"
        },
        {
          category = "terraform"
          key      = "cluster_id"
          hcl      = true
          value    = jsonencode(data.terraform_remote_state.cluster.outputs.cluster_arn)
        },
        {
          category = "terraform"
          key      = "listener_arn"
          value    = jsonencode(data.terraform_remote_state.cluster.outputs.listener_arn)
        },
        {
          category = "terraform"
          key      = "vpc_id"
          value    = jsonencode(data.terraform_remote_state.network.outputs.vpc_id)
        },
        {
          category = "terraform"
          key      = "port"
          value    = "8080"
        },
        {
          category = "terraform"
          key      = "paths"
          value    = jsonencode(["/*"])
          hcl      = true
        },
        {
          category = "terraform"
          key      = "config"
          value    = jsonencode({
            GOOGLE_REDIRECT_URL = "https://d11krv93sm9qnr.cloudfront.net/auth/google/callback"
    GOOSE_DRIVER        = "postgres"

          })
          hcl = true
        },
        {
          category = "terraform"
          key      = "secrets"
          value    = jsonencode(["GOOGLE_CLIENT_ID",
    "GOOGLE_CLIENT_SECRET",
    "GOOSE_DBSTRING",
    "POSTGRES_URL",
])
          hcl      = true
        }
      ]
    }



   
    
  }
}