
variable "cwe_id" {
  description = "Arn of cloudwatch event to limit sqs permissions"
  type        = string
}

variable "sqs_queue_id" {
  description = "Id (url) of the main SQS queue"
  type        = string
}

variable "sqs_queue_arn" {
  description = "Arn of the main SQS queue"
  type        = string
}
