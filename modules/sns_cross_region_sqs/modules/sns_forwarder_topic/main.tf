resource "aws_sns_topic" "forwarder_topic" {
  name              = var.topic_name
  kms_master_key_id = var.kms_key_id
  policy            = <<EOF
{
  "Version": "2008-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "events_service",
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": [
        "SNS:GetTopicAttributes",
        "SNS:SetTopicAttributes",
        "SNS:AddPermission",
        "SNS:RemovePermission",
        "SNS:DeleteTopic",
        "SNS:Subscribe",
        "SNS:ListSubscriptionsByTopic",
        "SNS:Publish",
        "SNS:Receive"
      ],
      "Resource": "${aws_sns_topic.forwarder_topic.arn}"
    }
  ]
}
EOF

}

resource "aws_sns_topic_subscription" "cross_region_sqs_subscription" {
  topic_arn            = aws_sns_topic.forwarder_topic.arn
  protocol             = "sqs"
  raw_message_delivery = true
  endpoint             = var.central_queue_arn
}


