sqs\_dead\_letter\_queue\_policy: Creates a sqs queue policy for use as a DLQ

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| sqs\_dead\_letter\_queue\_arn | Arn of the dead letter queue | `string` | n/a | yes |
| sqs\_dead\_letter\_queue\_id | ID of the DLQ SQS queue | `string` | n/a | yes |
| sqs\_queue\_arn | Arn of the main SQS queue | `string` | n/a | yes |

## Outputs

No output.

