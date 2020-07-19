/*
* sns_email_subscription: Module to create an email subscribed SNS topic via cloudformation for reflex alerting.
*/

resource "aws_cloudformation_stack" "sns_topic" {
  name = var.stack_name
  parameters = {
    DisplayName     = var.topic_name
    Email           = var.notification_email
    SlackWebhookUrl = var.slack_webhook
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
    },
    "SlackWebhookUrl": {
      "Type" : "String",
      "Default": "none",
      "Description" : "Slack webhook URL for notification."
    }
  },
  "Conditions" : {
    "SlackIntegration" : { "Fn::Not" : [{
      "Fn::Equals" : [
        {"Ref" : "SlackWebhookUrl"}, "none"
        ]
      }]
    }
  },
  "Resources" : {
    "EmailSNSTopic": {
      "Type" : "AWS::SNS::Topic",
      "Properties" : {
        "DisplayName" : { "Ref" : "DisplayName" },
        "TopicName" : { "Ref" : "DisplayName" },
        "Subscription": {
          "Fn::If": [
            "SlackIntegration",
            
            [
              {
               "Endpoint" : { "Ref" : "Email" },
               "Protocol" : "email"
              },
             {
               "Endpoint" : { "Ref" : "SlackNotificationFunction" },
               "Protocol" : "lambda"
              }
            ]
            ,
            
            [
              {
               "Endpoint" : { "Ref" : "Email" },
               "Protocol" : "email"
              }
            ]
          
          ]
        }

    },
  
    "LambdaExecutionRole": {
      "Condition": "SlackIntegration",
      "Type": "AWS::IAM::Role",
      "Properties": {
        "AssumeRolePolicyDocument": {
          "Version": "2012-10-17",
          "Statement": [{ "Effect": "Allow", "Principal": {"Service": ["lambda.amazonaws.com"]}, "Action": ["sts:AssumeRole"] }]
        },
        "ManagedPolicyArns": ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
           }
    },

  "SlackNotificationFunction": {
      "Condition": "SlackIntegration",
      "Type": "AWS::Lambda::Function",
      "Properties": {
          "Handler": "index.handler",
          "Role": {
              "Fn::GetAtt": [
                  "LambdaExecutionRole",
                  "Arn"
              ]
          },
          "Code": {
                  "ZipFile": {
                      "Fn::Join": [
                          "\n",
                          [
                            "import urllib3",
                            "import json",
                            "import os",
                            "http = urllib3.PoolManager()",
                            "def lambda_handler(event, context):",
                            "    url = os.environ['SLACK_WEBHOOK_URL']",
                            "    msg = {",
                            "        'text': event['Records'][0]['Sns']['Message'],",
                            "    }",
                            "    encoded_msg = json.dumps(msg).encode('utf-8')",
                            "    resp = http.request('POST',url, body=encoded_msg)",
                            "    print({",
                            "        'message': event['Records'][0]['Sns']['Message'],",
                            "        'status_code': resp.status,",
                            "        'response': resp.data",
                            "    })"
                          ]
                      ]
                  }
              },
          "Runtime": "python3.7",
          "Timeout": 25,
          "TracingConfig": {
              "Mode": "Active"
          }
      }
  },
  "SnsPermission": {
      "Condition": "SlackIntegration",
      "Type": "AWS::Lambda::Permission",
      "Properties": {
          "FunctionName": {
              "Fn::GetAtt": [
                  "SlackNotificationFunction",
                  "Arn"
              ]
          },
          "Action": "lambda:InvokeFunction",
          "Principal": "sns.amazonaws.com",
          "SourceAccount": {
              "Ref": "AWS::AccountId"
          },
          "SourceArn": {
              "Fn::GetAtt": [
                  "EmailSNSTopic",
                  "Arn"
              ]
          }
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
