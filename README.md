## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| principal\_id | ID for the principal (User, Group, Service Principal) to assign the Role definition to | `any` | n/a | yes |
| role\_assignment | Object containing all the parameters for the role\_assignment | `any` | `{}` | no |
| role\_definition | Name or ID of the RBAC role being assigned | `string` | n/a | yes |
| scope | ID for the resource where the role will be assigned | `string` | n/a | yes |

## Outputs

No output.

## In another module

This module can be used within another to allow role assignment of any arbitrary role and principal. Here is the module block to include within the module to add this feature

```
module "rbac" {
  source = "github.com/canada-ca-terraform-modules/terraform-azurerm-caf-role-assignment?ref=v1.0.0"
  for_each = {for role in try(var.<variable for your module>.rbac, []) : role.role => role}

  scope = azurerm_storage_account.storage-account.id
  principal_id = each.value.principal_id
  role_definition = each.key
  role_assignment = each.value
}
```
Please change variable in the for_each block to the variable in your module. \
The block in the tfvars file will be the same as the one in the template
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.roles](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_scope_names"></a> [custom\_scope\_names](#input\_custom\_scope\_names) | List of names to use instead of the scopes for naming TF resources. This is required if the scope is being created in the same TF invocation. | `list(string)` | `[]` | no |
| <a name="input_principal_id"></a> [principal\_id](#input\_principal\_id) | ID for the principal (User, Group, Service Principal) to assign the Role definition to | `any` | n/a | yes |
| <a name="input_role_assignment"></a> [role\_assignment](#input\_role\_assignment) | Object containing all the parameters for the role\_assignment | `any` | `{}` | no |
| <a name="input_role_definition"></a> [role\_definition](#input\_role\_definition) | Name or ID of the RBAC role being assigned | `string` | n/a | yes |
| <a name="input_scope"></a> [scope](#input\_scope) | ID sfor the resource where the role will be assigned | `list(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->