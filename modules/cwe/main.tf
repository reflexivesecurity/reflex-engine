module "cloudwatch_event_rule" {
  source        = "./modules/event_rule"
  name          = var.rule_name
  description   = var.rule_description
  event_pattern = var.event_pattern
}

