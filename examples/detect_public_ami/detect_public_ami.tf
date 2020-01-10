provider "aws" {
  region = "us-east-1"
}

data "archive_file" "source" {
  type        = "zip"
  source_dir  = "${path.module}/source"
  output_path = "${path.module}/source.zip"
}

module "detect_public_ami" {
  source           = "../../modules/cwe_lambda"
  rule_name        = "DetectPublicAMI"
  rule_description = "Rule to check if AMI is modified to be public"

  event_pattern            = <<PATTERN
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

  function_name            = "DetectPublicAMI"
  filename                 = "${path.module}/source.zip"
  handler                  = "detect_public_ami.lambda_handler"
  source_code_hash         = "${data.archive_file.source.output_base64sha256}"
  lambda_runtime           = "python3.7"
  environment_variable_map = { example = "example_value" }
  custom_lambda_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:DescribeImageAttribute",
        "ec2:ModifyImageAttribute"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF


  queue_name    = "DetectPublicAMI"
  delay_seconds = 0

  target_id = "DetectPublicAMI"

  topic_name = "DetectPublicAMI"
  email      = var.email
}
