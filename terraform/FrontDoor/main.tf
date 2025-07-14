resource "azurerm_cdn_frontdoor_profile" "demo" {
  name                = "mgklayytechdemofrontdoor"
  resource_group_name = var.resource_group_name
  sku_name            = "Premium_AzureFrontDoor"
}

resource "azurerm_cdn_frontdoor_endpoint" "demo" {
  name                     = "webapp-origin"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.demo.id
}

resource "azurerm_cdn_frontdoor_origin_group" "demo" {
  name                     = "drupaldemo-origin"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.demo.id

  health_probe {
    interval_in_seconds = 100
    path                = "/"
    protocol            = "Http"
    request_type        = "HEAD"
  }

  load_balancing {
    additional_latency_in_milliseconds = 50
    sample_size                        = 4
    successful_samples_required        = 3
  }

}

resource "azurerm_cdn_frontdoor_origin" "demo" {
  name                           = "default-webapp-origin"
  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.demo.id
  certificate_name_check_enabled = true
  host_name                      = var.app_service_hostname
  http_port                      = 80
  https_port                     = 443
  origin_host_header             = var.app_service_hostname
  priority                       = 1
  weight                         = 1000

  private_link {
    location               = var.location
    private_link_target_id = var.app_service_id
    request_message        = "The request is from the Front Door service to connect to the App Service"
    target_type            = "sites"
  }
}

resource "azurerm_cdn_frontdoor_firewall_policy" "demo" {
  enabled                                   = true
  js_challenge_cookie_expiration_in_minutes = 30
  mode                                      = "Detection"
  name                                      = "DefaultWebAppWafbf0f964e7f6d4dbd9b43edefedb247e0"
  request_body_check_enabled                = true
  resource_group_name                       = var.resource_group_name
  sku_name                                  = "Premium_AzureFrontDoor"

  managed_rule {
    action  = "Block"
    type    = "Microsoft_DefaultRuleSet"
    version = "2.1"
  }
}


resource "time_sleep" "wait_for_origin" {
  depends_on = [ azurerm_cdn_frontdoor_origin.demo ]
  create_duration = "120s"
}

resource "azurerm_cdn_frontdoor_route" "demo" {
  name                          = "route-to-app"
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.demo.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.demo.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.demo.id]
  forwarding_protocol           = "MatchRequest"
  patterns_to_match             = ["/*"]
  supported_protocols           = ["Http", "Https"]
  https_redirect_enabled        = true
  link_to_default_domain        = true
  enabled                       = true

  depends_on = [ time_sleep.wait_for_origin ]
}
