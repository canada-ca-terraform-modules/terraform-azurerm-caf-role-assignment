variable "scope" {
  description = "ID sfor the resource where the role will be assigned"
  type = list(string)
}

variable "custom_scope_names" {
  description = "List of names to use instead of the scopes for naming TF resources. This is required if the scope is being created in the same TF invocation."
  type = list(string)
  default = []
}

variable "principal_id" {
  description = "ID for the principal (User, Group, Service Principal) to assign the Role definition to"
  type = any
}

variable "role_definition" {
  description = "Name or ID of the RBAC role being assigned"
  type = string
}

variable "role_assignment" {
  description = "Object containing all the parameters for the role_assignment"
  type = any
  default = {}
}