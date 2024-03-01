data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "sung-terraform-state"
    key    = "infra/vpc/terraform.tfstate"
    region = "ap-northeast-2"
  }
}