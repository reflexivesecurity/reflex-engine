/*
* sqs_queue_policy: Creates a sane queue policy for reflex sqs queues.
*/
data "aws_caller_identity" "current" {}

resource "aws_sqs_queue_policy" "cwe_queue_policy" {
  count     = var.cwe_id != null ? 1 : 0
  queue_url = var.sqs_queue_id

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
      "Resource": "${var.sqs_queue_arn}",
      "Condition": {
        "ArnLike": {
          "aws:SourceArn": "arn:aws:events:*:${data.aws_caller_identity.current.account_id}:rule/${var.cwe_id}"
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
      "Resource": "${var.sqs_queue_arn}"
    }
  ]
}
POLICY
}

resource "aws_sqs_queue_policy" "no_cwe_queue_policy" {
  count     = var.cwe_id == null ? 1 : 0
  queue_url = var.sqs_queue_id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "AllowSNSTopic",
      "Effect": "Allow",
      "Principal": {
        "Service": "sns.amazonaws.com"
      },
      "Action": "sqs:SendMessage",
      "Resource": "${var.sqs_queue_arn}"
    }
  ]
}
POLICY
}

data "aws_iam_policy_document" "sqs_queue_policy" {
  statement {
    effect  = "Allow"
    actions = ["sqs:SendMessage"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [var.sqs_queue_arn]
  }
}
