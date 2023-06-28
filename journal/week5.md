# Week 5 — DynamoDB and Serverless Caching

We need to think what data we are putting in - that's influence decision what DB to use.

Preplanning to know what date involved and when it's involved is critical to preplan. Not good approach just to put data into table ant than trying to figure it out how to use it. Because in that case it will not work well, or it will get to expensive

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

Creating bash scripts for DynamoDB will make it easier to prepare seed data.

For debugging, check logs and specific responses within the browser console. To check database tables, use the command `SELECT * from users;` and `\x auto` for improved output formatting. In VS Code, the combination `Ctrl + P` is useful for quickly navigating between files.

Many parts required debugging step by step to identify the cause since the messages were not being shown yet.

- Checked the development for DynamoDB variables (endpoint URL was being set for the AWS CLI).
- Performed a scan using the utility script to check inside the database.
- Compared the implementation in the lib file with the `bin/patterns/list-conversations` to see if one of them was working.

Useful commands to run each time starting Gitpod:
```
./bin/db/setup
./bin/ddb/schema-load 
./bin/ddb/seed
```

It worked!

```
[2023-Jun-24 20:57]  GET http /api/messages/5ae290ed-55d1-47a0-bc6d-fe2bc2700399? 200 OK
[2023-Jun-24 20:57]  GET http /api/message_groups? 200 OK
 - - [24/Jun/2023 20:57:02] "GET /api/message_groups HTTP/1.1" 200 -
 - - [24/Jun/2023 20:57:02] "GET /api/messages/5ae290ed-55d1-47a0-bc6d-fe2bc2700399 HTTP/1.1" 200 -
```

UUIDs in the database and DynamoDB must match.

## DynamoDB Stream trigger to update message groups

AWS VPC gateway endpoints do not introduce additional charges and are used to control access to DynamoDB, such as restricting access to specific tables.

Next, create a Lambda function to grant permission for reading DynamoDB stream events. The Lambda function should be triggered only when a new message is created.

After deploying the Lambda function, the `AWSLambdaInvocation-DynamoDB` permission was added to the Lambda IAM role. However, it was not sufficient. Following best AWS security practices, a specific IAM role was created for our DynamoDB table.

After several attempts, it started work as expected. In the AWS CloudWatch log groups, the streams received the expected output, and the database table was properly populated.
```yaml
{
   "Records":[
      {
         "eventID":"3328806016f56c2f6060f1df0d2a82b5",
         "eventName":"INSERT",
         "eventVersion":"1.1",
         "eventSource":"aws:dynamodb",
         "awsRegion":"us-east-2",
         "dynamodb":{
            "ApproximateCreationDateTime":1687774560.0,
            "Keys":{
               "sk":{
                  "S":"2023-06-26T10:16:00.375877+00:00"
               },
               "pk":{
                  "S":"MSG#5ae290ed-55d1-47a0-bc6d-fe2bc2700399"
               }
            },
            "NewImage":{
               "user_uuid":{
                  "S":"76d2f241-a860-4d8b-a8e3-6cd68db75ab9"
               },
               "user_handle":{
                  "S":"Augustsz"
               },
               "sk":{
                  "S":"2023-06-26T10:16:00.375877+00:00"
               },
               "message_uuid":{
                  "S":"5ebf5021-1881-4e1c-8c10-93173ba1a87a"
               },
               "pk":{
                  "S":"MSG#5ae290ed-55d1-47a0-bc6d-fe2bc2700399"
               },
               "message":{
                  "S":"opa"
               },
               "user_display_name":{
                  "S":"Augustsz"
               }
            },
            "SequenceNumber":"8500000000009229331846",
            "SizeBytes":299,
            "StreamViewType":"NEW_IMAGE"
         },
         "eventSourceARN":"arn:aws:dynamodb:us-east-2:194030184857:table/cruddur-messages/stream/2023-06-26T08:36:49.800"
      }
   ]
}
```
