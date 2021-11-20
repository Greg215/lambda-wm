#-------- output ------

output "arn" {
  value = aws_lambda_function.func.arn
}

output "invoke_arn" {
  value = aws_lambda_function.func.invoke_arn
}

output "last_modified" {
  value = aws_lambda_function.func.last_modified
}

output "qualified_arn" {
  value = aws_lambda_function.func.qualified_arn
}

output "source_code_size" {
  value = aws_lambda_function.func.source_code_size
}

output "tags_all" {
  value = aws_lambda_function.func.tags
}

output "version" {
  value = aws_lambda_function.func.version
}

output "vpc_config" {
  value = aws_lambda_function.func.vpc_config
}

output "rols_arn" {
  value = aws_iam_role.iam_for_lambda.arn
}

output "cloudwatch_loggroup" {
  value = aws_cloudwatch_log_group.default.arn
}
