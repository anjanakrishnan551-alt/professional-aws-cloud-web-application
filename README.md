# Professional AWS Cloud Web Application

A professional-level AWS cloud engineering project focused on building a secure, scalable, highly available web application architecture using Terraform and core AWS services.

## Project Objective

This project demonstrates how a production-style cloud web application can be designed using Infrastructure as Code and AWS best practices.

The architecture will include:

- Multi-AZ VPC networking
- Public, application, and database subnet tiers
- Application Load Balancer
- Auto Scaling compute layer
- Private application servers
- Amazon RDS managed database
- IAM and security groups
- CloudWatch monitoring
- High availability and fault tolerance
- Terraform-based infrastructure provisioning

## Current Progress

Completed:

- Terraform project structure
- AWS provider configuration
- VPC foundation
- Internet Gateway
- Public subnets across two Availability Zones
- Private application subnets
- Private database subnets
- Public route table
- NAT Gateway architecture
- Private application route tables
- Isolated database routing
- Terraform outputs
- Terraform validation

## Architecture

The planned request flow is:

```text
Internet
   |
Application Load Balancer
   |
Private Application Tier
   |
Amazon RDS Database
