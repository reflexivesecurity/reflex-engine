provider "aws" {
  region = "us-east-1"
}

module "example_cwe" {
  source = "../../modules/event_rule"
  name = "CreateVpcRule"
  description = "Rule to check when VPC is created"
  event_pattern = <<PATTERN
{
  "detail-type": [
    "AWS API Call via CloudTrail"
  ],
  "source": [
    "aws.ec2"
  ],
  "detail": {
    "eventSource": [
      "ec2.amazonaws.com"
    ],
    "eventName": [
      "CreateVpc"
    ]
  }
}
PATTERN
}

module "sns_forwarder" {
  source = "../../modules/sns_topic"
  topic_name = "CreateVpcTopic"
}

module "event_target" {
  source = "../../modules/event_target"
  event_rule_name = module.example_cwe.id
  target_id = "CreateVpcTarget"
  target_arn = module.sns_forwarder.arn
}
