## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| description | A description for our CWE rule | `string` | n/a | yes |
| event\_pattern | Event pattern that details the events to listen for. | `string` | n/a | yes |
| name | A name for the Cloudwatch Event. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | Event Rule Arn |
| id | Event Rule ID |

