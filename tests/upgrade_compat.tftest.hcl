mock_provider "azurerm" {}

variables {
  scope           = ["/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-one"]
  principal_id    = ["11111111-1111-1111-1111-111111111111"]
  role_definition = "Reader"
}

run "baseline_apply" {
  command = apply

  assert {
    condition     = length(keys(azurerm_role_assignment.roles)) == 1
    error_message = "Baseline apply must create one assignment."
  }
}

run "upgrade_plan_no_replacement" {
  command = plan

  assert {
    condition     = azurerm_role_assignment.roles["11111111-1111-1111-1111-111111111111-rg-one"].scope == "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-one"
    error_message = "Upgrade plan must preserve assignment scope."
  }
}
