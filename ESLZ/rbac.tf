variable "rbac" {
  description = "Object containing all the configuration for RBAC role assignment"
  type = any
  default = []
}

module "rbacv2" {
  source = "github.com/canada-ca-terraform-modules/terraform-azurerm-caf-role-assignment?ref=v1.0.0"
  for_each = {for role in try(var.rbac, []) : role.role => role}

  scope = each.value.scope
  principal_id = each.value.principal_id
  role_definition = each.key
  role_assignment = each.value
}