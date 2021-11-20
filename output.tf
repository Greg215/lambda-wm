# output of the main tf

output "arn" {
  value = module.lambda.arn
}

output "invoke_arn" {
  value = module.lambda.invoke_arn
}

output "last_modified" {
  value = module.lambda.last_modified
}

output "qualified_arn" {
  value = module.lambda.qualified_arn
}

output "source_code_size" {
  value = module.lambda.source_code_size
}

output "tags_all" {
  value = module.lambda.tags_all
}

output "version" {
  value = module.lambda.version
}

output "vpc_config" {
  value = module.lambda.vpc_config
}

output "rols_arn" {
  value = module.lambda.arn
}

output "cloudwatch_loggroup" {
  value = module.lambda.arn
}