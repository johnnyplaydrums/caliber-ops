provider "aws" {
  region  = "${var.region}"
}

resource "aws_iam_policy" "all_access_policy" {
  name = "all-access-policy"
  policy = "${file("${path.module}/policies/all-access-policy.json")}"
}

resource "aws_iam_user" "john_spencer" {
  name = "john.spencer"
  force_destroy = true
}

resource "aws_iam_access_key" "john_spencer" {
    user = "${aws_iam_user.john_spencer.name}"
}

resource "aws_iam_group" "ops" {
  name = "ops"
}

resource "aws_iam_group_policy_attachment" "ops_group_all_access_attachment" {
  group = "${aws_iam_group.ops.id}"
  policy_arn = "${aws_iam_policy.all_access_policy.arn}"
}

resource "aws_iam_group_membership" "ops" {
  name = "ops-group-membership"
  users = [
    "${aws_iam_user.john_spencer.name}"
  ]
  group = "${aws_iam_group.ops.name}"
}
