/*
* sns_cross_region_sqs: module to create forwarder infrastructure using SNS topic publishing to a central SQS queue.
*/
data "aws_caller_identity" "current" {}

resource "aws_sns_topic" "forwarder_topic" {
  name              = "Forwarder-${var.cloudwatch_event_rule_id}"
  kms_master_key_id = var.kms_key_id
}

resource "aws_sns_topic_policy" "events_policy" {
  arn = aws_sns_topic.forwarder_topic.arn

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
resource "null_resource" "sqs_account_subscribe" {
  provisioner "local-exec" {
    command = "aws sns subscribe --topic-arn $SNS_TOPIC_ARN --protocol sqs --notification-endpoint $SQS_QUEUE"

    environment = {
      SNS_TOPIC_ARN = aws_sns_topic.forwarder_topic.arn
      SQS_QUEUE     = "arn:aws:sqs:${var.central_region}:${var.parent_account}:${var.central_queue_name}"
    }
  }
}

resource "aws_cloudwatch_event_target" "cwe_rule_target" {
  rule      = var.cloudwatch_event_rule_id
  target_id = "ForwarderTarget${var.cloudwatch_event_rule_id}"
  arn       = aws_sns_topic.forwarder_topic.arn
}

