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
      execution_mode = "local"
      project_id     = module.project["fem-eci-project"].id
      vcs_repo_identifier = "${var.github_organization_name}/Infra-as-code-github"

      }
    
  }
}