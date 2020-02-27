variable "rule_name" {
  description = "A name for the Cloudwatch Event."
  type        = string
}

variable "rule_description" {
  description = "A description for our CWE rule"
  type        = string
}

variable "event_pattern" {
  description = "Event pattern that details the events to listen for."
  type        = string
}

variable "sns_topic_arn" {
  description = "Topic ARN for event target"
  type        = string
}

variable "target_id" {
  description = "Target ID"
  type        = string
}
