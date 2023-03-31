
# # resource "aws_s3_bucket" "terraform_state" {
# #   bucket = "terraform-up-and-running5-state-15555555-01"

# #   # Prevent accidental deletion of this S3 bucket
# #   lifecycle {
# #     prevent_destroy = true
# #   }
# # }
# # resource "aws_s3_bucket_versioning" "enabled" {
# #   bucket = aws_s3_bucket.terraform_state.id
# #   versioning_configuration {
# #     status = "Enabled"
# #   }
# # }

# # resource "aws_dynamodb_table" "terraform_locks" {
# #   name         = "terraform-up-and-running-locks"
# #   billing_mode = "PAY_PER_REQUEST"
# #   hash_key     = "LockID"

# #   attribute {
# #     name = "LockID"
# #     type = "S"
# #   }
# # }
# terraform {
#   backend "s3" {
#     # Replace this with your bucket name!
#     bucket = "terraform-up-and-running5-state-15555555-01"
#     key    = "dev/terraform.tfstate"
#     region = "us-east-1"

#     # Replace this with your DynamoDB table name!
#     dynamodb_table = "terraform-up-and-running-locks"
#     encrypt        = true
#   }
# }