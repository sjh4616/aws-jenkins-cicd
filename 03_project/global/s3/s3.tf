resource "aws_s3_bucket" "terraform-state" {
  bucket = "sung-terraform-state"

  lifecycle {
    prevent_destroy = false
  }
  force_destroy = true

  tags = {
    Name = "sung-terraform-state"
  }
}

resource "aws_dynamodb_table" "terraform-locks" {
  name         = "sung-terraform-looks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}