/* Configure the AWS Provider */
provider "aws" {
  access_key = var.access_key_id
  region = "us-east-1"
  secret_key = var.aws_secret_access_key
}

