terraform {
  backend "s3" {
    bucket         = "sung-terraform-state"
    region         = "ap-northeast-2"
    key            = "infra/vpc/terraform.tfstate"
    dynamodb_table = "sung-terraform-looks"
    encrypt        = true
  }
}