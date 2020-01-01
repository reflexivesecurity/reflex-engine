module "cloudwatch_event_rule" {
  source        = "../event_rule"
  name          = var.rule_name
  description   = var.rule_description
  event_pattern = var.event_pattern
}

module "sns_forwarder" {
  source             = "../sns_email_subscription"
  topic_name         = var.topic_name
  stack_name         = "EmailSNSStack${var.topic_name}"
  notification_email = var.email
}

module "event_target" {
  source          = "../event_target"
  event_rule_name = module.cloudwatch_event_rule.id
  target_id       = var.target_id
  target_arn      = module.sns_forwarder.arn
}
