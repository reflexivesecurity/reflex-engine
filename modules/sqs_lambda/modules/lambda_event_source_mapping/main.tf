resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  event_source_arn = var.event_source_arn
  enabled          = true
  function_name    = var.function_name
  batch_size       = 1
}

