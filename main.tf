# ----- main tf code ------------------------------------------
#------ The Lambda module for the web -------------------------
#--------------------------------------------------------------

module "lambda" {
  source = "./lambda"

  function_name    = var.function_name
  source_file_name = var.source_file_name
  output_file_name = var.output_file_name
  runtime          = var.runtime
  handler          = var.handler
  tags             = var.tags
}

