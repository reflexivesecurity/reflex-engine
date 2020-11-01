/*
* lambda: Reflex module to create lambda function infrastructure for processing events.
*/

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_iam_role" "iam_for_lambda" {
  name = "Reflex${var.function_name}LambdaExecution"

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
  tags = {
    Reflex = "true"
  }
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_policy"
  role = aws_iam_role.iam_for_lambda.id

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
    },
    {
      "Action": [
        "sns:Publish"
      ],
      "Effect": "Allow",
      "Resource": "${var.sns_topic_arn}"
    },
    {
      "Action": [
        "sts:AssumeRole"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::*:role/Reflex${var.function_name}LambdaAssume"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.iam_for_lambda.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_cloudwatch_log_group" "cloudwatch_logs" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 14
  kms_key_id        = "arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/${var.kms_key_id}"
}

resource "aws_lambda_function" "cwe_lambda" {
  filename         = var.package_location
  function_name    = var.function_name
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = var.handler
  source_code_hash = filebase64sha256(var.package_location)
  timeout          = var.lambda_timeout

  runtime = var.lambda_runtime

  environment {
    variables = merge(var.environment_variable_map,
    { "ASSUME_ROLE_NAME" = "Reflex${var.function_name}LambdaAssume" })
  }

  tags = {
    Reflex = "true"
  }
}
