variable "kms_key_id" {
  description = "Key ID of reflex KMS key"
  type        = string
}

variable "cloudwatch_event_rule_id" {
  description = "Easy name for our CWE rule"
  type        = string
}

variable "central_region" {
  description = "Central region to forward events to"
  type        = string
}

variable "central_queue_name" {
  description = "Camel case name of queue found in central region"
  type        = string
}

variable "parent_account" {
  description = "Account id that we will forward events to"
  type        = string
  default     = null
}
