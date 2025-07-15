resource "azurerm_cdn_frontdoor_profile" "mg-frontdoor" {
  name                = var.frontdoor_name
  resource_group_name = var.resource_group_name
  sku_name            = "Premium_AzureFrontDoor"
}

resource "azurerm_cdn_frontdoor_endpoint" "mg-endpoint" {
  name                     = var.frontdoor_endpoint_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.mg-frontdoor.id
}