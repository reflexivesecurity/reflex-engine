output "arn" {
  description = "Lambda Arn"
  value       = element(concat(aws_lambda_function.cwe_lambda.*.arn, [""]), 0)
}

output "execution_role_arn" {
  description = "IAM Execution Arn"
  value       = element(concat(aws_iam_role.iam_for_lambda.*.arn, [""]), 0)
}

