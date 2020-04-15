data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_iam_role" "iam_for_lambda" {
  name = "Reflex${var.function_name}Lambda"

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
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "custom_lambda_policy" {
  count = var.custom_lambda_policy != null ? 1 : 0
  name  = "custom_lambda_policy"
  role  = aws_iam_role.iam_for_lambda.id

  policy = var.custom_lambda_policy
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
  filename         = data.archive_file.source.output_path
  function_name    = var.function_name
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = var.handler
  source_code_hash = data.archive_file.source.output_base64sha256
  timeout          = 60

  runtime = var.lambda_runtime

  environment {
    variables = var.environment_variable_map
  }
}

data "archive_file" "source" {
  type        = "zip"
  source_dir  = var.source_code_dir
  output_path = "${path.cwd}/${var.function_name}-source.zip"

  depends_on = [
    null_resource.pip_install,
  ]
}

resource "null_resource" "pip_install" {
  triggers = {
    requirements = "${filesha1("${var.source_code_dir}/requirements.txt")}"
    python       = "${filesha1(element(fileset("${var.source_code_dir}/", "*.py"), 0))}"
  }

  provisioner "local-exec" {
    command = "pip install -r ${var.source_code_dir}/requirements.txt -t ${var.source_code_dir}"
  }
}
