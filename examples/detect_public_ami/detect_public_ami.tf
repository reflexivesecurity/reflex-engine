provider "aws" {
  region = "us-east-1"
}

module "detect_public_ami" {
  source = "../../modules/cwe_lambda"
  rule_name = "DetectPublicAMI"
  rule_description = "Rule to check if AMI is modified to be public"

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
  function_name = "DetectPublicAMI"
  filename = "example_lambda.zip"
  handler = "example_lambda.handler.lambda_handler"
  source_code_hash = "${filebase64sha256("example_lambda.zip")}"
  lambda_runtime = "python3.7"
  environment_variable_map = { example = "example_value" }
  

  queue_name = "DetectPublicAMI"
  delay_seconds = 0

  target_id = "DetectPublicAMI"
  
  topic_name = "DetectPublicAMI"
  email = var.email
}
