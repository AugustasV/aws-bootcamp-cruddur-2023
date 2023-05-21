# Week 4 — Postgres and RDS

* It's practical to turn off RDS instance if you are not using it. It's called temporary shutdown, that's let you turn off the instance for 7 days - after that time it's restarted automatically.
So created RDS instance on AWS, but stopped for now. Inside my docker container PostgreSQL instance created db. Creating SQL schema file.
* Its good practice to export connection URL for docker container `export CONNECTION_URL="postgresql://postgres:password@localhost:5432/cruddur"`
this command save connection string
and setting up for Gitpod env ` gp env CONNECTION_URL="postgresql://postgres:password@localhost:5432/cruddur"`, so we don't need every time to enter that long string
prod connection url for AWS RDS database ` export PROD_CONNECTION_URL="postgresql://cruddurroot:Password@cruddur-db-instance.ceqpiscnjzto.us-east-2.rds.amazonaws.com:5432/cruddur"`
Space before `gp env` and `export` is used, so command will not be saved into history of commands

Created bash scripts, so it's easier to manipulate with development local dockerized database and AWS RDS database. Experimented with bash output different colors

Database schema is like different namespaces in database. There is default namespace Public, it goes there if we are not specifying.
Created schema is in `backend-flash/db/schema.sql` file. It's empty namespaces
Seed.sql is mock up data to fill schema.sql file, so we could check if fields we created, and database created would fit.

Installing PostgreSQL python driver is needed to integrate code with database. Specifying connection pool - so we would limit how many connections could be made at once

Added GitHub Codespaces config, so I could have same environment on GitHub Codespaces platform or on local machine if I would open code in container (because it has.devcontainer file). This approach works, but it's super slow, so will be used only as alternative.

Creating lambda so than new user will register, lambda will make new entry into database. After lambda creation, it has to be added directly to AWS Cognito. I used lambda layer, so I don't need to add python library directly with python file to lambda.

Also, I had to set up database connection endpoint variable into lambda, also adding VPC.
Oh, and basic lambda iam role didn't have permission to create VPC. Had to edit role and add some ec2 policies to do that.

As docker plugin icon disappeared from Gitpod Vscode left side, I am using docker CLI commands since.
In case if container exited, that's the command to show those containers ID, so I could check logs to find out reason behind it `docker ps -a -q -f status=exited`