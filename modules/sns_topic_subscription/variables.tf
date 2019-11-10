variable "topic_arn" {
  description = "Arn of Topic to create subscription for."
  type = string
}

variable "protocol" {
  description = "Protocol for subscription (note: no email or email-json"
  type = string
}

variable "endpoint" {
  description = "Endpoint that is relevant to individual protocol"
  type = string
}
