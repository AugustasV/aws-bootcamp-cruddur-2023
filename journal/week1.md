# Week 1 — App Containerization

Created a docker image and ran the flask backend.

API received from https://{URL}gitpod.io/api/activities/home

`docker build -t flask-backend ./backend-flask`

Interesting that -t means to tag a version of the Docker image, not a literal tag.
Added docker files and docker-compose files.
##### Docker environment variables pass
When setting variables in Shell, it makes no difference whether we use single or double quotes (" "). Only single quotes ( ' ' ) can be passed into the Docker cli.