resource "aws_s3_bucket" "terraform-state" {
  bucket = "aws00-terraform-state"

  lifecycle {
    prevent_destroy = false
  }
  force_destroy = true

  tags = {
    Name = "aws00-terraform-state"
  }
}

resource "aws_dynamodb_table" "terraform-locks" {
  name         = "aws00-terraform-looks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}