variable "rule_name" {
  description = "A name for the Cloudwatch Event."
  type        = string
}

variable "rule_description" {
  description = "A description for our CWE rule"
  type        = string
}

variable "event_pattern" {
  description = "Event pattern that details the events to listen for."
  type        = string
}

variable "target_id" {
  description = "Target ID"
  type        = string
}

variable "source_code_dir" {
  description = "Directory holding Lambda source code"
  type        = string
}

variable "function_name" {
  description = "Clean name for Lambda function"
  type        = string
}

variable "handler" {
  description = "Handler location for lambda function"
  type        = string
}

variable "lambda_runtime" {
  description = "Language runtime for lambda function"
  type        = string
}

variable "environment_variable_map" {
  description = "Map of environment variables for Lambda"
  type        = map(string)
}

variable "email" {
  description = "Email of end user for sns topic"
  type        = string
}

variable "topic_name" {
  description = "Name of sns topic"
  type        = string
}

variable "queue_name" {
  description = "Name of sqs queue"
  type        = string
}

variable "delay_seconds" {
  description = "Seconds to delay processing of message in sqs queue"
  type        = number
  default     = 0
}

variable "custom_lambda_policy" {
  description = "Lambda policy specific to invoked lambda"
  type        = string
}
