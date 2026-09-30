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

The infrastructure is spread across two Availability Zones so the application is not dependent on only one AWS location.
What I have completed so far
So far I have built the networking foundation using Terraform:
- Created the VPC
- Added an Internet Gateway
- Created public subnets across two Availability Zones
- Created private application subnets
- Created private database subnets
- Added public and private route tables
- Added NAT Gateway configuration
- Kept the database network isolated from the public internet
- Added Terraform outputs
- Successfully ran terraform init
- Successfully validated the Terraform configuration
What I am learning
Through this project I am learning:
- How AWS networking works
- The difference between public and private subnets
- How route tables control traffic
- Why databases should not be publicly accessible
- How high availability works across Availability Zones
- How Terraform modules help keep infrastructure organised
- How Infrastructure as Code can be used to build repeatable cloud environments
Technologies
- AWS
- Terraform
- Amazon VPC
- EC2
- Application Load Balancer
- Auto Scaling
- Amazon RDS
- IAM
- CloudWatch
- Git
- GitHub
Current Status
This project is still in progress.