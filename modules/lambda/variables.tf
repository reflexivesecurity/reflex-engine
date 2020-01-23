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

variable "sqs_queue_arn" {
  description = "Arn of resource for sqs IAM permissions"
  type        = string
}

variable "custom_lambda_policy" {
  description = "Lambda policy specific to invoked lambda"
  type        = string
}

