resource "azurerm_cdn_frontdoor_origin_group" "mg-origin-group" {
  name                     = var.origin_group_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.mg-frontdoor.id

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

resource "azurerm_cdn_frontdoor_origin" "mg-origin" {
  name                           = var.origin_name
  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.mg-origin-group.id
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