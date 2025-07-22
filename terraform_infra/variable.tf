variable "region" {
  description = "AWS region to deploy the resources"
  type        = string
  default     = "ap-south-1"
}
variable "availability-zones" {
  description = "List of availability zones to use for the resources"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}
variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0a1235697f4afa8a4" #for bastian host
}
variable "user" {
  default = "priyank"
}
variable "db_username" {
  description = "Database master username"
  type        = string
  default     = "admin"
  sensitive   = true
}
variable "db_password" {
  description = "Database master password"
  type        = string
  sensitive   = true
}
variable "db_engine" {
  type    = string
  default = "sqlserver-ex"
}
variable "db_engine_version" {
  default = "15.00.4430.1.v1"
}
variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}
variable "rds_cidr" {
  description = "CIDR block for the RDS VPC"
  type        = string
  default     = "11.0.0.0/16"
}
variable "rds_private_subnets" {
  description = "List of private subnets for the RDS VPC"
  type        = list(string)
  default     = ["11.0.1.0/24", "11.0.2.0/24", "11.0.3.0/24"]
}
variable "rds_public_subnets" {
  description = "List of public subnets for the RDS VPC"
  type        = list(string)
  default     = ["11.0.101.0/24"]
}
variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "my-cluster"
}
variable "eks_instance_type" {
  description = "Instance type for EKS nodes"
  type        = tuple([string])
  default     = ["c7i-flex.large"]
}
variable "eks_vpc_cidr" {
  description = "CIDR block for the EKS VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "eks_private_subnets" {
  description = "List of private subnets for the EKS VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
variable "eks_public_subnets" {
  description = "List of public subnets for the EKS VPC"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}