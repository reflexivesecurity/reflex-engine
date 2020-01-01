provider "aws" {
  region = "us-east-1"
}

data "archive_file" "source" {
  type        = "zip"
  source_dir  = "${path.module}/source"
  output_path = "${path.module}/source.zip"
}

module "enforce_s3_encryption" {
  source           = "../../modules/cwe_lambda"
  rule_name        = "EnforceS3Encryption"
  rule_description = "Rule to check if AMI is modified to be public"

  event_pattern            = <<PATTERN
{
  "detail-type": [
    "AWS API Call via CloudTrail"
  ],
  "source": [
    "aws.s3"
  ],
  "detail": {
    "eventSource": [
      "s3.amazonaws.com"
    ],
    "eventName": [
      "CreateBucket",
      "DeleteBucketEncryption"
    ]
  }
}
PATTERN

  function_name            = "EnforceS3Encryption"
  filename                 = "${path.module}/source.zip"
  handler                  = "s3_encryption.lambda_handler"
  source_code_hash         = "${data.archive_file.source.output_base64sha256}"
  lambda_runtime           = "python3.7"
  environment_variable_map = { SNS_TOPIC = "example_value" }
  custom_lambda_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetEncryptionConfiguration",
        "s3:PutEncryptionConfiguration"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF



  queue_name    = "EnforceS3Encryption"
  delay_seconds = 60

  target_id = "EnforceS3Encryption"

  topic_name = "EnforceS3Encryption"
  email      = var.email
}
