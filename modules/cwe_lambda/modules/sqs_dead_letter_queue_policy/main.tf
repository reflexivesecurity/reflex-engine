resource "aws_sqs_queue_policy" "dead_letter_queue_policy" {
  queue_url = "${aws_sqs_queue.sqs_dead_letter_queue.id}"

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
      "Resource": "${aws_sqs_queue.sqs_dead_letter_queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sqs_queue.sqs_queue.arn}",
        }
      }
    }
  ]
}
POLICY
}

