/*
* sqs_queue_policy: Creates a sane queue policy for reflex sqs queues.
*/
data "aws_organizations_organization" "current" {}

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
          "aws:SourceArn": "arn:aws:events:*:*:rule/${var.cwe_id}"
        },
        "StringEquals": {
           "aws:PrincipalOrgID": "${data.aws_organizations_organization.current.id}"
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
