locals {
  website_gateway_name = "guestbook-frontend-gateway"
}

resource "yandex_api_gateway" "guestbook_frontend_gateway" {
  name      = local.website_gateway_name
  folder_id = local.folder_id
  spec      = file("../frontend/openapi.yaml")
}

output "guestbook_frontend_gateway_domain" {
  value = "https://${yandex_api_gateway.guestbook_frontend_gateway.domain}"
}
