variable "queue_name" {
  description = "A name for the main SQS Queue. Name appened with '-DLQ'. "
  type        = string
}

variable "sqs_kms_key_id" {
  description = "Key id for Reflex generic SQS infrastructure."
  type        = string
}
