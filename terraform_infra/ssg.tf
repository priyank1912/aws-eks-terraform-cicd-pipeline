resource "aws_security_group" "Workers_rules" {
  name        = "eks_nodes_sg"
  description = "This security group is for personal project"
  vpc_id      = module.eksvpc.vpc_id
  ingress {
    description = "Allow all traffic from within the VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
  }
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name    = "tf-eks-cicd-pipeline",
    purpose = "priyank-personal-project"
  }
}

resource "aws_security_group" "bastianhost_sg" {
  name   = "bastianhost-sg"
  vpc_id = module.rdsvpc.vpc_id

  ingress {
    description = "SSH from your IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["49.36.65.110/32", "139.55.20.161/32"] # my ip address and purav ip address
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    purpose = "priyank-personal-project"
  }
}


 