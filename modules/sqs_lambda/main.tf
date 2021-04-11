data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

/*
 * SQS Queue
 */
resource "aws_sqs_queue" "sqs_queue" {
  name                       = var.queue_name
  delay_seconds              = var.delay_seconds
  kms_master_key_id          = var.sqs_kms_key_id
  visibility_timeout_seconds = var.visibility_timeout_seconds
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.sqs_dead_letter_queue.arn
    maxReceiveCount     = var.max_receive_count
  })
  tags = {
    Reflex = "true"
  }
}

resource "aws_sqs_queue_policy" "queue_policy" {
  queue_url = aws_sqs_queue.sqs_queue.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "AllowCWE",
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.sqs_queue.arn}",
      "Condition": {
        "ArnLike": {
          "aws:SourceArn": "arn:aws:events:*:${data.aws_caller_identity.current.account_id}:rule/${var.cloudwatch_event_rule_id}"
        }
      }
    },
    {
      "Sid": "AllowSNSTopic",
      "Effect": "Allow",
      "Principal": {
        "Service": "sns.amazonaws.com"
      },
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.sqs_queue.arn}"
    }
  ]
}
POLICY
}

/*
 * SQS Dead Letter Queue
 */
resource "aws_sqs_queue" "sqs_dead_letter_queue" {
  name              = "${var.queue_name}-DLQ"
  kms_master_key_id = var.sqs_kms_key_id
}

resource "aws_sqs_queue_policy" "dead_letter_queue_policy" {
  queue_url = aws_sqs_queue.sqs_dead_letter_queue.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqsDlqPolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": {
        "Service": "sqs.amazonaws.com"
      },
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.sqs_dead_letter_queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sqs_queue.sqs_queue.arn}"
        }
      }
    }
  ]
}
POLICY
}

/*
 * Event Routing
 */
resource "aws_cloudwatch_event_target" "cwe_rule_target" {
  rule      = var.cloudwatch_event_rule_id
  target_id = var.target_id
  arn       = aws_sqs_queue.sqs_queue.arn
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  event_source_arn = aws_sqs_queue.sqs_queue.arn
  enabled          = true
  function_name    = aws_lambda_function.cwe_lambda.arn
  batch_size       = 1
}

/*
 * Lambda Function
 */
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

/*
 * Lambda IAM
 */
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
      "Resource": "${aws_sqs_queue.sqs_queue.arn}"
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

/*
 * CloudWatch Logging
 */
resource "aws_cloudwatch_log_group" "cloudwatch_logs" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 14
  kms_key_id        = "arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/${var.sqs_kms_key_id}"
}
