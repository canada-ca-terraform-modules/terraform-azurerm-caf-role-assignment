locals {
  role_definition_type =  strcontains(var.role_definition, "/roleDefinitions/") ? "id" : "name"
}