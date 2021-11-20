#-----------variable file------------------------------------

#----------- below are the value that must be provided ------
variable "aws_region" {
  description = "The region of AWS"
  type        = string
  default     = "ap-southeast-1"
}

variable "function_name" {
  description = " Unique name for your Lambda Function."
  type        = string
  default     = "Lambda function Greg"
}

variable "handler" {
  description = "Function entrypoint in your code"
  type        = string
  default     = ""
}

variable "runtime" {
  description = " Identifier of the function's runtime"
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
