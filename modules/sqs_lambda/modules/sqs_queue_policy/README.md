sqs\_queue\_policy: Creates a sane queue policy for reflex sqs queues.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cwe\_id | Arn of cloudwatch event to limit sqs permissions | `string` | n/a | yes |
| sqs\_queue\_arn | Arn of the main SQS queue | `string` | n/a | yes |
| sqs\_queue\_id | Id (url) of the main SQS queue | `string` | n/a | yes |

## Outputs

No output.

