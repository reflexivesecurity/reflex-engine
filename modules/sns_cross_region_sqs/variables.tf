variable "kms_key_id" {
  description = "Key ID of reflex KMS key"
  type        = string
}

variable "cloudwatch_event_rule_id" {
  description = "Easy name for our CWE rule"
  type        = string
}

variable "central_queue_arn" {
  description = "Central region SQS Queue arn"
  type        = string
}


