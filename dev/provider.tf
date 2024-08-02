# dev/providers.tf

provider "aws" {
  region  = "us-west-2"  # Specify the AWS region
  version = "~> 4.0"     # Optional: specify a version constraint

  # You can configure credentials in various ways:
  # Option 1: Use environment variables (recommended)
  # Option 2: Use a shared credentials file
  # Option 3: Hardcode access key and secret key (not recommended)

  # Option 1 (using environment variables, e.g., AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY):
  # No additional configuration needed if environment variables are set

  # Option 2 (using shared credentials file):
  # profile = "your-profile-name"

  # Option 3 (hardcoding credentials, not recommended):
  # access_key = "your-access-key"
  # secret_key = "your-secret-key"
}
