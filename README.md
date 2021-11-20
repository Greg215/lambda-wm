# terraform-lambda

This repo has a simple Lambda function which written in Python 3.9.

The function can be deployed by the Terraform.

The CD for this whole module is using Jenkins, details can be found in the Jenkins file along with the repo.

## Terraform module
1. The Terraform version is 1.0.11
2. The Lambda module should be suited for most Lambda deployment.
3. The module will create an IAM role along with the Lambda function also a Cloudwatch log group.
4. 
## CD
