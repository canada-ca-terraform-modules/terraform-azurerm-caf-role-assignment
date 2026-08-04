mock_provider "azurerm" {}

variables {
  scope           = ["/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-one"]
  principal_id    = ["11111111-1111-1111-1111-111111111111"]
  role_definition = "Reader"
}

run "naming_convention" {
  command = plan

  assert {
    condition     = contains(keys(azurerm_role_assignment.roles), "11111111-1111-1111-1111-111111111111-rg-one")
    error_message = "Role assignment key must use principal ID and basename(scope)."
  }
}

run "default_values" {
  command = plan

  assert {
    condition     = azurerm_role_assignment.roles["11111111-1111-1111-1111-111111111111-rg-one"].skip_service_principal_aad_check == false
    error_message = "skip_service_principal_aad_check must default to false."
  }
}

run "cartesian_product" {
  command = plan

  variables {
    scope = [
      "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-one",
      "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-two",
    ]
    principal_id = [
      "11111111-1111-1111-1111-111111111111",
      "22222222-2222-2222-2222-222222222222",
    ]
  }

  assert {
    condition     = length(keys(azurerm_role_assignment.roles)) == 4
    error_message = "Principal and scope lists must expand to the full cartesian product."
  }
}

run "custom_scope_names" {
  command = plan

  variables {
    scope = [
      "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-one",
      "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-two",
    ]
    custom_scope_names = ["custom-one", "custom-two"]
  }

  assert {
    condition     = contains(keys(azurerm_role_assignment.roles), "11111111-1111-1111-1111-111111111111-custom-one")
    error_message = "custom_scope_names must override basename(scope) in resource keys."
  }
}

run "role_definition_id_and_optional_attrs" {
  command = plan

  variables {
    role_definition = "/subscriptions/00000000-0000-0000-0000-000000000000/providers/Microsoft.Authorization/roleDefinitions/00000000-0000-0000-0000-000000000000"
    role_assignment = {
      principal_type                         = "ServicePrincipal"
      condition                              = "(@Resource[Microsoft.Storage/storageAccounts:Tags:env] StringEquals 'prod')"
      condition_version                      = "2.0"
      delegated_managed_identity_resource_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-managed/providers/Microsoft.ManagedIdentity/userAssignedIdentities/uami"
      description                            = "Optional fields stay wired through."
      skip_service_principal_aad_check       = true
    }
  }

  assert {
    condition     = azurerm_role_assignment.roles["11111111-1111-1111-1111-111111111111-rg-one"].role_definition_id == "/subscriptions/00000000-0000-0000-0000-000000000000/providers/Microsoft.Authorization/roleDefinitions/00000000-0000-0000-0000-000000000000"
    error_message = "role_definition_id must be used when role_definition contains /roleDefinitions/."
  }

  assert {
    condition     = azurerm_role_assignment.roles["11111111-1111-1111-1111-111111111111-rg-one"].principal_type == "ServicePrincipal"
    error_message = "principal_type must be passed through."
  }

  assert {
    condition     = azurerm_role_assignment.roles["11111111-1111-1111-1111-111111111111-rg-one"].condition_version == "2.0"
    error_message = "condition_version must be passed through."
  }

  assert {
    condition     = azurerm_role_assignment.roles["11111111-1111-1111-1111-111111111111-rg-one"].description == "Optional fields stay wired through."
    error_message = "description must be passed through."
  }
}
