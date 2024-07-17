display_name = "Rpothin Environments"
environment_type = "OnlyEnvironments"
environments = ["bc71e927-ffe8-effa-8666-78c5cfa7bdf4"]

business_connectors = [
  {
    id = "/providers/Microsoft.PowerApps/apis/shared_commondataservice"
    default_action_rule_behavior = ""
    action_rules = []
    endpoint_rules = []
  },
  {
    id = "/providers/Microsoft.PowerApps/apis/shared_commondataserviceforapps"
    default_action_rule_behavior = ""
    action_rules = []
    endpoint_rules = []
  },
  {
    id = "/providers/Microsoft.PowerApps/apis/shared_office365users"
    default_action_rule_behavior = ""
    action_rules = []
    endpoint_rules = []
  },
  {
    id = "/providers/Microsoft.PowerApps/apis/shared_powerappsforappmakers"
    default_action_rule_behavior = ""
    action_rules = []
    endpoint_rules = []
  },
  {
    id = "/providers/Microsoft.PowerApps/apis/shared_teams"
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
