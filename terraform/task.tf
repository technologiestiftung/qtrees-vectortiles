resource "aws_cloudwatch_log_group" "vectortiles" {
  name              = "${var.prefix}-${var.name}-${var.env}"
  retention_in_days = 7
  tags = {
    name    = "${var.prefix}-${var.name}-${var.env}"
    project = "${var.tag_project}"
  }
}


resource "aws_ecs_task_definition" "task" {

  family                   = "${var.prefix}-${var.name}-${var.env}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.task_execution_role.arn
  # the difinition could also be located in a file
  # container_definitions = "${file("task-definitions/service.json")}"
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
      {"name":"ECS_AVAILABLE_LOGGING_DRIVERS",
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
      { "name":"AWS_DEFAULT_REGION"
      , "value":"${var.AWS_DEFAULT_REGION}"
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
    "name": "${var.prefix}-${var.name}-${var.env}",
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
  tags = {
    name    = "${var.prefix}-${var.name}-${var.env}"
    project = "${var.tag_project}"
  }
}
