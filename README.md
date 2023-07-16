# OpenSearch Index State Management Policy

Terraform module for constructing valid ISM policies in HCL.

Presently _extremely_ unstable.
Developed against OpenSearch 1.3.

Open to ideas of how to nicely support more than one version of OpenSearch.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_state"></a> [default\_state](#input\_default\_state) | Initial condition of the state machine | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Flavor text for the policy | `string` | n/a | yes |
| <a name="input_index_patterns"></a> [index\_patterns](#input\_index\_patterns) | Index patterns to apply to | `list(string)` | n/a | yes |
| <a name="input_priority"></a> [priority](#input\_priority) | Priority for evaluation | `number` | n/a | yes |
| <a name="input_states"></a> [states](#input\_states) | Ref: https://opensearch.org/docs/latest/im-plugin/ism/policies/ | <pre>list(object({<br>    name = string<br>    properties = object({<br>      actions = set(object({<br>        retry = object({<br>          count   = number<br>          backoff = optional(string)<br>          delay   = optional(string)<br>        })<br>        # TODO: current issue is this<br>        # Either we make this entire actions set arbitrary maps<br>        # Or we need to make the unset keys disappear<br>        #  as the key = null fouls against the API<br>        # There are filtering options using for != null but<br>        #  that might mean we need to no only construct the entire schema<br>        #  but REconstruct the object after filtering<br>        # We may be able to use compact() later or a conditional<br>        # Ref: https://github.com/hashicorp/terraform/issues/28264#issuecomment-831941670<br>        # Ref: https://github.com/hashicorp/terraform/issues/19898<br>        delete = optional(map(any), {})<br>        force_merge = optional(object({<br>          max_num_segments       = number<br>          wait_for_completion    = optional(bool)<br>          task_execution_timeout = optional(string)<br>        }))<br>      }))<br>      transitions = set(object({<br>        state_name = string<br>        conditions = map(any)<br>      }))<br>    })<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_debug"></a> [debug](#output\_debug) | TODO: remove after development |
| <a name="output_policy_data_structure"></a> [policy\_data\_structure](#output\_policy\_data\_structure) | n/a |
<!-- END_TF_DOCS -->
