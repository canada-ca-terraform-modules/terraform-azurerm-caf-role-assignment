# Wired to .github/workflows/live-test.yml as of this comment.
terraform {
  required_version = ">= 1.9"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0"
    }
  }

  # Empty on purpose: the state file path is supplied at `terraform init`
  # time via `-backend-config="path=..."` (partial configuration), so the
  # target-branch checkout and the PR-branch checkout can point at the same
  # external state file without either owning its own local state.
  backend "local" {}
}

provider "azurerm" {
  storage_use_azuread             = true
  resource_provider_registrations = "legacy"
  features {}
}

# Principal for the role assignment: the identity Terraform itself runs as.
# Deliberately NOT a freshly-created principal (e.g. a UAMI) - a role
# assignment against a principal created in the same apply can fail with
# "principal not found in the directory" due to AAD replication lag, and its
# object_id would be unknown-until-apply, which breaks the module's for_each
# key (see custom_scope_names below). The caller's own object_id is both a
# known value at plan time and carries no risk: this only grants an extra,
# explicit role on a throwaway resource group this harness already owns.
data "azurerm_client_config" "current" {}

module "role_assignment" {
  # PR code and baseline code are two on-disk checkouts of this same repo,
  # not two resolved git refs - no pinned ?ref, no version toggle here.
  source = "../../"

  # custom_scope_names avoids a for_each key derived from an unknown value:
  # the module's own for_each key defaults to basename(scope), but scope here
  # is a resource this same invocation creates, so basename(scope) is unknown
  # until apply. Per the module's own variable description, custom_scope_names
  # is required when the scope is being created in the same TF invocation.
  scope              = [local.resource_group.id] # from test_dependencies.tf
  custom_scope_names = ["probe"]
  principal_id       = [data.azurerm_client_config.current.object_id]
  role_definition    = var.role_definition
}
