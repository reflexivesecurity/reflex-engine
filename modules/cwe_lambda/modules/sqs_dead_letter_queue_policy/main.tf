resource "aws_sqs_queue_policy" "dead_letter_queue_policy" {
  queue_url = "${var.sqs_dead_letter_queue_id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqsDlqPolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${var.sqs_dead_letter_queue_arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${var.sqs_queue_arn}",
        }
      }
    }
  ]
}
POLICY
}
