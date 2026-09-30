# Professional AWS Cloud Web Application

This is a cloud engineering project I am building to understand how a real web application can be designed and hosted on AWS.

The main goal of this project is to learn how different AWS services work together to create a secure, scalable and highly available application.

I am using Terraform so the infrastructure can be created and managed as code instead of setting everything up manually in the AWS Console.

## What I am building

The application architecture will include:

- A VPC for the main AWS network
- Public subnets for internet-facing resources
- Private application subnets for the app servers
- Private database subnets for Amazon RDS
- An Application Load Balancer
- Auto Scaling for the application servers
- Amazon RDS for the database
- Security Groups and IAM for access control
- CloudWatch for monitoring and logs
- Terraform for Infrastructure as Code

## Architecture

The basic traffic flow will be:

```text
Internet
   |
Application Load Balancer
   |
Private Application Servers
   |
Amazon RDS