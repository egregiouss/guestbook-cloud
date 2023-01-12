locals {
  api_gateway_name = "guestbook-api-gateway"
}

resource "yandex_api_gateway" "guestbook_api_gateway" {
  name      = local.api_gateway_name
  folder_id = local.folder_id
  spec      = file("../backend/openapi.yaml")
}

output "guestbook_api_gateway_domain" {
  value = "https://${yandex_api_gateway.guestbook_api_gateway.domain}"
}
