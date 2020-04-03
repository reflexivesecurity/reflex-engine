
resource "aws_sqs_queue_policy" "queue_policy" {
  queue_url = var.sqs_queue_id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sqs:SendMessage",
      "Resource": "${var.sqs_queue_arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${var.cwe_arn}"
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
