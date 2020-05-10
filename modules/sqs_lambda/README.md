sqs\_lambda: module to generate the targeted sqs queue to lambda ingestion of event payloads

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloudwatch\_event\_rule\_arn | Arn of previously generated event rule | `string` | n/a | yes |
| cloudwatch\_event\_rule\_id | Cloudwatch event rule name | `string` | n/a | yes |
| custom\_lambda\_policy | Lambda policy specific to invoked lambda | `string` | `null` | no |
| delay\_seconds | Seconds to delay processing of message in sqs queue | `number` | `0` | no |
| environment\_variable\_map | Map of environment variables for Lambda | `map(string)` | n/a | yes |
| function\_name | Clean name for Lambda function | `string` | n/a | yes |
| handler | Handler location for lambda function | `string` | n/a | yes |
| lambda\_runtime | Language runtime for lambda function | `string` | n/a | yes |
| queue\_name | Name of sqs queue | `string` | n/a | yes |
| sns\_topic\_arn | SNS Topic arn for lambda access to publish messages. | `string` | n/a | yes |
| source\_code\_dir | Directory holding Lambda source code | `string` | n/a | yes |
| sqs\_kms\_key\_id | KMS Key Id to be used with SQS | `string` | n/a | yes |
| target\_id | Target ID | `string` | n/a | yes |

## Outputs

No output.

