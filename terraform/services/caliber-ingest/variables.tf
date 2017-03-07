variable "region" {
    default = "us-east-1"
}

variable "service_name" {
    default = "caliber-ingest"
}

variable "min_size" {
    default = "0"
}

variable "max_size" {
    default = "0"
}

variable "desired_capacity" {
    default = "0"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "vpc_id" {
    default = "vpc-b4c6bdd2"
}
