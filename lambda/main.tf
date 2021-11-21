# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE LAMBDA FUNCTION
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_lambda_function" "func" {
  description   = var.description
  publish       = var.publish
  function_name = var.function_name

  # When source_path is set and image_uri is not set, it indicates that the function should come from the local file path.
  filename         = local.use_local_file ? local.zip_file_path : null
  source_code_hash = local.use_local_file ? local.source_code_hash : null

  # When source_path and image_uri are not set (null), it indicates that the function should come from S3.
  s3_bucket         = var.s3_bucket
  s3_key            = local.use_s3_bucket ? var.s3_key : null
  s3_object_version = local.use_s3_bucket ? var.s3_object_version : null

  role = aws_iam_role.iam_for_lambda.arn

  tags = var.tags

  timeout      = var.timeout
  memory_size  = var.memory_size
  kms_key_arn  = var.kms_key_arn
  image_uri    = var.image_uri
  layers       = local.use_docker_image ? [] : var.layers
  package_type = local.use_docker_image ? "Image" : "Zip"
  runtime      = local.use_docker_image ? null : var.runtime
  handler      = local.use_docker_image ? null : "${var.handler}.lambda_handler"

  environment {
    variables = var.environment_variables
  }

  dynamic "vpc_config" {
    # The content of the list does not matter, because we are using this as an on off switch based on the input
    # variable.
    for_each = var.run_in_vpc ? ["use_vpc_config"] : []
    content {
      subnet_ids         = var.subnet_ids
      security_group_ids = aws_security_group.lambda.*.id
    }
  }

  # Terraform will error if target_arn for dead_letter_config is just nil.
  # Workaround is to dynamically generic this block if the string length for dead_letter_target_arn is not 0.
  dynamic "dead_letter_config" {
    for_each = var.dead_letter_target_arn == null ? [] : [1]
    content {
      target_arn = var.dead_letter_target_arn
    }
  }

  # In order to mount a file system, the lambda must also be deployed inside a VPC.
  dynamic "file_system_config" {
    for_each = var.mount_to_file_system ? ["mount_file_system"] : []
    content {
      arn              = var.file_system_access_point_arn
      local_mount_path = var.file_system_mount_path
    }
  }

  # The Lambda OCI image configurations.
  dynamic "image_config" {
    for_each = local.use_docker_image ? ["once"] : []
    content {
      entry_point       = var.entry_point
      command           = var.command
      working_directory = var.working_directory
    }
  }
}

# Check that only one of the resources (s3, local ip, docker image) is specified.
resource "null_resource" "assert_exactly_one_of" {
  count = length(compact([var.image_uri, var.source_file_name, var.s3_bucket])) == 1 ? 0 : "ERROR: exactly one of image_uri, source_path, or s3_bucket must be specified."
}

# Local variables which specify which deployment method is used.
locals {
  use_local_file   = var.source_file_name != null && var.s3_bucket == null && var.image_uri == null
  use_s3_bucket    = var.source_file_name == null && var.s3_bucket != null && var.image_uri == null
  use_docker_image = var.source_file_name == null && var.s3_bucket == null && var.image_uri != null
}

data "archive_file" "source_code" {
  type        = "zip"
  source_file = var.source_file_name
  output_path = var.output_file_name
}

locals {
  source_code_hash = (
    join(",", data.archive_file.source_code.*.output_base64sha256)
  )

  zip_file_path = join("", data.archive_file.source_code.*.output_path)
}

#------ create the iam role for Lambda-------------------
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

#--------- enable cloudwatch ----------
# This is to optionally manage the CloudWatch Log Group for the Lambda Function.
# If skipping this resource configuration, also add "logs:CreateLogGroup" to the IAM policy below.
resource "aws_cloudwatch_log_group" "default" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 14
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A SECURITY GROUP FOR THE LAMBDA JOB
# If this lambda function has access to a VPC (var.run_in_vpc is true)
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_security_group" "lambda" {
  count = var.run_in_vpc ? 1 : 0

  name        = "${var.function_name}-lambda"
  description = "Security group for the lambda function ${var.function_name}"
  vpc_id      = var.vpc_id

  tags = var.tags
}

resource "aws_security_group_rule" "allow_outbound_all" {
  count             = var.should_create_outbound_rule ? 1 : 0
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lambda[0].id
}

# ---------------------------------------------------------------------------------------------------------------------
# GIVE THE LAMBDA FUNCTION PERMISSIONS TO CREATE NETWORK INTERFACES SO IT CAN RUN IN A VPC
# These resources are only created if var.run_in_vpc is true.
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_iam_role_policy" "network_interfaces_for_lambda" {
  count = var.run_in_vpc ? 1 : 0

  name   = "${var.function_name}-network-interfaces"
  role   = length(aws_iam_role.iam_for_lambda) > 0 ? aws_iam_role.iam_for_lambda.id : null
  policy = data.aws_iam_policy_document.network_interfaces_for_lambda.json
}

data "aws_iam_policy_document" "network_interfaces_for_lambda" {
  statement {
    effect = "Allow"

    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DetachNetworkInterface",
      "ec2:ModifyNetworkInterfaceAttribute",
      "ec2:ResetNetworkInterfaceAttribute",
    ]

    resources = ["*"]
  }
}