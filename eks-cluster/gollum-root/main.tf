module "gollum-cluster" {
  source          = "../kubernetes-cluster"
  project         = var.root_var_project
  environment     = var.root_var_environment
  subnets         = module.gollum-vpc.subnet_ids
  ec2_types       = var.root_var_ec2_types
  workers_desired = var.root_var_workers_desired
  workers_max     = var.root_var_workers_max
  workers_min     = var.root_var_workers_min
  k8s_version     = var.root_var_k8s_version
}

module "gollum-vpc" {
  source             = "../vpc"
  vpc_cidr           = var.root_var_vpc_cidr
  subnet_cidrs       = var.root_var_subnet_cidrs
  availability_zones = var.root_var_availability_zones
  project            = var.root_var_project
  environment        = var.root_var_environment
}

# resource "aws_s3_bucket" "demo" {
#   bucket = "todayisagreatdaytolearndevops"

#   versioning {
#     enabled = true
#   }

#   tags = {
#     project = "gollum"
#   }
# }

# resource "aws_s3_bucket" "demo2" {
#   bucket = "anothergreatbucketfordevops"
# }

# retrieve default VPC
data "aws_vpc" "filtered" {
  default = true
}


# retrieve subnets of Default VPC
data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.filtered.id]
  }
}

# output default VPC id
output "vpc_details" {
  value = data.aws_vpc.filtered.id
}

# output first 3 default subnet IDs
output "subnets_of_default_vpc" {
  value = slice(data.aws_subnets.default_subnets.ids, 0, 3)
}

## For using External module from Terraform Registry
# module "vpc" {
#   source = "terraform-aws-modules/vpc/aws"
#   version = "5.21.0"

#   cidr = var.root_var_vpc_cidr
#   azs             = var.root_var_availability_zones
#   public_subnets  = var.root_var_subnet_cidrs

#   tags = {
#     project = var.root_var_project_tag
#   }
# }

## Output in the root module is only for terminal display purposes
# output "output_from_vpc_module" {
#   value = module.gollum-vpc.subnet_ids
# }