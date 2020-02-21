output "arn" {
  description = "SNS Topic ARN"
  value       = element(concat(aws_cloudformation_stack.sns_topic.*.outputs.ARN, [""]), 0)
}
