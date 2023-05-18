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
