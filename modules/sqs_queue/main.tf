resource "aws_sqs_queue" "sqs_queue" {
  name                      = var.queue_name
  delay_seconds             = var.delay_seconds
}

resource "aws_sqs_queue_policy" "queue_policy" {
  queue_url = "${aws_sqs_queue.sqs_queue.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.sqs_queue.arn}",
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

    resources = ["${aws_sqs_queue.sqs_queue.arn}"]
  }
}

