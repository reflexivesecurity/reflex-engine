variable "sqs_dead_letter_queue_arn" {
  description = "Arn of the dead letter queue"
  type        = string
}

variable "sqs_dead_letter_queue_id" {
  description = "Id (Url) of the dead letter queue"
  type        = string
}

variable "sqs_queue_arn" {
  description = "Arn of the event queue"
  type        = string
}
