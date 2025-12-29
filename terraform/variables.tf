#General

variable "aws_tags" {
  description = "Tags for Resources"
  type        = map(string)
}


#vpc

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr_block" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr_block" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_1_cidr_block" {
  description = "CIDR block for private subnet 1"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet_2_cidr_block" {
  description = "CIDR block for private subnet 2"
  type        = string
  default     = "10.0.4.0/24"
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "subnet_map_public_ip_on_launch" {
  description = "Whether to map public IP on launch for subnets"
  type        = bool
  default     = true
}

variable "availability_zone_1" {
  description = "Availability zone 1"
  type        = string
  default     = "eu-west-2a"
}

variable "availability_zone_2" {
  description = "Availability zone 2"
  type        = string
  default     = "eu-west-2b"
}

variable "route_cidr_block" {
  description = "CIDR block for the route"
  type        = string
  default     = "0.0.0.0/0"
}


#EC2

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
  default     = "ami-0a0ff88d0f3f85a14" # Ubuntu 22.04 LTS
}

variable "bastion_instance_type" {
  description = "Instance type for bastion host"
  type        = string
  default     = "t3.micro"
}

variable "control_plane_instance_type" {
  description = "Instance type for control plane"
  type        = string
  default     = "t3.medium"
}

variable "worker_node_instance_type" {
  description = "Instance type for worker nodes"
  type        = string
  default     = "t3.micro"
}
