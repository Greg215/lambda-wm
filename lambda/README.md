<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | n/a |
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.lambda_logging](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.iam_for_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.network_interfaces_for_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.lambda_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.func](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_security_group.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.allow_outbound_all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [null_resource.assert_exactly_one_of](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [archive_file.source_code](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_iam_policy_document.network_interfaces_for_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_architectures"></a> [architectures](#input\_architectures) | Instruction set architecture for your Lambda function. Valid values are ['x86\_64'] and ['arm64']. Default is ['x86\_64']. Removing this attribute, function's architecture stay the same. | `string` | `"x86_64"` | no |
| <a name="input_code_signing_config_arn"></a> [code\_signing\_config\_arn](#input\_code\_signing\_config\_arn) | To enable code signing for this function, specify the ARN of a code-signing configuration. A code-signing configuration includes a set of signing profiles, which define the trusted publishers for this function. | `string` | `""` | no |
| <a name="input_command"></a> [command](#input\_command) | The CMD for the docker image. Only used if you specify a Docker image via image\_uri. | `list(string)` | `[]` | no |
| <a name="input_dead_letter_config"></a> [dead\_letter\_config](#input\_dead\_letter\_config) | Configuration block. | `string` | `""` | no |
| <a name="input_dead_letter_target_arn"></a> [dead\_letter\_target\_arn](#input\_dead\_letter\_target\_arn) | The ARN of an SNS topic or an SQS queue to notify when invocation of a Lambda function fails. If this option is used, you must grant this function's IAM role (the ID is outputted as iam\_role\_id) access to write to the target object, which means allowing either the sns:Publish or sqs:SendMessage action on this ARN, depending on which service is targeted. | `any` | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of what your Lambda Function does. | `string` | `"simple lambda function"` | no |
| <a name="input_entry_point"></a> [entry\_point](#input\_entry\_point) | The ENTRYPOINT for the docker image. Only used if you specify a Docker image via image\_uri. | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Configuration block | `string` | `""` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | A map of environment variables to pass to the Lambda function. AWS will automatically encrypt these with KMS and decrypt them when running the function. | `map(string)` | <pre>{<br>  "EnvVarPlaceHolder": "Placeholder"<br>}</pre> | no |
| <a name="input_file_system_access_point_arn"></a> [file\_system\_access\_point\_arn](#input\_file\_system\_access\_point\_arn) | The ARN of an EFS access point to use to access the file system. Only used if var.mount\_to\_file\_system is true. | `string` | `null` | no |
| <a name="input_file_system_config"></a> [file\_system\_config](#input\_file\_system\_config) | Configuration block. | `string` | `""` | no |
| <a name="input_file_system_mount_path"></a> [file\_system\_mount\_path](#input\_file\_system\_mount\_path) | The mount path where the lambda can access the file system. This path must begin with /mnt/. Only used if var.mount\_to\_file\_system is true. | `string` | `null` | no |
| <a name="input_filename"></a> [filename](#input\_filename) | Path to the function's deployment package within the local filesystem. Conflicts with image\_uri, s3\_bucket, s3\_key, and s3\_object\_version. | `string` | `""` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | Unique name for your Lambda Function. | `string` | `"Lambda function Greg"` | no |
| <a name="input_handler"></a> [handler](#input\_handler) | Function entrypoint in your code | `string` | `null` | no |
| <a name="input_image_config"></a> [image\_config](#input\_image\_config) | Configuration block | `string` | `""` | no |
| <a name="input_image_uri"></a> [image\_uri](#input\_image\_uri) | The ECR image URI containing the function's deployment package. Example: 01234501234501.dkr.ecr.us-east-1.amazonaws.com/image\_name:image\_tag | `string` | `null` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key. If this configuration is provided when environment variables are not in use, the AWS Lambda API does not save this configuration and Terraform will show a perpetual difference of adding the key. To fix the perpetual difference, remove this configuration. | `string` | `null` | no |
| <a name="input_layers"></a> [layers](#input\_layers) | The list of Lambda Layer Version ARNs to attach to your Lambda Function. You can have a maximum of 5 Layers attached to each function. | `list(string)` | `[]` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128 | `number` | `128` | no |
| <a name="input_mount_to_file_system"></a> [mount\_to\_file\_system](#input\_mount\_to\_file\_system) | Set to true to mount your Lambda function on an EFS. Note that the lambda must also be deployed inside a VPC (run\_in\_vpc must be set to true) for this config to have any effect. | `bool` | `false` | no |
| <a name="input_output_file_name"></a> [output\_file\_name](#input\_output\_file\_name) | The archive file output file name | `string` | `""` | no |
| <a name="input_package_type"></a> [package\_type](#input\_package\_type) | Lambda deployment package type. Valid values are Zip and Image | `string` | `"zip"` | no |
| <a name="input_publish"></a> [publish](#input\_publish) | Whether to publish creation/change as new Lambda Function Version. | `bool` | `false` | no |
| <a name="input_reserved_concurrent_executions"></a> [reserved\_concurrent\_executions](#input\_reserved\_concurrent\_executions) | Amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1 | `string` | `""` | no |
| <a name="input_run_in_vpc"></a> [run\_in\_vpc](#input\_run\_in\_vpc) | Set to true to give your Lambda function access to resources within a VPC. | `bool` | `false` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Identifier of the function's runtime | `string` | `null` | no |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | S3 bucket location containing the function's deployment package. Conflicts with filename and image\_uri. This bucket must reside in the same AWS region where you are creating the Lambda function. | `string` | `null` | no |
| <a name="input_s3_key"></a> [s3\_key](#input\_s3\_key) | S3 key of an object containing the function's deployment package. Conflicts with filename and image\_uri. | `string` | `null` | no |
| <a name="input_s3_object_version"></a> [s3\_object\_version](#input\_s3\_object\_version) | Object version containing the function's deployment package. Conflicts with filename and image\_uri. | `string` | `null` | no |
| <a name="input_should_create_outbound_rule"></a> [should\_create\_outbound\_rule](#input\_should\_create\_outbound\_rule) | If true, create an egress rule allowing all outbound traffic from Lambda function to the entire Internet (e.g. 0.0.0.0/0). | `bool` | `false` | no |
| <a name="input_source_code_hash"></a> [source\_code\_hash](#input\_source\_code\_hash) | Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3\_key. The usual way to set this is filebase64sha256(file.zip) (Terraform 0.11.12 and later) or base64sha256(file(file.zip)) (Terraform 0.11.11 and earlier), where file.zip is the local filename of the lambda function source archive. | `string` | `""` | no |
| <a name="input_source_file_name"></a> [source\_file\_name](#input\_source\_file\_name) | The archive file source file anme | `string` | `""` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet IDs the Lambda function should be able to access within your VPC. Only used if var.run\_in\_vpc is true. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to apply to the Lambda function. | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | Amount of time your Lambda Function has to run in seconds. | `number` | `3` | no |
| <a name="input_tracing_config"></a> [tracing\_config](#input\_tracing\_config) | Configuration block | `string` | `""` | no |
| <a name="input_vpc_config"></a> [vpc\_config](#input\_vpc\_config) | Configuration block | `string` | `""` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The ID of the VPC the Lambda function should be able to access. Only used if var.run\_in\_vpc is true. | `string` | `null` | no |
| <a name="input_working_directory"></a> [working\_directory](#input\_working\_directory) | The working directory for the docker image. Only used if you specify a Docker image via image\_uri. | `string` | `null` | no |

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