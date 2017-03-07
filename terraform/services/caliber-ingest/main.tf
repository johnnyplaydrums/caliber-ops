provider "aws" {
  region  = "${var.region}"
}

module "asg" {
    source = "../../modules/asg"
    name = "${var.service_name}"
    min_size = "${var.min_size}"
    max_size = "${var.max_size}"
    desired_capacity = "${var.desired_capacity}"
}
