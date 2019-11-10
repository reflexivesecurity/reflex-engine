resource "aws_sns_topic_subscription" "sns_topic_subscription" {
  topic_arn = var.topic_arn
  protocol = var.protocol
  endpoint = var.endpoint
}

