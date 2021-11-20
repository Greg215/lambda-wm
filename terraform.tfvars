function_name = "wm-web-lambda"

source_file_name = "lambda.py"

handler = "lambda"

output_file_name = "lambda.zip"

runtime = "python3.9"

tags = {
  managed_by        = "Terraform"
  terraform_version = "1.0.11"
  project           = "wm-web"
  runtime           = "python3.9"
}