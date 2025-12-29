module "vpc" {
  source = "./modules/vpc"

  name                           = var.name
  vpc_cidr_block                 = var.vpc_cidr_block
  public_subnet_1_cidr_block     = var.public_subnet_1_cidr_block
  public_subnet_2_cidr_block     = var.public_subnet_2_cidr_block
  private_subnet_1_cidr_block    = var.private_subnet_1_cidr_block
  private_subnet_2_cidr_block    = var.private_subnet_2_cidr_block
  enable_dns_support             = var.enable_dns_support
  enable_dns_hostnames           = var.enable_dns_hostnames
  subnet_map_public_ip_on_launch = var.subnet_map_public_ip_on_launch
  availability_zone_1            = var.availability_zone_1
  availability_zone_2            = var.availability_zone_2
  route_cidr_block               = var.route_cidr_block

}

module "ec2" {
  source = "./modules/ec2"

  vpc_id              = module.vpc.vpc_id
  public_subnet_1_id  = module.vpc.public_subnet_1_id
  public_subnet_2_id  = module.vpc.public_subnet_2_id
  private_subnet_1_id = module.vpc.private_subnet_1_id
  private_subnet_2_id = module.vpc.private_subnet_2_id

  ami_id                      = var.ami_id
  bastion_instance_type       = var.bastion_instance_type
  control_plane_instance_type  = var.control_plane_instance_type
  worker_node_instance_type   = var.worker_node_instance_type
}