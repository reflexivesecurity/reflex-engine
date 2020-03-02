module "cloudwatch_event_rule" {
  source        = "../event_rule"
  name          = var.rule_name
  description   = var.rule_description
  event_pattern = var.event_pattern
}

module "lambda_endpoint" {
  source                   = "../lambda"
  function_name            = var.function_name
  source_code_dir          = var.source_code_dir
  handler                  = var.handler
  lambda_runtime           = var.lambda_runtime
  environment_variable_map = var.environment_variable_map
  sqs_queue_arn            = module.sqs_queue.arn
  sns_topic_arn            = var.sns_topic_arn
  custom_lambda_policy     = var.custom_lambda_policy
}

module "sqs_queue" {
  source         = "../sqs_queue"
  queue_name     = var.queue_name
  delay_seconds  = var.delay_seconds
  cwe_arn        = module.cloudwatch_event_rule.arn
  sqs_kms_key_id = var.sqs_kms_key_id
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

