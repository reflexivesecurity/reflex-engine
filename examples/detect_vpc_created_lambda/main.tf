provider "aws" {
  region = "us-east-1"
}

module "example_cwe_lambda" {
  source = "../../modules/cwe_lambda"
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

  function_name = "CreateVpcLambda"
  filename = "create_vpc_lambda.zip"
  handler = "index.lambda_handler"
  source_code_hash = "${filebase64sha256("create_vpc_lambda.zip")}"
  lambda_runtime = "python3.7"
  environment_variable_map = {
    "EXAMPLE" = "maybe_a_secret"
  }
  target_id = "CreateVpcLmbda"
}
