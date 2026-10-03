data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_launch_template" "app" {
  name_prefix   = "${var.environment}-cloud-webapp-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  vpc_security_group_ids = [var.app_security_group_id]

  iam_instance_profile {
    name = var.iam_instance_profile_name
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y nginx

    cat <<HTML > /usr/share/nginx/html/index.html
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Professional AWS Cloud Web Application</title>
      <style>
        body {
          margin: 0;
          font-family: Arial, sans-serif;
          background: #f4f6f8;
          color: #1f2937;
        }

        .container {
          max-width: 900px;
          margin: 60px auto;
          padding: 20px;
        }

        .header {
          background: #ffffff;
          padding: 35px;
          border-radius: 12px;
          box-shadow: 0 4px 15px rgba(0,0,0,0.08);
          margin-bottom: 25px;
        }

        h1 {
          margin: 0 0 10px;
          font-size: 32px;
        }

        .subtitle {
          color: #6b7280;
          font-size: 16px;
        }

        .status {
          display: inline-block;
          margin-top: 15px;
          padding: 8px 14px;
          background: #dcfce7;
          color: #166534;
          border-radius: 20px;
          font-weight: bold;
        }

        .grid {
          display: grid;
          grid-template-columns: repeat(2, 1fr);
          gap: 18px;
        }

        .card {
          background: #ffffff;
          padding: 22px;
          border-radius: 10px;
          box-shadow: 0 3px 12px rgba(0,0,0,0.06);
        }

        .card h3 {
          margin-top: 0;
          margin-bottom: 8px;
        }

        .check {
          color: #16a34a;
          font-weight: bold;
        }

        .info {
          margin-top: 25px;
          background: #ffffff;
          padding: 22px;
          border-radius: 10px;
          box-shadow: 0 3px 12px rgba(0,0,0,0.06);
        }

        .footer {
          text-align: center;
          margin-top: 25px;
          color: #6b7280;
          font-size: 14px;
        }

        @media (max-width: 650px) {
          .grid {
            grid-template-columns: 1fr;
          }
        }
      </style>
    </head>

    <body>
      <div class="container">

        <div class="header">
          <h1>Professional AWS Cloud Web Application</h1>
          <div class="subtitle">
            Terraform-managed AWS cloud infrastructure demonstration
          </div>
          <div class="status">✓ Application Running</div>
        </div>

        <div class="grid">

          <div class="card">
            <h3>✓ Application Load Balancer</h3>
            <p>Internet-facing traffic distribution</p>
          </div>

          <div class="card">
            <h3>✓ Auto Scaling</h3>
            <p>Application capacity managed automatically</p>
          </div>

          <div class="card">
            <h3>✓ Amazon EC2</h3>
            <p>Application servers running across Availability Zones</p>
          </div>

          <div class="card">
            <h3>✓ Amazon RDS</h3>
            <p>Managed MySQL database infrastructure</p>
          </div>

          <div class="card">
            <h3>✓ Multi-AZ Architecture</h3>
            <p>Infrastructure distributed across eu-west-2a and eu-west-2b</p>
          </div>

          <div class="card">
            <h3>✓ CloudWatch</h3>
            <p>Infrastructure monitoring and Auto Scaling alarms</p>
          </div>

        </div>

        <div class="info">
          <strong>Environment:</strong> Development<br>
          <strong>Region:</strong> eu-west-2 (London)<br>
          <strong>Server:</strong> $(hostname)
        </div>

        <div class="footer">
          Student Cloud Engineering Project · AWS · Terraform
        </div>

      </div>
    </body>
    </html>
    HTML

    systemctl enable nginx
    systemctl start nginx
  EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.environment}-cloud-webapp-app"
    }
  }
}

resource "aws_autoscaling_group" "app" {
  name                = "${var.environment}-cloud-webapp-asg"
  min_size            = var.min_size
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = var.app_subnet_ids
  target_group_arns   = [var.target_group_arn]

  health_check_type         = "ELB"
  health_check_grace_period = 120

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.environment}-cloud-webapp-app"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "cpu_target" {
  name                   = "${var.environment}-cloud-webapp-cpu-scaling"
  autoscaling_group_name = aws_autoscaling_group.app.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 50.0
  }
}