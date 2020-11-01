variable "package_location" {
  description = "Path for the Lambda deployment package"
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

variable "sns_topic_arn" {
  description = "Topic arn for deployed notification topic"
  type        = string
}

variable "kms_key_id" {
  description = "KMS Key Id to be used with CloudWatch Logs"
  type        = string
}

variable "lambda_timeout" {
  description = "Lambda timeout as a configuration setting"
  type        = number
  default     = 60
}