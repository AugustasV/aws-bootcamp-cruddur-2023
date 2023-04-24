# Week 3 — Decentralized Authentication

SAML is language for one connection
OpenID connect: let you use other services for authentication, like OAuth,
GitHub or LinkedIn credentials could be used to access websites

Decentralized authentication: One username and password could be reused

What is Amazon Cognito? It’s a user directory with a context of Amazon Web Services, something like Active Directory. It can be specified with policies that determine which services users can access. Furthermore, it provides temporary credentials with an expiration date and temporary access tokens. It’s a regional service.

> "GCP has many good services, but the documentation is awful."

After importing AWS Amplify libraries, configuring the behavior of what could be seen when logged in and what could be shown all the time. 

I ran out of space and used the `docker prune` command - That reclaimed 20 GB of data. 
Added a sign-in form on the Sign Page so that AWS Cognito would be in place instead of using cookies. At first, you just did console.log to show errors in the console. You mixed up some variables, but now it’s all good, and you can see error messages on the Sign page.

It is strange that when creating a user in AWS Cognito UI, the user gets stuck in a strange state where they are prompted to change their password, and this cannot be fixed through the UI. To resolve this issue, I used the AWS CLI to run the following command:

`aws cognito-idp admin-set-user-password --user-pool-id "us-east-2_10s0M5FZq" --username "augustas" --password "Testing1234!" --permanent`

After running this command, I was able to successfully login and logout. I also added a User attribute through the AWS Cognito CLI, which enabled me to see the user handle and name when logged in. However, managing data in this way can be challenging.

I have also implemented functionality for signing up and recovering passwords, and have added corresponding pages. One issue I encountered was that the error text was difficult to read due to the black font color. I attempted to address this by modifying the CSS.

To enable JWT access tokens, I integrated the `Flask-AWSCognito` library (https://github.com/cgauge/Flask-AWSCognito). While this library was helpful in validating the token and ensuring system integrity, it lacked documentation and had some limitations. To address these issues, I reused portions of code from the library and integrated them into my code. The integration of AWS Cognito into my code was not well-documented or straightforward, which presented additional challenges.

We decided not to use boto3, the AWS Python library, because using it would require hitting the AWS API every time we wanted to check the Cognito token, which is not an efficient way to handle things.

As an alternative, we considered using the [aws-jwt-verify](https://github.com/awslabs/aws-jwt-verify) library, which was created for node.js backends, not Python. Although it is well-documented and could be used in a sidecar container, it would still require paying for the cost of running the container. Additionally, if we were to deploy multiple applications, each one would need its own sidecar container to obtain the JWT token, which would increase costs.

Instead, we opted to integrate the JWT verification code into our Python code, even though it required a bit more effort to implement. This approach is cheaper in the long run and eliminates the need for an intermediate sidecar container.

Another third-party option we considered was the [cognitojwt](https://github.com/borisrozumnuk/cognitojwt) Python library. However, we would need to check the code quality of the library before using it. Libraries created by AWS or other reputable companies are usually better supported and more reliable.

It is important to note that a JWT token contains specific encoded values and should be handled with care to ensure the security and integrity of the system.