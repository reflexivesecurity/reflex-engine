resource "aws_sns_topic" "sns_topic" {
  name = var.topic_name
}

resource "aws_sns_topic_policy" "default" {
  arn    = "${aws_sns_topic.sns_topic.arn}"
  policy = "${data.aws_iam_policy_document.sns_topic_policy.json}"
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    effect  = "Allow"
    actions = var.sns_actions
    principals {
      type        = "Service"
      identifiers = var.service_identifiers
    }

    resources = ["${aws_sns_topic.sns_topic.arn}"]
  }
}
