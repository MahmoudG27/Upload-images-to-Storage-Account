resource "azurerm_cdn_frontdoor_firewall_policy" "mg-waf-policy" {
  name                                      = "DefaultWebAppWafbf0f964e7f6d4dbd9b43edefedb247e0"
  resource_group_name                       = var.resource_group_name
  sku_name                                  = "Premium_AzureFrontDoor"
  enabled                                   = true
  js_challenge_cookie_expiration_in_minutes = 30
  mode                                      = "Detection"
  request_body_check_enabled                = true


  managed_rule {
    action  = "Block"
    type    = "Microsoft_DefaultRuleSet"
    version = "2.1"
  }
}