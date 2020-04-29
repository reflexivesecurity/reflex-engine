resource "aws_sqs_queue" "sqs_queue" {
  name                       = var.queue_name
  delay_seconds              = var.delay_seconds
  kms_master_key_id          = var.sqs_kms_key_id
  visibility_timeout_seconds = var.visibility_timeout_seconds
  redrive_policy = jsonencode({
    deadLetterTargetArn = var.sqs_dead_letter_queue_arn
    maxReceiveCount     = var.max_receive_count
  })
}
