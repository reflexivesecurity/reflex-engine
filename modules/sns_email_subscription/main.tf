/*
* sns_email_subscription: Module to create an email subscribed SNS topic via cloudformation for reflex alerting.
*/

resource "aws_cloudformation_stack" "sns_topic" {
  name = var.stack_name
  parameters = {
    DisplayName = var.topic_name
    Email       = var.notification_email
  }
  template_body = <<STACK
{
  "AWSTemplateFormatVersion": "2010-09-09",
  "Parameters" : {
    "DisplayName" : {
      "Type" : "String",
      "Description" : "Name of SNS Topic"
    },
    "Email" : {
      "Type" : "String",
      "Description" : "Email for SNS Notifications"
    }
  },
  "Resources" : {
    "EmailSNSTopic": {
      "Type" : "AWS::SNS::Topic",
      "Properties" : {
        "DisplayName" : { "Ref" : "DisplayName" },
        "TopicName" : { "Ref" : "DisplayName" },
        "Subscription": [
          {
           "Endpoint" : { "Ref" : "Email" },
           "Protocol" : "email"
          }
        ]
      }
    }
  },
  "Outputs" : {
    "ARN" : {
      "Description" : "Email SNS Topic ARN",
      "Value" : { "Ref" : "EmailSNSTopic" }
    }
  }
}
STACK

}

resource "aws_sns_topic_policy" "default" {
  arn    = aws_cloudformation_stack.sns_topic.outputs.ARN
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect  = "Allow"
    actions = var.sns_actions
    principals {
      type        = "Service"
      identifiers = var.service_identifiers
    }

    resources = [aws_cloudformation_stack.sns_topic.outputs.ARN]
  }
}
