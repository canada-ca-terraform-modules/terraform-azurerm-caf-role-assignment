# test_dependencies.tf
# Self-contained dependency resources, owned entirely by this harness.
#
# Deliberately NOT reusing any shared/production resource group: writing into
# a shared RG usually requires elevated, non-sandbox permissions. A dedicated
# throwaway RG (as the role-assignment scope) here needs only Contributor +
# User Access Administrator on the sandbox subscription and can never
# collide with or affect any production resource.

resource "azurerm_resource_group" "live_test" {
  # PR-number suffix keeps two concurrently open PRs against this module from
  # colliding on the same sandbox resource group.
  name     = "${var.env}-caf-role-assignment-live-test-${var.pr_number}-rg"
  location = var.location

  # pr-number tag: lets the nightly orphan sweeper find this RG by tag and
  # match it back to a PR, independent of naming convention.
  tags = {
    "pr-number" = var.pr_number
  }
}

locals {
  resource_group = {
    id       = azurerm_resource_group.live_test.id
    name     = azurerm_resource_group.live_test.name
    location = azurerm_resource_group.live_test.location
  }
}
