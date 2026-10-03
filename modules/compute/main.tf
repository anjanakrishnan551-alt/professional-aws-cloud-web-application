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
    <html>
      <head>
        <title>AWS Cloud Web Application</title>
      </head>
      <body>
        <h1>Professional AWS Cloud Web Application</h1>
        <p>This application is running on an EC2 instance behind an Application Load Balancer.</p>
        <p>Hostname: $(hostname)</p>
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