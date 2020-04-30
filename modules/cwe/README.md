# module

This is a module that creates a Cloudwatch Event Rule with a specific pattern as inputs.


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| name | A name for the Cloudwatch Event  | string |  | yes |
| description | A description for our CWE rule | string |  | yes |
| event_pattern | Event pattern that details the events to listen for | string |  | yes |


## Outputs

| Name | Description |
|------|-------------|
|  this_aws_cloudwatch_event_rule_id| Event Rule ID |
|  this_aws_cloudwatch_event_rule_arn| Event Rule Arn |
