#!/bin/sh

terraform apply -target=yandex_ydb_database_serverless.guestbook_database
terraform apply -target=yandex_iam_service_account.guestbook_api_sa
terraform apply -target=yandex_container_registry.default
terraform apply -target=yandex_container_repository.guestbook_api_repository
yc container registry configure-docker
yc sls container create --name guestbook-api-container --folder-id ${FOLDER_ID}
echo terraform output -raw aws_private_key
