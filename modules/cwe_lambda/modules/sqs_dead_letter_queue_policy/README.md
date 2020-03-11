# module

This is a module that creates the policies for an SQS DLQ (Dead Letter Queue) to support the redrive policy of the main queue

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| sqs\_dead\_letter\_queue\_arn | Arn of the dead letter queue | `string` | n/a | yes |
| sqs\_dead\_letter\_queue\_id | ID of the DLQ SQS queue | `string` | n/a | yes |
| sqs\_queue\_arn | Arn of the main SQS queue | `string` | n/a | yes |

## Outputs

No output.
