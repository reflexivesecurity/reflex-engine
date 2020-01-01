variable "filename" {
  description = "Filename location of Lambda source zip"
  type = string
}

variable "function_name" {
  description = "Clean name for Lambda function"
  type = string
}

variable "handler" {
  description = "Handler location for lambda function"
  type = string
}

variable "lambda_runtime" {
  description = "Language runtime for lambda function"
  type = string
}

variable "environment_variable_map" {
  description = "Map of environment variables for Lambda"
  type = map(string)
}

variable "source_code_hash" {
  description = "Hash value of Lambda source"
  type = string
}

variable "sqs_queue_arn" {
  description = "Arn of resource for sqs IAM permissions"
  type = string
}

