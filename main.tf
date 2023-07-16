locals {
  policy = {
    policy = {
      description   = var.description
      default_state = var.default_state
      states        = var.states
      ism_template = [
        {
          index_patterns = var.index_patterns
          priority       = var.priority
        }
      ]
    }
  }
  # TODO: remove after development
  states = { for property, value_list in var.states[0].properties : property =>
    [for value in value_list :
      { for key, val in value : (key) => value[key] if val != null } if length(value_list) > 0
      # { for key, val in value : (key) => value[key] if(val) } if length(value_list) > 0
      # { for key, val in value : (key) => value[key] if(val ? true : false) } if length(value_list) > 0
      # { for key, val in value : (key) => value[key] if val } if length(value_list) > 0
      # { for key, val in value : (key) => value[key] if length(coalescelist(val, [])) != 0 } if length(value_list) > 0
      # { for key, val in value : (key) => value[key] if coalesce(val, "fail") != "fail" } if length(value_list) > 0
    ]
  }
}

# TODO: remove after development
output "debug" {
  value = local.states
}
