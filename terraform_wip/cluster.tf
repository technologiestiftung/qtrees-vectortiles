
resource "aws_ecs_cluster" "default" {
  name = local.name
  tags = local.tags
  settings {
    name  = "containerInsights"
    value = "enabled"
  }
  depends_on = [
    aws_subnet.default,
    aws_security_group.default
  ]
}
