variable "scope" {
  description = "ID for the resource where the role will be assigned"
  type = any
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