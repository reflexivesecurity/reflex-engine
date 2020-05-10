sns\_cross\_region\_sqs: module to create forwarder infrastructure using SNS topic publishing to a central SQS queue.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| central\_queue\_name | Camel case name of queue found in central region | `string` | n/a | yes |
| central\_region | Central region to forward events to | `string` | n/a | yes |
| cloudwatch\_event\_rule\_id | Easy name for our CWE rule | `string` | n/a | yes |
| kms\_key\_id | Key ID of reflex KMS key | `string` | n/a | yes |

## Outputs

No output.

