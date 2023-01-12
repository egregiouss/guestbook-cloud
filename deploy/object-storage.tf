locals {
  images_bucket_name_prefix  = "guestbook-images"
  website_bucket_name_prefix = "guestbook-website"
}

resource "yandex_storage_bucket" "guestbook_images_bucket" {
  bucket     = "${local.images_bucket_name_prefix}-${local.folder_id}"
  access_key = yandex_iam_service_account_static_access_key.guestbook_api_sa_static_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.guestbook_api_sa_static_key.secret_key
}

resource "yandex_storage_bucket" "guestbook_website_bucket" {
  bucket     = "${local.website_bucket_name_prefix}-${local.folder_id}"
  access_key = yandex_iam_service_account_static_access_key.guestbook_api_sa_static_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.guestbook_api_sa_static_key.secret_key
}

output "guestbook_images_bucket" {
  value = yandex_storage_bucket.guestbook_images_bucket.bucket
}

output "guestbook_website_bucket" {
  value = yandex_storage_bucket.guestbook_website_bucket.bucket
}
