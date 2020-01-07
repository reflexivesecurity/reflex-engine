module "cloudwatch_event_rule" {
  source        = "../event_rule"
  name          = var.rule_name
  description   = var.rule_description
  event_pattern = var.event_pattern
}

module "lambda_endpoint" {
  source                   = "../lambda"
  function_name            = var.function_name
  filename                 = var.filename
  handler                  = var.handler
  source_code_hash         = var.source_code_hash
  lambda_runtime           = var.lambda_runtime
  environment_variable_map = var.environment_variable_map
  sqs_queue_arn            = module.sqs_queue.arn
  custom_lambda_policy  = var.custom_lambda_policy
}

module "sqs_queue" {
  source        = "../sqs_queue"
  queue_name    = var.queue_name
  delay_seconds = var.delay_seconds
  cwe_arn       = module.cloudwatch_event_rule.arn
}

module "lambda_event_source_mapping" {
  source           = "../lambda_event_source_mapping"
  event_source_arn = module.sqs_queue.arn
  function_name    = module.lambda_endpoint.arn
}

module "event_target" {
  source          = "../event_target"
  event_rule_name = module.cloudwatch_event_rule.id
  target_id       = var.target_id
  target_arn      = module.sqs_queue.arn
}

module "sns_forwarder" {
  source             = "../sns_email_subscription"
  topic_name         = var.topic_name
  stack_name         = "EmailSNSStack${var.topic_name}"
  notification_email = var.email
}


