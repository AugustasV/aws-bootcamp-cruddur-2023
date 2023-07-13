# Using alpine image, in that way we make build time shorter
FROM 194030184857.dkr.ecr.us-east-2.amazonaws.com/cruddur-python:3.10-slim-buster

WORKDIR /backend-flask

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .

ENV FLASK_ENV=development
# It could be hardcoded like that bellow
# ENV BACKEND_URL="*"
# ENV FRONTEND_URL="*"

EXPOSE ${PORT}
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port=4567", "--no-debug", "--no-debugger", "--no-reload"]
