
resource "aws_db_subnet_group" "taeho-io-database" {
  name        = "taeho-io-database"
  description = "taeho.io database subnets"
  subnet_ids  = data.terraform_remote_state.vpc.outputs.database_subnets
}

resource "aws_security_group" "mysql" {
  name        = "taeho-io-mysql"
  description = "taeho.io rds mysql serverless"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    cidr_blocks = [
      data.terraform_remote_state.vpc.outputs.vpc_cidr_block,
    ]
    ipv6_cidr_blocks = []

    protocol  = "tcp"
    from_port = 3306
    to_port   = 3306

    prefix_list_ids = []
    self            = false
  }

  egress {
    cidr_blocks = [
      "0.0.0.0/0",
    ]
    ipv6_cidr_blocks = [
      "::/0",
    ]

    protocol  = "-1"
    from_port = 0
    to_port   = 0

    prefix_list_ids = []
    self            = false
  }
}

resource "aws_rds_cluster" "taeho-io-serverless" {
  cluster_identifier = "taeho-io-serverless"

  availability_zones   = data.terraform_remote_state.vpc.outputs.azs
  db_subnet_group_name = aws_db_subnet_group.taeho-io-database.name

  engine                          = "aurora"
  engine_mode                     = "serverless"
  db_cluster_parameter_group_name = "default.aurora5.6"
  port                            = 3306
  storage_encrypted               = true
  master_username                 = "taeho"

  backup_retention_period      = 1
  copy_tags_to_snapshot        = true
  preferred_backup_window      = "14:43-15:13"
  preferred_maintenance_window = "mon:18:15-mon:18:45"

  vpc_security_group_ids = [
    aws_security_group.mysql.id,
  ]

  scaling_configuration {
    auto_pause               = true
    max_capacity             = 8
    min_capacity             = 1
    seconds_until_auto_pause = 300
    timeout_action           = "RollbackCapacityChange"
  }

  timeouts {}
}
