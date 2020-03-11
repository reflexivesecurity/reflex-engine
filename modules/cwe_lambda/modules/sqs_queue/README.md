# module

This is a module that creates an SQS queue of CloudWatch events for lambda to consume.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| cwe\_arn | Arn of cloudwatch event to limit sqs permissions | `string` | n/a | yes |
| delay\_seconds | Time in seconds that delivery of messages in a queue is delayed | `number` | `0` | no |
| max\_receive\_count | Maxium number of retries of event before event is considered an error | `number` | `3` | no |
| queue\_name | A name for the SQS Queue | `string` | n/a | yes |
| sqs\_dead\_letter\_queue\_arn | Maxium number of retries of event before event is considered an error | `string` | n/a | yes |
| sqs\_kms\_key\_id | Key id for Reflex generic SQS infrastructure. | `string` | n/a | yes |
| visibility\_timeout\_seconds | Time in seconds that message is hidden from other consumers. | `number` | `60` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | SQS Arn |
| id | SQS ID |
