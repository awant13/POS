# POS 
![Image alt](https://github.com/awant13/pos/blob/main/image/pos.png)
### Запуск

#### Копируем кода проекта 

```bash
mkdir pos && cd pos
git clone https://github.com/awant13/POS.git .
```
*В директории pos создать каталог sotrage c необходимым набором файлов*

#### Сборка STAGING

```bash
docker-compose -f docker-compose-staging.yaml build
```

```bash
docker-compose -f docker-compose-staging.yaml up -d 
```

#### Запуск PROD

```bash
docker-compose -f docker-compose-staging.yaml up -d 
```

#### Проверка HELTHCHECK контейнера

```bash
docker inspect --format '{{json .State.Health}}' unibox-ve | jq
```
#### Проверка метрик приложения 

```bash
curl -k https://$HOSTNAME:8000/hw_proxy/status_json  | jq
```
