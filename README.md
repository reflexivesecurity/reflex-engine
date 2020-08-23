# reflex
These are the engine terraform modules that drive the reflex event driven detective and remediative infrastructure for your cloud environment. 

## Overview
reflex provides an infrastructure-as-code first approach to creating detective controls in your AWS environment. 

The modules in this repository are meant to be consumed by other detective rules that are specified as part of the reflex system and by custom rules made by end users. For example, the cwe_sns_email module can be used to very simply forward a specified CloudWatch Event to an SNS Topic that has an email subscription.

## More Information

- https://reflexivesecurity.com/
- https://docs.reflexivesecurity.com/
