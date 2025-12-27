output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "public_subnet_1_id" {
  description = "Public subnet 1 ID"
  value       = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  description = "Public subnet 2 ID"
  value       = aws_subnet.public_subnet_2.id
}

output "private_subnet_1_id" {
  description = "Private subnet 1 ID"
  value       = aws_subnet.private_subnet_1.id
}

output "private_subnet_2_id" {
  description = "Private subnet 2 ID"
  value       = aws_subnet.private_subnet_2.id
}
