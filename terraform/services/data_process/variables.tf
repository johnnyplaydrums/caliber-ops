data "aws_caller_identity" "current" {}

variable "desired_capacity" {
    default = "1"
}

variable "image_id" {
  default =  "ami-33cd5625"
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
    default = "data_process"
}

variable "vpc_id" {
    default = "vpc-b4c6bdd2"
}
