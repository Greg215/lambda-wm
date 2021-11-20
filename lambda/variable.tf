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
  default     = ""
}

variable "image_config" {
  description = "Configuration block"
  type        = string
  default     = ""
}

variable "image_uri" {
  description = "ECR image URI containing the function's deployment package. Conflicts with filename, s3_bucket, s3_key, and s3_object_version."
  type        = string
  default     = ""
}

variable "kms_key_arn" {
  description = " Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key. If this configuration is provided when environment variables are not in use, the AWS Lambda API does not save this configuration and Terraform will show a perpetual difference of adding the key. To fix the perpetual difference, remove this configuration."
  type        = string
  default     = ""
}

variable "layers" {
  description = "List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function."
  default     = ""
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
  default     = ""
}

variable "s3_bucket" {
  description = " S3 bucket location containing the function's deployment package. Conflicts with filename and image_uri. This bucket must reside in the same AWS region where you are creating the Lambda function."
  default     = ""
}

variable "s3_key" {
  description = "S3 key of an object containing the function's deployment package. Conflicts with filename and image_uri."
  default     = ""
}

variable "s3_object_version" {
  description = "Object version containing the function's deployment package. Conflicts with filename and image_uri."
  default     = ""
}

variable "source_code_hash" {
  description = "Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3_key. The usual way to set this is filebase64sha256(file.zip) (Terraform 0.11.12 and later) or base64sha256(file(file.zip)) (Terraform 0.11.11 and earlier), where file.zip is the local filename of the lambda function source archive."
  default     = ""
}

variable "tags" {
  description = "Map of tags to assign to the object. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  default     = ""
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

