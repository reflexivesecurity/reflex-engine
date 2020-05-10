/*
* sqs_lambda: module to generate the targeted sqs queue to lambda ingestion of event payloads
*/
module "event_target" {
  source          = "./modules/event_target"
  event_rule_name = var.cloudwatch_event_rule_id
  target_id       = var.target_id
  target_arn      = module.sqs_queue.arn
}

module "sqs_dead_letter_queue" {
  source         = "./modules/sqs_dead_letter_queue"
  queue_name     = "${var.queue_name}-DLQ"
  sqs_kms_key_id = var.sqs_kms_key_id
}

module "sqs_queue" {
  source                    = "./modules/sqs_queue"
  queue_name                = var.queue_name
  delay_seconds             = var.delay_seconds
  cwe_arn                   = var.cloudwatch_event_rule_arn
  sqs_kms_key_id            = var.sqs_kms_key_id
  sqs_dead_letter_queue_arn = module.sqs_dead_letter_queue.arn
}

module "sqs_queue_policy" {
  source        = "./modules/sqs_queue_policy"
  cwe_id        = var.cloudwatch_event_rule_id
  sqs_queue_id  = module.sqs_queue.id
  sqs_queue_arn = module.sqs_queue.arn
}

module "sqs_dead_letter_queue_policy" {
  source                    = "./modules/sqs_dead_letter_queue_policy"
  sqs_dead_letter_queue_arn = module.sqs_dead_letter_queue.arn
  sqs_dead_letter_queue_id  = module.sqs_dead_letter_queue.id
  sqs_queue_arn             = module.sqs_queue.arn
}


module "lambda_event_source_mapping" {
  source           = "./modules/lambda_event_source_mapping"
  event_source_arn = module.sqs_queue.arn
  function_name    = module.lambda_endpoint.arn
}

module "lambda_endpoint" {
  source                   = "./modules/lambda"
  function_name            = var.function_name
  source_code_dir          = var.source_code_dir
  handler                  = var.handler
  lambda_runtime           = var.lambda_runtime
  environment_variable_map = var.environment_variable_map
  sqs_queue_arn            = module.sqs_queue.arn
  sns_topic_arn            = var.sns_topic_arn
  custom_lambda_policy     = var.custom_lambda_policy
  kms_key_id               = var.sqs_kms_key_id
}
