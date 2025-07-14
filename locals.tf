locals {
  role_definition_type =  strcontains(var.role_definition, "/roleDefinitions/") ? "id" : "name"

  scope_ids_or_names = length(var.custom_scope_names) == length(var.scope) ? {
                              for name in var.custom_scope_names : 
                                name => var.scope[index(var.custom_scope_names, name)]
                          } : {
                            for scope in var.scope: scope => basename(scope)
                          }


  assignments = flatten([for id in var.principal_id: [for name, scope in local.scope_ids_or_names: {
    principal_id = id 
    scope = scope
    scope_name = name
  }]])
}