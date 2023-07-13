variable "description" {
  type        = string
  description = "Flavor text for the policy"
}

variable "default_state" {
  type        = string
  description = "Initial condition of the state machine"
}

variable "index_patterns" {
  type        = list(string)
  description = "Index patterns to apply to"
}

variable "priority" {
  type        = number
  description = "Priority for evaluation"
}

# Ref: https://opensearch.org/docs/latest/im-plugin/ism/policies/
variable "states" {
  type = list(object({
    name = string
    actions = set(object({
      retry = object({
        count   = number
        backoff = optional(string)
        delay   = optional(string)
      })
      # TODO: current issue is this
      # Either we make this entire actions set arbitrary maps
      # Or we need to make the unset keys disappear
      #  as the key = null fouls against the API
      # There are filtering options using for != null but
      #  that might mean we need to no only construct the entire schema
      #  but REconstruct the object after filtering
      # We may be able to use compact() later or a conditional
      # Ref: https://github.com/hashicorp/terraform/issues/28264#issuecomment-831941670
      # Ref: https://github.com/hashicorp/terraform/issues/19898
      delete = optional(map(any), {})
      force_merge = optional(object({
        max_num_segments       = number
        wait_for_completion    = optional(bool)
        task_execution_timeout = optional(string)
      }))
    }))
    transitions = set(object({
      state_name = string
      conditions = map(any)
    }))
  }))
}

/*
More advanced, enumerated conditions
Inclusion TBD
variable "transitions" {
	type = list(object(
			{
				state_name = string
				conditions = object({
					min_index_age = optional(string)
					min_rollover_age = optional(string)
					min_doc_count = optional(number)
					min_size = optional(string)
					cron = optional(object({
						expression = string
					  timezone = string
					}))
		})
			}
		)
	)
	default = [{
		state_name = "foo"
		conditions = {
			# These should fail if the enumeration works
			bar = 2
			min_index_age = 4
		}
	}]
}
*/
