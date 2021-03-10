/*
* sqs_lambda: module to generate the targeted sqs queue to lambda ingestion of event payloads
*/

resource "aws_sqs_queue" "sqs_dead_letter_queue" {
  name              = "${var.queue_name}-DLQ"
  kms_master_key_id = var.sqs_kms_key_id
}

/*
* sqs_queue: Creation of sqs queue for the purposes of passing events to Lambda
*/
resource "aws_sqs_queue" "sqs_queue" {
  name                       = var.queue_name
  delay_seconds              = var.delay_seconds
  kms_master_key_id          = var.sqs_kms_key_id
  visibility_timeout_seconds = var.visibility_timeout_seconds
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.sqs_dead_letter_queue.arn
    maxReceiveCount     = var.max_receive_count
  })
  tags = {
    Reflex = "true"
  }
}

resource "aws_cloudwatch_event_target" "cwe_rule_target" {
  rule      = var.cloudwatch_event_rule_id
  target_id = var.target_id
  arn       = aws_sqs_queue.sqs_queue.arn
}

module "sqs_queue_policy" {
  source        = "./modules/sqs_queue_policy"
  cwe_id        = var.cloudwatch_event_rule_id
  sqs_queue_id  = aws_sqs_queue.sqs_queue.id
  sqs_queue_arn = aws_sqs_queue.sqs_queue.arn
}

module "sqs_dead_letter_queue_policy" {
  source                    = "./modules/sqs_dead_letter_queue_policy"
  sqs_dead_letter_queue_arn = aws_sqs_queue.sqs_dead_letter_queue.arn
  sqs_dead_letter_queue_id  = aws_sqs_queue.sqs_dead_letter_queue.id
  sqs_queue_arn             = aws_sqs_queue.sqs_queue.arn
}

module "lambda_endpoint" {
  source                   = "./modules/lambda"
  function_name            = var.function_name
  package_location         = var.package_location
  handler                  = var.handler
  lambda_runtime           = var.lambda_runtime
  environment_variable_map = var.environment_variable_map
  sqs_queue_arn            = aws_sqs_queue.sqs_queue.arn
  sns_topic_arn            = var.sns_topic_arn
  kms_key_id               = var.sqs_kms_key_id
  lambda_timeout           = var.lambda_timeout
}

module "iam_assume_role" {
  source                    = "./modules/iam_assume_role"
  function_name             = var.function_name
  lambda_execution_role_arn = module.lambda_endpoint.execution_role_arn
  custom_lambda_policy      = var.custom_lambda_policy
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  event_source_arn = aws_sqs_queue.sqs_queue.arn
  enabled          = true
  function_name    = module.lambda_endpoint.arn
  batch_size       = 1
  depends_on       = [module.lambda_endpoint]
}
