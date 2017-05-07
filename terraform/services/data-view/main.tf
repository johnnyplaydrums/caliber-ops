provider "aws" {
  region  = "${var.region}"
}

data "terraform_remote_state" "data_ingest" {
  backend = "s3"
  config {
    bucket = "caliber-ops-${data.aws_caller_identity.current.account_id}-${var.region}"
    key = "terraform/services/data-ingest/terraform-${data.aws_caller_identity.current.account_id}-${var.region}.tfstate"
    region = "${var.region}"
  }
}

resource "aws_iam_role" "data_view_role" {
  name = "data_view_role"
  assume_role_policy = "${file("${path.module}/policies/service-instance-role.json")}"
}

resource "aws_iam_role_policy_attachment" "associate_ip_attachment" {
  role = "${aws_iam_role.data_view_role.name}"
  policy_arn = "${data.terraform_remote_state.data_ingest.associate_ip_role}"
}

resource "aws_iam_role_policy_attachment" "dynamodb_attachment" {
  role = "${aws_iam_role.data_view_role.name}"
  policy_arn = "${data.terraform_remote_state.data_ingest.dynamodb_role}"
}

resource "aws_iam_instance_profile" "data_view" {
  name = "${var.service_name}-instance-profile-role"
  roles = ["${aws_iam_role.data_view_role.name}"]
}

resource "aws_eip" "data_view" {
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
  iam_instance_profile = "${aws_iam_instance_profile.data_view.name}"
  security_groups = ["${aws_security_group.data_view.id}"]
  eip_id = "${aws_eip.data_view.id}"
}

resource "aws_security_group" "data_view" {
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
    Name = "${var.service_name} SG"
  }
}
