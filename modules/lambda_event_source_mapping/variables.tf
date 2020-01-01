variable "event_source_arn" {
  description = "ARN of SQS Queue as Event Source"
  type        = string
}

variable "function_name" {
  description = "Function that will take in the event from the sqs queue"
  type        = string
}
