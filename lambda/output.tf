#-------- output for Lambda------

output "arn" {
  value       = aws_lambda_function.func.arn
  description = "Amazon Resource Name (ARN) identifying your Lambda Function."
}

output "invoke_arn" {
  value       = aws_lambda_function.func.invoke_arn
  description = "ARN to be used for invoking Lambda Function from API Gateway - to be used in aws_api_gateway_integration's uri."
}

output "last_modified" {
  value       = aws_lambda_function.func.last_modified
  description = "Date this resource was last modified."
}

output "qualified_arn" {
  value       = aws_lambda_function.func.qualified_arn
  description = "ARN identifying your Lambda Function Version (if versioning is enabled via publish = true)."
}

output "source_code_size" {
  value       = aws_lambda_function.func.source_code_size
  description = "Size in bytes of the function .zip file."
}

output "tags_all" {
  value       = aws_lambda_function.func.tags
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
}

output "version" {
  value       = aws_lambda_function.func.version
  description = "Latest published version of your Lambda Function."
}

output "vpc_config" {
  value       = aws_lambda_function.func.vpc_config
  description = "ID of the VPC."
}


output "rols_arn" {
  value       = aws_iam_role.iam_for_lambda.arn
  description = "The ARN of the Iam role which created for the Lambda funtion."
}

output "cloudwatch_loggroup" {
  value       = aws_cloudwatch_log_group.default.arn
  description = "The ARN of the CLoudwatch loggroup."
}
