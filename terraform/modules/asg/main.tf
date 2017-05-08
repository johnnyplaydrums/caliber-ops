resource "aws_autoscaling_group" "base" {
  name = "${var.name}-asg"
  max_size = "${var.max_size}"
  min_size = "${var.min_size}"
  desired_capacity = "${var.desired_capacity}"
  launch_configuration = "${aws_launch_configuration.base.name}"
  health_check_type = "${var.health_check_type}"
  vpc_zone_identifier = ["${var.vpc_subnets}"]

  lifecycle {
    create_before_destroy = "true"
  }

  tag {
    key = "Name"
    value = "${var.name}"
    propagate_at_launch = true
  }
}

resource "aws_launch_configuration" "base" {
  name_prefix = "${var.name}-"
  image_id = "${var.image_id}"
  instance_type = "${var.instance_type}"
  iam_instance_profile = "${var.iam_instance_profile}"
  key_name = "${var.public_ssh_key}"
  security_groups = ["${var.security_groups}"]

  lifecycle {
    create_before_destroy = "true"
  }

  user_data = <<EOF
    #cloud-config
    runcmd:
      - aws ec2 associate-address --region us-east-1 --instance-id $(curl http://169.254.169.254/latest/meta-data/instance-id) --allocation-id ${var.eip_id} --allow-reassociation
    EOF
}
