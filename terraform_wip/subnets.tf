# Fetch AZs in the current region
data "aws_availability_zones" "available_zones" {
}

# Define the subnet for the ECS cluster
resource "aws_subnet" "default" {
  count                   = 2
  cidr_block              = cidrsubnet(data.aws_vpc.default.cidr_block, 8, 2 + count.index)
  vpc_id                  = data.aws_vpc.default.id
  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  map_public_ip_on_launch = true
  tags                    = local.tags
}

# Associate the security group with the subnet
resource "aws_security_group_rule" "default_subnet_association" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.default.id
  source_security_group_id = aws_security_group.default.id
}
