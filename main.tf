
provider "aws" {
  region  = "us-east-1"
}


terraform {
  backend "s3" {
    bucket         = "tf-state-management-ai-caller"
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "TfStateLock"
    encrypt        = true
  }
}
