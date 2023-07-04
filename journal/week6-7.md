# Week 6-7 — Deploying Containers

In AWS ECS, there are many vulnerable images. The main difference between EC2 and ECS is that ECS manages the infrastructure for you.

AWS Fargate vs EC2:
- With AWS Fargate, you are only responsible for putting the container in place, as AWS takes care of the underlying infrastructure.
- In Fargate, you have no access to the underlying ephemeral resources, making it hard to perform triage or forensics for detected threats. There is also no file/network monitoring, and traditional security agents cannot be run in Fargate. Users can run unverified containers.
- With EC2, you manage everything on your own.

AWS ECS Anywhere allows you to deploy containers outside of the AWS architecture.

Some key points:
- On ECS, it is possible to have Task roles and Task execution roles.
- While SSH access to containers is not necessary and not considered best practice, having good monitoring ensures we know what is inside the containers.
- AWS Inspector can perform scanning for ECS images, and Snyk is a good alternative for identifying vulnerabilities.
- Cloud Control Plane Configuration should include access control and container image management.
- Amazon ECR can scan images.
- Use VPC Endpoints or Security Groups with known sources only.
- Specify compliance standards.

Logs retention has been changed to 1 day to reduce costs, as CloudWatch Logs charges based on the amount of log data ingested, stored, and retrieved.

AWS Cloud Map is a service discovery for cloud resources. When creating an AWS ECS cluster and specifying the `--service-connect-default` namespace, it is possible to refer to that namespace instead of an endpoint.

## AWS Fargate

The project's base image is pulling Python from Docker Hub. To improve security, the image will be pulled to AWS ECR and referenced from there. The image is pulled, tagged for our image in the Docker registry, and changes are pushed.

It is generally not considered good practice to use the "latest" tag, but for AWS Fargate, it is required.

A task is short-term, while a service is a constantly running container.

In the task definition, specifying both the frontend and backend containers is not a good approach, as deploying both containers at once makes it difficult to scale them separately. It is recommended to specify a sidecar container, like a proxy, for better separation.

Since AWS Fargate uses VPC, only the container port needs to be specified, not the host port.

To create an ALB (Application Load Balancer), a new security group needs to be created that can access the ALB and redirect the necessary traffic. Backend and frontend target groups should be specified for ports 3000 and 4567, respectively.

In the containers, only essential packages should be included. It is important to avoid unnecessary packages like curl. This helps mitigate potential risks if someone gains access to the containers.

The session manager plugin can be used to access instances. Instead of using the Gitpod URL in the `REACT_APP_BACKEND_URL` variable, it will be changed to the load balancer DNS.

The ALB setup is completed, a domain is added to Route53, and an HTTPS certificate is created using AWS Certificate Manager.

As always, port 80 is redirected to 3000 (frontend) in the ALB configuration. Port 443 and the host header for the API are also added. In Route53, the domain is now directly pointed to the ALB using an alias. Using an alias allows direct pointing to other AWS services and avoids using static values, which is beneficial when changes occur.

Now, the API can be accessed via the load balancer URL: `https://api.cloudstuff.pro/api/health-check`.

## Deploying containers

When deploying containers on AWS and setting up a service mesh, AWS App Mesh and AWS Cloud Map are commonly used options. Another approach is to enable Service Connect directly from ECS Service, but it requires additional configuration and incurs costs since you would need a NAT gateway on every subnet.

NAT (Network Address Translation) allows private network resources to access the internet. AWS provides NAT Gateway for this purpose, but it comes with a cost and needs to be deployed in each subnet. Creating VPC endpoints is another possibility, but unfortunately, it's not available for Cognito. Interface endpoints could work, but they are needed for every subnet.

As an alternative, you can consider using [Alternat](https://github.com/1debit/alternat). It functions similarly to a AWS NAT Instance, allowing you to create a VM to meet your needs. The AWS NAT Instance has reached its end of life and is no longer actively supported. Only security updates will be provided for it going forward.