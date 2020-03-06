output "arn" {
  description = "Lambda Arn"
  value       = element(concat(aws_lambda_function.cwe_lambda.*.arn, [""]), 0)
}

