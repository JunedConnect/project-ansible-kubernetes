variable "vpc_id" {
  description = "VPC ID where resources will be created"
  type        = string
}

variable "public_subnet_1_id" {
  description = "Public subnet 1 ID for bastion host"
  type        = string
}

variable "public_subnet_2_id" {
  description = "Public subnet 2 ID for bastion host"
  type        = string
}

variable "private_subnet_1_id" {
  description = "Private subnet 1 ID for control plane and worker node 1"
  type        = string
}

variable "private_subnet_2_id" {
  description = "Private subnet 2 ID for worker node 2"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "bastion_instance_type" {
  description = "Instance type for bastion host"
  type        = string
}

variable "control_plane_instance_type" {
  description = "Instance type for control plane"
  type        = string
}

variable "worker_node_instance_type" {
  description = "Instance type for worker nodes"
  type        = string
}

