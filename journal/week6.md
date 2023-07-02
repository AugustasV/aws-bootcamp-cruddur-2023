# Week 6 — Deploying Containers

AWS ECS, there are many vulnerable images.  
Difference between EC2 and ECS that ECS managing infrastructure for you.

AWS Fargate vs EC2
AWS Fargate you are only responsible to put container in pace, AWS take care of underlying infrastructure - 
* you have no access to it. Ephemeral  
* Resources makes it hard to do triage or 
* Forensics for detected threats
* No file/network monitoring
* Can't run traditional security agent in Fargate
* Users can run unverified containers

EC2 you managing everything on your own.

AWS ECS Anywhere allow to deploy containers outside from AWS architecture.

* On ECS, it's possible to have Task role and Task execution roles.
*If monitoring is good, ssh to container is not a must, and also it's best practice, so we are making sure we know what is inside container
* AWS Inspector does scanning for ECS images
Snyk is good alternative to identify vulnerabilities.
* Cloud Control Plane Configuration - access control, container images
* Amazon ECR Scan Images
* Use VPC Endpoints or Security Groups with known sources only.
* Compliance standard should be specified 

In containers, we must pack only essentials packages ( without curl get etc) because if someone could access containers, it can't do anything.

Using session manager plugin we can access 
Instead of using gitpod url in `REACT_APP_BACKEND_URL` variable, we are changing to loadbalancer DNS
