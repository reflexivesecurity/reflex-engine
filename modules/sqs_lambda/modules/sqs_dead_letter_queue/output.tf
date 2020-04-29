output "id" {
  description = "SQS DLQ ID"
  value       = element(concat(aws_sqs_queue.sqs_dead_letter_queue.*.id, [""]), 0)
}

output "arn" {
  description = "SQS DLQ Arn"
  value       = element(concat(aws_sqs_queue.sqs_dead_letter_queue.*.arn, [""]), 0)
}
