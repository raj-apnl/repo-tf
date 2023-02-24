module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = "cpuc-terraform_vpc"
  cidr = "10.99.0.0/18"

  azs                      = ["${data.aws_region.current.name}b", "${data.aws_region.current.name}c"]  # removed "${data.aws_region.current.name}a", for us-west-1
  public_subnets           = ["10.99.0.0/24", "10.99.1.0/24", "10.99.2.0/24"]
  private_subnets          = ["10.99.3.0/24", "10.99.4.0/24", "10.99.5.0/24"]
  database_subnets         = ["10.99.7.0/24", "10.99.8.0/24", "10.99.9.0/24"]
  default_route_table_tags = { DefaultRouteTable = true }

  enable_dns_hostnames   = true
  enable_dns_support     = true
  enable_nat_gateway     = false # Disabled NAT to be able to run this example quicker
  enable_vpn_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false


  tags = {
    Name        = "Cpuc-Terraform-UAT-VPC"
    Terraform   = "true"
    Environment = "dev"
  }
}