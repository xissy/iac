
resource "aws_eip" "bastion" {
  instance = aws_instance.bastion.id
  vpc      = true
}

resource "aws_eip_association" "bastion" {
  instance_id   = aws_instance.bastion.id
  allocation_id = aws_eip.bastion.id
}

resource "aws_security_group" "bastion" {
  name        = "taeho-io-production-bastion"
  description = "taeho.io production bastion host"
  vpc_id      = local.bastion_host.vpc_id

  ingress {
    cidr_blocks = [
      "211.177.118.6/32",
    ]
    from_port        = 22
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    self             = false
    to_port          = 22
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

resource "aws_instance" "bastion" {
  ami               = data.aws_ami.ubuntu.id
  instance_type     = "t2.micro"
  availability_zone = local.bastion_host.az
  subnet_id         = local.bastion_host.subnet
  key_name          = var.keypair
  security_groups = [
    aws_security_group.bastion.id,
  ]

  associate_public_ip_address = true
  source_dest_check           = false
}
