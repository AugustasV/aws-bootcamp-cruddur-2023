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