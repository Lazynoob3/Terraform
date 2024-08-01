# environments/dev/main.tf
module "vpc" {
  source     = "../../modules/vpc"
  cidr_block = "10.0.0.0/16"
  name       = "dev-vpc"
}

module "internet_gateway" {
  source = "../../modules/internet_gateway"
  vpc_id = dev-vpc
  name   = "igw-dev-vpc"
}

module "subnets" {
  source = "../../modules/subnets"
  vpc_id = dev-vpc
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "route_tables" {
  source = "../../modules/route_tables"
  vpc_id = dev-vpc
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  public_subnet_ids   = module.subnets.public_subnets
  private_subnet_ids  = module.subnets.private_subnets
}