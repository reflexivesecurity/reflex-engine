# module

This is a module that creates an SQS DLQ (Dead Letter Queue) to support the redrive policy of the main queue.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| queue\_name | A name for the main SQS Queue. Name appened with '-DLQ'. | `string` | n/a | yes |
| sqs\_kms\_key\_id | Key id for Reflex generic SQS infrastructure. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | SQS DLQ Arn |
| id | SQS DLQ ID |
