lambda: Reflex module to create lambda function infrastructure for processing events.

## Providers

| Name | Version |
|------|---------|
| archive | n/a |
| aws | n/a |
| null | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| custom\_lambda\_policy | Lambda policy specific to invoked lambda | `string` | `null` | no |
| environment\_variable\_map | Map of environment variables for Lambda | `map(string)` | n/a | yes |
| function\_name | Clean name for Lambda function | `string` | n/a | yes |
| handler | Handler location for lambda function | `string` | n/a | yes |
| kms\_key\_id | KMS Key Id to be used with CloudWatch Logs | `string` | n/a | yes |
| lambda\_runtime | Language runtime for lambda function | `string` | n/a | yes |
| sns\_topic\_arn | Topic arn for deployed notification topic | `string` | n/a | yes |
| source\_code\_dir | Directory holding Lambda source code | `string` | n/a | yes |
| sqs\_queue\_arn | Arn of resource for sqs IAM permissions | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | Lambda Arn |

