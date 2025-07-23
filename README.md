# AWS EKS Terraform CI/CD Pipeline Project

## 📖 Overview
This project demonstrates an end-to-end **production-grade AWS EKS deployment** for a containerized full-stack application, fully automated using:
- **Terraform** for infrastructure provisioning
- **GitHub Actions** for CI/CD pipeline
- **AWS ECR** for Docker image registry
- **Helm** for Kubernetes application deployment
- **AWS Load Balancer Controller + Ingress** for external traffic management
- **Route 53 + ACM** for secure HTTPS routing
- **Horizontal Pod Autoscaler (HPA)** for auto-scaling backend and frontend pods
- **Prometheus-compatible metrics** via Kubernetes metrics-server

---

## 🔧 Stack & Tools
- **AWS Services:**
  - EKS (Elastic Kubernetes Service)
  - ECR (Elastic Container Registry)
  - Route 53 (DNS)
  - ACM (Certificate Manager)
  - IAM (RBAC and permissions)
  - VPC + VPC Peering + Private/Public Subnets
  - Load Balancer (ALB)

- **DevOps & Kubernetes:**
  - Terraform (Infrastructure as Code)
  - Helm (Package manager for Kubernetes)
  - Kubernetes HPA (Horizontal Pod Autoscaler)
  - GitHub Actions (CI/CD)

- **Application:**
  - React frontend
  - Backend API (Dockerized service)
  - MSSQL RDS backend (optional, integrated securely via Route 53 Resolver)

---

## 🚀 Architecture

<img width="2481" height="1645" alt="architecture (1)" src="https://github.com/user-attachments/assets/e18d7a64-5518-4a83-915e-c8fe31e4aacc" />


---

## 📦 Features
✅ Full-stack application containerized with Docker  
✅ Infrastructure fully provisioned with Terraform:
  - EKS Cluster
  - VPC, Subnets (Public + Private)
  - Route 53 DNS zones and resolver rules
  - Route 53 Resolver endpoints for private DNS resolution (optional)
  - Security groups and IAM roles
✅ CI/CD Pipeline using GitHub Actions:
  - Automatic Docker image build & push to ECR
  - Helm chart deployment to EKS  
✅ AWS Load Balancer Controller with external ALB ingress:
  - Automatic provisioning of ALB
  - HTTPS using ACM-managed TLS certificate
✅ Route 53 DNS integration (`www.Your_domain.com`)
✅ Horizontal Pod Autoscaler:
  - Auto-scales frontend and backend pods based on CPU utilization
✅ Private backend database connectivity (optional  RDS integration)

---

## 📝 Key Terraform Modules
- `vpc.tf`: Custom VPC, private/public subnets
- `eks-cluster.tf`: EKS cluster and managed node group
- `rds.tf`: (Optional) Oracle RDS deployment
- `route53resolver.tf`: Private DNS resolution for multi-VPC scenario
- `vpcpeering.tf`: VPC peering between EKS and RDS VPCs

---

## ⚙️ CI/CD Pipeline Flow
1️⃣ Code pushed to `main` branch triggers GitHub Actions  
2️⃣ Docker images for backend and frontend built & pushed to AWS ECR  
3️⃣ Helm chart deployed to `prod` namespace on EKS  
4️⃣ Application exposed via ALB and `www.Your_domain.com` using Route 53

---

## 📈 Observability
- Kubernetes metrics-server installed
- HPA active on frontend and backend pods
- Metrics available for monitoring and scaling decisions

---

## 🔒 Security Highlights
- EKS runs in **private subnets**
- IAM Roles for Service Accounts (IRSA) for AWS Load Balancer Controller
- **ALB Ingress Controller** in public subnet with HTTPS
- Minimal RBAC privileges in Kubernetes
- **RDS** in a separate VPC, accessed via **VPC Peering** and **Route 53 resolver**
- **Bastion Host** in public subnet for DB access

---

## 🔄 Auto Scaling

- Configured **Horizontal Pod Autoscalers (HPA)** for backend & frontend
- Metrics server collects CPU usage
- Pods scale between 1 to 3 based on utilization

---

## 🖥️ How to deploy

### ✅ Deployment Prerequisites
- AWS CLI configured
- Terraform installed
- kubectl & Helm installed
- GitHub Secrets for AWS credentials and ECR access

### 📦 1️⃣ Infrastructure:
- Edit the variable values according to your project requirements.
```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```
### 🌍 2️⃣ website:
- Edit the variable values and create a .env file.
- For development:
```bash
git clone https://github.com/priyank1912/aws-eks-terraform-cicd-pipeline
cd ./backend
donet restore
donet watch run
cd ./frontend
npm build
npm run
```
- For deploying website in docker:
```bash
cd ./backend
docker build -t "your desired name" .
docker run <image_id>
cd ./frontend
docker build -t "your desired name" .
docker run <image_id>
```

### ⚙️3️⃣ CI/CD Pipeline:
- In the repository open the workflow folder and use the tf-eks-pipeline.yaml file.
- Add secrets in the github Repository

---

## What can be improved ?
- Instead of using Route 53 DNS resolver just transform the architecture in a single VPC.
- Cost can be optimized by removing the Route 53 DNS resolver.
- Right now only pod autoscaler is present but cluster autoscale can also be implemented to scale the nodes.

