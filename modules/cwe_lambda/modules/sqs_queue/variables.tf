

variable "delay_seconds" {
  description = "Time in seconds that delivery of messages in a queue is delayed"
  type        = number
  default     = 0
}

variable "visibility_timeout_seconds" {
  description = "Time in seconds that message is hidden from other consumers."
  type        = number
  default     = 60
}

variable "max_receive_count" {
  description = "Maxium number of retries of event before event is considered an error"
  type        = number
  default     = 3
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
