output "associate_ip_role" {
    value = "${aws_iam_policy.associate_ip.arn}"
}

output "dynamodb_role" {
    value = "${aws_iam_policy.dyanmodb.arn}"
}
