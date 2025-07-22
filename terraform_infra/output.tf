# output the EKS cluster ID
output "cluster_id" {
  description = "EKS cluster ID."
  value       = module.eks.cluster_id
}

# output the EKS control plane endpoint
output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

# Output the security group IDs attached to the EKS control plane
output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane."
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}
output "ecr_repository_frontend_url" {
  description = "ECR repository URL."
  value       = aws_ecr_repository.frontend_repo.repository_url
}
output "ecr_repository_backend_url" {
  description = "ECR repository URL."
  value       = aws_ecr_repository.backend_repo.repository_url
}
output "eks_private_subnets" {
  value = module.eksvpc.private_subnets
}
output "eks_public_subnets" {
  value = module.eksvpc.public_subnets
}
output "rds_private_subnets" {
  value = module.rdsvpc.private_subnets
}
output "rds_public_subnets" {
  value = module.rdsvpc.public_subnets
}
output "inbound_db_ip_list" {
  description = "IP addresses allocated to inbound resolver endpoint"
  value       = [for addr in aws_route53_resolver_endpoint.inbound_db_vpc.ip_address : addr.ip]
}
output "outbound_app_vpc_ip_addresses" {
  description = "IP addresses for the inbound resolver endpoint in the RDS VPC."
  value       = aws_route53_resolver_endpoint.outbound_app_vpc.ip_address
}
output "eks_vpc_id" {
  description = "EKS VPC ID"
  value       = module.eksvpc.vpc_id
}