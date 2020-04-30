module "sns_forwarder_topic" {
  source            = "./modules/sns_forwarder_topic"
  topic_name        = "Forwarder-${var.cloudwatch_event_rule_id}"
  kms_key_id        = var.kms_key_id
  central_queue_arn = var.central_queue_arn
}

module "event_target" {
  source          = "./modules/event_target"
  event_rule_name = var.cloudwatch_event_rule_id
  target_id       = "ForwarderTarget${var.cloudwatch_event_rule_id}"
  target_arn      = module.sns_forwarder_topic.arn
}
