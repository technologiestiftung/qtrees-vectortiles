

locals {
  name = "${var.prefix}-${var.name}-${var.env}"
  tags = {
    name    = local.name
    Project = var.tag_project
  }
}




# data "aws_iam_policy" "ecs_events" {
#   arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceEventsRole"
# }

# data "aws_iam_policy_document" "ecs_task_execution_assume_role_policy" {
#   statement {
#     actions = ["sts:AssumeRole"]

#     principals {
#       type        = "Service"
#       identifiers = ["ecs-tasks.amazonaws.com"]
#     }
#   }
# }




# data "aws_iam_policy" "ecs_task_execution" {
#   arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
# }


data "aws_iam_policy_document" "ecs_events_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}









# CloudWatch Events IAM Role
#
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/CWE_IAM_role.html

# https://www.terraform.io/docs/providers/aws/r/iam_role.html
resource "aws_iam_role" "ecs_events" {


  name               = "${local.name}-cloudwatch"
  assume_role_policy = data.aws_iam_policy_document.ecs_events_assume_role_policy.json
  # path               = var.iam_path
  description = var.description
  tags        = local.tags
}





# https://www.terraform.io/docs/providers/aws/r/iam_role_policy_attachment.html
resource "aws_iam_role_policy_attachment" "ecs_events" {

  role       = aws_iam_role.ecs_events.name
  policy_arn = data.aws_iam_policy.ecs_events.arn
}



# https://www.terraform.io/docs/providers/aws/r/iam_role_policy_attachment.html
resource "aws_iam_role_policy_attachment" "ecs_task_execution" {

  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = aws_iam_policy.ecs_task_execution.arn
}


