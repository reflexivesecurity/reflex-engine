variable "name" {
  description = "A name for the Cloudwatch Event."
  type = string
}

variable "description" {
  description = "A description for our CWE rule"
  type = string
}

variable "event_pattern" {
  description = "Event pattern that details the events to listen for."
  type = string
}
