resource "time_sleep" "wait_for_origin" {
  depends_on      = [azurerm_cdn_frontdoor_origin.mg-origin]
  create_duration = "300s"
}

resource "azurerm_cdn_frontdoor_route" "mg-route" {
  name                          = var.route_name
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.mg-endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.mg-origin-group.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.mg-origin.id]
  forwarding_protocol           = "MatchRequest"
  patterns_to_match             = ["/*"]
  supported_protocols           = ["Http", "Https"]
  https_redirect_enabled        = true
  link_to_default_domain        = true
  enabled                       = true

  depends_on = [time_sleep.wait_for_origin]
}