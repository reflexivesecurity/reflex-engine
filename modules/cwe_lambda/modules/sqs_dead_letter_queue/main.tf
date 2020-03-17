resource "aws_sqs_queue" "sqs_dead_letter_queue" {
  name                       = var.queue_name
  kms_master_key_id          = var.sqs_kms_key_id
}
