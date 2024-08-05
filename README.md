# Итоговое задание «Интенсив Docker»

Докеризировать python приложение:
- Подготовить Dockerfile, в котором архив с веб-приложением скачивается с официального сайта, распаковывается в контейнер. Базовый образ может быть любой с Docker Hub (Ubuntu, Debian, Alpine). Использовать готовый образ с веб-приложением нельзя!
- С помощью docker-compose.yml прокинуть туда конфиги и все необходимое. Приложение должно состоять из фронта (nginx, caddy), самого приложения (Apache, uwsgi), и базы данных. Необходимо использовать две сети, в одной находится фронт и приложение, в другой приложение и база данных.
- В итоге по команде docker-compose up собираются образы и запускается приложение.
```
Результат: репозиторий с docker-compose.yml и всем необходимым для запуска
```
## Быстрый старт

```bash
git clone https://github.com/alexander-barmin/py-jokes.git
cd ./py-jokes/
docker-compose up -d
curl http://10.100.11.10/
```
## Отладка
```bash
docker-compose down
mv ./docker-compose.override.+yml ./docker-compose.override.yml
docker-compose up --build --force-recreate
curl http://10.100.11.10/
```
