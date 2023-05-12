# ECS Task Execution IAM Role
#
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_execution_IAM_role.html

# https://www.terraform.io/docs/providers/aws/r/iam_role.html
# Define the IAM role for the task execution
resource "aws_iam_role" "task_execution_role" {
  name = "${local.name}-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
  tags = local.tags
}

# https://www.terraform.io/docs/providers/aws/r/iam_policy.html
# Define the policy for the task execution role
resource "aws_iam_policy" "task_execution_policy" {
  name = "${local.name}-task-execution-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "task_execution_role_policy_attachment" {
  policy_arn = aws_iam_policy.task_execution_policy.arn
  role       = aws_iam_role.task_execution_role.name
}
