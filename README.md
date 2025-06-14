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

.
├── main.tf # Root module - calls the VPC module
├── variables.tf # Input variable definitions
├── terraform.tfvars # Actual input values
├── provider.tf # AWS provider setup
├── modules/
│ └── vpc/
│ ├── main.tf # Resource definitions
│ ├── variables.tf # Module input variables
│ ├── outputs.tf # Module outputs


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
