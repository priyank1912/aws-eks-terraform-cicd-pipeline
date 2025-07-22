# SG for OUTBOUND resolver in eksvpc
resource "aws_security_group" "resolver_sg_eks" {
  name        = "resolver-sg-eks"
  description = "Allow DNS traffic for Resolver endpoints in EKS VPC"
  vpc_id      = module.eksvpc.vpc_id

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["10.0.0.0/16", "11.0.0.0/16"]
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16", "11.0.0.0/16"]
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

# SG for INBOUND resolver in rdsvpc
resource "aws_security_group" "resolver_sg_rds" {
  name        = "resolver-sg-rds"
  description = "Allow DNS traffic for Resolver endpoints in RDS VPC"
  vpc_id      = module.rdsvpc.vpc_id

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["10.0.0.0/16", "11.0.0.0/16"]
  }

  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16", "11.0.0.0/16"]
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

# OUTBOUND resolver endpoint in eksvpc
resource "aws_route53_resolver_endpoint" "outbound_app_vpc" {
  name      = "outbound-app-vpc"
  direction = "OUTBOUND"

  security_group_ids = [aws_security_group.resolver_sg_eks.id]

  ip_address {
    subnet_id = module.eksvpc.private_subnets[0]
  }

  ip_address {
    subnet_id = module.eksvpc.private_subnets[1]
  }

  tags = {
    purpose = "priyank-personal-project"
  }
}

# INBOUND resolver endpoint in rdsvpc (auto IP assignment)
resource "aws_route53_resolver_endpoint" "inbound_db_vpc" {
  name      = "inbound-db-vpc"
  direction = "INBOUND"

  security_group_ids = [aws_security_group.resolver_sg_rds.id]

  ip_address {
    subnet_id = module.rdsvpc.private_subnets[0]
  }

  ip_address {
    subnet_id = module.rdsvpc.private_subnets[1]
  }

  tags = {
    purpose = "priyank-personal-project"
  }
}

# DNS forwarding rule for rds.amazonaws.com  Use this only if you are using Oracle RDS.
# resource "aws_route53_resolver_rule" "forward_rds_dns" {
#   domain_name          = "rds.amazonaws.com"
#   rule_type            = "FORWARD"
#   resolver_endpoint_id = aws_route53_resolver_endpoint.outbound_app_vpc.id
#   name                 = "forward-rds-dns"

#   # You will fill actual IPs after first apply if needed:
#   # Example:
#   target_ip {
#     ip = "11.0.1.233"
#   }
#   target_ip {
#     ip = "11.0.2.253"
#   }

#   tags = {
#     purpose = "priyank-personal-project"
#   }
# }

# # Associate resolver rule to eksvpc
# resource "aws_route53_resolver_rule_association" "app_vpc_association" {
#   resolver_rule_id = aws_route53_resolver_rule.forward_rds_dns.id
#   vpc_id           = module.eksvpc.vpc_id
# }
