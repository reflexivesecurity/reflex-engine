variable "lambda_execution_role_arn" {
  description = "Arn for lambda execution role."
  type        = string
}

variable "function_name" {
  description = "Clean name for Lambda function"
  type        = string
}

variable "custom_lambda_policy" {
  description = "Lambda policy specific to invoked lambda"
  type        = string
  default     = null
}
