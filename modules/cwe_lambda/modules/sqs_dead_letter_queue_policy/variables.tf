variable "sqs_dead_letter_queue_arn" {
  description = "Arn of the dead letter queue"
  type        = string
}

variable "sqs_queue_arn" {
  description = "Arn of the main SQS queue"
  type        = string
}

variable "sqs_dead_letter_queue_id" {
  description = "ID of the DLQ SQS queue"
  type        = string
}
