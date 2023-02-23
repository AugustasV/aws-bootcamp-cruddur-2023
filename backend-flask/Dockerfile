# Using alpine image, in that way we make build time shorter
FROM python:alpine3.17

WORKDIR /backend-flask

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .

ENV FLASK_ENV=development
# It could be hardcoded like that bellow
# ENV BACKEND_URL="*"
# ENV FRONTEND_URL="*"

EXPOSE ${PORT}
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port=4567"]