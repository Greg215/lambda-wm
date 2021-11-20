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