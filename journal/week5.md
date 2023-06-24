# Week 5 — DynamoDB and Serverless Caching

We need to think what data we are putting in - that's influence decision what DB to use.

Preplanning to know what date involed and when it's involded is critical to preplan. Not good appraoch just to put data into table ant than trying to figure it out how to use it. Because in that case it will not work well, or it will get to expensive

Difference between SQL and DynamoDB that there is no joint, you have to think how to put data into tables, and if you need multiple of those. We are going through single table design, because it helps to understand what data we need, it makes sense to keep it together. Also, it could save money too

It is possible to write SQL for DynamoDB, using [partiql](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/ql-reference.html) It's not specific for DynamoDB, other tools using it too.

There is different than you just look the course about DynamoDB simple cases, and then adopting that knowledge for production case.

* Partition key - unique identifier. It must be specified.
* Global Secondary Index (GSI) - some fields can use different partition key, tables can be added during development. It's considered "global" because queries on the index can span all the data in the base table, across all partitions. It will be used in that project.
* Local Secondary Index (LSI) It requires second index key to be consistent, created at time of base database creation and can't be deleted. It needs both a partition and a sort key.
Partition key must be the same as the base table, sort key should be different.
Message and Message Group could be put into sort key.

## Do we even have to use single table design, or it's just a trend?

Usually, there are no cases where people build one way and then build another way to compare the differences. However, you should not use a single table design for everything; it should make sense why you are using it. It entirely depends on access patterns.

People often struggle with single table design when they don't know how to interact with their data effectively. If people don't have a clue about how NoSQL databases work or if they are using the wrong tool for their use case, struggles can arise.


## DynamoDB and NoSQL databases

- These databases have been created to facilitate easy scalability and reduce resource consumption compared to SQL databases.
- It is not necessary to connect to the database via the internet. Instead, you can attach a VPC or gateway endpoint to an EC2 instance, for example.

**Compliance considerations**:

- Data should be hosted in the same region where it is generated. For example, data generated in Europe should be hosted in Europe.
- Encryption at rest and in transit can be enabled without incurring additional costs.

**Security best practices**:

- Disable `delete database` option and deny delete DynamoDB table policies.
- Use AWS Organizations Service Control Policies to manage DynamoDB table deletion, creation, and region locking.
- Enable CloudTrail logging for auditing and monitoring DynamoDB activities.
- Use IAM Roles or AWS Cognito Identity Pool instead of providing direct access to specific users or groups.
- Use Site-to-Site VPN or Direct Connect for accessing DynamoDB from on-premises systems.
- Amazon recommends client-side encryption for DynamoDB.

Creating bash scripts for DynamoDB, so it will be easier to prepare seed data.

For debugging checking logs, specific responses inside browser console.
To check database tables using command `SELECT * from users;` and `\x auto` for better looking output
Ctrl + P is useful combination in VS code to jump between files

Many different parts, so I had to debug step by step to find the cause, because messages is not shown yet

* Checking development for DynamoDB vars(endpoint url is being set for the AWS CLI)
* Checking inside database by performing a scan using utility script
* Checking implementation in the lib file vs the bin/patterns/list-conversations, if one of them working

Usefull commands to run each time starting Gitpod
```
./bin/db/setup
./bin/ddb/schema-load 
./bin/ddb/seed
```
It works!
```
[2023-Jun-24 20:57] 192.168.149.76 GET http /api/messages/5ae290ed-55d1-47a0-bc6d-fe2bc2700399? 200 OK
[2023-Jun-24 20:57] 192.168.149.76 GET http /api/message_groups? 200 OK
192.168.149.76 - - [24/Jun/2023 20:57:02] "GET /api/message_groups HTTP/1.1" 200 -
192.168.149.76 - - [24/Jun/2023 20:57:02] "GET /api/messages/5ae290ed-55d1-47a0-bc6d-fe2bc2700399 HTTP/1.1" 200 -
```
UUIDS in database and DynamoDB must match
