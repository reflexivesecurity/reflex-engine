module "cloudwatch_event_rule" {
  source        = "../event_rule"
  name          = var.rule_name
  description   = var.rule_description
  event_pattern = var.event_pattern
}

module "lambda_endpoint" {
  source = "../lambda"
  function_name = var.function_name
  filename = var.filename
  handler = var.handler
  source_code_hash = var.source_code_hash
  lambda_runtime = var.lambda_runtime
  environment_variable_map = var.environment_variable_map
}

module "event_target" {
  source = "../event_target"
  event_rule_name = module.cloudwatch_event_rule.id
  target_id = var.target_id
  target_arn = module.lambda_endpoint.arn
}
