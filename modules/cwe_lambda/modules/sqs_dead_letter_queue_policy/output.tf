output "id" {
  description = "SQS ID"
  value       = element(concat(aws_sqs_queue.sqs_queue.*.id, [""]), 0)
}

output "arn" {
  description = "SQS Arn"
  value       = element(concat(aws_sqs_queue.sqs_queue.*.arn, [""]), 0)
}

