resource "aws_security_group" "alb" {
  name        = "${var.environment}-cloud-webapp-alb-sg"
  description = "Allow web traffic from the internet to the Application Load Balancer"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-cloud-webapp-alb-sg"
  }
}

resource "aws_security_group" "app" {
  name        = "${var.environment}-cloud-webapp-app-sg"
  description = "Allow application traffic only from the load balancer"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow traffic from the ALB"
    from_port       = var.app_port
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-cloud-webapp-app-sg"
  }
}

resource "aws_security_group" "database" {
  name        = "${var.environment}-cloud-webapp-db-sg"
  description = "Allow database traffic only from the application servers"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow MySQL from application servers"
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [aws_security_group.app.id]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-cloud-webapp-db-sg"
  }
}