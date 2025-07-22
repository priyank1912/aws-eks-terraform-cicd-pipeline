module "rdsvpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name = "rdsvpc"
  cidr = var.rds_cidr

  azs                  = var.availability-zones
  private_subnets      = var.rds_private_subnets
  private_subnet_names = ["rds-private-subnet-1", "rds-private-subnet-2", "rds-private-subnet-3"]
  public_subnets       = var.rds_public_subnets
  public_subnet_names  = ["bastion-public-subnet"]

  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_nat_gateway   = false


  tags = {
    purpose = "priyank-personal-project"
  }
}

resource "aws_route" "rds_to_eks" {
  count                     = length(module.rdsvpc.private_route_table_ids)
  route_table_id            = module.rdsvpc.private_route_table_ids[count.index]
  destination_cidr_block    = var.eks_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.eks_rds.id
}


