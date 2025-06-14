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

output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.private.id
}

#########################################
# NAT & Internet Gateway
#########################################

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.this.id
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.this.id
}

output "nat_eip" {
  description = "The Elastic IP of the NAT Gateway"
  value       = aws_eip.nat.public_ip
}
