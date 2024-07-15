display_name = "Example 2"
environment_type = "OnlyEnvironments"
environments = ["Default-7e7df62f-7cc4-4e63-a250-a277063e1be7"]

business_connectors = [
  {
    {
    id = "/providers/Microsoft.PowerApps/apis/shared_commondataserviceforapps"
    default_action_rule_behavior = ""
    action_rules = []
    endpoint_rules = []
  }
]

custom_connectors = [
  {
    order = 1
    host_url_pattern = "*"
    data_group = "Ignore"
  }
]