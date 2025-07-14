resource "azurerm_role_assignment" "roles" {
  for_each = {for assignment in local.assignments: "${assignment.principal_id}-${assignment.scope_name}" => assignment}
  scope = each.value.scope
  principal_id = each.value.principal_id

  role_definition_id = local.role_definition_type == "id" ? var.role_definition : null
  role_definition_name = local.role_definition_type == "name" ? var.role_definition : null

  principal_type = try(var.role_assignment.principal_type, null)
  condition = try(var.role_assignment.condition, null)
  condition_version = try(var.role_assignment.condition_version, null)
  delegated_managed_identity_resource_id = try(var.role_assignment.delegated_managed_identity_resource_id, null)
  description = try(var.role_assignment.description, null)
  skip_service_principal_aad_check = try(var.role_assignment.skip_service_principal_aad_check, false)
}