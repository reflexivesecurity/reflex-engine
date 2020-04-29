variable "topic_name" {
  description = "Name for the SNS Topic."
  type        = string
}

variable "kms_key_id" {
  description = "KMS Key ID to use for SSE"
  type        = string
}

variable "central_queue_arn" {
  description = "SQS queue arn that is ultimate target for events"
  type        = string
}
