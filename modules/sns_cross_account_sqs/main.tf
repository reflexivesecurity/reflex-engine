module "cross_account_event_forwarding" {
  source                   = "../sns_cross_region_sqs"
  kms_key_id               = var.kms_key_id
  cloudwatch_event_rule_id = var.cloudwatch_event_rule_id
  central_region           = var.central_region
  central_queue_name       = var.central_queue_name
  parent_account           = var.parent_account
}
