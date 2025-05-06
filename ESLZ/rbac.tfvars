rbac = [
  {
    scope = ["ID of the resource you are trying to assign to"]
    role = "Storage Blob Data Contributor"                      # Can be either the name of the role or ID
    principal_id = ["xx"]                                       # Must be Object ID of the user, group, or service principal
  }
]