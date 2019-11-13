provider "aws" {
  region = "us-east-1"
}

module "detect_public_ami" {
  source = "../modules/cwe_sns_email"
  rule_name = "DetectPublicAmi"
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
      "ModifyImageAttribute"
    ]
  }
}
PATTERN

  topic_name = "DetectPublicAmi"
  target_id = "DetectPublicAmiTarget"
  email = var.email
}
