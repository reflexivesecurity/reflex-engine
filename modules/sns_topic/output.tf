output "id" {
  description = "SNS Topic ID"
  value       = element(concat(aws_sns_topic.sns_topic.*.id, [""]), 0)
}

output "arn" {
  description = "SNS Topic Arn"
  value       = element(concat(aws_sns_topic.sns_topic.*.arn, [""]), 0)
}

