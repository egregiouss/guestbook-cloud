# Создание инфраструктуры

1. Выставить env `FOLDER_ID` и заполнить `provider.tf` соответсвующими значениями переменных из облака
2. стартовая инфра ./startup.sh
3. Заполнить следующие переменные окружения значениями из вывода скрипта + из созданного скриптом файла aws_secret.txt
```
      API_SA_ID
      AWS_ACCESS_KEY_ID
      DOCUMENT_API_ENDPOINT
      GUESTBOOK_API_REPOSITORY_NAME
      GUESTBOOK_API_CONTAINER_ID
      AWS_SECRET_ACCESS_KEY
```
4. Выдать права сервсианому акку командой `./grant_permissions.sh`
5. Поменять в openapi файлах(бэк и фронт) заглушки `API_SA_ID` и `GUESTBOOK_API_CONTAINER_ID` на реальные значения
6. гейтвеи 
- `terraform apply -target=yandex_ydb_database_serverless.guestbook_api_gateway`
- `terraform apply -target=yandex_api_gateway.guestbook_frontend_gateway`
- выставляем в енвы `GUESTBOOK_API_GATEWAY`, вывод второй - ссылка для фронта 
7. Создать бакеты командой `terraform apply -target=yandex_storage_bucket.guestbook_frontend_bucket` + добавить env `GUESTBOOK_WEBSITE_BUCKET` с соответсвующим значением
8. в папке `backend` выполнить python скрипт create_tables.py для создания таблиц в бд а в папке `frontend/src/api.js` указать значение `GUESTBOOK_API_GATEWAY` 
8. вроде все создали и все переменные выставили, можно деплоить - скрипт `deploy.sh` лежит в каждой из папок `frontend` и `backend` 
