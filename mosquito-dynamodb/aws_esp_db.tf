# aws_esp_db.tf

resource "aws_dynamodb_table" "esp_ddb" {
  name                        = var.esp_db_name
  billing_mode                = "PROVISIONED"
  read_capacity               = 5
  write_capacity              = 1
  hash_key                    = "ts"
  range_key                   = "jsonValue"

  attribute {
    name = "ts"
    type = "N"
  }

  attribute {
    name = "jsonValue"
    type = "S"
  }
}
