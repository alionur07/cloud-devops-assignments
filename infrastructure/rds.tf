resource "aws_db_subnet_group" "contoso-app-db" {
  name       = "contoso-app-db"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = "contoso-app-db"
  }
}

resource "aws_security_group" "rds" {
  name   = "contoso-app-db_rds"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "contoso-app-db_rds"
  }
}

resource "aws_db_parameter_group" "contoso-app-db" {
  name   = "contoso-app-db"
  family = "postgres13"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_instance" "contoso-app-db" {
  identifier             = "contoso-app-db"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "13.1"
  username               = var.db_user
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.contoso-app-db.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.contoso-app-db.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}