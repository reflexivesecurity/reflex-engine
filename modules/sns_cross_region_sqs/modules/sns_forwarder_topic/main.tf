resource "aws_sns_topic" "forwarder_topic" {
  name              = var.topic_name
  kms_master_key_id = var.kms_key_id
}

resource "aws_sns_topic_subscription" "cross_region_sqs_subscription" {
  topic_arn            = aws_sns_topic.forwarder_topic.arn
  protocol             = "sqs"
  raw_message_delivery = true
  endpoint             = var.central_queue_arn
}

