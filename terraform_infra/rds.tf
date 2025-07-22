resource "aws_db_subnet_group" "this" {
  name       = "tf-eksdb-subnet-group"
  subnet_ids = module.rdsvpc.private_subnets
}
module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.12.0"

  identifier = "tf-eksdb"

  engine               = var.db_engine
  engine_version       = var.db_engine_version
  family               = "sqlserver-ex-15.0"
  major_engine_version = "15.00"
  instance_class       = var.db_instance_class
  license_model        = "license-included"

  allocated_storage     = 20
  max_allocated_storage = 100

  # Using sensitive variables for credentials
  username = var.db_username
  password = var.db_password
  port     = 1433

  multi_az               = false
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [module.rds_sg.security_group_id]

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["error"]
  create_cloudwatch_log_group     = true

  backup_retention_period = 1
  skip_final_snapshot     = true
  deletion_protection     = false

  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  create_monitoring_role                = true
  monitoring_interval                   = 60

  tags = {
    purpose = "priyank-personal-project"
  }
}

module "rds_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "tfeksrdssg"
  description = "Allow sql access from EKS nodes only"
  vpc_id      = module.rdsvpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 1433
      to_port     = 1433
      protocol    = "tcp"
      description = "MSSQL access from EKS VPC"
      cidr_blocks = var.eks_vpc_cidr
    }
  ]

  ingress_with_source_security_group_id = [
    {
      from_port                = 1433
      to_port                  = 1433
      protocol                 = "tcp"
      description              = "Oracle access from Bastion Host"
      source_security_group_id = aws_security_group.bastianhost_sg.id
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow all outbound traffic"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = {
    purpose = "priyank-personal-project"
  }
}