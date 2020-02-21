output "sns_topic_arn" {
  description = "SNS Topic ARN"
  value       = module.sns_forwarder.arn
}
