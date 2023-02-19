# Week 0 — Billing and Architecture

#### Architecture

A good requirement is to be measurable and specific, which will aid in understanding in the long run.
* verifiable
* monitor able
* traceable
* feasible

It's important to keep risks, assumptions, and constraints in mind.

#### Risks examples:

* User commitment, late deliveries.
* single point of failure.
* Assumptions are things that we pretend are true but are not.
* budget changes,
* stakeholders availability.
* sufficient network bandwidth.

#### The technical limitations are

* time: 14 weeks of boot camp.
* budget – utilizing the free tier.
* AWS vendor selection.
#### In the design phase, we should sketch a diagram of infrastructure.

* There are three steps to this.
* Conceptual design is an abstract idea created by stakeholders without specific details.
* Database, Server, no specifics.
#### Logic Design

How it should be implemented, without actual names

#### Physical design

* Represent the actual infrastructure that was built.
* IP addresses, EC2 instances, access resource names, bucket names
* This phase is super important.

> "Dumb questions," such as "do we have enough skillsets, enough workforce?" must be asked.

#### Document everything:

* Where the data lies and how it works
* Use AWS's well-architected framework to review your workloads against current AWS best practices. The main idea is to ask the right questions without getting too caught up in infrastructure.
* Knowing the AWS well-architected framework allows you to ask stakeholders and engineers the right questions.
* It's good to ask what the goal of this meeting is, especially if they have different backgrounds. Try to overcome your fear of asking "dumb questions" and ask about architecture.

## Insights
* In AWS right now it's possible to select black theme and default region (no more switching) https://aws.amazon.com/about-aws/whats-new/2022/04/unified-settings-aws-management-console/

## Security
* It's good security practice to grant least access as posible, use AWS Organizations. Force to use MFA to spin up ec2 instances. Yubikey is also supported by AWS for 2FA.
* Great aws organizations policy resources https://github.com/hashishrajan/aws-scp-best-practice-policies
* Least privilages as possible