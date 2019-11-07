output "id" {
  description = "Event Rule ID"
  value       = element(concat(aws_cloudwatch_event_rule.cwe_rule.*.id, [""]), 0)
}

output "cwe_arn" {
  description = "Event Rule Arn"
  value       = element(concat(aws_cloudwatch_event_rule.cwe_rule.*.arn, [""]), 0)
}

