# Example tfvars file for a Power Platform DLP policy configuration
display_name = "Example DLP Policy"
environment_type = "OnlyEnvironments" # Default environment handling for the policy
environments = ["env-12345", "env-67890"]
business_connectors = [
  {
    id = "shared_logicflows",
    name = "Power Automate",
    default_action_rule_behavior = "Allow",
    action_rules = [],
    endpoint_rules = []
  },
  {
    id = "shared_powerapps",
    name = "Power Apps",
    default_action_rule_behavior = "Allow",
    action_rules = [],
    endpoint_rules = []
  }
]
custom_connectors = [
  {
    order = 1,
    host_url_pattern = "*.azurewebsites.net",
    data_group = "Business"
  }
]
