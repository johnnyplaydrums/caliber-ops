variable "desired_capacity" {
    default = "1"
}

variable "image_id" {
  default =  "ami-f4c7a8e2"
}

variable "instance_type" {
    default = "t2.micro"
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
    default = "data_ingest"
}

variable "vpc_id" {
    default = "vpc-b4c6bdd2"
}
