resource "aws_dynamodb_table" "vision_table" {
  name           = var.table_name
  billing_mode   = "PAY_PER_REQUEST"

  hash_key       = "UserId"

  attribute {
    name = "UserId"
    type = "S"
  }

  tags = {
    Name = "DynamoDBTableForVisionApp"
  }
}