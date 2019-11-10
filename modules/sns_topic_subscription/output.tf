output "id" {
  description = "SNS Topic Subscription ID"
  value       = element(concat(aws_sns_topic_subscription.sns_topic_subscription.*.id, [""]), 0)
}

output "arn" {
  description = "SNS Topic Subscription Arn"
  value       = element(concat(aws_sns_topic_subscription.sns_topic_subscription.*.arn, [""]), 0)
}

