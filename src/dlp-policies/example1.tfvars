# Power Platform DLP policy configuration
display_name = "Example 1"
environment_type = "OnlyEnvironments"
environments = ["Default-7e7df62f-7cc4-4e63-a250-a277063e1be7"]

business_connectors = [
    {
        id = "/providers/Microsoft.PowerApps/apis/shared_sql"
        default_action_rule_behavior = "Allow"
        action_rules = [
            {
                action_id = "DeleteItem_V2"
                behavior  = "Block"
            },
            {
                action_id = "ExecutePassThroughNativeQuery_V2"
                behavior  = "Block"
            },
        ]
        endpoint_rules = [
            {
                behavior = "Allow"
                endpoint = "contoso.com"
                order    = 1
            },
            {
                behavior = "Deny"
                endpoint = "*"
                order    = 2
            },
        ]
    },
    {
        id                           = "/providers/Microsoft.PowerApps/apis/shared_approvals"
        default_action_rule_behavior = ""
        action_rules                 = []
        endpoint_rules               = []
    },
    {
        id                           = "/providers/Microsoft.PowerApps/apis/shared_cloudappsecurity"
        default_action_rule_behavior = ""
        action_rules                 = []
        endpoint_rules               = []
    }
]

custom_connectors = [
    {
        order            = 1
        host_url_pattern = "https://*.contoso.com"
        data_group       = "Blocked"
    },
    {
        order            = 2
        host_url_pattern = "*"
        data_group       = "Ignore"
    }
]