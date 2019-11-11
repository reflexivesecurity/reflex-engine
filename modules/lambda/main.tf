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

data "aws_caller_identity" "current" {}

data "aws_region" "region" {}

resource "aws_lambda_permission" "allow_events" {
  statement_id  = "AllowExecutionFromEvents"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.cwe_lambda.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "arn:aws:events:${data.aws_region.region.name}:${data.aws_caller_identity.current.account_id}:rule/*"
}


