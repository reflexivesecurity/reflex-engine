/*
* Reflex KMS Key: Creates a KMS key that will be used by reflex infrastructure for encryption. 
*
*/
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_kms_key" "reflex_key" {
  description             = "Reflex KMS Key"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  policy                  = <<EOF
{
    "Version": "2012-10-17",
    "Id": "key-consolepolicy-3",
    "Statement": [
        {
            "Sid": "Enable IAM User Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
            },
            "Action": "kms:*",
            "Resource": "*"
        },
        {
            "Sid": "Allow use of the key",
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "events.amazonaws.com",
                    "sns.amazonaws.com",
                    "lambda.amazonaws.com",
                    "logs.${data.aws_region.current.name}.amazonaws.com",
                    "sqs.amazonaws.com"
                ]
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:DescribeKey"
            ],
            "Resource": "*"
        },
        {
            "Sid": "Allow access through Simple Queue Service (SQS) for all principals in the account that are authorized to use SQS",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": [
                "kms:Encrypt",
                "kms:Decrypt",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*",
                "kms:CreateGrant",
                "kms:DescribeKey"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "kms:ViaService": "sqs.${data.aws_region.current.name}.amazonaws.com",
                    "kms:CallerAccount": "${data.aws_caller_identity.current.account_id}"
                }
            }
        }
    ]
}
EOF
}

resource "aws_kms_alias" "reflex_alias" {
  name          = "alias/ReflexKey"
  target_key_id = aws_kms_key.reflex_key.key_id
}
