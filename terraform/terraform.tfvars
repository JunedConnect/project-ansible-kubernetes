# General
aws_tags = {
  Environment = "dev"
  Project     = "ansible-kubernetes"
  Owner       = "juned"
  Terraform   = "true"
}

# VPC
vpc_cidr_block                 = "10.0.0.0/16"
public_subnet_1_cidr_block     = "10.0.1.0/24"
public_subnet_2_cidr_block     = "10.0.2.0/24"
private_subnet_1_cidr_block    = "10.0.3.0/24"
private_subnet_2_cidr_block    = "10.0.4.0/24"
enable_dns_support             = true
enable_dns_hostnames           = true
subnet_map_public_ip_on_launch = true
availability_zone_1            = "eu-west-2a"
availability_zone_2            = "eu-west-2b"
route_cidr_block               = "0.0.0.0/0"

#EC2
ami_id = "ami-0a0ff88d0f3f85a14" # Ubuntu 22.04 LTS
bastion_instance_type = "t3.micro"
control_plane_instance_type = "t3.medium"
worker_node_instance_type = "t3.micro"