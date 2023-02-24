locals {
  name   = "dev-cpuc-poc"
  region = "us-west-1"

  tags = {
    Project    = "Test-CPUC"
    CreatedOn  = timestamp()
    Environment= terraform.workspace
    Example    = local.name
    GithubRepo = "terraform-aws-rds-aurora"
    GithubOrg  = "terraform-aws-modules"
  }
}
################################################################################
# PostgreSQL Serverless v2
################################################################################

data "aws_rds_engine_version" "postgresql" {
  engine  = "aurora-postgresql"
  version = "13.6"
}

module "aurora_postgresql_v2" {
  source = "terraform-aws-modules/rds-aurora/aws"

  name              = "${local.name}-postgresqlv2"
  engine            = data.aws_rds_engine_version.postgresql.engine
  engine_mode       = "provisioned"
  engine_version    = data.aws_rds_engine_version.postgresql.version
  storage_encrypted = true

  vpc_id                = module.vpc.vpc_id
  subnets               = module.vpc.database_subnets
  create_security_group = true
  allowed_cidr_blocks   = module.vpc.private_subnets_cidr_blocks

  monitoring_interval = 60

  apply_immediately   = true
  skip_final_snapshot = true

  db_parameter_group_name         = aws_db_parameter_group.example_postgresql13.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.example_postgresql13.id

  serverlessv2_scaling_configuration = {
    min_capacity = 1
    max_capacity = 10
  }

  instance_class = "db.serverless"
  instances = {
    one = {}
    two = {}
  }
}

resource "aws_db_parameter_group" "example_postgresql13" {
  name        = "${local.name}-aurora-db-postgres13-parameter-group"
  family      = "aurora-postgresql13"
  description = "${local.name}-aurora-db-postgres13-parameter-group"
}

resource "aws_rds_cluster_parameter_group" "example_postgresql13" {
  name        = "${local.name}-aurora-postgres13-cluster-parameter-group"
  family      = "aurora-postgresql13"
  description = "${local.name}-aurora-postgres13-cluster-parameter-group"
}

/*
module "db" {
  source = "terraform-aws-modules/rds/aws"
  # DB-Namel
  identifier = var.identifier

  # Database-Features
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  port              = var.port
  multi_az          = true
  major_engine_version = "8.0"      # DB option group

  # Database-Credentia; 
  db_name  = var.db_name
  username = var.username
  password = var.password

  # Security-Group
  vpc_security_group_ids = [aws_security_group.db_instance_securityGroup.id]

  #Backup & maintainance 
  maintenance_window      = var.maintenance_window
  backup_window           = var.backup_window
  backup_retention_period = 0

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = module.vpc.private_subnets

  # DB parameter group
  family = var.family

  # Database Deletion Protection
  skip_final_snapshot = true
  deletion_protection = var.deletion_protection

  # Tags 
  tags = var.tags
}
*/