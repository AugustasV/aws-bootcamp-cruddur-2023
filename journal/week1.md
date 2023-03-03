# Week 1 — App Containerization

Created a docker image and ran the flask backend.

API received from https://{URL}gitpod.io/api/activities/home

`docker build -t flask-backend ./backend-flask`

Interesting that -t means to tag a version of the Docker image, not a literal tag.
Added docker files and docker-compose files.
##### Docker environment variables pass
When setting variables in Shell, it makes no difference whether we use single or double quotes (" "). Only single quotes ( ' ' ) can be passed into the Docker CLI.

## Security best practices
* Update docker engine often.
* Run image vulnerability check - for example Snyk in CI/CD process - there is open source version.
* Trust only private image registry.
* Read only file system volume for docker.
* Read about DevSecOps practices.
* Container must have only limited things that are needed for container.

Clair is good open source alternative for snyk, or Amazon Inspector. To use clair you have to use their docker image.

## Different containerization options on AWS
AWS ECS, AWS EKS, AWS Fargate, AWS App Runner, AWS CoPilot.
* AWS ECS - managed containers service platform as a Service.
* AWS EKS - Kubernetes service, managed by user.
* AWS App Runner - Managed container app service.
* AWS CoPilot - To Launch and manage applications on Amazon ECS an AWS Fargate.

## Snyk tool against this repo
In Snyk I ran project check against vulnerabilities, and find out 3 of them. Two of them High severity, named Regular Expression Denial of Service (ReDoS). I find out that those are just false-positive.
> For example, a "Regex DDOS attack" can never be a real vulnerability for a development-time tool.

Source: https://github.com/facebook/create-react-app/issues/11174
* I could try to use different versions but didn't want to introduce breaking changes.
#### What I did
Learned about security, scanned this repo with Snyk.

## Enabling notifications
First we have to update open API file, then make changes in flask backend files. In App.py we have to import it. Need to make sure that classes, naming are correct. Terminal logs show where are issues.