variable "env" {
  description = "Environment prefix used in the generated live-test resource group name"
  type        = string
  default     = "livetest"
}

variable "location" {
  description = "Location for the throwaway live-test resource group"
  type        = string
  default     = "canadacentral"
}

variable "pr_number" {
  description = <<-EOT
    Suffix applied to test_dependencies.tf resource names so concurrent PRs
    against this module never collide on the same sandbox subscription. CI
    sources this from `TF_VAR_pr_number` (`github.event.number`); manual runs
    can leave the default or pass their own value.
  EOT
  type        = string
  default     = "manual"
}

variable "role_definition" {
  description = "Name or ID of the RBAC role assigned to the caller's own principal against the throwaway scope, for the live-test harness"
  type        = string
  default     = "Reader"
}
