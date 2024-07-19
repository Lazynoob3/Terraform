# environments/dev/backend.tf
terraform {
  backend "s3" {
    bucket         = "terraform-s3-bucket-statefile"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-dynamodb-table"
  }
}