terraform {
  backend "s3" {
    bucket         = "sung-terraform-state"
    region         = "ap-northeast-2"
    key            = "global/s3/terraform.tfstate"
    dynamodb_table = "sung-terraform-looks"
    encrypt        = true
  }
}