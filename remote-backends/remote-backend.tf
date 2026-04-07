# s3 bucket to handle state file
resource "aws_s3_bucket" "remote-s3-bucket" {
  bucket = "terraform-advanced-bucket"

  tags = {
    Name = "terraform-advanced-bucket"
  }
}

# dynamodb

resource "aws_dynamodb_table" "remote-dynamodb-table" {
  name           = "terraform-advanced-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}