resource "aws_cloudwatch_event_target" "cwe_rule_target" {
  rule      = var.event_rule_name
  target_id = var.target_id
  arn       = var.target_arn
}

