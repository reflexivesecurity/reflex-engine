sns\_email\_subscription: Module to create an email subscribed SNS topic via cloudformation for reflex alerting.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| notification\_email | An email address to be notified by the topic | `string` | n/a | yes |
| service\_identifiers | A list of identifiers for the services accessing sns. | `list(string)` | <pre>[<br>  "events.amazonaws.com"<br>]</pre> | no |
| sns\_actions | A list of actions allowed | `list(string)` | <pre>[<br>  "SNS:Publish"<br>]</pre> | no |
| stack\_name | A name for the SNS Topic Stack | `string` | n/a | yes |
| topic\_name | A name for the SNS Topic | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | SNS Topic ARN |

