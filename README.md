# terraform-lambda

This repo has a simple Lambda function which written in Python 3.9.
The function can be deployed by the Terraform.
The CD for this whole module is using Jenkins, details can be found in the Jenkins file along with the repo.

## Terraform module
1. The Terraform version is 1.0.11
2. The Lambda module should be suited for most Lambda deployment.
3. The module will create an IAM role along with the Lambda function also a Cloudwatch log group.
4. The module use AWS s3 as backend.
5. If you want to deploy it to other AWS account, please change the backend and if needed also the region.
6. The source module if under the folder ```lambda``` 
7. The Terraform run time file is on the top layer (can also move to the specific folder if for monorepo case.)
   
## CI/CD
1. Using Jenkins for CI/CD here.
2. Jenkins is running on Kubernetes and using Jenkins config as code.
3. The pod template is no need to change as the using the Terraform official latest image.
4. The pipeline will send notification to Slack channel for the build info.
5. There is one parameter for the build which you can choose to create/update or destroy the Lambda funtion.



<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |


## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda"></a> [lambda](#module\_lambda) | ./lambda | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The region of AWS | `string` | `"ap-southeast-1"` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | Unique name for your Lambda Function. | `string` | `"Lambda function Greg"` | no |
| <a name="input_handler"></a> [handler](#input\_handler) | Function entrypoint in your code | `string` | `""` | no |
| <a name="input_output_file_name"></a> [output\_file\_name](#input\_output\_file\_name) | The archive file output file name | `string` | `""` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Identifier of the function's runtime | `string` | `""` | no |
| <a name="input_source_file_name"></a> [source\_file\_name](#input\_source\_file\_name) | The archive file source file anme | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the Lambda function. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Amazon Resource Name (ARN) identifying your Lambda Function. |
| <a name="output_cloudwatch_loggroup"></a> [cloudwatch\_loggroup](#output\_cloudwatch\_loggroup) | The ARN of the CLoudwatch loggroup. |
| <a name="output_invoke_arn"></a> [invoke\_arn](#output\_invoke\_arn) | ARN to be used for invoking Lambda Function from API Gateway - to be used in aws\_api\_gateway\_integration's uri. |
| <a name="output_last_modified"></a> [last\_modified](#output\_last\_modified) | Date this resource was last modified. |
| <a name="output_qualified_arn"></a> [qualified\_arn](#output\_qualified\_arn) | ARN identifying your Lambda Function Version (if versioning is enabled via publish = true). |
| <a name="output_rols_arn"></a> [rols\_arn](#output\_rols\_arn) | The ARN of the Iam role which created for the Lambda funtion. |
| <a name="output_source_code_size"></a> [source\_code\_size](#output\_source\_code\_size) | Size in bytes of the function .zip file. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the provider default\_tags configuration block. |
| <a name="output_version"></a> [version](#output\_version) | Latest published version of your Lambda Function. |
| <a name="output_vpc_config"></a> [vpc\_config](#output\_vpc\_config) | ID of the VPC. |
<!-- END_TF_DOCS -->