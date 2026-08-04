locals {
  role_definition_type = strcontains(var.role_definition, "/roleDefinitions/") ? "id" : "name"

  # Create a map of scope names to scope IDs/paths
  # If custom names are provided and match the scope count, use custom names as keys
  # Otherwise, use the basename of each scope as the key
  scope_ids_or_names = length(var.custom_scope_names) == length(var.scope) ? {
    for name in var.custom_scope_names :
    name => var.scope[index(var.custom_scope_names, name)]
    } : {
    for scope in var.scope : basename(scope) => scope
  }


  # Generates a flattened list of role assignments by creating a cartesian product
  # of principal IDs and scopes. For each principal ID, creates an assignment entry
  # for every scope (combining both scope IDs and names), resulting in a list where
  # each principal is paired with all available scopes.
  assignments = flatten([for id in var.principal_id : [for name, scope in local.scope_ids_or_names : {
    principal_id = id
    scope        = scope
    scope_name   = name
  }]])
}
