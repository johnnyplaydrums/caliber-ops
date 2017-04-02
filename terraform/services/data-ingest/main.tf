provider "aws" {
  region  = "${var.region}"
}

resource "aws_iam_role" "data_ingest_role" {
  name = "data_ingest_role"
  assume_role_policy = "${file("${path.module}/policies/service-instance-role.json")}"
}

resource "aws_iam_policy" "associate_ip" {
  name = "associate_ip"
  policy = "${file("${path.module}/policies/associate-address.json")}"
}

resource "aws_iam_role_policy_attachment" "associate_ip_attachment" {
  role = "${aws_iam_role.data_ingest_role.name}"
  policy_arn = "${aws_iam_policy.associate_ip.arn}"
}

resource "aws_iam_instance_profile" "data_ingest" {
  name = "${var.service_name}-instance-profile-role"
  roles = ["${aws_iam_role.data_ingest_role.name}"]
}

resource "aws_eip" "data_ingest" {
  vpc = true
}

module "asg" {
  source = "../../modules/asg"
  name = "${var.service_name}"
  min_size = "${var.min_size}"
  max_size = "${var.max_size}"
  desired_capacity = "${var.desired_capacity}"
  instance_type = "${var.instance_type}"
  image_id = "${var.image_id}"
  iam_instance_profile = "${aws_iam_instance_profile.data_ingest.name}"
  security_groups = ["${aws_security_group.data_ingest.id}"]
  eip_id = "${aws_eip.data_ingest.id}"
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
