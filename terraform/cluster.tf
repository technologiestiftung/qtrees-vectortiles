resource "aws_ecs_cluster" "vector_tiles_generator_cluster" {
  name = "${var.prefix}-${var.name}-${var.env}"
  tags = {
    name    = "${var.prefix}-${var.name}-${var.env}"
    project = "${var.tag_project}"
  }
}