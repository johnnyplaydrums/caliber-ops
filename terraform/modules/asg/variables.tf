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
  default = "ami-6c64e37a"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "iam_instance_profile" {
  default = ""
}

variable "eip_id" {
default = ""
}

variable "public_ssh_key" {
  default = "ops"
}

variable "security_groups" {
  type = "list"
  default = ["sg-1fa8b763"]
}
