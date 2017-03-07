provider "aws" {
  region  = "${var.region}"
}

module "asg" {
    source = "../../modules/asg"
    name = "${var.service_name}"
    min_size = "${var.min_size}"
    max_size = "${var.max_size}"
    desired_capacity = "${var.desired_capacity}"
    instance_type = "${var.instance_type}"
    security_groups = ["${aws_security_group.data_ingest.id}"]
}

resource "aws_security_group" "data_ingest" {
    vpc_id = "${var.vpc_id}"

    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags {
        Name = "${var.service_name} Base SG"
    }
}
