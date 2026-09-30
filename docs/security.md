# Testing and Validation

I am using this file to keep track of how I validate the Terraform code and how I plan to test the AWS infrastructure once it is deployed.

## Terraform Checks

Before deploying anything to AWS, I run:

```bashs
terraform fmt -recursive
terraform validate

This helps me check that the Terraform code is formatted correctly and that there are no configuration errors.
So far, the project has passed Terraform validation successfully.
What I will test after deployment
Once the infrastructure is deployed in AWS, I will test each part of the architecture.
Networking
I will check that:
- The VPC is created correctly
- Public, application and database subnets are created across two Availability Zones
- Public subnets can reach the internet
- Private app subnets use the NAT Gateway for outbound access
- Database subnets do not have direct internet access
Load Balancer
I will check that:
- The Application Load Balancer is running
- It is connected to both public subnets
- Port 80 is listening for HTTP traffic
- The target group shows healthy EC2 instances
Application Servers
I will check that:
- The Auto Scaling Group launches the expected number of EC2 instances
- The EC2 instances are inside private application subnets
- The Nginx page can be opened using the ALB DNS name
- Traffic is distributed between multiple EC2 instances
- Auto Scaling can replace an unhealthy instance
Database
I will check that:
- Amazon RDS is created inside the private database subnets
- The database is not publicly accessible
- Multi-AZ is enabled
- Storage encryption is enabled
- Automated backups are enabled
- Only the application security group can access the database
Monitoring
I will check that:
- CloudWatch alarms are created
- High CPU monitoring is working
- Unhealthy target monitoring is configured
- The SNS topic for alerts is created