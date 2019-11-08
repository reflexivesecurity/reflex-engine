variable "event_rule_name" {
  description = "Name for the Cloudwatch Event."
  type = string
}

variable "target_id" {
  description = "Target ID"
  type = string
}

variable "target_arn" {
  description = "Arn to be used as target for CWE"
  type = string
}
