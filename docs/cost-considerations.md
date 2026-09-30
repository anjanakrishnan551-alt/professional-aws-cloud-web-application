# Cost Considerations

While building this project, I also wanted to understand which AWS services can create costs and how I can avoid leaving resources running unnecessarily.

## Services that may create charges

Some of the services used in this project can create costs when they are deployed, including:

- NAT Gateway
- Application Load Balancer
- EC2 instances
- Amazon RDS
- CloudWatch logs and metrics
- Route 53 if a hosted zone is added later

## How I plan to control cost

For testing, I will:

- Use small instance sizes where possible
- Keep the environment running only while I am testing it
- Take screenshots and record the results
- Destroy the infrastructure after testing
- Avoid leaving NAT Gateway, RDS and Load Balancer resources running
- Use Terraform so the whole environment can be removed cleanly

After testing, I will run:

```bash
terraform destroy

This removes the deployed AWS resources while keeping the Terraform code and project evidence in GitHub.
Why this matters
One thing I learned from this project is that good cloud engineering is not only about building infrastructure.
It also includes thinking about:
- Cost
- Security
- Availability
- Monitoring
- Resource cleanup
For a portfolio project, I do not need to keep the infrastructure running permanently. I only need to deploy it long enough to test it properly, collect evidence and then remove it.