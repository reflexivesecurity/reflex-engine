variable "queue_name" {
  description = "A name for the main SQS Queue. Name appened with '-DLQ'. "
  type        = string
}

variable "delay_seconds" {
  description = "Time in seconds that delivery of messages in a queue is delayed"
  type        = number
  default     = 0
}

variable "sqs_queue_arn" {
  description = "Arn of sqs queue to limit sqs dead letter queue permissions"
  type        = string
}

variable "sqs_kms_key_id" {
  description = "Key id for Reflex generic SQS infrastructure."
  type        = string
}
