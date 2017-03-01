provider "aws" {
  region  = "${var.region}"
}

resource "aws_iam_policy" "all_access_policy" {
  name = "all-access-policy"
  policy = "${file("${path.module}/policies/all-access-policy.json")}"
}

#########
# USERS #
#########

resource "aws_iam_user" "john_spencer" {
  name = "john.spencer"
  force_destroy = true
}

resource "aws_iam_access_key" "john_spencer" {
    user = "${aws_iam_user.john_spencer.name}"
}

resource "aws_iam_user" "damien_hobday" {
  name = "damien.hobday"
  force_destroy = true
}

resource "aws_iam_access_key" "damien_hobday" {
    user = "${aws_iam_user.damien_hobday.name}"
}

resource "aws_iam_user" "james_uttaro" {
  name = "james.uttaro"
  force_destroy = true
}

resource "aws_iam_access_key" "james_uttaro" {
    user = "${aws_iam_user.james_uttaro.name}"
}

resource "aws_iam_user" "samuel_quintana" {
  name = "samuel.quintana"
  force_destroy = true
}

resource "aws_iam_access_key" "samuel_quintana" {
    user = "${aws_iam_user.samuel_quintana.name}"
}

##########
# GROUPS #
##########

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
    "${aws_iam_user.john_spencer.name}",
    "${aws_iam_user.damien_hobday.name}",
    "${aws_iam_user.james_uttaro.name}",
    "${aws_iam_user.samuel_quintana.name}"
  ]
  group = "${aws_iam_group.ops.name}"
}
