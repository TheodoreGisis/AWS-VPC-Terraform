# 🌐 AWS VPC Networking with Terraform

This project provisions a complete and production-ready VPC networking architecture on AWS using Terraform. It's designed for modularity, reusability, and scalability — the foundational layer for any cloud-native infrastructure.

---

## ✅ Features

- 🏗️ Custom VPC with configurable CIDR block
- 🌍 3 Public Subnets (one per Availability Zone)
- 🔒 6 Private Subnets (two per Availability Zone)
- 🌐 Internet Gateway for public access
- 🔁 NAT Gateway for private subnets' outbound internet
- 🛣️ Separate route tables for public and private traffic
- 🏷️ Centralized tagging using Terraform `locals`
- ⚙️ Modular design for easy reuse and customization

---

## 📁 Project Structure

```
.
├── main.tf                # Root module - calls the VPC module
├── variables.tf           # Input variable definitions
├── terraform.tfvars       # Actual input values
├── provider.tf            # AWS provider setup
├── modules/
│   └── vpc/
│       ├── main.tf        # Resource definitions
│       ├── variables.tf   # Module input variables
│       ├── outputs.tf     # Module outputs
```

---

## 🚀 Getting Started

### Prerequisites

- Terraform v1.3+
- AWS CLI configured (`aws configure`)
- Valid IAM permissions to create networking resources

---

### Step-by-step

```bash
# Initialize Terraform
terraform init

# Preview what will be created
terraform plan

# Deploy infrastructure
terraform apply
```

---

## 🧱 Architecture Overview

- **Region**: `eu-central-1`
- **Availability Zones**: `eu-central-1a`, `1b`, `1c`
- **Subnet Distribution**:
  - `Public`: 1 per AZ
  - `Private`: 2 per AZ
- **Routing**:
  - Public subnets → Internet Gateway
  - Private subnets → NAT Gateway

---

## 📤 Outputs

After deployment, Terraform will output:

- VPC ID
- Public & Private Subnet IDs
- Route Table IDs
- NAT Gateway and Elastic IP

---

## 🏷️ Tagging Strategy

All AWS resources are tagged with:

```hcl
{
  Project     = var.vpc_name
  Environment = "dev"
  Owner       = "theodoros"
  ManagedBy   = "Terraform"
}
```

These tags are centrally defined using `locals` for consistency.

---

## 🧠 Why This Matters

> Every resilient cloud architecture starts with a solid networking layer.  
> This project demonstrates how to build that layer using infrastructure-as-code best practices, ensuring repeatability, scalability, and collaboration-readiness.

---


## 🏁 Next Steps (ideas to expand)

- Add EC2 / ALB modules using these subnets
- Setup S3 backend for remote state

---

