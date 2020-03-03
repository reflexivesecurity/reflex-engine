output "key_id" {
  description = "Reflex KMS Key Id"
  value       = element(concat(aws_kms_key.reflex_key.*.key_id, [""]), 0)
}

output "key_arn" {
  description = "Reflex KMS Key Arn"
  value       = element(concat(aws_kms_key.reflex_key.*.arn, [""]), 0)
}

output "alias" {
  description = "Reflex KMS Alias Arn"
  value       = element(concat(aws_kms_alias.reflex_alias.*.arn, [""]), 0)
}

