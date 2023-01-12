#!/bin/bash

echo "`(cat version.json) | jq '.version = .version + 1'`"  > version.json;

app_version=$(jq -r '.version' version.json);

docker build -t ${GUESTBOOK_API_REPOSITORY_NAME}:0.0.app_version . ;

docker push ${GUESTBOOK_API_REPOSITORY_NAME}:0.0.app_version;

yc sls container revisions deploy \
	--folder-id ${FOLDER_ID} \
	--container-id ${GUESTBOOK_API_CONTAINER_ID} \
	--memory 512M \
	--cores 1 \
	--execution-timeout 5s \
	--concurrency 8 \
	--environment AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID},AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY},DOCUMENT_API_ENDPOINT=${DOCUMENT_API_ENDPOINT},APP_VERSION=$app_version \
	--service-account-id ${API_SA_ID} \
	--image "${GUESTBOOK_API_REPOSITORY_NAME}:0.0.$backendVersion";


