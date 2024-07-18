# environments/prod/backend.tf
terraform {
  backend "s3" {
    bucket         = "terraform-s3-bucket-statefile"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-dynamodb-table"
    encrypt        = true
  }
}
