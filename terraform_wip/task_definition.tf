
# ECS Task Definitions
#
# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definitions.html

# https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html
resource "aws_ecs_task_definition" "default" {


  # A unique name for your task definition.
  family = local.name

  # The ARN of the task execution role that the Amazon ECS container agent and the Docker daemon can assume.
  execution_role_arn = aws_iam_role.task_execution_role.arn
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


resource "aws_cloudwatch_log_group" "default" {
  name              = local.name
  retention_in_days = 7
  tags              = local.tags
}

