/*
* CWE: A reusable module for creating and passing cloudwatch events.
*/
resource "aws_cloudwatch_event_rule" "cwe_rule" {
  name          = var.name
  description   = var.description
  event_pattern = var.event_pattern
}

