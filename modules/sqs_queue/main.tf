resource "aws_sqs_queue" "sqs_queue" {
  name                      = var.queue_name
  delay_seconds             = var.delay_seconds
}
