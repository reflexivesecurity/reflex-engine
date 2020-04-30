output "arn" {
  description = "Event Rule Arn"
  value       = element(concat(aws_sns_topic.forwarder_topic.*.arn, [""]), 0)
}

