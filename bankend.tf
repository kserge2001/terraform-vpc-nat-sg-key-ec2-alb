terraform {
  backend "s3" {
    bucket         = "week10-sk-bucket"
    key            = "test/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}