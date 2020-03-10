

variable "delay_seconds" {
  description = "Time in seconds that delivery of messages in a queue is delayed"
  type        = number
  default     = 0
}

variable "cwe_arn" {
  description = "Arn of cloudwatch event to limit sqs permissions"
  type        = string
}

variable "sqs_kms_key_id" {
  description = "Key id for Reflex generic SQS infrastructure."
  type        = string
}

variable "sqs_dead_letter_queue_arn" {
  description = "Arn of the dead letter queue"
  type        = string
}
