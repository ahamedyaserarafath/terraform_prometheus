resource "aws_iam_user" "prometheus_iam" {
  name = "${var.prometheus_access_name}"
  path = "/"
  tags = {
    Environment = "${var.env}"
  }

}

resource "aws_iam_access_key" "prometheus_access_key" {
  user = "${aws_iam_user.prometheus_iam.name}"
}

resource "aws_iam_user_policy" "prometheus_role" {
  name = "${var.prometheus_access_name}_role"
  user = "${aws_iam_user.prometheus_iam.name}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ec2:Describe*",
            "Resource": "*"
        }
    ]
}
EOF
}

