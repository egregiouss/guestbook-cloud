locals {
  database_name = "guestbook-database"
}

resource "yandex_ydb_database_serverless" "guestbook-database" {
  name      = local.database_name
  folder_id = local.folder_id
}

output "guestbook-database_document_api_endpoint" {
  value = yandex_ydb_database_serverless.guestbook-database.document_api_endpoint
}

output "guestbook-database_path" {
  value = yandex_ydb_database_serverless.guestbook-database.database_path
}
