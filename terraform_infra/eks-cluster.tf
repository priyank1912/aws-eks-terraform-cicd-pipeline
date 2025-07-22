module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.14.0"

  cluster_name                   = var.eks_cluster_name
  cluster_version                = "1.33"
  subnet_ids                     = module.eksvpc.private_subnets
  vpc_id                         = module.eksvpc.vpc_id
  enable_irsa                    = true
  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    dev-nodes = {
      desired_size   = 2
      min_size       = 1
      max_size       = 3
      instance_types = var.eks_instance_type
      capacity_type  = "ON_DEMAND"
      iam_role_additional_policies = {
        AmazonEKSWorkerNodePolicy          = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
        AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
        AmazonEKS_CNI_Policy               = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
      }
    }
  }

  enable_cluster_creator_admin_permissions = true

  tags = {
    purpose = "priyank-personal-project"
  }
}
