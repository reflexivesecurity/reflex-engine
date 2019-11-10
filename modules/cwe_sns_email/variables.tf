variable "rule_name" {
  description = "A name for the Cloudwatch Event."
  type = string
}

variable "rule_description" {
  description = "A description for our CWE rule"
  type = string
}

variable "event_pattern" {
  description = "Event pattern that details the events to listen for."
  type = string
}

variable "topic_name" {
  description = "A name for the SNS Topic"
  type = string
}

variable "email" {
  description = "Email endpoint for SNS topic"
  type = string
}


variable "target_id" {
  description = "Target ID"
  type = string
}
