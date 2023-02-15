# data.tf

# Fetch AZs in the current region
data "aws_availability_zones" "available" {
}

data "aws_vpc" "main" {
  id = var.vpc_id
}
