data "aws_caller_identity" "current" {}

variable "desired_capacity" {
    default = "1"
}

variable "image_id" {
  default =  "ami-df315bc9"
}

variable "instance_type" {
    default = "t2.medium"
}

variable "max_size" {
    default = "1"
}

variable "min_size" {
    default = "1"
}

variable "region" {
    default = "us-east-1"
}

variable "service_name" {
    default = "data-process"
}

variable "vpc_id" {
    default = "vpc-b4c6bdd2"
}
