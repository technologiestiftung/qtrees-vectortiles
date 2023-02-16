provider "aws" {
  profile = var.profile
  region  = var.region
}

locals {
  name = "${var.prefix}-${var.name}-${var.env}"
  tags = {
    name    = local.name
    Project = var.tag_project
  }
}


data "aws_vpc" "default" {
  id = var.vpc_id
}

# Fetch AZs in the current region
data "aws_availability_zones" "available_zones" {
}

data "aws_iam_policy" "ecs_events" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceEventsRole"
}

data "aws_iam_policy_document" "ecs_task_execution_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}




data "aws_iam_policy" "ecs_task_execution" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


data "aws_iam_policy_document" "ecs_events_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}


resource "aws_subnet" "public" {
  count                   = 2
  cidr_block              = cidrsubnet(data.aws_vpc.default.cidr_block, 8, 2 + count.index)
  availability_zone       = data.aws_availability_zones.available_zones.names[count.index]
  vpc_id                  = data.aws_vpc.default.id
  map_public_ip_on_launch = true
}


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
      subnets = aws_subnet.public.*.id
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

resource "aws_cloudwatch_log_group" "vectortiles" {
  name              = local.name
  retention_in_days = 7
  tags              = local.tags
}


# ECS Task Definitions
#
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definitions.html

# https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html
resource "aws_ecs_task_definition" "default" {


  # A unique name for your task definition.
  family = local.name

  # The ARN of the task execution role that the Amazon ECS container agent and the Docker daemon can assume.
  execution_role_arn = aws_iam_role.ecs_task_execution.arn
  # A list of container definitions in JSON format that describe the different containers that make up your task.
  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#container_definitions
  container_definitions = <<JSON
 [
  {
"logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group": "${aws_cloudwatch_log_group.vectortiles.name}",
                    "awslogs-region": "${var.region}",
                    "awslogs-stream-prefix": "${var.prefix}"
                }
            },

    "environment": [
      {
      "name":"ECS_AVAILABLE_LOGGING_DRIVERS",
      "value":"'[\"json-file\",\"awslogs\"]'"
      },
      {
        "name": "TILESET_DIR",
        "value": "${var.TILESET_DIR}"
      },
      {
        "name": "TMP_DIR",
        "value": "${var.TMP_DIR}"
      },
      {
        "name": "TILESET_NAME",
        "value": "${var.TILESET_NAME}"
      },
      {
        "name": "WORKDIR",
        "value": "${var.WORKDIR}"
      },
      {
        "name": "GEOJSON_OUTPUT_FILENAME",
        "value": "${var.GEOJSON_OUTPUT_FILENAME}"
      },
      {
        "name": "POSTGRES_HOST",
        "value": "${var.POSTGRES_HOST}"
      },
      {
        "name": "POSTGRES_PORT",
        "value": "${var.POSTGRES_PORT}"
      },
      {
        "name": "POSTGRES_DB",
        "value": "${var.POSTGRES_DB}"
      },
      {
        "name": "POSTGRES_USER",
        "value": "${var.POSTGRES_USER}"
      },
            {
        "name": "POSTGRES_PASSWORD",
        "value": "${var.POSTGRES_PASSWORD}"
      },
      {
        "name": "POSTGRES_MATERIALIZE_VIEW_NAME",
        "value": "${var.POSTGRES_MATERIALIZE_VIEW_NAME}"
      },
      { "name":"AWS_DEFAULT_REGION",
       "value":"${var.AWS_DEFAULT_REGION}"
      },
      {
        "name":"AWS_ACCESS_KEY_ID",
        "value":"${var.AWS_ACCESS_KEY_ID}"
      },
      {
        "name":"AWS_SECRET_ACCESS_KEY",
        "value":"${var.AWS_SECRET_ACCESS_KEY}"
      },{
        "name": "AWS_BUCKET",
        "value":"${var.AWS_BUCKET}"
      }


    ],
    "name": "${local.name}",
    "image": "${var.image}",
    "cpu": 256,
    "memory": 512,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
JSON

  # The number of CPU units used by the task.
  # It can be expressed as an integer using CPU units, for example 1024, or as a string using vCPUs, for example 1 vCPU or 1 vcpu.
  # String values are converted to an integer indicating the CPU units when the task definition is registered.
  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size
  cpu = 256

  # The amount of memory (in MiB) used by the task.
  # It can be expressed as an integer using MiB, for example 1024, or as a string using GB, for example 1GB or 1 GB.
  # String values are converted to an integer indicating the MiB when the task definition is registered.
  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size
  memory = 512

  # The launch type that the task is using.
  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#requires_compatibilities
  requires_compatibilities = ["FARGATE"]

  # Fargate infrastructure support the awsvpc network mode.
  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#network_mode
  network_mode = "awsvpc"

  # A mapping of tags to assign to the resource.
  tags = local.tags
}


resource "aws_ecs_cluster" "default" {
  name = local.name
  tags = local.tags
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

# ECS Task Execution IAM Role
#
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_execution_IAM_role.html

# https://www.terraform.io/docs/providers/aws/r/iam_role.html
resource "aws_iam_role" "ecs_task_execution" {

  name               = "${local.name}-ecs-task-execution"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_assume_role_policy.json
  description        = var.description
  tags               = local.tags
}



# https://www.terraform.io/docs/providers/aws/r/iam_role_policy_attachment.html
resource "aws_iam_role_policy_attachment" "ecs_events" {

  role       = aws_iam_role.ecs_events.name
  policy_arn = data.aws_iam_policy.ecs_events.arn
}


# https://www.terraform.io/docs/providers/aws/r/iam_policy.html
resource "aws_iam_policy" "ecs_task_execution" {

  name        = local.name
  policy      = data.aws_iam_policy.ecs_task_execution.policy
  description = var.description
}

# https://www.terraform.io/docs/providers/aws/r/iam_role_policy_attachment.html
resource "aws_iam_role_policy_attachment" "ecs_task_execution" {

  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = aws_iam_policy.ecs_task_execution.arn
}


