# module

This is a module that creates a Cloudwatch Event Rule with a specific pattern as inputs.


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| topic_name | A name for the SNS Topic  | string |  | yes |
| sns_actions | A list of actions to for topic policy | list(string) |  ["SNS:Publish"] | yes |
| service_identifiers | Endpoints for services that will communicate with SNS | list(string) | ["events.amazonaws.com"] | yes |


## Outputs

| Name | Description |
|------|-------------|
|  this_aws_sns_topic_id | SNS Topic ID |
|  this_aws_sns_topic_arn| SNS Topic Arn |
