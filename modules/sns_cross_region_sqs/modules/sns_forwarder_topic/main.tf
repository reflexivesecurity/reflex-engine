resource "aws_sns_topic" "forwarder_topic" {
  name              = var.topic_name
  kms_master_key_id = var.kms_key_id
}

resource "aws_sns_topic_policy" "events_policy" {
  arn = "${aws_sns_topic.forwarder_topic.arn}"

  policy = "${data.aws_iam_policy_document.sns_topic_policy.json}"
}

data "aws_iam_policy_document" "sns_topic_policy" {
  policy_id = "__default_policy_ID"

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [
      "${aws_sns_topic.forwarder_topic.arn}",
    ]

    sid = "__default_statement_ID"
  }
}

resource "aws_sns_topic_subscription" "cross_region_sqs_subscription" {
  topic_arn            = aws_sns_topic.forwarder_topic.arn
  protocol             = "sqs"
  raw_message_delivery = true
  endpoint             = var.central_queue_arn
}


