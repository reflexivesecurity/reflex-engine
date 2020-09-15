/*
* lambda_iam: Reflex module to create AssumeRole for lambdas to use
*/

resource "aws_iam_role" "assume_role" {
  name = "Reflex${var.function_name}LambdaAssume"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "${var.lambda_execution_role_arn}"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "custom_lambda_policy" {
  count = var.custom_lambda_policy != null ? 1 : 0
  name  = "custom_lambda_policy"
  role  = aws_iam_role.assume_role.id

  policy = var.custom_lambda_policy
}
