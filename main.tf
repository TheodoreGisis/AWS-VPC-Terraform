#############################################
# VPC Networking Module
#############################################

module "vpc" {
  source = "./modules/vpc"

  # VPC settings
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name

  # Subnet configuration
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
}
