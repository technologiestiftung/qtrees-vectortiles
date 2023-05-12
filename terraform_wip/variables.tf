variable "profile" {
  description = "The profile to work with. See your ~/.aws/credentials"
  default     = "default"
}

variable "region" {
  description = "The region to work in."
  default     = "eu-central-1"
}

variable "prefix" {
  description = "A name prefix added to all resources created"
  default     = "tf"
}

variable "name" {
  description = "The name of resources created"
  default     = "vector-tiles-generator"
}

variable "env" {
  description = "Just another suffix so you can have environments"
  default     = "dev"
}

variable "description" {
  description = "The description of resource"
  default     = "running the vector tiles generator"

}
variable "availability_zones" {
  description = "I Think there are only 3 in europe"
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}
variable "az_count" {
  description = "Number of Availability Zones (AZs) to cover in a given region"
  default     = "3"
}
variable "vpc_id" {
  description = "The ID of your existing VPC where all the groups will be created in"
}

variable "security_group_id" {
  description = "The ID of your existing security group where all the groups will be created in"
}

# variable "subnets" {
#   description = "The IDs of your existing subnets where all the groups will be created in"
#   type        = list(string)
# }



variable "image" {
  description = "the image to use for your task"
  default     = "technologiestiftung/qtrees-vectortiles_generator:2.6.2"
}
variable "schedule_expression" {
  description = "The schedule to run in. Could also be cron(*/5 * * * *) see https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html"
  default     = "cron(0/5 * * * ? *)"
  # default     = "cron(0 7 * * ? *)"
}

variable "tag_project" {
  type        = string
  default     = "vector_tiles_generator"
  description = "Default tag for all resouces"
}


# env vars

variable "TILESET_DIR" {
  type        = string
  description = ""
}
variable "TMP_DIR" {
  type        = string
  description = ""
}
variable "TILESET_NAME" {
  type        = string
  description = ""
}
variable "WORKDIR" {
  type        = string
  description = ""
}
variable "GEOJSON_OUTPUT_FILENAME" {
  type        = string
  description = ""
}
variable "POSTGRES_HOST" {
  type        = string
  description = ""
}
variable "POSTGRES_PORT" {
  type        = string
  description = ""
}
variable "POSTGRES_DB" {
  type        = string
  description = ""
}
variable "POSTGRES_USER" {
  type        = string
  description = ""
}
variable "POSTGRES_PASSWORD" {
  type        = string
  description = ""
}
variable "POSTGRES_MATERIALIZE_VIEW_NAME" {
  type        = string
  description = ""
}
variable "AWS_DEFAULT_REGION" {
  type        = string
  description = ""
}
variable "AWS_BUCKET" {
  type        = string
  description = ""
}
variable "AWS_ACCESS_KEY_ID" {
  type        = string
  description = ""
}
variable "AWS_SECRET_ACCESS_KEY" {
  type        = string
  description = ""
}
