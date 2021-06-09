data "aws_availability_zones" "zones" {
  filter {
    name   = "region-name"
    values = [var.aws_region]
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.1.0"

  name = "circleci-pipeline-poc"
  cidr = "10.0.0.0/16"

  azs = [
    data.aws_availability_zones.zones.names[0],
    data.aws_availability_zones.zones.names[1],
    data.aws_availability_zones.zones.names[2],
    data.aws_availability_zones.zones.names[0],
    data.aws_availability_zones.zones.names[1],
    data.aws_availability_zones.zones.names[2],
  ]

  private_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
  ]

  public_subnets = [
    "10.0.10.0/24",
    "10.0.11.0/24",
    "10.0.12.0/24",
  ]
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_version = "1.17"
  cluster_name    = "circleci-pipeline-poc"
  tags = {
    Name      = "CircleCI Pipeline POC"
    ManagedBy = "Terraform"
    Source    = "https://github.com/liatrio/circleci-pipeline-poc"
  }
  vpc_id  = module.vpc.vpc_id
  subnets = concat(module.vpc.private_subnets, module.vpc.public_subnets)

  worker_groups = [
    {
      instance_type = "m4.large"
      asg_max_size  = 2
    }
  ]

}
