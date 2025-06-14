#########################################
# VPC Outputs
#########################################

output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.this.id
}

#########################################
# Subnets
#########################################

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = aws_subnet.private[*].id
}

#########################################
# Route Tables
#########################################

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "List of private route table IDs (1 per AZ)"
  value       = [for rt in aws_route_table.private : rt.id]
}

output "private_route_table_ids_by_az" {
  description = "Map of AZ to private route table ID"
  value = {
    for i, az in var.availability_zones :
    az => aws_route_table.private[i].id
  }
}

#########################################
# NAT & Internet Gateway
#########################################

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.this.id
}

output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs (1 per AZ)"
  value       = [for nat in aws_nat_gateway.this : nat.id]
}

output "nat_gateway_ids_by_az" {
  description = "Map of AZ to NAT Gateway ID"
  value = {
    for i, az in var.availability_zones :
    az => aws_nat_gateway.this[i].id
  }
}

output "nat_eip_public_ips" {
  description = "List of NAT Gateway EIP public IPs"
  value       = [for eip in aws_eip.nat : eip.public_ip]
}

output "nat_eip_public_ips_by_az" {
  description = "Map of AZ to NAT Gateway EIP public IP"
  value = {
    for i, az in var.availability_zones :
    az => aws_eip.nat[i].public_ip
  }
}
