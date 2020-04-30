data "aws_caller_identity" "current" {}

resource "aws_sqs_queue_policy" "queue_policy" {
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
      "Resource": "${var.sqs_queue_arn}",
      "Condition": {
        "ArnLike": {
          "aws:SourceArn": "arn:aws:sns:*:${data.aws_caller_identity.current.account_id}:Forwarder-${var.cwe_id}"
        }
      }
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
