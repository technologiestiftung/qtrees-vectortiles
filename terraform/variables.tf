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

variable "image" {
  description = "the image to use for your task"
  default     = "technologiestiftung/qtrees-vector-tiles_generator:v2.13.0-dev"
}
variable "schedule_expression" {
  description = "The schedule to run in. Could also be cron(*/5 * * * *) see https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html"
  default     = "cron(0 7 * * ? *)"
}

variable "tag_project" {
  type        = string
  default     = "vector_tiles_generator"
  description = "Default tag for all resouces"
}


# env vars

variable "aws_access_key_id" {
  description = "The aws access key for your profile. Todo? Make the task use task_role_arn instead of passing the keys in env"
}

variable "aws_secret_access_key" {
  description = "The aws access key for your profile. Todo? Make the task use task_role_arn instead of passing the keys in env"

}


