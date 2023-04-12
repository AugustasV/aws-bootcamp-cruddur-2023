# Week 2 — Distributed Tracing

Usually we had logs for tracing, but modern observability mix all the logs in system, and give as a story what happened.
When systems are massive, it's good to see on service map how services are connected

Honeycomb is good service for distributed observability. We will use OpenTelemetry with Honeycomb.

Key thing is to gather backend metrics, frontend not so useful and straightforward to set up.

OpenTelemetry will send metrics into honeycomb. Honeycomb support Node.js, Python, Java, .NET, Ruby, Go, Browser and Other platforms.

* Best practice about docker image for dev and prod environments
For dev environment you have base image of Ubuntu, with all tools that could be useful for debugging and testing purposes. For Prod, you start with base image, mostly alpine so image is slim, works fast and is most secure.

* In Honeycomb had to add extra span to logs. A "span" refers to a specific task or operation within a system. For example, it could be a single action like sending an HTTP request or performing a database query. Each span has a unique ID and can be connected to other spans to create a trace that shows the entire path of a request through the system.

* Those API calls/results are hard coded, so it's easy to find them in honeycomb, filter out, see when error occurred in what time specifically.

## What's the difference between observability and monitoring

It's how question is asked, different things
### Monitoring
Thinking about if system is available, if system is healthy, if fault happened where and when, and if system is backed up.
### Observability
Thinking for how long system is up, what system is doing, what is the fault reason, also thinking how to prevent the issue from reoccurring.

### 3 pillars of observability
* Metrics - are useful to know key information about the system, real time state performance and utilization of application.
* Traces - uses unique identifiers to track requests as they flow from frontend devices to backend services and databases. 
* Logs - textual format of things what happening in the system.

## AWS X-Ray

X-Ray is middle ware software for analysis, traces collection. It's pretty straightforward way to get started, just need to install `aws-xray-sdk` package for python, pass AWS credentials for container, and we are good to go. Interesting that X-Ray could show services map, useful than more microservices would be used in place, not for now.

But configuration/setup is pretty clunky and takes much time to do some stuff that on AWS X-Ray - it's pretty hard to use. Sometimes it's just not worth a time, as there is plenty alternatives around. But I made it work, I could see Error (4xx) trace. 

## Rollbar

When an error occurs in an application, Rollbar detects it and sends a notification to the developer or team responsible for the application. This allows them to quickly diagnose and fix the issue, reducing downtime and improving overall application performance. It tries to show where exactly error happened and how to fix it. I could see many parameters of error - what programming language, server information like host, pid, root, uuid.