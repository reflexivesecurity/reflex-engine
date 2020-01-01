variable "queue_name" {
  description = "A name for the SQS Queue"
  type = string
}

variable "delay_seconds" {
  description = "Time in seconds that delivery of messages in a queue is delayed"
  type = number
  default = 0
}

variable "cwe_arn" {
  description = "Arn of cloudwatch event to limit sqs permissions"
  type = string
}
