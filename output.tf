# ---------------- output of the Lambda ----------------

output "arn" {
  value       = module.lambda.arn
  description = "Amazon Resource Name (ARN) identifying your Lambda Function."
}

output "invoke_arn" {
  value       = module.lambda.invoke_arn
  description = "ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration's uri."
}

output "last_modified" {
  value       = module.lambda.last_modified
  description = "Date this resource was last modified."
}

output "qualified_arn" {
  value       = module.lambda.qualified_arn
  description = "ARN identifying your Lambda Function Version (if versioning is enabled via publish = true)."
}

output "source_code_size" {
  value       = module.lambda.source_code_size
  description = "Size in bytes of the function .zip file."
}

output "tags_all" {
  value       = module.lambda.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
}

output "version" {
  value       = module.lambda.version
  description = "Latest published version of your Lambda Function."
}

output "vpc_config" {
  value       = module.lambda.vpc_config
  description = "ID of the VPC."
}

output "rols_arn" {
  value       = module.lambda.arn
  description = "The ARN of the Iam role which created for the Lambda funtion."
}

output "cloudwatch_loggroup" {
  value       = module.lambda.arn
  description = "The ARN of the CLoudwatch loggroup."
}