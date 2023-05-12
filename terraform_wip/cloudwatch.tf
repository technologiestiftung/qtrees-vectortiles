# https://www.terraform.io/docs/providers/aws/r/cloudwatch_event_target.html
resource "aws_cloudwatch_event_target" "default" {
  count = 1

  target_id = local.name
  arn       = aws_ecs_cluster.default.arn
  rule      = aws_cloudwatch_event_rule.default.name
  role_arn  = aws_iam_role.ecs_events.arn

  # Contains the Amazon ECS task definition and task count to be used, if the event target is an Amazon ECS task.
  # https://docs.aws.amazon.com/AmazonCloudWatchEvents/latest/APIReference/API_EcsParameters.html
  ecs_target {
    launch_type         = "FARGATE"
    task_count          = 1
    task_definition_arn = aws_ecs_task_definition.default.arn

    # Specifies the platform version for the task. Specify only the numeric portion of the platform version, such as 1.1.0.
    # This structure is used only if LaunchType is FARGATE.
    # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/platform_versions.html
    platform_version = "1.4.0"

    # This structure specifies the VPC subnets and security groups for the task, and whether a public IP address is to be used.
    # This structure is relevant only for ECS tasks that use the awsvpc network mode.
    # https://docs.aws.amazon.com/AmazonCloudWatchEvents/latest/APIReference/API_AwsVpcConfiguration.html
    network_configuration {
      assign_public_ip = true

      # Specifies the security groups associated with the task. These security groups must all be in the same VPC.
      # You can specify as many as five security groups. If you do not specify a security group,
      # the default security group for the VPC is used.

      # security_groups = var.security_groups

      # Specifies the subnets associated with the task. These subnets must all be in the same VPC.
      # You can specify as many as 16 subnets.
      subnets = aws_subnet.default.*.id
    }
  }
}



resource "aws_cloudwatch_event_rule" "default" {
  # count       = 1
  name        = local.name
  description = var.description
  is_enabled  = true

  # All scheduled events use UTC time zone and the minimum precision for schedules is 1 minute.
  # CloudWatch Events supports Cron Expressions and Rate Expressions
  # For example, "cron(0 20 * * ? *)" or "rate(5 minutes)".
  # https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html
  schedule_expression = var.schedule_expression
}
