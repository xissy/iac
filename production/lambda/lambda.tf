
resource "aws_iam_role" "lambda-function-role" {
  name = "lambda-function-role"
  assume_role_policy = jsonencode(
    {
      Statement = [
        {
          Effect = "Allow"
          Action = "sts:AssumeRole"
          Principal = {
            Service = "lambda.amazonaws.com"
          }
        },
      ]
      Version = "2012-10-17"
    }
  )

  path                 = "/"
  max_session_duration = 3600
  tags                 = {}
}

resource "aws_iam_role_policy" "ec2-network-interface" {
  name = "ec2-network-interface"
  role = aws_iam_role.lambda-function-role.id
  policy = jsonencode(
    {
      "Statement" : [
        {
          Effect : "Allow",
          Resource : "*",
          Action : [
            "ec2:CreateNetworkInterface",
            "ec2:DeleteNetworkInterface",
            "ec2:DescribeNetworkInterfaces",
          ]
        }
      ]
      "Version" : "2012-10-17",
    }
  )
}

resource "aws_security_group" "lambda-function-public-api" {
  name        = "lambda-function-public-api"
  description = "lambda function public api"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    cidr_blocks = [
      "0.0.0.0/0",
    ]
    from_port        = 443
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    self             = false
    to_port          = 443
  }

  egress {
    cidr_blocks = [
      "0.0.0.0/0",
    ]
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    self             = false
    to_port          = 0
  }
}

resource "aws_lambda_function" "myip" {
  function_name = "myip"
  handler       = "index.handler"
  role          = aws_iam_role.lambda-function-role.arn
  runtime       = "nodejs12.x"
  timeout       = 5
  memory_size   = 128

  vpc_config {
    subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets
    security_group_ids = [
      aws_security_group.lambda-function-public-api.id
    ]
  }
}

resource "aws_lambda_function" "taeho" {
  function_name = "taeho"
  handler       = "taeho"
  role          = aws_iam_role.lambda-function-role.arn
  runtime       = "go1.x"
  timeout       = 5
  memory_size   = 128
  filename      = "taeho.zip"

  vpc_config {
    subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets
    security_group_ids = [
      aws_security_group.lambda-function-public-api.id
    ]
  }
}
