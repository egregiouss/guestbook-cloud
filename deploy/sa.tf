locals {
  service_account_name_prefix = "guestbook-service-acc"
}

resource "yandex_iam_service_account" "guestbook_api_sa" {
  name        = "${local.service_account_name_prefix}-${local.folder_id}"
  description = "Service account to call guestbook container and guestbook-database"
}

resource "yandex_iam_service_account_static_access_key" "guestbook_api_sa_static_key" {
  service_account_id = yandex_iam_service_account.guestbook_api_sa.id
}

output "guestbook_api_sa_id" {
  value = yandex_iam_service_account.guestbook_api_sa.id
}

output "aws_access_key_id" {
  value = yandex_iam_service_account_static_access_key.guestbook_api_sa_static_key.access_key
}

output "aws_private_key" {
  value = yandex_iam_service_account_static_access_key.guestbook_api_sa_static_key.secret_key
  sensitive = true
}
