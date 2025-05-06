locals {
  role_definition_type =  strcontains(var.role_definition, "/roleDefinitions/") ? "id" : "name"

  assignments = flatten([for id in var.principal_id: [for scope in var.scope: {
    principal_id = id 
    scope = scope
  }]])
}