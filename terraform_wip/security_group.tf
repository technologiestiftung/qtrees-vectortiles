# Define the security group for the ECS cluster
resource "aws_security_group" "default" {
  name_prefix = local.name
  vpc_id      = data.aws_vpc.default.id

  # Inbound traffic from the same security group
  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    self      = true
  }

  # Inbound traffic from the internet on port 80
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound traffic to the internet on all ports
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
