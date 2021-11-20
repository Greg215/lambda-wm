#----- variables of lambda----

variable "function_name" {
  description = " Unique name for your Lambda Function."
  type        = string
  default     = "Lambda function Greg"
}

variable "architectures" {
  description = "Instruction set architecture for your Lambda function. Valid values are ['x86_64'] and ['arm64']. Default is ['x86_64']. Removing this attribute, function's architecture stay the same."
  type        = string
  default     = "x86_64"
}

variable "code_signing_config_arn" {
  description = "To enable code signing for this function, specify the ARN of a code-signing configuration. A code-signing configuration includes a set of signing profiles, which define the trusted publishers for this function."
  type        = string
  default     = ""
}

variable "dead_letter_config" {
  description = "Configuration block. "
  type        = string
  default     = ""
}

variable "description" {
  description = "Description of what your Lambda Function does."
  type        = string
  default     = "simple lambda function"
}

variable "environment" {
  description = "Configuration block"
  type        = string
  default     = ""
}

variable "file_system_config" {
  description = "Configuration block. "
  type        = string
  default     = ""
}

variable "filename" {
  description = "Path to the function's deployment package within the local filesystem. Conflicts with image_uri, s3_bucket, s3_key, and s3_object_version."
  type        = string
  default     = ""
}

variable "handler" {
  description = "Function entrypoint in your code"
  type        = string
  default     = null
}

variable "image_config" {
  description = "Configuration block"
  type        = string
  default     = ""
}

variable "kms_key_arn" {
  description = " Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key. If this configuration is provided when environment variables are not in use, the AWS Lambda API does not save this configuration and Terraform will show a perpetual difference of adding the key. To fix the perpetual difference, remove this configuration."
  type        = string
  default     = null
}

variable "layers" {
  description = "The list of Lambda Layer Version ARNs to attach to your Lambda Function. You can have a maximum of 5 Layers attached to each function."
  type        = list(string)
  default     = []
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128"
  default     = 128
}

variable "package_type" {
  description = "Lambda deployment package type. Valid values are Zip and Image"
  default     = "zip"
}

variable "publish" {
  description = "Whether to publish creation/change as new Lambda Function Version."
  default     = false
}

variable "reserved_concurrent_executions" {
  description = "Amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1"
  default     = ""
}

variable "runtime" {
  description = " Identifier of the function's runtime"
  default     = null
  type        = string
}

variable "s3_bucket" {
  description = " S3 bucket location containing the function's deployment package. Conflicts with filename and image_uri. This bucket must reside in the same AWS region where you are creating the Lambda function."
  type        = string
  default     = null
}

variable "s3_key" {
  description = "S3 key of an object containing the function's deployment package. Conflicts with filename and image_uri."
  default     = null
  type        = string
}

variable "s3_object_version" {
  description = "Object version containing the function's deployment package. Conflicts with filename and image_uri."
  default     = null
  type        = string
}

variable "source_code_hash" {
  description = "Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3_key. The usual way to set this is filebase64sha256(file.zip) (Terraform 0.11.12 and later) or base64sha256(file(file.zip)) (Terraform 0.11.11 and earlier), where file.zip is the local filename of the lambda function source archive."
  default     = ""
}

variable "tags" {
  description = "A map of tags to apply to the Lambda function."
  type        = map(string)
  default     = {}
}

variable "timeout" {
  description = "Amount of time your Lambda Function has to run in seconds."
  default     = 3
}

variable "tracing_config" {
  description = "Configuration block"
  default     = ""
}

variable "vpc_config" {
  description = "Configuration block"
  default     = ""
}

variable "source_file_name" {
  description = "The archive file source file anme"
  type        = string
  default     = ""
}

variable "output_file_name" {
  description = "The archive file output file name"
  type        = string
  default     = ""
}

variable "environment_variables" {
  description = "A map of environment variables to pass to the Lambda function. AWS will automatically encrypt these with KMS and decrypt them when running the function."
  type        = map(string)

  # Lambda does not permit you to pass it an empty map of environment variables, so our default value has to contain
  # this totally useless placeholder.
  default = {
    EnvVarPlaceHolder = "Placeholder"
  }
}

variable "image_uri" {
  description = "The ECR image URI containing the function's deployment package. Example: 01234501234501.dkr.ecr.us-east-1.amazonaws.com/image_name:image_tag"
  type        = string
  default     = null
}

variable "entry_point" {
  description = "The ENTRYPOINT for the docker image. Only used if you specify a Docker image via image_uri."
  type        = list(string)
  default     = []
}

variable "command" {
  description = "The CMD for the docker image. Only used if you specify a Docker image via image_uri."
  type        = list(string)
  default     = []
}

variable "working_directory" {
  description = "The working directory for the docker image. Only used if you specify a Docker image via image_uri."
  type        = string
  default     = null
}

variable "mount_to_file_system" {
  description = "Set to true to mount your Lambda function on an EFS. Note that the lambda must also be deployed inside a VPC (run_in_vpc must be set to true) for this config to have any effect."
  type        = bool
  default     = false
}

variable "file_system_access_point_arn" {
  description = "The ARN of an EFS access point to use to access the file system. Only used if var.mount_to_file_system is true."
  type        = string
  default     = null
}

variable "file_system_mount_path" {
  description = "The mount path where the lambda can access the file system. This path must begin with /mnt/. Only used if var.mount_to_file_system is true."
  type        = string
  default     = null
}

variable "dead_letter_target_arn" {
  description = "The ARN of an SNS topic or an SQS queue to notify when invocation of a Lambda function fails. If this option is used, you must grant this function's IAM role (the ID is outputted as iam_role_id) access to write to the target object, which means allowing either the sns:Publish or sqs:SendMessage action on this ARN, depending on which service is targeted."
  default     = null
}

variable "run_in_vpc" {
  description = "Set to true to give your Lambda function access to resources within a VPC."
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "The ID of the VPC the Lambda function should be able to access. Only used if var.run_in_vpc is true."
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "A list of subnet IDs the Lambda function should be able to access within your VPC. Only used if var.run_in_vpc is true."
  type        = list(string)
  default     = []
}

variable "should_create_outbound_rule" {
  description = "If true, create an egress rule allowing all outbound traffic from Lambda function to the entire Internet (e.g. 0.0.0.0/0)."
  type        = bool
  default     = false
}