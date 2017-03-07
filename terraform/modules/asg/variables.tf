variable "name" {}

variable "max_size" {
    default = "1"
}

variable "min_size" {
    default = "1"
}

variable "desired_capacity" {
    default = "1"
}

variable "health_check_type" {
    default = "EC2"
}

variable "vpc_subnets" {
    type = "list"
    default = ["subnet-67ffd64a", "subnet-107a6359"]
}

variable "image_id" {
    default = "ami-0b33d91d"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "public_ssh_key" {
    default = "ops"
}
