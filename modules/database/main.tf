resource "aws_db_subnet_group" "this" {
  name       = "${var.environment}-cloud-webapp-db-subnet-group"
  subnet_ids = var.database_subnet_ids

  tags = {
    Name = "${var.environment}-cloud-webapp-db-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier = "${var.environment}-cloud-webapp-db"

  allocated_storage           = 20
  max_allocated_storage       = 100
  engine                      = "mysql"
  engine_version              = "8.0"
  instance_class              = var.db_instance_class
  db_name                     = var.db_name
  username                    = var.db_username
  manage_master_user_password = true

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.database_security_group_id]

  publicly_accessible = false
  multi_az            = true
  storage_encrypted   = true

  backup_retention_period = 7
  skip_final_snapshot     = true
  deletion_protection     = false

  tags = {
    Name = "${var.environment}-cloud-webapp-db"
  }
}
