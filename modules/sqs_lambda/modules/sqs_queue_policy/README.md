# module

This is a module that creates the policies for a Cloudwatch Event Rule with a specific pattern as inputs.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| cwe\_arn | Arn of cloudwatch event to limit sqs permissions | `string` | n/a | yes |
| sqs\_queue\_arn | Arn of the main SQS queue | `string` | n/a | yes |
| sqs\_queue\_id | Id (url) of the main SQS queue | `string` | n/a | yes |

## Outputs

No output.
