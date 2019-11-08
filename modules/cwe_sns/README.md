# module

This is a module that creates a Cloudwatch Event Rule with an SNS topic as its target.


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| rule_name | A name for the Cloudwatch Event  | string |  | yes |
| rule_description | A description for our CWE rule | string |  | yes |
| event_pattern | Event pattern that details the events to listen for | string |  | yes |
| topic_name | Useful name for SNS Topic | string |  | yes |
| target_id | Logical id for topic target | string |  | yes |
