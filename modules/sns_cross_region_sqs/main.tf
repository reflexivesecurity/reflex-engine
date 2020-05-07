data "aws_caller_identity" "current" {}

module "sns_forwarder_topic" {
  source            = "./modules/sns_forwarder_topic"
  topic_name        = "Forwarder-${var.cloudwatch_event_rule_id}"
  kms_key_id        = var.kms_key_id
  central_queue_arn = "arn:aws:sqs:${var.central_region}:${data.aws_caller_identity.current.account_id}:${var.central_queue_name}"
}

module "event_target" {
  source          = "./modules/event_target"
  event_rule_name = var.cloudwatch_event_rule_id
  target_id       = "ForwarderTarget${var.cloudwatch_event_rule_id}"
  target_arn      = module.sns_forwarder_topic.arn
}
