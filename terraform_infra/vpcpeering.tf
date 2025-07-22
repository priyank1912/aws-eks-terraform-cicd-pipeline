resource "aws_vpc_peering_connection" "eks_rds" {
  vpc_id      = module.eksvpc.vpc_id
  peer_vpc_id = module.rdsvpc.vpc_id
  auto_accept = true

  tags = {
    Name    = "eks_rds_peering",
    purpose = "priyank-personal-project"
  }
}

resource "aws_vpc_peering_connection_options" "eks_rds_requester" {
  vpc_peering_connection_id = aws_vpc_peering_connection.eks_rds.id

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_vpc_peering_connection_options" "eks_rds_accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection.eks_rds.id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }
}