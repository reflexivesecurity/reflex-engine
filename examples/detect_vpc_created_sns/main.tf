provider "aws" {
  region = "us-east-1"
}

module "example_cwe" {
  source = "../../modules/cwe_sns"
  rule_name = "CreateVpcRule"
  rule_description = "Rule to check when VPC is created"

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

  topic_name = "CreateVpcTopic"
  target_id = "CreateVpcTarget"
}
