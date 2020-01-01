resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = "${aws_iam_role.iam_for_lambda.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "sqs:ReceiveMessage",
        "sqs:DeleteMessage",
        "sqs:GetQueueAttributes"
      ],
      "Effect": "Allow",
      "Resource": "${var.sqs_queue_arn}"
    }
  ]
}
EOF
}


resource "aws_lambda_function" "cwe_lambda" {
  filename      = var.filename
  function_name = var.function_name
  role          = "${aws_iam_role.iam_for_lambda.arn}"
  handler       = var.handler
  source_code_hash = var.source_code_hash

  runtime = var.lambda_runtime

  environment {
    variables = var.environment_variable_map
}
}

