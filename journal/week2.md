# Week 2 — Distributed Tracing

Usually we had logs for tracing, but modern observability mix all the logs in system, and give as a story what happened.
When systems are massive, it's good to see on service map how services are connected




Honeycomb is good service for distributed observability. We will use OpenTelemetry with Honeycomb.

Key thing is to gather backend metrics, frontend not so usefull and straightforward to setup.

OpenTelemetry will send metrics into honeycomb. Honeycomb support Node.js, Python, Java, .NET, Ruby, Go, Browser and Other platforms.

* Best practice about docker image for dev and prod environments
For dev environment you have base image of Ubuntu, with all tools that could be useful for debugging and testing purposes. For Prod you start with base image, mostly alpine so image is slim, works fast and is most secure.