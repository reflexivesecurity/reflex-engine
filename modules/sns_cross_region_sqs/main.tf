module "event_target" {
  source          = "./modules/event_target"
  event_rule_name = var.cloudwatch_event_rule_id
  target_id       = var.target_id
  target_arn      = module.sns_forarder_topic.arn
}

module "sns_forwarder_topic" {
  source            = "./modules/sns_forwarder_topic"
  topic_name        = var.topic_name
  kms_key_id        = var.kms_key_id
  central_queue_arn = var.central_queue_arn
}

