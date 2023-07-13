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
  filtered_actions = [for obj in var.states[*] :
    obj if obj != null
  ]
}

# TODO: remove after development
output "debug" {
  value = local.filtered_actions
}
