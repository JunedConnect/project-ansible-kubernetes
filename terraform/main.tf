module "vpc" {
  source = "./modules/vpc"

  name                           = var.name
  vpc_cidr_block                 = var.vpc_cidr_block
  public_subnet_1_cidr_block       = var.public_subnet_1_cidr_block
  public_subnet_2_cidr_block       = var.public_subnet_2_cidr_block
  private_subnet_1_cidr_block      = var.private_subnet_1_cidr_block
  private_subnet_2_cidr_block      = var.private_subnet_2_cidr_block
  enable_dns_support             = var.enable_dns_support
  enable_dns_hostnames           = var.enable_dns_hostnames
  subnet_map_public_ip_on_launch = var.subnet_map_public_ip_on_launch
  availability_zone_1            = var.availability_zone_1
  availability_zone_2            = var.availability_zone_2
  route_cidr_block               = var.route_cidr_block

}