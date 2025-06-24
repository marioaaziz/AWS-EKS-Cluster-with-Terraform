
# 🚀 AWS EKS Cluster with Terraform

This project provisions a fully functional **EKS (Elastic Kubernetes Service)** cluster using Terraform.

---

##  What's Included

- ✅ Custom VPC with 3 subnets across `us-east-2a`, `2b`, `2c`
- ✅ Internet Gateway and routing for public access
- ✅ EKS Control Plane (Kubernetes v1.27)
- ✅ One managed node group (1x t3.medium EC2 instance)
- ✅ All built using the `terraform-aws-modules/eks/aws` module v20.31

---

##  Project Structure

| File         | Description |
|--------------|-------------|
| `main.tf`    | Core infrastructure (VPC, subnets, route table, EKS) |
| `provider.tf`| AWS provider config |
| `variables.tf` | Input variables |
| `outputs.tf`   | Useful cluster output after deploy |
| `.gitignore` | Prevents committing sensitive files |
| `README.md`  | Project documentation |

---

##  Prerequisites

- Terraform v1.5+
- AWS CLI configured (`aws configure`)
- Access to `us-east-2` region

---

##  How to Deploy

```bash
terraform init
terraform plan
terraform apply
