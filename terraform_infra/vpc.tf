terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "eksvpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.21.0"

  name = "ENTER YOUR EKS VPC NAME HERE"
  cidr = var.eks_vpc_cidr

  azs                  = var.availability-zones
  private_subnets      = var.eks_private_subnets
  private_subnet_names = ["eks-private-subnet-1", "eks-private-subnet-2", "eks-private-subnet-3"]
  public_subnets       = var.eks_public_subnets
  public_subnet_names  = ["eks-public-subnet-1", "eks-public-subnet-2", "eks-public-subnet-3"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    purpose = "priyank-personal-project"
  }
}

resource "aws_route" "eks_to_rds" {
  count                     = length(module.eksvpc.private_route_table_ids)
  route_table_id            = module.eksvpc.private_route_table_ids[count.index]
  destination_cidr_block    = var.rds_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.eks_rds.id

}


