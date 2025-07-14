rbac = [
  {
    scope = ["ID of the resource you are trying to assign to"]
    // custom_scope_names =  [ "Custom-Name" ]                  # (Optional) For each scope id above, a custom name within TF for naming the resource. Useful when it doesn't yet exist.
    role = "Storage Blob Data Contributor"                      # Can be either the name of the role or ID
    principal_id = ["xx"]                                       # Must be Object ID of the user, group, or service principal
  }
]